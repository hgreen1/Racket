;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |quadratic formula|) (read-case-sensitive #t) (teachpacks ((lib "image.ss" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.ss" "teachpack" "2htdp")))))
(define a 3)
(define b 6)
(define c 3)

 (/ (* b b (- (sqrt (* 4 a c))))(* 2 a))
 
 (/ (* b b  (sqrt (* 4 a c)))(* 2 a))