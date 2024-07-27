#!/usr/bin/env -S emacs -x
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-upgrade-all)
