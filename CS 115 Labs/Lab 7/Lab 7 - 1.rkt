;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lab7) (read-case-sensitive #t) (teachpacks ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp")))))
;; WorldState is either:
;; 1. empty
;; 2. a dragged ball
;; 3. a thrown ball
(define-struct dragged-ball (orig to))
(define-struct thrown-ball (loc vel))

(define *bg* (empty-scene 500 500))
(define *dot* (circle 5 'solid 'black))
(define *ball* (circle 20 'solid 'red))

; ball-move :: ThrownBall -> ThrownBall
(define (ball-move ball)
  (make-thrown-ball (make-posn (+ (posn-x (thrown-ball-loc ball))
                                  (posn-x (thrown-ball-vel ball)))
                               (+ (posn-y (thrown-ball-loc ball))
                                  (posn-y (thrown-ball-vel ball))))
                    (thrown-ball-vel ball)))

;; out-of-bounds? :: ThrownBall -> Boolean
(define (out-of-bounds? ball)
  false)

;; tick-handler :: WorldState -> Worldstate
(define (tick-handler ws)
  (cond ((and (thrown-ball? ws) (out-of-bounds? ws))
         empty)
        ((thrown-ball? ws)
         (ball-move ws))
        (else 
         ws)))

;; mouse-handler :: WorldState Number Number MouseEvent -> WorldState
(define (mouse-handler ws x y me)
  (cond ((string=? me "button-down")
         (make-dragged-ball (make-posn x y)
                            (make-posn x y)))
        ((string=? me "drag")
         (make-dragged-ball (dragged-ball-orig ws)
                            (make-posn x y)))
        ((string=? me "button-up")
         (make-thrown-ball (make-posn x y)
                           (velocity-vector ws)))
        (else
         ws)))

;; velocity-vector :: DraggedBall -> Posn
(define (velocity-vector dball)
  (make-posn (- (posn-x (dragged-ball-orig dball))
                (posn-x (dragged-ball-to dball)))
             (- (posn-y (dragged-ball-orig dball))
                (posn-y (dragged-ball-to dball)))))

;; render :: WorldState -> Image
(define (render ws)
  (cond ((thrown-ball? ws)
         (place-image *ball*
                      (posn-x (thrown-ball-loc ws))
                      (posn-y (thrown-ball-loc ws))
                      *bg*))
        ((dragged-ball? ws)
         (place-image *dot*
                      (posn-x (dragged-ball-orig ws))
                      (posn-y (dragged-ball-orig ws))
                      (place-image *ball*
                                   (posn-x (dragged-ball-to ws))
                                   (posn-y (dragged-ball-to ws))
                                   *bg*)))
        (else 
         *bg*)))


(big-bang empty
          (on-tick tick-handler)
          (on-mouse mouse-handler)
          (to-draw render))