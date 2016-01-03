
(use-package evil-anzu :ensure t)

;; (setq display-time-day-and-date t)
;; (setq display-time-24hr-format t)
;; (setq display-time-mail-string "")

(add-hook 'org-mode-hook '(lambda () (setq mode-name "ꙮ")))
(add-hook 'clojure-mode-hook '(lambda () (setq mode-name "λ")))
(add-hook 'emacs-lisp-mode-hook (lambda () (setq mode-name "ξ")))
(add-hook 'eshell-mode-hook (lambda () (setq mode-name "$")))

(defun set-simple-mode-line-face ()
  ""
  (make-face 'mode-line-input-method-title-face)
  (make-face 'mode-line-editable-face)
  (make-face 'mode-line-read-only-face)
  (make-face 'mode-line-modified-face)
  (make-face 'mode-line-80+-face)
  (make-face 'mode-line-position-face)

  (set-face-attribute 'mode-line nil
                      :height (face-attribute 'default :height)
                      :foreground "white"
                      :background "black"
                      :inverse-video nil
                      :box (list :line-width 10 :color "black" :style nil))
  (set-face-attribute 'mode-line-inactive nil
                      :height (- (face-attribute 'default :height) 20)
                      :foreground "#888"
                      :background "black"
                      :inverse-video nil
                      :box (list :line-width 5 :color "black" :style nil))
  (set-face-attribute 'mode-line-editable-face nil
                      :inherit 'mode-line-face
                      :foreground "sky blue")
  (set-face-attribute 'mode-line-input-method-title-face nil
                      :inherit 'mode-line-face
                      :foreground "dark orange"
                      :background "#000")
  (set-face-attribute 'mode-line-read-only-face nil
                      :inherit 'mode-line-face
                      :foreground "white")
  (set-face-attribute 'mode-line-modified-face nil
                      :inherit 'mode-line-face
                      :foreground "pink")
  (set-face-attribute 'mode-line-80+-face nil
                      :inherit 'mode-line-face
                      :foreground "dark orange")
  (set-face-attribute 'mode-line-position-face nil
                      :inherit 'mode-line-face))

(setq simple-mode-line-format
   '(;; input method
     (:propertize (:eval (if current-input-method-title current-input-method-title "")) 'face mode-line-input-method-title-face)
     " "
     (:eval
      (cond ((eq buffer-file-coding-system 'utf-8-unix) "")
            (t "%z ")))
     (:eval
      (cond (buffer-read-only
             (propertize "%b" 'face 'mode-line-read-only-face))
            ((buffer-modified-p)
             (propertize "%b" 'face 'mode-line-modified-face))
            (t (propertize "%b" 'face 'mode-line-editable-face))))
     " "
     ;; is remote or local?
     (:eval (if buffer-file-name mode-line-remote ""))
     (:eval (if buffer-file-name " " ""))
     ;; Display a current cursor position
     (:propertize (:eval (if buffer-file-name "%l" "")) 'face mode-line-position-face)
     (:eval (propertize (if buffer-file-name ":%c " "")
                        'face
                        (if (>= (current-column) 80) 'mode-line-80+-face
                          'mode-line-position-face)))
     ;; Other buffer file infomations
     (:eval (if buffer-file-name "%p " ""))
     (:eval (if buffer-file-name "%I " ""))
     ;; vc mode
     (vc-mode vc-mode)
     " "
     ;; Major mode
     "%m"))

(setq-default mode-line-format nil)

(set-simple-mode-line-face)

(setq-default mode-line-format simple-mode-line-format)

(provide 'mode-line-conf)
