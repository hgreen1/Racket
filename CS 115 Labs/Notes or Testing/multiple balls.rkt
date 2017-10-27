;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |multiple balls|) (read-case-sensitive #t) (teachpacks ((lib "universe.ss" "teachpack" "2htdp") (lib "image.ss" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.ss" "teachpack" "2htdp") (lib "image.ss" "teachpack" "2htdp")))))
(define *ball* (circle 20 'solid 'blue))
(define *bg* (empty-scene 500 500))
(define-struct ball (loc vel))

;; draw-ball :: Posn Image -> Image
(define (draw-ball ball bg)
  (place-image *ball*
               (posn-x (ball-loc ball))
               (posn-y (ball-loc ball))
               bg))

;; draw-balls :: [Ball] Image -> Image
;; [posn] is either a cons containing a posn or empty.
(define (draw-balls balls)
  (if (empty? empty)
      *bg*
      (draw-ball (first balls)
                 (draw-balls (rest balls)))))

;; add-ball :: posn [posn] [posn] -> [posn]
(define (add-ball ball balls)
  (cons ball balls))

(define (mouse-handler ws x y me)
  (cond
    ((mouse=? me "button-down") (make-ball (make-posn x y) (make-posn (- (random 11) 5) (- (random 11) 5))))
    (else ws)))

;; move-ball :: Posn -> Posn
(define (move-ball loc)
  (make-ball (make-posn (+ (posn-x (ball-loc ball))
                           (posn-x (ball-vel ball)))
                        (+ (posn-y (ball-loc ball))
                           (posn-y (ball-vel ball))))
             (ball-vel ball)))

;; move-balls :: [Posn] -> Posn
(define (move-balls balls)
  (if (empty? balls)
      empty
      (cons (move-ball (first balls))
            (move-balls (rest balls)))))

(define (start init)
  (big-bang init
            (to-draw draw-balls)
            (on-mouse mouse-handler)
            (on-tick move-balls)))