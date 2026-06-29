;; -*- lexical-binding: t; -*-

(when (display-graphic-p)
  (set-face-attribute 'default nil
                      :family "Roboto Mono"
                      :height 200)
  (set-face-attribute 'fixed-pitch nil
                      :family "Roboto Mono"
                      :inherit 'default)
  (set-face-attribute 'fixed-pitch-serif nil
                      :family "Courier Prime Code"
                      :inherit 'default)
  (set-face-attribute 'variable-pitch nil
                      :family "Roboto"
                      :inherit 'default)
  (set-fontset-font nil 'han
                    (font-spec :family "Noto Sans CJK TC")
                    nil 'prepend)
  (set-fontset-font nil 'bopomofo
                    (font-spec :family "Noto Sans CJK TC")
                    nil 'prepend)
  (set-fontset-font nil 'kana
                    (font-spec :family "Noto Sans CJK JP")
                    nil 'prepend))

(use-package package
  :custom
  (package-archives
   '(("melpa"  . "https://melpa.org/packages/")
     ("gnu"    . "https://elpa.gnu.org/packages/")
     ("nongnu" . "https://elpa.nongnu.org/nongnu/"))))

(use-package eglot
  :custom
  (eglot-autoshutdown t))

(use-package magit
  :ensure t)

(use-package treesit-auto
  :ensure t
  :config
  (treesit-auto-add-to-auto-mode-alist))

(defconst id/rubbish-dir (concat user-emacs-directory "rubbish"))
(unless (file-directory-p id/rubbish-dir)
  (make-directory id/rubbish-dir))
(setopt backup-directory-alist `(("." . ,id/rubbish-dir)))

(add-hook 'before-save-hook #'delete-trailing-whitespace)
(add-hook 'text-mode-hook (lambda () (auto-fill-mode 1)))
(add-hook 'compilation-filter-hook #'ansi-color-compilation-filter)

(keymap-global-unset "C-z")
(keymap-global-unset "C-x C-z")
(keymap-global-set "<f5>" #'compile)

;; Set indent offset of major modes here, so I can use the `tab-width` variable.
(setopt tab-width 4
        go-ts-mode-indent-offset tab-width
        typescript-ts-mode-indent-offset tab-width
        json-ts-mode-indent-offset tab-width)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auth-source-save-behavior nil)
 '(column-number-mode t)
 '(current-language-environment "UTF-8")
 '(custom-enabled-themes '(modus-vivendi))
 '(delete-selection-mode t)
 '(dired-dwim-target 'dired-dwim-target-next)
 '(dired-listing-switches "-alh")
 '(fill-column 80)
 '(frame-resize-pixelwise t)
 '(grep-command "rg -nH --null -e ")
 '(indent-tabs-mode nil)
 '(indicate-empty-lines t)
 '(inhibit-startup-screen t)
 '(menu-bar-mode nil)
 '(package-selected-packages '(magit treesit-auto))
 '(save-interprogram-paste-before-kill t)
 '(scroll-bar-mode nil)
 '(sentence-end-double-space nil)
 '(shell-command-prompt-show-cwd t)
 '(tool-bar-mode nil)
 '(which-key-mode t)
 '(x-select-enable-clipboard-manager nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
