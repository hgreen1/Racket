;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname vector) (read-case-sensitive #t) (teachpacks ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp")))))
(define-struct world (init curr))
(define *start* (make-world empty empty))
(define *bg* (empty-scene 500 500))
(define *dot* (circle 5 'solid 'brown))

;; Render :: World -> Image
(define (render ws)
  (cond 
    ((empty? (world-init ws)) *bg*)
    ((empty? (world-curr ws)) (place-image *dot* 
                                           (posn-x (world-init ws))
                                           (posn-y (world-init ws))
                                           *bg*))
    (else
     (place-image (text (vector->string ws) 18 'black)
                  100
                  20
                  (place-image *dot* 
                               (posn-x (world-init ws))
                               (posn-y (world-init ws))
                               (place-image *dot* 
                                            (posn-x (world-curr ws))
                                            (posn-y (world-curr ws))
                                            (add-line *bg*
                                                      (posn-x (world-init ws))
                                                      (posn-y (world-init ws))
                                                      (posn-x (world-curr ws))
                                                      (posn-y (world-curr ws))
                                                      'brown)))))))

(define (vector->string ws)
  (string-append "X: "
                 (number->string (- (posn-x (world-curr ws)) (posn-x (world-init ws))))
                 " Y: "
                 (number->string (- (posn-y (world-curr ws)) (posn-y (world-init ws))))))

;; Mousehandler :: world x y mouseevent -> world
(define (mousehandler ws x y me)
  (cond
    ((mouse=? me "button-down") (make-world (make-posn x y) empty))
    ((mouse=? me "drag") (make-world (world-init ws) (make-posn x y)))
    (else ws)))

(define (start init)
  (big-bang init
            (to-draw render)
            (on-mouse mousehandler)))

(start *start*)