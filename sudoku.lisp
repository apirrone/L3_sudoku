(defconstant grid-size 9)
(defconstant box-size 3)
(defconstant empty 0)

(defvar grid ())
(defvar col)
(defvar row)
(defvar val)

;;Par soucis de practicité lors des entrées,
;; on associe aux colonnes une lettre
(defparameter *hash-let-to-num* (make-hash-table))
(setf (gethash 'A *hash-let-to-num*) 0)
(setf (gethash 'B *hash-let-to-num*) 1)
(setf (gethash 'C *hash-let-to-num*) 2)
(setf (gethash 'D *hash-let-to-num*) 3)
(setf (gethash 'E *hash-let-to-num*) 4)
(setf (gethash 'F *hash-let-to-num*) 5)
(setf (gethash 'G *hash-let-to-num*) 6)
(setf (gethash 'H *hash-let-to-num*) 7)
(setf (gethash 'I *hash-let-to-num*) 8)


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
  (game-loop)

)

(defun game-loop()
  (print-board grid)
  (princ "Enter column : ")
  (setq col (gethash (read) *hash-let-to-num* ))
  ;;rajouter test validité de la colonne
  (princ "Enter row : ")
  (setq row (read))
  ;;rajouter test validité de la ligne
  (if (= 0 (aref grid row col))
      (progn (princ "Enter value : ")
       (setq val (read))
       (let (g-temp)
	 (setf g-temp grid)
	 (setf (aref g-temp row col) val)
	 (if (/= 0 (check-grid g-temp))
	     (setf (aref grid row col) val)
	     (format t "Erreur, vous ne pouvez pas jouer cela ici"))
       )
      )
      (princ "Erreur, Case non vide")
  )
  ;;definir condition d'arret
  (game-loop)
)

(defun check-grid(g)
  ;;check lines
  (let ((tempList '())
	(nb 0))
    (dotimes (r grid-size)
      (dotimes (c grid-size)
	(if (/= 0 (aref g r c ))
	    (push (aref g r c) tempList))))
    (setq nb (length tempList))
    (setq tempList (remove-duplicates tempList))
    (if (> nb (length tempList))
	0
	1
    )
  )
      
      
)

(defun print-board (g)
  (format t "~%   | A | B | C | D | E | F | G | H | I |")
  (dotimes (r grid-size)
    (format t "~%---+---+---+---+---+---+---+---+---+---+~%")
    (format t " ~a |" r)
    (dotimes (c grid-size)
      (if (= 0 (aref g r c))
	  (format t "   |")
	  (format t " ~A |" (aref g r c)))))
  (format t "~%---+---+---+---+---+---+---+---+---+---+~%~%")
)

