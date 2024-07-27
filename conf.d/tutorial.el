(defvar tutorial-file nil
  "This variable holds the name of the tutorial file. It is expected to change
  every time the tutorial is opened, since it is a temporary copy.")

(defun open-temporary-copy ()
  (interactive)
  (let* ((original-file (expand-file-name "tutorial" user-emacs-directory))
         (temp-file (make-temp-file "tutorial-" nil ".txt")))
    (copy-file original-file temp-file t)
    (find-file temp-file)
    (setq tutorial-file temp-file)
    (evil-emacs-state)
    (add-hook 'kill-buffer-hook #'delete-temporary-copy)))

(defun exit-temporary-copy-emacs-mode ()
  "Switch back to Evil mode when exiting the tutorial buffer."
  (when (string= (buffer-name) "tutorial")
    (evil-emacs-state -1)))

(defun delete-temporary-copy ()
  "Delete temporary file."
  (when (and (boundp 'tutorial-file) tutorial-file)
    (delete-file tutorial-file)
    (setq tutorial-file nil))
  (remove-hook 'kill-buffer-hook #'delete-temporary-copy))

(add-hook 'kill-buffer-hook #'exit-temporary-copy-emacs-mode)

(keymap-set evil-normal-state-map "C-h t" 'open-temporary-copy)
