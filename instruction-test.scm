(import test)
(load "instruction.scm")

(define instr '(#x0A . #xBC))

(test-group "instr-addr"
  (test #xABC (instr-addr instr)))
 
(test-group "instr-nibble"
  (test #xC (instr-nibble instr)))

(test-group "instr-x"
  (test #xA (instr-x instr)))

(test-group "instr-y"
  (test #xB (instr-y instr)))

(test-group "instr-byte"
  (test #xBC (instr-byte instr)))
