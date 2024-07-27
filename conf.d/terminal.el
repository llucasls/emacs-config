(defun my-open-terminal ()
  (interactive)
  (term (executable-find "bash")))

(defun my-term-handle-exit (&optional process-name msg)
  (message "%s: %s" process-name (string-trim msg))
  (setq maximum-scroll-margin 0.33)
  (kill-buffer (current-buffer)))

(defun my-term-enter-hook ()
  "Function to run when entering terminal mode."
  (evil-emacs-state)
  (setq display-line-numbers nil
        maximum-scroll-margin 0.0))

;(setq maximum-scroll-margin 0.33)

(defun my-term-exit-hook ()
  "Function to run when exiting terminal mode."
  (evil-normal-state)
  (setq display-line-numbers 'relative))

(defun my-restore-scroll-margin ()
  "Restore `maximum-scroll-margin' to its proper value."
  (interactive)
  (setq maximum-scroll-margin 0.33))

(add-hook 'term-mode-hook #'my-term-enter-hook)
(add-hook 'term-mode-exit-hook #'my-term-exit-hook)
;(add-hook 'evil-normal-state-entry-hook (lambda () (interactive) (setq maximum-scroll-margin 0.33)))

(advice-add 'term-handle-exit :after 'my-term-handle-exit)
