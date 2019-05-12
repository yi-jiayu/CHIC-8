(import (chicken bitwise))

(define-syntax instr-addr
  (syntax-rules ()
    ((_ instr)
     (bitwise-ior (arithmetic-shift  (bitwise-and #x0f (car instr)) 8) (cdr instr)))))

(define-syntax instr-nibble
  (syntax-rules ()
    ((_ instr)
     (bitwise-and #x0f (cdr instr)))))

(define-syntax instr-x
  (syntax-rules ()
    ((_ instr)
     (bitwise-and #x0f (car instr)))))

(define-syntax instr-y
  (syntax-rules ()
    ((_ instr)
     (arithmetic-shift (bitwise-and #xf0 (cdr instr)) -4))))

(define-syntax instr-byte
  (syntax-rules ()
    ((_ instr)
     (cdr instr))))
