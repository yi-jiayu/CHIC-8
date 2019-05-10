(load "interpreter.scm")

(define (subroutine-return! ip instr)
  (let ((sp (- (interpreter-sp ip) 1)))
   (set! (interpreter-pc ip) (vector-ref (interpreter-stack ip) sp))
   (set! (interpreter-sp ip) sp)))

(define (subroutine-call! ip instr)
  (vector-set! (interpreter-stack ip)
               (interpreter-sp ip)
               (interpreter-pc ip))
  (set! (interpreter-sp ip) (+ 1 (interpreter-sp ip)))
  (set! (interpreter-pc ip) instr))
