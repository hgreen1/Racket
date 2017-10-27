;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname bounce1) (read-case-sensitive #t) (teachpacks ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp")))))

;; WorldState is a Ball, consisting of Location and Velocity
(define-struct ball (loc vel))

;; Location is a (make-posn x y)

;; Velocity is a (make-posn hori vert)
;; where hori is the horizontal velocity, and vert is the vertical velocity

(define *init* (make-ball (make-posn 100 100) 
                          (make-posn 4 6)))

(define *width*  500)
(define *height* 500)
(define *bg* (empty-scene *width* *height*))

(define *ball-radius* 10)
(define *ball* (circle *ball-radius* 'solid 'red))
(define *horizvel* 5)
(define *vertvel* 5)

;; move-ball :: Ball -> Ball
;; compute the next state of the ball, based on its current location and velocity
(define (move-ball ball)
  (make-ball (make-posn (cond ((and (> (posn-x (ball-loc ball)) (- *width* 10))
                                    (> (posn-x (ball-vel ball)) 0))
                               (posn-y (ball-loc ball)))
                              ((and (< (posn-x (ball-loc ball)) 10)
                                    (< (posn-x (ball-vel ball)) 0))
                               (posn-y (ball-loc ball)))
                              (else
                               (+ (posn-x (ball-loc ball))
                                  (posn-x (ball-vel ball)))))
                        (cond ((and (> (posn-y (ball-loc ball)) (- *height* 10))
                                    (> (posn-y (ball-vel ball)) 0))
                               (posn-y (ball-loc ball)))
                              ((and (< (posn-y (ball-loc ball)) 10)
                                    (< (posn-y (ball-vel ball)) 0))
                               (posn-y (ball-loc ball)))
                              (else
                               (+ (posn-y (ball-loc ball))
                                  (posn-y (ball-vel ball))))))
             (make-posn (cond  ((and (> (posn-x (ball-loc ball)) (- *width* 10))
                                     (> (posn-x (ball-vel ball)) 0))
                                (- (posn-x (ball-vel ball))))
                               ((and (< (posn-x (ball-loc ball)) 10)
                                     (< (posn-x (ball-vel ball)) 0))
                                (- (posn-x (ball-vel ball))))
                               (else 
                                (posn-x (ball-vel ball))))
                        (cond  ((and (> (posn-y (ball-loc ball)) (- *height* 10))
                                     (> (posn-y (ball-vel ball)) 0))
                                (- (posn-y (ball-vel ball))))
                               ((and (< (posn-y (ball-loc ball)) 10)
                                     (< (posn-y (ball-vel ball)) 0))
                                (- (posn-y (ball-vel ball))))
                               (else 
                                (posn-y (ball-vel ball)))))))

;; mousehandler :: ws me x y -> ws
;; takes where the mouse is clicked and starts the animation from where it is clicked
(define (mousehandler ws x y me)
  (cond
    ((mouse=? me "enter") ws)
    ((mouse=? me "leave") ws)
    ((mouse=? me "button-down") (make-ball (make-posn x y) (make-posn (random 10) (random 10))))
  (else ws)))

;; render :: Ball -> Image
(check-expect (render *init*)
              (place-image *ball* 100 100 *bg*))
(define (render ball)
  (place-image *ball*
               (posn-x (ball-loc ball)) (posn-y (ball-loc ball))
               *bg*))

(define (start init)
  (big-bang init
            (on-tick move-ball)
            (to-draw render)
            (on-mouse mousehandler)))

(start (make-ball (make-posn 50 100) (make-posn 1 5)))