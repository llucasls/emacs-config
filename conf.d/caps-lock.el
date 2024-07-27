(defun get-process-output (program &optional infile &rest args)
  "Execute a subprocess synchronously and return its result in a
  hash table."
  (with-temp-buffer
    (let ((status (apply 'call-process
                    program infile (buffer-name) nil args))
           (result (make-hash-table :size 2 :test 'eq)))
      (puthash 'status status result)
      (puthash 'output (buffer-string) result)
      result)))

(defun get-caps-lock-state ()
  (unless (executable-find "xset")
    (error "`xset' is not present in the user's `PATH'"))
  (with-temp-buffer
    (let* ((result (get-process-output "xset" nil "q"))
            (status (gethash 'status result))
            (output (gethash 'output result)))
      (unless (zerop status)
        (error "Process `xset' returned status %d" status))
      (insert output)
      (goto-char (point-min))
      (search-forward "caps lock:")
      (re-search-forward "\s+\\b\\(on\\|\\off\\)\\b")
      (match-string 1))))

(defun caps-lock-p ()
  "Return `t' if Caps Lock is on and `nil' if it is off.
  Signal an error if it can't be determined."
  (let ((state (get-caps-lock-state)))
    (cond
      ((string= state "on") t)
      ((string= state "off") nil)
      (t (error "Could not get caps lock state")))))

(defun turn-off-caps ()
  "Turn off Caps Lock if it is turned on."
  (unless (executable-find "xdotool")
    (error "`xdotool' is not present in the user's `PATH'"))
  (when (caps-lock-p)
    (call-process "xdotool" nil 0 nil "key" "Caps_Lock")))

(add-hook 'evil-insert-state-exit-hook #'turn-off-caps)
