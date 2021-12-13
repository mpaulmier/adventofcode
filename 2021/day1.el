(require 'utils)

(defun count-depth-increases (depths)
  (let ((prev (car depths)))
    (cl-loop for depth in (cdr depths)
             if (> depth prev) count depth
             do (setq prev depth))))

(defun day1-parser (content)
  (mapcar #'string-to-number
          (split-string content "\n" t)))

(with-input-for-day 1
  #'day1-parser
  (cons
   ;; part 1
   (count-depth-increases input)
   ;; part 2
   (progn
     (let ((sums (cl-loop for (a b c) on input
                    while (not (null c))
                    collect (+ a b c))))
       (count-depth-increases sums)))))
