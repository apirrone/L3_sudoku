(defconstant grid-size 9)
(defconstant box-size 3)
(defconstant empty 0)

(defvar grid ())
(defvar g-temp ())
(defvar col)
(defvar row)
(defvar val)
(defvar tmpList)
(defvar nb)

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
  (setq g-temp #2a((0 6 0 1 0 4 0 5 0)
                 (0 0 8 3 0 5 6 0 0)
                 (2 0 0 0 0 0 0 0 1)
                 (8 0 0 4 0 7 0 0 6)
                 (0 0 6 0 0 0 3 0 0)
                 (7 0 0 9 0 1 0 0 4)
                 (5 0 0 0 0 0 0 0 2)
                 (0 0 7 2 0 6 9 0 0)
                 (0 4 0 5 0 8 0 7 0)))
  (print-board grid)
  (game-loop)
)

(defun game-loop()
   (princ "Enter column : ")
   (setq col (gethash (read) *hash-let-to-num* ))
   ;;rajouter test validité de la colonne
   (princ "Enter row : ")
   (setq row (read))
   ;;rajouter test validité de la ligne
   (if (= 0 (aref grid row col))
       (progn (princ "Enter value : ")
        (setq val (read))
	(copy-grid grid g-temp)
	(setf (aref g-temp row col) val)
	(check-grid g-temp row col val)
       )
       (princ "Erreur, Case non vide"))
   ;;definir condition d'arret
   (print-board grid)
   (game-loop)
 )

(defun copy-grid(source dest)
  (dotimes (r grid-size)
    (dotimes (c grid-size)
      (setf (aref dest r c) (aref source r c))
    )
  )
)


(defun check-grid (g row col val)

  ;;check lines
  (dotimes (r grid-size)
    (setq tmpList '())
    (setq nb 0)
    (dotimes (c grid-size)
      (if (/= 0 (aref g r c))
	  (push (aref g r c) tmpList))
    )
    (setq nb (length tmpList))
    (if (> nb (length (remove-duplicates tmpList)))
        (progn
          (format t "Erreur, vous ne pouvez pas jouer cela ici")
          (return-from check-grid 0)
        )
    )
    
  )
  ;;check columns
  (dotimes (c grid-size)
    (setq tmpList '())
    (setq nb 0)
    (dotimes (r grid-size)
      (if (/= 0 (aref g r c))
	  (push (aref g r c) tmpList))
    )
    (setq nb (length tmpList))
    (if (> nb (length (remove-duplicates tmpList)))
        (progn
          (format t "Erreur, vous ne pouvez pas jouer cela ici")
          (return-from check-grid 0)
        )
    )
  )
 
  ;;check squares
  (let ((offset_r 0)
       (offset_c 0))
       (dotimes (x 3)
	 (dotimes (y 3)
	   (setq tmpList '())
	   (setq nb 0)
	   (dotimes (r 3)
	     (dotimes (c 3)
	       (if (/= 0 (aref g (+ r offset_r) (+ c offset_c)))
		   (push (aref g (+ r offset_r) (+ c offset_c)) tmpList)
	       )
	     )
	   )
	   (setq nb (length tmpList))
	   (if (> nb (length (remove-duplicates tmpList)))
	       (progn
		 (format t "Erreur, vous ne pouvez pas jouer cela ici")
		 (return-from check-grid 0)
	       )
	   )
	   (setq offset_c (+ 3 offset_c))
	 )
	 (setq offset_c 0)
	 (setq offset_r (+ 3 offset_r))
       )
  )
  (setf (aref grid row col) val)

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

