(in-package :lem-user)

(lem/themes::define-color-theme "black" nil
  (:display-background-mode :dark)
  (:foreground "#ffffff")
  (:background "#000000")
  (:inactive-window-background nil)
  (region :foreground nil :background "#404040")
  (modeline :background "#404040" :foreground "#ffffff")
  (modeline-inactive :background "#303030" :foreground "#eeeeee")
  (syntax-string-attribute :foreground "#ffff00")
  (syntax-builtin-attribute :foreground "#ffffff")
  (syntax-comment-attribute :foreground "#ff0000")
  (syntax-keyword-attribute :foreground "#ffffff")
  (syntax-constant-attribute :foreground "#ffffff")
  (syntax-function-name-attribute :foreground "#ffffff")
  (syntax-variable-attribute :foreground "#ffffff")
  (syntax-type-attribute :foreground "#ffffff")
  (lem/isearch:isearch-highlight-attribute :background "#ff0000")
  (lem/isearch:isearch-highlight-active-attribute :background "#707070")
  (lem/listener-mode:listener-prompt-attribute :foreground "#ff0000")
  (lem/line-numbers:active-line-number-attribute :bold t)
  (lem-lisp-mode/internal::compilation-region-highlight :bold t))

(load-theme "black")

(setf lem/line-numbers:*relative-line* t
      *auto-format* t
      lem-lisp-mode/hyperspec::*hyperspec-root* "https://funk443.github.io/CLHS/HyperSpec/"
      lem-core/commands/edit::*save-interprogram-clipboard-before-kill-p* t
      (variable-value 'add-newline-at-eof-on-writing-file :global) t
      (variable-value 'lem-core/commands/file::delete-trailing-whitespace-on-writing-file :global) t)

(lem-if:update-cursor-shape (lem:implementation) :bar)
(lem/line-numbers:toggle-line-numbers)

(defmacro make-formatter (mode name commands)
  `(progn
     (defun ,name (buf)
       (let ((file (buffer-filename buf)))
         (uiop:run-program
          (list ,@commands file)
          :ignore-error-status t))
       (revert-buffer t))
     (lem:register-formatter ,mode (function ,name))))

(make-formatter lem-python-mode:python-mode
                my-python-formatter
                ("black"))
(make-formatter lem-java-mode:java-mode
                my-java-formatter
                ("google-java-format" "-r"))

#+lem-sdl2
(when (typep (lem:implementation) 'lem-sdl2/sdl2:sdl2)
  ;; Only enable `paredit-mode` when using SDL2 backend.
  ;; See https://github.com/lem-project/lem/issues/373
  (add-hook lem-lisp-mode:*lisp-mode-hook* (lambda () (lem-paredit-mode:paredit-mode t)))
  (lem-sdl2/display:change-font (lem-sdl2/display:current-display)
                                (lem-sdl2/font:make-font-config
                                 :size 20
                                 :latin-normal-file "/home/id/.local/share/fonts/Iosevka-Regular.ttf"
                                 :latin-bold-file "/home/id/.local/share/fonts/Iosevka-Bold.ttf")))

(remove-hook *after-init-hook* 'lem/frame-multiplexer::enable-frame-multiplexer)
