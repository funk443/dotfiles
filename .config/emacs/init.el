;; -*- lexical-binding: t; -*-

(when (display-graphic-p)
  (set-face-attribute 'default nil
                      :family "Source Code Pro"
                      :height 200)
  (set-face-attribute 'fixed-pitch nil
                      :family "Source Code Pro"
                      :inherit 'default)
  (set-face-attribute 'variable-pitch nil
                      :family "Source Sans 3"
                      :inherit 'default)
  (set-fontset-font nil 'han
                    (font-spec :family "Noto Sans CJK TC")
                    nil 'prepend)
  (set-fontset-font nil 'bopomofo
                    (font-spec :family "Noto Sans CJK TC")
                    nil 'prepend)
  (set-fontset-font nil 'kana
                    (font-spec :family "Noto Sans CJK JP")
                    nil 'prepend)
  (setopt modus-themes-variable-pitch-ui t))

(load-theme 'modus-vivendi t)

(use-package package
  :custom
  (package-archives
   '(("melpa"  . "https://melpa.org/packages/")
     ("gnu"    . "https://elpa.gnu.org/packages/")
     ("nongnu" . "https://elpa.nongnu.org/nongnu/"))))

(use-package tramp
  :custom
  (tramp-remote-process-environment
   '("ENV=''" "TMOUT=0" "CDPATH=" "HISTORY=" "MAIL=" "MAILCHECK="
     "MAILPATH=" "PAGER=cat" "autocorrect=" "correct="))
  :config
  (tramp-enable-method "run0"))

(use-package eglot
  :custom
  (eglot-autoshutdown t))

(use-package vterm
  :ensure t
  :bind
  ("<f6>" . vterm))

(use-package magit
  :ensure t)

(use-package notmuch
  :commands (notmuch)
  :init
  (add-to-list 'load-path "/usr/share/emacs/site-lisp")
  :custom
  (mail-specify-envelope-from t)
  (mail-envelope-from 'header)
  (message-signature "Best,\nID\n")
  (notmuch-fcc-dirs nil)
  (message-citation-line-function #'message-insert-formatted-citation-line)
  (message-citation-line-format "\nOn %Y-%m-%d %R%z, %f wrote:\n")
  (message-cite-reply-position 'below)
  (send-mail-function 'sendmail-send-it)
  (notmuch-saved-searches
   '((:name "emacs-devel"
            :query "tag:emacs-devel"
            :sort-order newest-first)
     (:name "inbox"
            :query "tag:inbox"
            :key "i"
            :sort-order newest-first)
     (:name "unread"
            :query "tag:unread"
            :key "u"
            :sort-order newest-first)
     (:name "flagged"
            :query "tag:flagged"
            :key "f"
            :sort-order newest-first)
     (:name "sent"
            :query "tag:sent"
            :key "t"
            :sort-order newest-first)
     (:name "drafts"
            :query "tag:draft"
            :key "d"
            :sort-order newest-first)
     (:name "all mail"
            :query "*"
            :key "a"
            :sort-order newest-first))))

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

(use-package edit-indirect
  :ensure t)

(defconst my-rubbish-dir (concat user-emacs-directory "rubbish"))
(unless (file-directory-p my-rubbish-dir)
  (make-directory my-rubbish-dir))
(setopt backup-directory-alist `(("." . ,my-rubbish-dir)))

(add-hook 'before-save-hook #'delete-trailing-whitespace)
(add-hook 'text-mode-hook (lambda () (auto-fill-mode 1)))
(add-hook 'compilation-filter-hook #'ansi-color-compilation-filter)

(keymap-global-unset "C-z")
(keymap-global-unset "C-x C-z")
(keymap-global-set   "<f5>" #'compile)

;; Set indent offset of major modes here.
(setopt tab-width                4
        go-ts-mode-indent-offset tab-width)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auth-source-save-behavior nil)
 '(case-fold-search nil)
 '(case-replace nil)
 '(column-number-mode t)
 '(current-language-environment "UTF-8")
 '(delete-selection-mode t)
 '(dired-dwim-target 'dired-dwim-target-next)
 '(dired-listing-switches "-alh")
 '(fill-column 80)
 '(frame-resize-pixelwise t)
 '(indent-tabs-mode nil)
 '(indicate-empty-lines t)
 '(inhibit-startup-screen t)
 '(menu-bar-mode nil)
 '(package-selected-packages '(edit-indirect magit markdown-mode treesit-auto vterm))
 '(save-interprogram-paste-before-kill t)
 '(scroll-bar-mode nil)
 '(sentence-end-double-space nil)
 '(shell-command-prompt-show-cwd t)
 '(tool-bar-mode nil)
 '(transient-mark-mode nil)
 '(which-key-mode t)
 '(x-select-enable-clipboard-manager nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
