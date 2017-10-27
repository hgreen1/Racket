;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |draw-time tweak|) (read-case-sensitive #t) (teachpacks ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp")))))
(define (draw-time t)   
   (overlay (text (number->string newtons-cubed-root) 120 'blue)
            (empty-scene 400 150)))

(define (plus1 n)
  (+ n 1))

(define (start init)
 (big-bang init
            (on-tick sub1 1/28 init)
            (to-draw draw-time)))


;finished? :: WorldState -> Boolean
(define (finished? n)
  (<= n 0))
