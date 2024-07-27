#!/usr/bin/env -S emacs -x
(setq load-path (cons (locate-user-emacs-file "") load-path))
(load "conf.d/melpa-packages" 'nomessage 'noerror)

(setq stdout t)
(setq stderr #'external-debugging-output)
(setq byte-compile-warnings nil)

(defun printf (format-string &rest objects)
  "Write formatted output."
  (princ (apply 'format format-string objects) t))

(defun fprintf (output-stream format-string &rest objects)
  "Write formatted output to a specific stream. It currently accepts
either `stdout' or `stderr' as its first argument."
  (princ (apply 'format format-string objects) output-stream))

(setq my-table (make-hash-table
  :test 'equal))

(puthash "-b" "batch" my-table)
(puthash "-c" "byte-code" my-table)
(puthash "-n" "native" my-table)
(puthash "-o" "output" my-table)
(puthash "-r" "recursive" my-table)
(puthash "-h" "help" my-table)

(defun compile-byte-code (files)
  "Compile input files into byte-code."
  (dolist (file files)
    (progn
      (printf "compiling \033[34m%s\033[0m into byte-code: " file)
      (condition-case
        err (let ((result (byte-compile-file file)))
              (if result
                (if (string= result t)
                  (printf "\033[32m%s\033[0m\n" result)
                  (printf "%s\n" result))
                (printf "\033[31m%s\033[0m\n" result)))
        (file-missing
          (progn
            (printf
              "\033[31m%s\033[0m\nError: the file %s doesn't exist.\n"
              nil (nth 3 err))
            (setq return-code 1)))
        (t (progn
             (printf "\033[31m%s\033[0m\n" nil)
             (dolist (msg err) (printf "%s " msg))
             (printf "\n")
             (setq return-code -1)))))))

(defun compile-native (arg)
  "Calls native-copile")

(defun compile-directory (arg)
  "Compiles every source code file in a given directory.")

;(defun compile-batch (&optional arg)
;  "Calls batch-byte-compile")

;(defun compile-batch-native (&optional arg)
;  "Calls batch-native-compile")

(defun parse-opts (argv)
  "do nothing for now")

(defun parse-args (argv)
  "do nothing for now")

(setq argv (nthcdr 3 command-line-args))

(setq arg nil)

(compile-byte-code argv)

; Process options
;(while (and argv (not (string= arg "--")))
;       (setq arg (pop argv))
;       (if (not (string= arg "--"))
;       (progn
;         (princ (format "option %s\n" arg) t))))

; Process arguments
;(dolist (arg argv)
;  (princ (format "byte-compile %s\n" arg) t))

;(dolist (file argv)
;  (byte-compile-file file))

;(message "%s" my-table)
;(message "%s" (gethash "-r" my-table))

;(message "%s" (native-comp-available-p))

;; Exit with the appropriate return code
(when (boundp 'return-code)
  (kill-emacs return-code))
