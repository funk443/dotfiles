(set-face-attribute 'default nil
                    :family "IBM Plex Mono"
                    :height 280)
(set-face-attribute 'fixed-pitch nil
                    :inherit 'default)
(set-face-attribute 'variable-pitch nil
                    :inherit 'default
                    :family "IBM Plex Sans")

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(use-package catppuccin-theme
  :ensure t
  :custom (catppuccin-flavor 'latte)
  :config (load-theme 'catppuccin t))

(use-package treesit-auto
  :ensure t
  :config (treesit-auto-add-to-auto-mode-alist))

(use-package magit
  :ensure t)

(use-package vterm
  :ensure t
  :custom (vterm-copy-mode-remove-fake-newlines t))

(use-package markdown-mode
  :ensure t)

(defconst rubbish-dir (concat user-emacs-directory "rubbish")
  "Directory for Emacs to dump auto save files and backup files.")
(unless (file-directory-p rubbish-dir)
  (make-directory rubbish-dir))

(add-hook 'before-save-hook #'delete-trailing-whitespace)
(keymap-global-set "C-c C-p" #'compile)
(keymap-global-unset "C-z")
(keymap-global-unset "C-x C-z")
(add-to-list 'auto-mode-alist '("\\.[mc]js\\'" . javascript-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auth-source-save-behavior nil)
 '(auto-save-file-name-transforms `((".*" ,rubbish-dir t)))
 '(backup-directory-alist `((".*" \, rubbish-dir)))
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(current-language-environment "UTF-8")
 '(dabbrev-case-fold-search nil)
 '(delete-selection-mode t)
 '(dired-dwim-target t)
 '(dired-listing-switches "-alh")
 '(frame-resize-pixelwise t)
 '(indent-tabs-mode nil)
 '(indicate-empty-lines t)
 '(initial-buffer-choice t)
 '(initial-frame-alist '((vertical-scroll-bars) (fullscreen . maximized)))
 '(initial-scratch-message ";; EMACS: Escape, Meta, Alt, Control, and Shift.\12\12")
 '(menu-bar-mode nil)
 '(mode-line-compact t)
 '(package-selected-packages '(treesit-auto vterm markdown-mode magit catppuccin-theme))
 '(save-interprogram-paste-before-kill t)
 '(scalable-fonts-allowed t)
 '(scroll-bar-mode nil)
 '(scroll-error-top-bottom t)
 '(size-indication-mode t)
 '(tool-bar-mode nil)
 '(x-select-enable-clipboard-manager nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
