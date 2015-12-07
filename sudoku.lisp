(defconstant grid-size 9)
(defconstant box-size 3)
(defconstant empty 0)

(defvar grid ())

;;Remplacer la grille en dur par l'input
(defun sudoku(input)
  (setq grid #2a((0 6 0 1 0 4 0 5 0)
                 (0 0 8 3 0 5 6 0 0)
                 (2 0 0 0 0 0 0 0 1)
                 (8 0 0 4 0 7 0 0 6)
                 (0 0 6 0 0 0 3 0 0)
                 (7 0 0 9 0 1 0 0 4)
                 (5 0 0 0 0 0 0 0 2)
                 (0 0 7 2 0 6 9 0 0)
                 (0 4 0 5 0 8 0 7 0)))
  (print-board)
  
)

(defun print-board ()
  (format t "~%   | A | B | C | D | E | F | G | H | I |")
  (dotimes (r grid-size)
    (format t "~%---+---+---+---+---+---+---+---+---+---+~%")
    (format t " ~a |" r)
    (dotimes (c grid-size)
      (format t " ~A |" (aref grid r c))))
  (format t "~%---+---+---+---+---+---+---+---+---+---+~%~%")
)

