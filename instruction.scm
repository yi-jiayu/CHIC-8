(import (chicken bitwise))

(define-syntax instr-addr
  (syntax-rules ()
    ((_ instr)
     (bitwise-ior (arithmetic-shift  (bitwise-and #x0f (car instr)) 8) (cdr instr)))))
