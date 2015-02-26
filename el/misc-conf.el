
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

(provide 'misc-conf)
