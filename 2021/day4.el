(require 'utils)

(defun list-of-nums-from-str (str)
  (mapcar #'string-to-number (split-string str)))

(defun parse-grids (str)
  (mapcar #'(lambda (grid-str)
              (mapcar #'list-of-nums-from-str (split-string grid-str "\n")))
          str))

(defun day4-parser (content)
  (let* ((lines (split-string content "\n\n" t))
         (picked (mapcar #'string-to-number (split-string (car lines) "," t)))
         (grids (parse-grids (cdr lines))))
    (cons picked grids)))

(defun all-picked (seq picked)
  "Returns T if all items in SEQ are in PICKED"
  (if (< (length picked) (length seq))
      nil
    (cl-every #'(lambda (x) (seq-contains picked x)) seq)))

(defun cols (grid)
  (cl-loop for x below (length grid) collect
       (cl-loop for line in grid collect (nth x line))))

(defun compute-score (grid so-far)
  "Returns the sum of all numbers in GRID that don't belong to
SO-FAR multiplied by the last element of SO-FAR"
  (*
   (car (last so-far))
   (cl-loop for line in grid sum
        (cl-reduce
         #'(lambda (acc elem) (+ acc (if (seq-contains so-far elem) 0 elem)))
         line
         :initial-value 0))))

(defun compute-rank-and-score (grid picks)
  "Compute the amount items in PICKS it takes to get this GRID to
a winning state (either a full row or column has been picked) as
well as the score of the grid."
  (cl-loop for pick in picks collect pick into so-far
     if (or
         (cl-some #'(lambda (col) (all-picked col so-far)) (cols grid))
         (cl-some #'(lambda (line) (all-picked line so-far)) grid))
     return (cons (length so-far)
                  (compute-score grid so-far))))

(defun part-result (fun ranks-and-scores)
  (cdr (cl-reduce
        #'(lambda (winner elem) (if (funcall fun (car winner) (car elem)) elem winner))
        ranks-and-scores)))

(with-input-for-day 4
  #'day4-parser
  (let* ((picks (car input))
         (grids (cdr input))
         (ranks-and-scores
          (mapcar #'(lambda (grid) (compute-rank-and-score grid picks)) grids)))
    (cons
     ;; First part
     (part-result #'> ranks-and-scores)
     ;; Second part
     (part-result #'< ranks-and-scores))))
