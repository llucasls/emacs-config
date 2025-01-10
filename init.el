(setq native-comp-jit-compilation nil)
(setq native-comp-jit-compilation-deny-list '("init\\.el" "conf\\.d\\/.+\\.el"))
(defun load-module (module &rest args)
  "Load user-defined Elisp module by reading a file name relative to
`user-emacs-directory'. Passes any extra arguments to `load'."
  (apply
    'load (file-name-sans-extension (locate-user-emacs-file module)) args))

(load-module "conf.d/melpa-packages")
(load-module "conf.d/keybindings")
(load-module "conf.d/tutorial")
(load-module "conf.d/caps-lock")

(setq custom-file (locate-user-emacs-file "conf.d/custom-vars.el"))
(load-module custom-file 'noerror 'nomessage)
(load-module "conf.d/terminal")

(setq inhibit-startup-screen nil)
(setq backup-directory-alist
      (list (cons "." (concat user-emacs-directory "backups"))))

(setq-default show-trailing-whitespace t)
(global-whitespace-mode 1)

(add-to-list 'default-frame-alist
             '(font . "Liberation Mono-10"))

(line-number-mode 1)
(column-number-mode 1)
(global-auto-revert-mode 1)
(recentf-mode 1)
