;;; codex.el --- simple Codex CLI prompt buffer -*- lexical-binding: t; -*-

(require 'ansi-color)
(require 'subr-x)

(defgroup codex nil
  "Run Codex CLI from an editable Emacs buffer."
  :group 'tools)

(defcustom codex-program "codex"
  "Codex CLI executable name/path."
  :type 'string)

(defcustom codex-extra-args nil
  "Extra args inserted after `codex` and before `exec` (e.g. '(\"--quiet\") or '(\"--sandbox\" \"read-only\"))."
  :type '(repeat string))

(defcustom codex-buffer-name "*Codex (prompt)*"
  "Name of the prompt buffer."
  :type 'string)

(defcustom codex-prompt-template "# write your prompt below:

at %s

# explain what this function does
# complete this function
# find the call sites of this function"
  "Prompt template."
  :type 'string)

(defun codex--project-root ()
  "Best-effort project root."
  (when-let* ((proj (ignore-errors (project-current nil))))
    (ignore-errors (project-root proj))))

(defun codex--relative-path ()
  "Return current buffer file path relative to project root (or `default-directory`)."
  (let* ((file (or (buffer-file-name) "")))
    (cond
     ((string-empty-p file) "<no-file>")
     (t
      (let* ((root (or (codex--project-root) default-directory)))
        (file-relative-name file root))))))

(defun codex--relative-path-with-line ()
  "Return current buffer file path relative to project root plus line number."
  (if-let* ((file (buffer-file-name)))
      (format "%s:%d"
              (let* ((root (or (codex--project-root) default-directory)))
                (file-relative-name file root))
              (line-number-at-pos))
    "<no-file>"))

(defun codex--prompt-from-buffer ()
  "Return prompt text from current buffer, excluding lines starting with #."
  (save-excursion
    (let ((lines nil))
      (goto-char (point-min))
      (while (not (eobp))
        (let ((line (buffer-substring-no-properties
                     (line-beginning-position)
                     (line-end-position))))
          (unless (string-prefix-p "#" (string-trim-left line))
            (push line lines)))
        (forward-line 1))
      (string-trim-right (string-join (nreverse lines) "\n")))))

(defun codex--ensure-not-running ()
  (when (get-buffer-process (current-buffer))
    (user-error "Codex process is already running in this buffer")))

(defun codex-run ()
  "Run `codex exec` with the prompt in the current buffer and insert the result."
  (interactive)
  (codex--ensure-not-running)
  (let* ((buf (current-buffer))
         (prompt (codex--prompt-from-buffer)))
    (when (string-empty-p (string-trim prompt))
      (user-error "Prompt is empty (below the header)"))
    (let ((inhibit-read-only t))
      (goto-char (point-max))
      (insert "\n\n--- codex output ---\n"))
    ;; Run codex; pass the whole prompt as a single argument to `exec`.
    ;; (Codex CLI commonly supports: `codex exec \"...\"`.)
    (let* ((args (append codex-extra-args (list "exec" prompt)))
           (proc (apply #'start-process "codex" buf codex-program args)))
      (set-process-query-on-exit-flag proc nil)
      (set-process-filter
       proc
       (lambda (_p chunk)
         (when (buffer-live-p buf)
           (with-current-buffer buf
             (let ((inhibit-read-only t))
               (goto-char (point-max))
               (insert (ansi-color-apply chunk)))))))
      (set-process-sentinel
       proc
       (lambda (p event)
         (when (buffer-live-p buf)
           (with-current-buffer buf
             (let ((inhibit-read-only t))
               (goto-char (point-max))
               (insert (format "\n--- codex done (%s) ---\n"
                               (string-trim event)))
               (when (memq (process-status p) '(exit signal))
                 (message "codex finished: %s" (string-trim event)))))))))))

(defun codex-quit ()
  "Quit the prompt buffer."
  (interactive)
  (let ((proc (get-buffer-process (current-buffer))))
    (when (and proc (process-live-p proc))
      (when (y-or-n-p "A Codex process is running. Kill it? ")
        (kill-process proc))))
  (quit-window t))

(define-derived-mode codex-mode text-mode "Codex-Prompt"
  "Major mode for editing a Codex prompt and inserting the result."
  (setq-local header-line-format "C-c C-c: run codex   |   C-c C-k: quit")
  (setq-local truncate-lines nil)
  (use-local-map (let ((m (make-sparse-keymap)))
                   (set-keymap-parent m text-mode-map)
                   (define-key m (kbd "C-c C-c") #'codex-run)
                   (define-key m (kbd "C-c C-k") #'codex-quit)
                   m)))

;;;###autoload
(defun codex-exec-with-current-location ()
  "Open a new buffer prefilled with the current relative file path.
Edit the prompt, then run Codex (`C-c C-c`) to insert the result in-place."
  (interactive)
  (let* ((rel (codex--relative-path-with-line))
         (buf (get-buffer-create codex-buffer-name)))
    (pop-to-buffer buf)
    (codex-mode)
    (let ((inhibit-read-only t))
      (erase-buffer)
      (insert
       (format codex-prompt-template rel))
      (goto-char (point-max)))))

;;;###autoload
(defun codex-with-current-location (prompt)
  "Prompt for input and run Codex, prefilling the current file location."
  (interactive (list (read-string "Codex prompt: ")))
  (let* ((rel (codex--relative-path-with-line))
         (buf (get-buffer-create codex-buffer-name)))
    (pop-to-buffer buf)
    (codex-mode)
    (let ((inhibit-read-only t))
      (erase-buffer)
      (insert (format "at %s\n\n%s" rel prompt))
      (goto-char (point-max)))
    (codex-run)))

(provide 'codex)
;;; codex.el ends here
