(set-face-attribute 'default nil
                    :family "Iosevka"
                    :height 200)
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

(defconst my-formatters-alist
  '((python-ts-mode . ("black"))
    (java-ts-mode   . ("google-java-format" "-r"))))
(defun my-format-buffer ()
  (interactive)
  (let ((formatter (alist-get major-mode my-formatters-alist)))
    (cond
     (formatter
      (let ((command (car formatter))
            (args (append (cdr formatter) (list buffer-file-name))))
        (apply #'call-process command nil nil t args))
      (revert-buffer t t t))
     (t
      (message "No formatter found for major mode: %s" major-mode)))))

(add-hook 'before-save-hook #'delete-trailing-whitespace)
(add-hook 'prog-mode-hook
          (lambda ()
            (when (and treesit-font-lock-feature-list
                       (<= treesit-font-lock-level 1))
              (setq-local treesit-font-lock-feature-list
                          (cons '(string comment)
                                treesit-font-lock-feature-list))
              (treesit-font-lock-recompute-features))))

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
 '(custom-enabled-themes '(modus-vivendi))
 '(delete-selection-mode t)
 '(font-lock-maximum-decoration nil)
 '(frame-resize-pixelwise t)
 '(indent-tabs-mode nil)
 '(indicate-empty-lines t)
 '(java-ts-mode-indent-offset 2)
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
