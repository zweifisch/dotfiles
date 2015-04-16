
(defun copy-file-name-to-clipboard ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((filename (buffer-file-name)))
    (when filename
      (kill-new filename)
      (message "Copied buffer file name '%s' to the clipboard." filename))))

(defun toggle-windows-split()
  (interactive)
  (if (not (window-minibuffer-p))
      (if (< 1 (count-windows))
          (progn
            (window-configuration-to-register ?u)
            (delete-other-windows))
        (jump-to-register ?u))))

(define-key global-map (kbd "C-a o") 'toggle-windows-split)

(defun projectile-persp-switch-project (project-to-switch)
  "Switch to a project or perspective we have visited before.
If the perspective of corresponding project does not exist, this
function will call `persp-switch' to create one and switch to
that before `projectile-switch-project' invokes
`projectile-switch-project-action'.

Otherwise, this function calls `persp-switch' to switch to an
existing perspective of the project unless we're already in that
perspective in which case `projectile-switch-project' is called."
  (interactive (list (projectile-completing-read
                      "Switch to project: "
                      (projectile-relevant-known-projects))))
  (let* ((name (file-name-nondirectory (directory-file-name project-to-switch)))
         (persp (gethash name perspectives-hash))
         (is-curr (and persp (equal persp persp-curr))))
    (when (and (not (string= "" name)) (or (not persp) (not is-curr)))
      (persp-switch name))
    (when (and (not (string= "" name)) (or (not persp) is-curr))
      (projectile-switch-project-by-name project-to-switch))))


(defun org-project-running ()
  (delq nil
        (mapcar (lambda (x)
                  (if (plist-get (cdr x) :started) (car x)))
                org-publish-project-alist)))

(defun org-project-idle ()
  (delq nil
        (mapcar (lambda (x)
                  (if (plist-get (cdr x) :started) nil (car x)))
                org-publish-project-alist)))

(defun serve-org-project (project)
  (interactive
   (list
    (completing-read "Project: " (org-project-idle))))
  (let ((settings (cdr (assoc project org-publish-project-alist))))
    (elnode-make-webserver
     (plist-get settings :publishing-directory)
     (plist-get settings :port))
    (plist-put settings :started t)))

(defun stop-org-project (project)
  (interactive
   (list
    (completing-read
     "Project: " (org-project-running))))
  (let ((settings (cdr (assoc project org-publish-project-alist))))
    (elnode-stop (plist-get settings :port))
    (plist-put settings :started nil)))

(defun browse-org-project (project)
  (interactive
   (list
    (completing-read
     "Project: " (org-project-running))))
  (let ((settings (cdr (assoc project org-publish-project-alist))))
    (browse-url (format "http://localhost:%d" (plist-get settings :port)))))


(defun eshell-buffer-names-in-project ()
  (remove-if-not
   (apply-partially 'string-prefix-p "*eshell*")
   (projectile-project-buffer-names)))

(defun switch-to-eshell-in-project ()
  (interactive)
  (helm :sources '((name . "eshell")
                   (candidates . eshell-buffer-names-in-project)
                   (action . (lambda (candidate)
                               (switch-to-buffer candidate))))))

(defun kill-process-at-point ()
  (interactive)
  (let* ((process (get-text-property (point) 'tabulated-list-id))
         (buffer (process-buffer process)))
    (if (y-or-n-p (format "kill process %s? " (process-name process)))
        (progn 
          (kill-process process)
          (kill-buffer buffer)
          (revert-buffer)))))

(defun restart-process-at-point ()
  (interactive)
  (let ((process (get-text-property (point) 'tabulated-list-id)))
    (if (y-or-n-p (format "restart process %s? " (process-name process)))
        (progn 
          (restart-process process)
          (revert-buffer)))))

(defun info-process-at-point ()
  (interactive)
  (let* ((process (get-text-property (point) 'tabulated-list-id))
         (buffer (process-buffer process)))
    (with-current-buffer buffer
      (message
       (format "%s %s" default-directory
               (prin1-to-string (process-status process)))))))

(defun restart-process (process)
  (if (processp process)
      (let ((name (process-name process))
            (buffer (process-buffer process))
            (command (process-command process)))
        (kill-process process)
        (sleep-for 1)
        (message (prin1-to-string (process-status process)))
        (with-current-buffer buffer
          (apply 'start-process name buffer command)))
    (error "can't find process!")))

(define-key process-menu-mode-map (kbd "r") 'restart-process-at-point)
(define-key process-menu-mode-map (kbd "k") 'kill-process-at-point)
(define-key process-menu-mode-map (kbd "i") 'info-process-at-point)

(defhydra helm-like-unite (:hint nil
                           :color pink)
  "
Nav ^^^^^^^^^        Mark ^^          Other ^^       Quit
^^^^^^^^^^------------^^----------------^^----------------------
_K_ ^ ^ _k_ ^ ^     _m_ark           _v_iew         _i_: cancel
^↕^ _h_ ^✜^ _l_     _t_oggle mark    _H_elp         _o_: quit
_J_ ^ ^ _j_ ^ ^     _U_nmark all     _d_elete
^^^^^^^^^^                           _f_ollow: %(helm-attr 'follow)
"
  ;; arrows
  ("h" helm-beginning-of-buffer)
  ("j" helm-next-line)
  ("k" helm-previous-line)
  ("l" helm-end-of-buffer)
  ;; beginning/end
  ("g" helm-beginning-of-buffer)
  ("G" helm-end-of-buffer)
  ;; scroll
  ("K" helm-scroll-other-window-down)
  ("J" helm-scroll-other-window)
  ;; mark
  ("m" helm-toggle-visible-mark)
  ("t" helm-toggle-all-marks)
  ("U" helm-unmark-all)
  ;; exit
  ("<escape>" keyboard-escape-quit "" :exit t)
  ("o" keyboard-escape-quit :exit t)
  ("i" nil)
  ;; sources
  ("}" helm-next-source)
  ("{" helm-previous-source)
  ;; rest
  ("H" helm-help)
  ("v" helm-execute-persistent-action)
  ("d" helm-buffer-run-kill-persistent)
  ("f" helm-follow-mode))

(define-key helm-map (kbd "C-o") 'helm-like-unite/body)

(defhydra hydra-global-org (:color blue :hint nil)
  "
Timer^^         ^Clock^           ^Capture^
--------------------------------------------------
s_t_art         _w_ clock in      _c_apture
 _s_top         _o_ clock out     _l_ast capture
_r_eset         _j_ clock goto
_p_rint
"
  ("t" org-timer-start)
  ("s" org-timer-stop)
  ;; Need to be at timer
  ("r" org-timer-set-timer)
  ;; Print timer value to buffer
  ("p" org-timer)
  ("w" (org-clock-in '(4)))
  ("o" org-clock-out)
  ;; Visit the clocked task from any buffer
  ("j" org-clock-goto)
  ("c" org-capture)
  ("l" org-capture-goto-last-stored))

(define-key org-mode-map (kbd "C-o") 'hydra-global-org/body)

(provide 'misc-conf)
