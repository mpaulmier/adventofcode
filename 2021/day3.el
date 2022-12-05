(require 'utils)

(defun day3-parser (content)
  "Change CONTENT to list of lists of bits"
  (mapcar #'(lambda (x)
              (cl-map 'list #'(lambda (c) (- c 48)) x))
          (split-string content)))

(defun compute-occurences (seq1 seq2)
  "For each bit in SEQ2 add 1 if 1 or -1 if 0 to the element in
  SEQ1 at the same position. SEQ1 and SEQ2 must be of equal length"
  (cl-loop for x in seq2
           for i from 0 do
           (if (eq 0 x)
               (cl-incf (nth i seq1) -1)
             (cl-incf (nth i seq1) 1)))
  seq1)

(defun list-of-bits-from-occurences (seq &optional revert)
  "Take SEQ the result of reducing the input with
  COMPUTE-OCCURENCES and transform it into a list of bits. If
  REVERT is non nil, 1 means least common bit at this position
  otherwise it is the most common."
  (let ((comparator (if revert #'<= #'>=)))
    (mapcar #'(lambda (x) (if (funcall comparator x 0) 1 0)) seq)))

(defun list-of-bits-to-number (seq)
  (string-to-number (cl-concatenate 'string (mapcar #'(lambda (x) (+ 48 x)) seq)) 2))

(defun find-gaz-rating (seq &optional popular)
  (let ((seq-copy (cl-copy-list seq))
        (remover (if popular #'cl-remove-if #'cl-remove-if-not)))
    (cl-loop for i upto (1- (length (car seq)))
             while (> (length seq-copy) 1) do
             (let* ((bits (list-of-bits-from-occurences
                           (cl-reduce #'compute-occurences
                                      seq-copy
                                      :initial-value (make-list (length (car seq-copy)) 0))))
                    (bit (nth i bits)))
               (setf seq-copy (funcall remover #'(lambda (x) (eq bit (nth i x))) seq-copy))))
    (list-of-bits-to-number (car seq-copy))))

(defmacro let-part (&rest body)
  "Both part1 and part2 use the same variables"
  `(let* ((occurences (cl-reduce #'compute-occurences
                                 input
                                 :initial-value (make-list (length (car input)) 0)))
          (gamma (list-of-bits-from-occurences occurences))
          (epsilon (list-of-bits-from-occurences occurences t)))
     ,@body))

(with-input-for-day 3
                    #'day3-parser
                    (cons
                     (let-part
                      (* (list-of-bits-to-number gamma) (list-of-bits-to-number epsilon)))
                     (let-part
                      (let ((co2 (find-gaz-rating input t))
                            (oxygen (find-gaz-rating input nil)))
                        (* co2 oxygen)))))
