(in-package :lem-user)

(load-theme "grayscale-dark")

(setf lem/line-numbers:*relative-line* t)

(define-keys *global-keymap*
  ("C-_" 'undo)
  ("C-\\" 'redo))

(lem-ncurses/term:update-cursor-shape :bar)
(lem/line-numbers:toggle-line-numbers)

(remove-hook *after-init-hook* 'lem/frame-multiplexer::enable-frame-multiplexer)
