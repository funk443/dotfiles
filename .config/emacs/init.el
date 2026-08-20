;; -*- lexical-binding: t; -*-

(setopt custom-file (concat user-emacs-directory "custom.el"))
(load custom-file)

(use-package package
  :custom
  (package-archives
   '(("melpa"  . "https://melpa.org/packages/")
     ("gnu"    . "https://elpa.gnu.org/packages/")
     ("nongnu" . "https://elpa.nongnu.org/nongnu/"))))

(use-package eglot
  :custom
  (eglot-autoshutdown t))

(use-package paredit
  :ensure t
  :bind (:map paredit-mode-map
              ("M-r" . move-to-window-line-top-bottom)
              ("M-e" . paredit-raise-sexp))
  :hook (emacs-lisp-mode lisp-mode scheme-mode sly-mrepl-mode))

(use-package magit
  :ensure t)

(use-package fd-dired
  :ensure t)

(defconst +id-rubbish-dir+ (concat user-emacs-directory "rubbish")
  "A directory for Emacs to dump all those backup files in.")
(unless (file-directory-p +id-rubbish-dir+)
  (make-directory +id-rubbish-dir+))
(setopt backup-directory-alist `(("." . ,+id-rubbish-dir+)))

(defconst +id-socket-dir+ (concat user-emacs-directory "socket")
  "A directory for Emacs server's socket.

By default, the socket is placed in XDG_RUNTIME_DIR, which gets cleaned
up after the user logs out.")
(unless (file-directory-p +id-socket-dir+)
  (make-directory +id-socket-dir+))
(chmod +id-socket-dir+ #o700)
(setopt server-socket-dir +id-socket-dir+)

(defun id-insert-tab (&optional arg)
  "This is like Neovim's i_ctrl-t."
  (interactive "P")
  (insert-tab arg))

(defun id-set-fonts ()
  (let ((mono "Roboto Mono")
        (sans "Roboto")
        (serif "Roboto Serif")
        (cjk-tc "Noto Sans CJK TC")
        (cjk-jp "Noto Sans CJK JP"))
    (when (display-graphic-p nil)
      (set-face-attribute 'default nil
                          :family mono
                          :height 200)
      (set-face-attribute 'fixed-pitch nil
                          :family mono
                          :inherit 'default)
      (set-face-attribute 'variable-pitch nil
                          :family sans
                          :inherit 'default)
      (set-fontset-font nil 'han
                        (font-spec :family cjk-tc)
                        nil 'prepend)
      (set-fontset-font nil 'bopomofo
                        (font-spec :family cjk-tc)
                        nil 'prepend)
      (set-fontset-font nil 'kana
                        (font-spec :family cjk-jp)
                        nil 'prepend))))

(add-hook 'before-save-hook #'delete-trailing-whitespace)
(add-hook 'text-mode-hook (lambda () (auto-fill-mode 1)))
(add-hook 'server-after-make-frame-hook #'id-set-fonts)
(add-hook 'compilation-filter-hook #'ansi-color-compilation-filter)

(keymap-global-unset "C-z")
(keymap-global-unset "C-x C-z")
(keymap-global-set "<f5>" #'compile)
(keymap-global-set "M-i" #'id-insert-tab)

;; Set indent offset of major modes here, so I can use the `tab-width` variable.
(setopt tab-width 4
        go-ts-mode-indent-offset tab-width
        c-ts-indent-offset tab-width)

(id-set-fonts)

(put 'narrow-to-region 'disabled nil)
