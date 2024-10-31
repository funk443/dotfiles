;;; Configuration options:
;;   --prefix=/home/id/.local
;;   --with-native-compilation=yes
;;   --with-pgtk=yes
;;   --with-tree-sitter=yes
;;   CFLAGS="-O2 -g3"

;;; Package repo configurations
(use-package package
  :custom
  (package-archives
   '(("melpa" . "https://melpa.org/packages/")
     ("gnu" . "https://elpa.gnu.org/packages/")
     ("nongnu" . "https://elpa.nongnu.org/nongnu/"))))

;;; Fonts and themes configurations
(set-face-attribute 'default nil
                    :family "IBM Plex Mono"
                    :height 280)
(set-face-attribute 'fixed-pitch nil
                    :inherit 'default
                    :family "IBM Plex Mono")
(set-face-attribute 'variable-pitch nil
                    :inherit 'default
                    :family "IBM Plex Sans")

(use-package modus-themes
  :init
  (require-theme 'modus-themes)
  :custom
  (modus-themes-bold-constructs t)
  (modus-themes-inhibit-reload nil)
  (modus-themes-italic-constructs t)
  (modus-themes-mixed-fonts t)
  :config
  (load-theme 'modus-vivendi t))

;;; Built-in packages configurations.
(use-package dired
  :custom
  (dired-dwim-target t)
  (dired-listing-switches "-alh"))

(use-package org
  :custom
  (org-src-preserve-indentation t)
  (org-startup-truncated nil))

;;; External packages configurations.
(use-package magit
  :ensure t)

(use-package treesit-auto
  :ensure t
  :config
  (treesit-auto-add-to-auto-mode-alist 'all))

(use-package vterm
  :ensure t)

;;; Programming languages configurations
(use-package markdown-mode
  :ensure t
  :hook
  (markdown-mode . auto-fill-mode)
  :config
  (add-to-list 'major-mode-remap-alist '(markdown-mode . gfm-mode)))

(use-package edit-indirect
  :ensure t
  :after markdown-mode)

(use-package c-ts-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.h\\'" . c-ts-mode))
  :custom
  (c-ts-mode-indent-offset 4)
  (c-ts-mode-indent-style 'k&r)
  :bind
  (:map c-ts-mode-map
        ("C-c C-\\" . my-c-format-buffer)))

;;; My defined variables and functions.
(defconst rubbish-dir (concat user-emacs-directory "rubbish")
  "Directory for Emacs to dump auto save files and backup files.")
(unless (file-directory-p rubbish-dir)
  (make-directory rubbish-dir))

(defun my-remove-fireworks ()
  (when (< treesit-font-lock-level 2)
    (setq-local treesit-font-lock-feature-list
                '((string comment preprocessor)))
    (treesit-font-lock-recompute-features)))

(defun my-c-format-buffer ()
  (interactive)
  (if (executable-find "astyle")
      (let ((line (line-number-at-pos)))
        (shell-command-on-region
         (point-min) (point-max)
         "astyle --style=kr"
         nil
         'no-mark)
        (goto-line line))
    (message "ERROR: `astyle` not found.")))

;;; Hooks and keymaps.
(add-hook 'before-save-hook #'delete-trailing-whitespace)
(add-hook 'prog-mode-hook #'my-remove-fireworks)

(keymap-global-set "C-c C-p" #'compile)
(keymap-global-unset "C-z")
(keymap-global-unset "C-x C-z")

;;; Emacs custom stuffs.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auth-source-save-behavior nil)
 '(auto-save-file-name-transforms `((".*" ,rubbish-dir t)))
 '(backup-directory-alist `((".*" \, rubbish-dir)))
 '(case-fold-search nil)
 '(case-replace nil)
 '(column-number-mode t)
 '(current-language-environment "UTF-8")
 '(dabbrev-case-fold-search nil)
 '(delete-selection-mode t)
 '(fill-column 72)
 '(find-ls-option '("-exec ls -ldh {} +" . "-ldh"))
 '(font-lock-maximum-decoration nil)
 '(frame-resize-pixelwise t)
 '(indent-tabs-mode nil)
 '(indicate-empty-lines t)
 '(inhibit-startup-screen t)
 '(initial-buffer-choice t)
 '(initial-frame-alist '((vertical-scroll-bars) (fullscreen . maximized)))
 '(initial-scratch-message ";; EMACS: Escape, Meta, Alt, Control, and Shift.\12\12")
 '(menu-bar-mode nil)
 '(mode-line-compact t)
 '(package-selected-packages '(edit-indirect magit markdown-mode treesit-auto vterm))
 '(read-buffer-completion-ignore-case t)
 '(ring-bell-function 'ignore)
 '(save-interprogram-paste-before-kill t)
 '(scalable-fonts-allowed t)
 '(scroll-bar-mode nil)
 '(scroll-error-top-bottom t)
 '(show-paren-delay 0)
 '(size-indication-mode t)
 '(tab-width 4)
 '(tool-bar-mode nil)
 '(treesit-font-lock-level 1)
 '(visual-line-fringe-indicators '(right-triangle right-curly-arrow))
 '(which-key-mode t)
 '(x-select-enable-clipboard-manager nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'scroll-left 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)
