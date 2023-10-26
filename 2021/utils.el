(defun mp/file-content (filename)
  "Extract the contents of file FILENAME the emacs way."
  (with-temp-buffer
    (insert-file-contents filename)
    (string-trim
     (buffer-substring-no-properties
      (point-min)
      (point-max)))))

(defmacro with-input-for-day (day parser &rest body)
  "Utility macro that preloads the input of the DAY.

PARSER is a function that takes a string argument corresponding to the DAY's input."
  (declare (indent 1))
  `(let* ((url (concat (concat "https://adventofcode.com/2021/day/" (int-to-string ,day)) "/input"))
          (lexical-binding t)
          (filename (concat "inputs/" (int-to-string ,day)))
          (cookie (mp/file-content "../session-cookie.txt"))
          (url-request-extra-headers
           (list (cons "Cookie" cookie))))
     (if (not (file-exists-p filename))
         (url-copy-file url filename))

     ;; Load data into input list
     (let ((input (funcall ,parser (mp/file-content filename))))
       ,@body)))

(provide 'utils)
