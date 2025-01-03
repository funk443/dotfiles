(set-face-attribute 'default nil
                    :family "Iosevka"
                    :height 160)
(set-face-attribute 'fixed-pitch nil
                    :family "Iosevka"
                    :inherit 'default)
(set-face-attribute 'variable-pitch nil
                    :family "Iosevka Slab"
                    :inherit 'default)

(use-package package
  :custom
  (package-archives
   '(("melpa"  . "https://melpa.org/packages/")
     ("gnu"    . "https://elpa.gnu.org/packages/")
     ("nongnu" . "https://elpa.nongnu.org/nongnu/"))))

(use-package catppuccin-theme
  :ensure t
  :config (load-theme 'catppuccin t))

(use-package vterm
  :ensure t)

(use-package magit
  :ensure t)

(use-package treesit-auto
  :ensure t
  :config
  (treesit-auto-add-to-auto-mode-alist))

(use-package markdown-mode
  :ensure t
  :hook
  (markdown-mode . auto-fill-mode)
  :config
  (add-to-list 'major-mode-remap-alist '(markdown-mode . gfm-mode)))

(defconst my-rubbish-dir (concat user-emacs-directory "rubbish"))
(unless (file-directory-p my-rubbish-dir)
  (make-directory my-rubbish-dir))
(setopt backup-directory-alist `((".*" . ,my-rubbish-dir)))

(defconst my-formatters-alist '((python-ts-mode . ("black"))
                                (java-ts-mode   . ("google-java-format" "-r"))))
(defun my-format-buffer ()
  (interactive)
  (let* ((formatter (append (alist-get major-mode my-formatters-alist)
                            (list buffer-file-name)))
         (command (car formatter))
         (args (cdr formatter)))
    (apply #'call-process command nil nil t args)))

(add-hook 'before-save-hook #'delete-trailing-whitespace)

(keymap-global-unset "C-z")
(keymap-global-unset "C-x C-z")
(keymap-global-set "C-c C-<return> C-c" #'compile)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(case-fold-search nil)
 '(case-replace nil)
 '(column-number-mode t)
 '(current-language-environment "UTF-8")
 '(delete-selection-mode t)
 '(font-lock-maximum-decoration nil)
 '(frame-resize-pixelwise t)
 '(indent-tabs-mode nil)
 '(indicate-empty-lines t)
 '(menu-bar-mode nil)
 '(package-selected-packages '(catppuccin-theme magit markdown-mode treesit-auto vterm))
 '(save-interprogram-paste-before-kill t)
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil)
 '(treesit-font-lock-level 1)
 '(x-select-enable-clipboard-manager nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
