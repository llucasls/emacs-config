(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(use-package apache-mode)

(use-package web-mode
  :mode (("\\.php\\'" . web-mode)
         ("\\.phtml\\'" . web-mode)
         ("\\.tpl\\.php\\'" . web-mode)
         ("\\.[agj]sp\\'" . web-mode)
         ("\\.as[cp]x\\'" . web-mode)
         ("\\.erb\\'" . web-mode)
         ("\\.mustache\\'" . web-mode)
         ("\\.djhtml\\'" . web-mode)
         ("\\.html\\'" . web-mode)
         ("\\.css\\'" . web-mode)
         ("\\.jinja\\'" . web-mode)
         ("\\.js\\'" . web-mode)))

(use-package evil)

(use-package undo-fu)

(use-package editorconfig)

(use-package rust-mode)

(use-package lsp-mode)

;(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
