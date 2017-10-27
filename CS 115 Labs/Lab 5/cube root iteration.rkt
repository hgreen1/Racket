;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |cube root iteration|) (read-case-sensitive #t) (teachpacks ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp")))))
(define *n* 27)

; improve :: Number Number -> Number
; Given the number *n* gives the approximate cubed rood of the number
(check-within (improve 23)(exact->inexact 
   (/ (+ 
       (/ *n* (* 23 23)) 
       (* 2 23))
      3)).000001)
(define (improve ws)
  (exact->inexact 
   (/ (+ 
       (/ *n* (* ws ws)) 
       (* 2 ws))
      3)))

(define (render ws) 
  (overlay (text (number->string (improve ws)) 120 'blue)
           (empty-scene 400 800)))

(define (key-handler ws key)
  (cond
    ((string=? key " ")  (improve ws))
    (else ws)))

(define (start ws)
  (big-bang ws
            (to-draw render)
            (on-key key-handler)))