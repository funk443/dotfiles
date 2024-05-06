(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(set-face-attribute 'default nil
                    :family "IBM Plex Mono"
                    :height 280)
(set-face-attribute 'fixed-pitch nil
                    :inherit 'default)

(use-package treesit-auto
  :ensure t
  :custom (treesit-auto-install 'prompt)
  :config
  (global-treesit-auto-mode))

(use-package magit
  :ensure t)

(use-package markdown-mode
  :ensure t)

(defconst rubbish-dir (concat user-emacs-directory "rubbish")
  "Directory for Emacs to dump auto save files and backup files.")
(unless (file-directory-p rubbish-dir)
  (make-directory rubbish-dir))

(add-hook 'before-save-hook #'delete-trailing-whitespace)
(keymap-global-set "C-c C-p" #'compile)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auth-source-save-behavior nil)
 '(auto-save-file-name-transforms `((".*" ,rubbish-dir t)))
 '(backup-directory-alist `((".*" \, rubbish-dir)))
 '(column-number-mode t)
 '(dabbrev-case-fold-search nil)
 '(delete-selection-mode t)
 '(dired-dwim-target t)
 '(frame-resize-pixelwise t)
 '(indent-tabs-mode nil)
 '(indicate-empty-lines t)
 '(initial-buffer-choice t)
 '(initial-frame-alist '((vertical-scroll-bars) (fullscreen . maximized)))
 '(initial-scratch-message
   (format-time-string ";; Imagine using GNU Emacs in %Y, are you a dinosaur?\12;; Still better than using a PROPRIETARY editor in a browser ig.\12\12"))
 '(menu-bar-mode nil)
 '(mode-line-compact t)
 '(package-selected-packages '(treesit-auto markdown-mode magit))
 '(save-interprogram-paste-before-kill t)
 '(scalable-fonts-allowed t)
 '(scroll-bar-mode nil)
 '(scroll-conservatively 101)
 '(scroll-error-top-bottom t)
 '(scroll-preserve-screen-position 1)
 '(size-indication-mode t)
 '(tool-bar-mode nil)
 '(x-select-enable-clipboard-manager nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
