;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |exercise 2|) (read-case-sensitive #t) (teachpacks ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp")))))
(define-struct target (loc width))

(define (render ws)
  (if (> (target-width ws)
         10)
      (place-image (square (target-width ws) 'solid 'brown)
                   (posn-x (target-loc ws))
                   (posn-y (target-loc ws))
                   (empty-scene 500 500))
      (place-image (text "You Win! Thanks for this hard-a$$ final!" 24 'red)
                   250
                   250
                   (empty-scene 500 500))))

(define (start ws)
  (big-bang (make-target (make-posn (random 500) (random 500)) 100)
            (on-mouse mouse-handler)
            (to-draw render)))

(define (mouse-handler ws x y me)
  (cond
    ((mouse=? me "enter") ws)
    ((mouse=? me "leave") ws)
    ((mouse=? me "button-down") (if (and (>= x (- (target-width ws) (posn-x (target-loc ws))))
                                         (<= x (+ (target-width ws) (posn-x (target-loc ws))))
                                         (>= y (- (target-width ws) (posn-y (target-loc ws))))
                                         (<= y (+ (target-width ws) (posn-y (target-loc ws)))))
                                         (make-target (make-posn (random 500) (random 500)) 
                                                      (* (target-width ws) 0.5))                                   
                                         ws))
                                    (else ws)))
    
    
    (start (make-target (make-posn (random 500) (random 500)) 100))