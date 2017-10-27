;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |square root iteration|) (read-case-sensitive #t) (teachpacks ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp")))))
 (define *n* 9)

; improve :: Number -> Number
; improves the approximation of the square root of the variable *n*
(check-within (improve 2)  (exact->inexact (/ (+ 2 (/ *n* 2)) 2)) .0000001)
(check-within (improve 15) (exact->inexact (/ (+ 15 (/ *n* 15)) 2)) .0000001)
(check-within (improve 27) (exact->inexact (/ (+ 27 (/ *n* 27)) 2)) .0000001)
(define (improve ws)
  (exact->inexact (/ (+ ws (/ *n* ws)) 2)))

; render :: Number -> Image
; takes the result of improve and makes it into an image
(define (render ws)
  (overlay (text (number->string (improve ws)) 24 'black)
           (empty-scene 500 500)))

(define (key-handler ws key)
  (cond
    ((string=? key " ") (improve ws))
    (else ws)))

(define (start ws)
  (big-bang ws
            (to-draw render)
            (on-key key-handler)))