;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Lab 7 - 2|) (read-case-sensitive #t) (teachpacks ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp")))))
(define-struct world (ball target gameover?))
(define-struct dragged-ball (from to)) ; where from & to are both locations
(define-struct thrown-ball (loc vel))  ; where loc = location; vel = velocity

(define *dot* (circle 5 'solid 'black))
(define *ball* (circle 20 'solid 'red))
(define *target* (circle 20 'solid 'blue))
(define *bg* (empty-scene 500 500))

;; render-dragged-ball :: DraggedBall -> Image
(define (render-dragged-ball dball bg)
  (place-image *dot*
               (posn-x (dragged-ball-from dball))
               (posn-y (dragged-ball-from dball))
               (place-image *ball*
                            (posn-x (dragged-ball-to dball))
                            (posn-y (dragged-ball-to dball))
                            bg)))

;; render-thrown-ball :: ThrownBall -> Image
(define (render-thrown-ball tball bg)
  (place-image *ball*
               (posn-x (thrown-ball-loc tball))
               (posn-y (thrown-ball-loc tball))
               bg))

;; render-target :: Posn -> Image
(define (render-target pos)
  (place-image *target*
               (posn-x pos)
               (posn-y pos)
               *bg*))

;; render :: World -> Image
(define (render world)
  (cond ((dragged-ball? (world-ball world)) (render-dragged-ball (world-ball world) 
                                                                 (render-target (world-target world))))
        ((thrown-ball? (world-ball world)) (render-thrown-ball (world-ball world)
                                                               (render-target (world-target world))))
        ((boolean=? (world-gameover? world) true) (place-image (text "Congratulations! You Win!" 24 'pink)
                                                               250
                                                               250
                                                               *bg*))
        (else (render-target (world-target world)))))

;; tick-handler :: World -> World
(define (tick-handler world)
  (cond ((world-gameover? world)
         world)
        ((thrown-ball? (world-ball world))
         (make-world (make-thrown-ball (make-posn (+ (posn-x (thrown-ball-vel (world-ball world)))
                                                     (posn-x (thrown-ball-loc (world-ball world))))
                                                  (+ (posn-y (thrown-ball-vel (world-ball world)))
                                                     (posn-y (thrown-ball-loc (world-ball world)))))
                                       (make-posn (posn-x (thrown-ball-vel (world-ball world)))
                                                  (+ (posn-y (thrown-ball-vel (world-ball world)))
                                                     10)))
                     (world-target world)
                     (hit? (thrown-ball-loc (world-ball world)) 
                           (world-target world)
                           (image-width *ball*))))
        ((boolean=? (world-gameover? world) true) (place-image (text "Congratulations! You Win!" 24 'pink)
                                                               250
                                                               250
                                                               world))
        (else world)))

;; hit :: Posn Posn -> Boolean
(define (hit? p0 p1 dist)
  (and (<= (abs (- (posn-x p0) (posn-x p1))) dist)
       (<= (abs (- (posn-y p0) (posn-y p1))) dist)))

;; mouse-handler :: World Number Number MouseEvent -> World
(define (mouse-handler world x y me)
  (cond ((string=? me "button-down")
         (make-world (make-dragged-ball (make-posn x y) (make-posn x y))
                     (world-target world)
                     false))
        ((string=? me "drag")
         (make-world (make-dragged-ball (dragged-ball-from (world-ball world)) (make-posn x y))
                     (world-target world)
                     (world-gameover? world)))
        ((and (dragged-ball? (world-ball world)) 
              (string=? me "button-up"))
         (make-world (make-thrown-ball (make-posn x y)
                                       (compute-velocity (dragged-ball-from (world-ball world))
                                                         (make-posn x y)))
                     (world-target world)
                     (world-gameover? world)))
        (else 
         world)))

(define (compute-velocity pfrom pto)
  (make-posn (/ (- (posn-x pfrom) (posn-x pto)) 2)
             (/ (- (posn-y pfrom) (posn-y pto)) 2)))

(big-bang (make-world empty (make-posn 200 200) false)
          (to-draw render)
          (on-mouse mouse-handler)
          (on-tick tick-handler))