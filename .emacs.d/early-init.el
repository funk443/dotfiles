(setq initial-scratch-message nil
      custom-file (locate-user-emacs-file "custom_var.el")
      gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.75)

(load custom-file 'noerror 'nomessage)
(unless (file-directory-p "~/.emacs.d/autosave")
  (make-directory "~/.emacs.d/autosave"))
(unless (file-directory-p "~/.emacs.d/backup")
  (make-directory "~/.emacs.d/backup"))
(unless (file-directory-p "~/.emacs.d/undo_tree")
  (make-directory "~/.emacs.d/undo_tree"))

(add-to-list 'default-frame-alist '(font . "NovaMono-12"))

(set-frame-parameter (selected-frame) 'alpha '(90 . 75))
(add-to-list 'default-frame-alist '(alpha . (90 . 75)))

(defun display-startup-echo-area-message ()
  (message "ad astra per aspera"))
