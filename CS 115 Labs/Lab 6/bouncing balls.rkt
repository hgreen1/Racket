;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |bouncing balls|) (read-case-sensitive #t) (teachpacks ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp")))))
(define *radius* 10)
(define *ball* (circle *radius* 'solid 'blue))
(define *width* 500)
(define *height* 500)
(define *bg* (empty-scene *width* *height*))

; WorldState is a ballLocation and Velocity
; --If its a posn, then (x, y) is the current coordinate for the ball
; --If its false, then there is no ball.

(define-struct ball (loc vel))

; Location is a (Make-posn x y)

; Velocity is a (make-posn horiz vert)

; Move-ball :: Worldstate (ball) -> worldstate (ball)
; compute the next state of the ball based on the current state and velocity

(check-expect (move-ball *init*)
              (make-ball (make-posn 102 107)
                         (make-posn 2 7)))
(check-expect (move-ball (move-ball *init*))
              (make-ball (make-posn 104 114)
                         (make-posn 2 7)))
(check-expect (move-ball (make-ball (make-posn 200 200)
                                    (make-posn -5 -10)))
              (make-ball (make-posn 195 190)
                         (make-posn -5 -10)))
(check-expect (move-ball (make-ball (make-posn 100 490)
                                    (make-posn 5 -10)))
              (make-ball (make-posn 105 480)
                         (make-posn 5   -10)))
(define (move-ball ball)
  (make-ball (make-posn (+ (posn-x (ball-loc ball))
                           (posn-x (ball-vel ball)))
                        (if (and (> (posn-y (ball-loc ball)) (- *height* 10))
                                 (> (posn-y (ball-vel ball)) 0))
                            (- (posn-y (ball-vel ball)))
                            (posn-y (ball-loc ball))
                            (+ (posn-y (ball-loc ball))
                               (posn-y (ball-vel ball))))))
             (make-posn (posn-x (ball-vel ball))
                        (cond ((and (>= (posn-y (ball-loc ball)) (- *height* 10))
                                    (> (posn-y (ball-vel ball)) 0))
                               (- (posn-y (ball-vel ball)))
                        

(define *init*
  (make-ball (make-posn 100 100)
             (make-posn 2 7)))
; render :: Ball/WorldState -> Image
(check-expect (render *init*)
              (place-image *ball* 100 100 *bg*))

(define (render ball)
  (place-image *ball*
               (posn-x (ball-loc ball)) 
               (posn-y (ball-loc ball))
               *bg*))

(define (start init)
  (big-bang init
            (to-draw render)
            (on-tick move-ball)))

