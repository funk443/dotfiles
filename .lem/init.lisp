(in-package :lem-user)

(load-theme "grayscale-dark")

(setf lem/line-numbers:*relative-line* t
      *auto-format* t
      (variable-value 'add-newline-at-eof-on-writing-file :global) t
      (variable-value 'lem-core/commands/file::delete-trailing-whitespace-on-writing-file :global) t)

(lem-if:update-cursor-shape (lem:implementation) :bar)
(lem/line-numbers:toggle-line-numbers)

(defmacro make-formatter (name commands)
  `(defun ,name (buf)
     (let ((file (buffer-filename buf)))
       (uiop:run-program
        (list ,@commands file)
        :ignore-error-status t))
     (revert-buffer t)))

(make-formatter my-python-formatter ("black"))
(make-formatter my-java-formatter ("google-java-format" "-r"))

(lem:register-formatters
  (lem-python-mode:python-mode #'my-python-formatter)
  (lem-java-mode:java-mode #'my-java-formatter))

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
