;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname draw-time) (read-case-sensitive #t) (teachpacks ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp")))))
; draw-time :: Number -> Image
; draws the provided number as an image, in 24 pt and blue
(check-expect (draw-time 0) (overlay (text (number->string (backwardsfrom10 0)) 128 'blue)
                                     (empty-scene 200 150)))
(check-expect (draw-time 25) (overlay (text (number->string (backwardsfrom10 25)) 128 'blue)
                                      (empty-scene 200 150)))
(check-expect (draw-time 36) (overlay (text (number->string (backwardsfrom10 36)) 128 'blue)
                                     (empty-scene 200 150)))

(define (draw-time t)   
  (overlay (text (number->string (backwardsfrom10 t)) 128 'blue)
           (empty-scene 200 150)))

(define *hz* 28)



; backwardsfrom10 :: Number Number -> Number
; counts down from 10 given an integer divided by 28
(check-expect (backwardsfrom10 0) (if 
                                   (<= (t->seconds 0) 10)
                                   (- 10 (t->seconds 0))
                                   0))
(check-expect (backwardsfrom10 10) (if 
                                    (<= (t->seconds 10) 10)
                                    (- 10 (t->seconds 10))
                                    0)) 
(check-expect (backwardsfrom10 25) (if 
                                    (<= (t->seconds 25) 10)
                                    (- 10 (t->seconds 25))
                                    0)) 
(define (backwardsfrom10 t)
  (if 
   (<= (t->seconds t) 10)
   (- 10 (t->seconds t))
   0))

; t->seconds :: Number -> Number
; given the number of ticks it returns the time in seconds.
(check-expect (t->seconds 0) (remainder (quotient 0 28) *hz*))
(check-expect (t->seconds 15) (remainder (quotient 15 28) *hz*))
(check-expect (t->seconds 80) (remainder (quotient 80 28) *hz*))
(define (t->seconds t)
  (remainder (quotient t 28) *hz*))