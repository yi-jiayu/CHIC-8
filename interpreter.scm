(module interpreter
  * 

  (import scheme
          (chicken base))

  (define-record-type interpreter
    (make-interpreter memory registers pc i stack sp)
    interpreter?
    (memory interpreter-memory (setter interpreter-memory))
    (registers interpreter-registers (setter interpreter-registers))
    (pc interpreter-pc (setter interpreter-pc))
    (i interpreter-i (setter interpreter-i))
    (stack interpreter-stack (setter interpreter-stack))
    (sp interpreter-sp (setter interpreter-sp)))

  (define (new-interpreter)
    (make-interpreter
      '()                 ;; memory (not implemented)
      (make-vector 16 0)  ;; registers
      #x200               ;; pc
      0                   ;; i
      (make-vector 16 0)  ;; stack
      0)))                 ;; sp
