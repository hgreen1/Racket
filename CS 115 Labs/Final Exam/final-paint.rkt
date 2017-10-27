;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |exercise 1 - paint|) (read-case-sensitive #t) (teachpacks ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp")))))
(define-struct canvas (curr-color image))
(define *bg* (empty-scene 500 500))
(define *init* (make-canvas 'red *bg*))

(define (render ws)
  (canvas-image ws))

(define (key-handler ws key)
  (cond
    ((key=? key "r") (make-canvas 'red (canvas-image ws)))
    ((key=? key "b") (make-canvas 'blue (canvas-image ws)))
    ((key=? key "g") (make-canvas 'green (canvas-image ws)))
    ((key=? key "c") (make-canvas (canvas-curr-color ws) *bg*))
    (else ws)))

(define (mouse-handler ws x y me)
  (cond ((mouse=? me "button-down") (make-canvas (canvas-curr-color ws)
                                                 (place-image (canvas-image 
                                                               (make-canvas (canvas-curr-color ws)
                                                                            (circle 10 'solid (canvas-curr-color ws))))
                                                              x y 
                                                              (canvas-image ws))))
        ((mouse=? me "drag") (make-canvas (canvas-curr-color ws)
                                          (place-image (canvas-image 
                                                        (make-canvas (canvas-curr-color ws)
                                                                     (circle 10 'solid (canvas-curr-color ws))))
                                                       x y 
                                                       (canvas-image ws))))
        (else ws)))

(define (start ws)
  (big-bang (make-canvas 'red *bg*)
            (to-draw render)
            (on-mouse mouse-handler)
            (on-key key-handler)))

(start *init*)