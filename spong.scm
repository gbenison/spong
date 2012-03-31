(use-modules (oop goops)
	     (gnome glib)
	     (gnome gtk))

(define velocity '(10 6))
(define position '(50 50))
(define puck-size 10)
(define board-size '(500 500))

(define main-window (make <gtk-window>
		      #:title "Scheme pong"
		      #:width-request (car board-size)
		      #:height-request (cadr board-size)))
(connect main-window 'destroy (lambda args (gtk-main-quit)))

(define drawing-area (make <gtk-drawing-area>))
(add main-window drawing-area)

(define fore-gc #f)

;; Redraw the puck on the drawing area.
(define (update-handler . args)
  (gdk-draw-rectangle ))

(connect drawing-area 'expose-event
	 (lambda args
	   (let ((x (car position))
		 (y (cadr position)))
	     (gdk-draw-rectangle (get-window drawing-area)
				 fore-gc 1 x y puck-size puck-size))
	   #t))

(g-timeout-add
 50
 (lambda args
   ;; update velocity
   (let ((x (car position))
	 (y (cadr position))
	 (vx (car velocity))
	 (vy (cadr velocity))
	 (max-x (car board-size))
	 (max-y (cadr board-size)))
     (if (> (+ x vx) max-x)
	 (set! vx (- (abs vx))))
     (if (< (+ x vx) 0)
	 (set! vx (abs vx)))
     (if (> (+ y vy) max-y)
	 (set! vy (- (abs vy))))
     (if (< (+ y vy) 0)
	 (set! vy (abs vy)))
     (set! position (list (+ x vx) (+ y vy)))
     (set! velocity (list vx vy))
     (gtk-widget-queue-draw drawing-area)
     #t)))

(show-all main-window)

(let ((style (get-style main-window)))
  (set! fore-gc (get-black-gc style)))

(gtk-main)
