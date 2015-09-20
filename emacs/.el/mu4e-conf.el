(require 'mu4e)
(require 'gnus-dired)

(setq mu4e-maildir "~/mail")
(setq mu4e-drafts-folder "/Drafts")
(setq mu4e-sent-folder   "/Sent Messages")
(setq mu4e-trash-folder  "/Deleted Messages")

(setq mu4e-sent-messages-behavior 'delete)
(setq mu4e-get-mail-command "offlineimap")
(setq mu4e-html2text-command "html2text")
(setq message-kill-buffer-on-exit t)
(setq mu4e-headers-skip-duplicates t)


(defun gnus-dired-mail-buffers ()
  "Return a list of active message buffers."
  (let (buffers)
    (save-current-buffer
      (dolist (buffer (buffer-list t))
        (set-buffer buffer)
        (when (and (derived-mode-p 'message-mode)
                   (null message-sent-message-via))
          (push (buffer-name buffer) buffers))))
    (nreverse buffers)))

(setq gnus-dired-mail-mode 'mu4e-user-agent)
(add-hook 'dired-mode-hook 'turn-on-gnus-dired-mode)

(add-to-list 'helm-find-files-actions '("Attach files for mu4e" . helm-mu4e-attach) t)

(defun helm-mu4e-attach (_file)
  (gnus-dired-attach (helm-marked-candidates)))

(provide 'mu4e-conf)
