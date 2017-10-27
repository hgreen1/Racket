;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |move ball1|) (read-case-sensitive #t) (teachpacks ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp")))))
;; a ball is a (make-posn x y)
;; where x and y are the horizontal and vertical coordinates of the ball

(define-struct balls (1st rest))

(define *ball* (circle 10 'solid 'red))
(define *bg* (empty-scene 400 300))
(define *ball-vel* (make-posn 2 1))

;; move-ball :: Ball->Ball
(define (move-ball ball)
  (make-posn (+ (posn-x ball) (posn-x *ball-vel*))
             (+ (posn-y ball) (posn-y *ball-vel*))))

(define (move-balls balls)
  (if (empty? balls)
      empty
      (make-balls (move-ball (balls-1st balls))
                  (move-balls (balls-rest balls)))))

;; draw-ball :: Ball Image -> Image

(define (draw-ball ball bg)
  (place-image *ball*
               (posn-x ball)
               (posn-y ball)
               bg))

;; render :: Ball Ball -> Image
(define (render balls)
  (if (empty? balls)
      *bg*
      (draw-ball (balls-1st balls)
                 (render (balls-rest balls)))))


(define *three-balls* (make-balls (make-posn 50 100)
                                  (make-balls (make-posn 50 50)
                                              (make-balls (make-posn 100 50)
                                                          empty))))
(define (start init)
  (big-bang init
            (to-draw render)
            (on-tick move-ball)))