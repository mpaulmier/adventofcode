(require 'utils)

(defun day2-parser (content)
  (split-string content nil t))

(with-input-for-day 2
  #'day2-parser
  (cons
   ;; Part 1
   (let ((pos 0)
         (depth 0))
     (cl-loop for (dir amount) on input by #'cddr do
          (let ((x (string-to-number amount)))
            (cond
              ((equal dir "forward") (setf pos (+ pos x)))
              ((equal dir "down") (setf depth (+ depth x)))
              ((equal dir "up") (setf depth (- depth x))))))
     (* pos depth))
   ;; Part2
   (let ((pos 0)
         (depth 0)
         (aim 0))
     (cl-loop for (dir amount) on input by #'cddr do
          (let ((x (string-to-number amount)))
            (cond
              ((equal dir "forward") (progn
                                       (setf depth (+ depth (* aim x)))
                                       (setf pos (+ pos x))))
              ((equal dir "down") (setf aim (+ aim x)))
              ((equal dir "up") (setf aim (- aim x))))))
     (* pos depth))))
