#!/usr/bin/env -S emacs -x
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(when (< (length command-line-args) 4)
  (message "Error: package name was not provided\n")
  (message "Usage: %s <package>" (nth 2 command-line-args))
  (kill-emacs 1))

(setq package-list (nthcdr 3 command-line-args))

(defun install-packages (package-list)
  "Install all packages from a given list of package names as strings."
  (dolist (pkg package-list)
    (package-install (intern pkg))))

(install-packages package-list)
