(import (chicken condition)
        (chicken format)
        srfi-69
        (prefix sdl2 sdl2:))

;;; Initialize the parts of SDL that we need.
(sdl2:set-main-ready!)
(sdl2:init! '(video events))

;; Automatically call sdl2:quit! when program exits normally.
(on-exit sdl2:quit!)

;; Call sdl2:quit! and then call the original exception handler if an
;; unhandled exception reaches the top level.
(current-exception-handler
 (let ((original-handler (current-exception-handler)))
   (lambda (exception)
     (sdl2:quit!)
     (original-handler exception))))

(printf "Compiled with SDL version ~A~N" (sdl2:compiled-version))
(printf "Running with SDL version ~A~N" (sdl2:current-version))
(printf "Using sdl2 egg version ~A~N" (sdl2:egg-version))

;;; Create a new window.
(define window
  (sdl2:create-window!
   "CHIC-8"                             ; title
   'centered  'centered                 ; x, y
   800  600))                           ; w, h

(define keypad (make-vector 16 #f))

(define keymap (alist->hash-table '((n-1 . 1) (n-2 . 2) (n-3 . 3) (n-4 . #xC)
                                            (q . 4)   (w . 5)   (e . 6)   (r . #xD)
                                            (a . 7)   (s . 8)   (d . 9) (f . #xE)
                                            (z . #xA) (x . 0) (c . #xB) (v . #xF))))

(define (key-down! ev)
  (let ((sc (sdl2:keyboard-event-scancode ev)))
        (if (hash-table-exists? keymap sc)
            (begin (vector-set! keypad (hash-table-ref keymap sc) #f)
                   (print keypad)))))

(define (key-up! ev)
  (let ((sc (sdl2:keyboard-event-scancode ev)))
        (if (hash-table-exists? keymap sc)
            (begin (vector-set! keypad (hash-table-ref keymap sc) #t)
                   (print keypad)))))

(define (render-display!)
  (let ((window-surf (sdl2:window-surface window)))
   (sdl2:fill-rect! window-surf #f (sdl2:make-color 0 80 160))
   (sdl2:update-window-surface! window)))

(do ((done #f))
    (done)
    (let ((ev (sdl2:wait-event!)))
     (case (sdl2:event-type ev)
       ((window)
        (render-display!))

       ((key-down)
        (key-down! ev))

       ((key-up)
        (key-up! ev))

       ((quit)
        (set! done #t)))))
