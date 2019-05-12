(import test)
(load "instruction.scm")

(test-group "instr-addr"
            (let ((instr '(#x0A . #xBC)))
             (test "addr of opcode 0x0ABC should be 0xABC" #xABC (instr-addr instr))))
