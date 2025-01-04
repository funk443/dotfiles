(in-package :lem-user)

(load-theme "grayscale-dark")

(setf lem/line-numbers:*relative-line* t)

(define-keys *global-keymap*
  ("C-_" 'undo)
  ("C-\\" 'redo))

(lem-if:update-cursor-shape (lem:implementation) :bar)

#+lem-sdl2
(when (typep (lem:implementation) 'lem-sdl2/sdl2:sdl2)
  (lem-sdl2/display:change-font (lem-sdl2/display:current-display)
                                (lem-sdl2/font:make-font-config
                                 :size 20
                                 :latin-normal-file "/home/id/.local/share/fonts/Iosevka-Regular.ttf"
                                 :latin-bold-file "/home/id/.local/share/fonts/Iosevka-Bold.ttf")))

(lem/line-numbers:toggle-line-numbers)

(remove-hook *after-init-hook* 'lem/frame-multiplexer::enable-frame-multiplexer)
