; FUNCTIONS

(defun my-insert-parentheses ()
  "Insert `()` and move the cursor back one character if an open parenthesis is
typed."
  (interactive)
  (insert "()")
  (backward-char))

(defun my-insert-brackets ()
  "Insert `[]` and move the cursor back one character if an open brackets is
typed."
  (interactive)
  (insert "[]")
  (backward-char))

(defun my-insert-braces ()
  "Insert `{}` and move the cursor back one character if an open braces is
typed."
  (interactive)
  (insert "{}")
  (backward-char))

(defun my-insert-quotes ()
  "Insert `\"\"` and move the cursor back one character if a single `\"` is
typed."
  (interactive)
  (insert "\"\"")
  (backward-char))

(defun my-insert-single-quotes ()
  "Insert `''` and move the cursor back one character if a single `'` is
typed."
  (interactive)
  (insert "''")
  (backward-char))

(defun is-lisp-p ()
  (or (eq major-mode 'lisp-mode)
      (eq major-mode 'emacs-lisp-mode)
      (eq major-mode 'lisp-interaction-mode)))

(defun is-in-braces-p()
  "A boolean that indicates whether the point is between braces `{}'.
It doesn't accept whitespace characters between the braces."
  (and (eq (preceding-char) 123) (eq (following-char) 125)))

(defun is-in-parenthesis-p()
  "A boolean that indicates whether the point is between parenthesis `()'.
It doesn't accept whitespace characters between the parenthesis."
  (and (eq (preceding-char) 40) (eq (following-char) 41)))

(defun is-in-brackets-p()
  "A boolean that indicates whether the point is between brackets `[]'.
It doesn't accept whitespace characters between the brackets."
  (and (eq (preceding-char) 91) (eq (following-char) 93)))

(defun my-enable-single-quotes ()
  "Enable single quotes behavior in non-lisp modes."
  (when (not (is-lisp-p))
    (local-set-key "'" 'my-insert-single-quotes)))

(defun insert-tab-action () (interactive)
  (if (looking-back "^\s*" nil)
    (evil-shift-right-line 1)
    (insert "\t")))

(defun insert-del-action () (interactive)
  (if (looking-back "^\s*" nil)
    (evil-shift-left-line 1)
    (delete-char -1)))

(defun get-first-non-whitespace-column ()
  "Return the column number of the first non-whitespace character
in the current line."
  (save-excursion
    (back-to-indentation)
    (current-column)))

;(defun insert-ret-action ()
;  "Insert a newline and indent, leaving blank lines when between braces."
;  (interactive)
;  (if (or (is-in-braces-p) (is-in-parenthesis-p) (is-in-brackets-p))
;    (let ((column (get-first-non-whitespace-column)))
;      (evil-ret)
;      (indent-to-column column)
;      (evil-insert-newline-above)
;      (indent-to-column column)
;      (insert-tab))
;    (newline)))

(defun insert-ret-action ()
  "Insert a newline and indent, leaving blank lines when between braces."
  (interactive)
  (if (or (is-in-braces-p) (is-in-parenthesis-p) (is-in-brackets-p))
      (let ((column (get-first-non-whitespace-column)))
        (evil-ret)
        (indent-to-column column)
        (evil-insert-newline-above)
        (indent-to-column column)
        (insert-tab))
    (newline-and-indent)))

(defun toggle-line-numbers ()
  "Toggle between relative and absolute line numbers."
  (interactive)
  (setq display-line-numbers
    (if (eq display-line-numbers t) 'relative t)))

(defvar leader ","
  "The leader key.")

(defun leader (&rest keys)
  "A function that translates `leader' into a key. It concatenates its
arguments into a string of characters separated by spaces, and prepends it
with a single leader character. You can pass the `leader' variable as an
argument, in order to use the leader key multiple times. It requires a
variable of the same name to be defined."
  (mapconcat 'identity (cons leader keys) " "))

; MAPPINGS

(keymap-set evil-insert-state-map "(" 'my-insert-parentheses)

(keymap-set evil-insert-state-map "[" 'my-insert-brackets)

(keymap-set evil-insert-state-map "{" 'my-insert-braces)

(keymap-set evil-insert-state-map "\"" 'my-insert-quotes)

(add-hook 'evil-insert-state-entry-hook 'my-enable-single-quotes)

(evil-set-initial-state 'Info-mode 'emacs)

(keymap-set evil-insert-state-map "TAB" 'insert-tab-action)

(keymap-set evil-insert-state-map "DEL" 'insert-del-action)

(keymap-set evil-normal-state-map "<f3>" 'toggle-line-numbers)

(keymap-set evil-normal-state-map (leader "t") 'my-open-terminal)

(evil-define-key 'insert web-mode-map
  (kbd "RET") 'insert-ret-action)

(evil-define-key 'insert css-mode-map
  (kbd "RET") 'insert-ret-action)

(evil-define-key 'insert js-mode-map
  (kbd "RET") 'insert-ret-action)
