#!/usr/bin/env -S emacs -x
(when (not (native-comp-available-p))
  (kill-emacs 1))
