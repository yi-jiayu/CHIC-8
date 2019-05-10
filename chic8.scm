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

(define keymap (alist->hash-table (map cons
                                       '(n-1 n-2 n-3 n-4
                                             q w e r
                                             a s d f
                                             z x c v)
                                       (list 1 2 3 #xC
                                             4 5 6 #xD
                                             7 8 9 #xE
                                             #xA 0 #xB #xF))))

(define (handle-keyboard-event! ev)
  (let ((sc (sdl2:keyboard-event-scancode ev)))
   (if (and (= 0 (sdl2:keyboard-event-repeat ev))
            (hash-table-exists? keymap sc))
       (begin (vector-set! keypad
                           (hash-table-ref keymap sc)
                           (sdl2:keyboard-event-state ev))
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

       ((key-down key-up)
        (handle-keyboard-event! ev))

       ((quit)
        (set! done #t)))))
