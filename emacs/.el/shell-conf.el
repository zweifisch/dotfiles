(evil-define-key 'normal 'eshell-mode-map
  "^" 'eshell-bol
  "[[" 'eshell-previous-prompt
  "]]" 'eshell-next-prompt
  "gk" 'eshell-previous-prompt
  "gj" 'eshell-next-prompt)

(evil-define-key '(normal insert) 'eshell-mode-map
  (kbd "C-k") 'eshell-previous-prompt
  (kbd "C-j") 'eshell-next-prompt
  (kbd "C-n") 'eshell-next-matching-input-from-input
  (kbd "C-p") 'eshell-previous-matching-input-from-input)

(provide 'shell-conf)
