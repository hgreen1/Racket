;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname make-posn) (read-case-sensitive #t) (teachpacks ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp")))))
(define origin (make-posn 0 0))
(define a-posn (make-posn 5 8))

; pos-x, pos-y to find out what position is in (make-posn x y)
; 

(define *dot* (circle 20 'solid 'red))
(define *background* (empty-scene 500 400))

(define (render ws)
  (place-image *dot*
               (posn-x ws) (posn-y ws)
               *background*))

(define (key-handler ws key)
  (cond
    ((key=? key "w") (make-posn (posn-x ws) (sub1 (posn-y ws))))
    ((key=? key "x") (make-posn (posn-x ws) (add1 (posn-y ws))))
    ((key=? key "a") (make-posn (sub1 (posn-x ws)) (posn-y ws)))
    ((key=? key "d") (make-posn (add1 (posn-x ws)) (posn-y ws)))
    ((key=? key "q") (make-posn (sub1 (posn-x ws)) (sub1 (posn-y ws))))
    ((key=? key "e") (make-posn (add1 (posn-x ws)) (sub1 (posn-y ws))))
    ((key=? key "z") (make-posn (sub1 (posn-x ws)) (add1 (posn-y ws))))
    ((key=? key "c") (make-posn (add1 (posn-x ws)) (add1 (posn-y ws))))
    (else ws)))

(define (start ws)
  (big-bang ws
            (to-draw render)
            (on-key key-handler))) 


