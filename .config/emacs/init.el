;; Configuration options:
;;   --prefix=/home/id/.local
;;   --with-native-compilation=yes
;;   --with-pgtk=yes
;;   --with-tree-sitter=yes
;;   CFLAGS=-O2

(load-theme 'modus-vivendi t)
(set-face-attribute 'default nil
                    :family "Iosevka"
                    :height 280)
(set-face-attribute 'fixed-pitch nil
                    :inherit 'default
                    :family "Iosevka")
(set-face-attribute 'variable-pitch nil
                    :inherit 'default
                    :family "Iosevka Aile")

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(use-package magit
  :ensure t)

(use-package vterm
  :ensure t)

(use-package treesit-auto
  :ensure t
  :config (treesit-auto-add-to-auto-mode-alist))

(use-package markdown-mode
  :ensure t
  :config
  (add-to-list 'major-mode-remap-alist '(markdown-mode . gfm-mode)))

(use-package edit-indirect
  :ensure t
  :after markdown-mode)

(defconst rubbish-dir (concat user-emacs-directory "rubbish")
  "Directory for Emacs to dump auto save files and backup files.")
(unless (file-directory-p rubbish-dir)
  (make-directory rubbish-dir))

(defun my-remove-fireworks ()
  "Syntax highlighting is harmful.

This function removes syntax highlighting for most of the things
(except string and comments) in tree-sitter major modes when
`treesit-font-lock-level' is set to 1."
  (when (and treesit-font-lock-feature-list
             (< treesit-font-lock-level 2))
    (setq-local treesit-font-lock-feature-list
                '((string comment)))
    (treesit-font-lock-recompute-features)))

(add-hook 'prog-mode-hook #'my-remove-fireworks)
(add-hook 'markdown-mode-hook (lambda () (auto-fill-mode 1)))
(add-hook 'before-save-hook #'delete-trailing-whitespace)
(add-hook 'python-ts-mode-hook
          (lambda () (setq python-eldoc-get-doc nil)))

(keymap-global-set "C-c C-p" #'compile)
(keymap-global-unset "C-z")
(keymap-global-unset "C-x C-z")

(add-to-list 'auto-mode-alist '("\\.[mc]js\\'" . js-ts-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auth-source-save-behavior nil)
 '(auto-save-file-name-transforms `((".*" ,rubbish-dir t)))
 '(backup-directory-alist `((".*" \, rubbish-dir)))
 '(c-ts-mode-indent-offset 4)
 '(case-fold-search nil)
 '(case-replace nil)
 '(column-number-mode t)
 '(current-language-environment "UTF-8")
 '(dabbrev-case-fold-search nil)
 '(delete-selection-mode t)
 '(dired-dwim-target t)
 '(dired-listing-switches "-alh")
 '(fill-column 72)
 '(find-ls-option '("-exec ls -alh {} +" . "-alh"))
 '(font-lock-maximum-decoration nil)
 '(frame-resize-pixelwise t)
 '(indent-tabs-mode nil)
 '(indicate-empty-lines t)
 '(inferior-lisp-program "sbcl")
 '(inhibit-startup-screen t)
 '(initial-buffer-choice t)
 '(initial-frame-alist '((vertical-scroll-bars) (fullscreen . maximized)))
 '(initial-scratch-message ";; EMACS: Escape, Meta, Alt, Control, and Shift.\12\12")
 '(menu-bar-mode nil)
 '(mode-line-compact t)
 '(modus-themes-bold-constructs t)
 '(modus-themes-inhibit-reload nil)
 '(modus-themes-italic-constructs t)
 '(modus-themes-mixed-fonts t)
 '(org-src-preserve-indentation t)
 '(org-startup-truncated nil)
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
