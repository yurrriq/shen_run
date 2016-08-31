#!/usr/bin/env shen_run_sbcl

(define show-args
  [] _ -> _
  [X | R] I -> (let - (output "  ~A: ~S~%" I X)
                 (show-args R (+ I 1))))

(define main
  [] -> (error "Not enough arguments.")
  ["-preved" | _] -> false
  Args -> (let - (output "Arguments~%")
               - (show-args Args 0)
               - (output "End~%")
               true))
