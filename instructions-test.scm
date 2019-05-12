(include-relative "instructions")

(import test)

(test-group "subroutine-call"
  (let ((ip (new-interpreter)))
   (subroutine-call! ip '(#x0A . #xBC))
   (test "stack pointer should be incremented to 1" 1 (interpreter-sp ip))
   (test "first element of stack should be previous pc" #x200 (vector-ref (interpreter-stack ip) 0))
   (test "new pc should be 0xABC" #xABC (interpreter-pc ip))))

(test-exit)
