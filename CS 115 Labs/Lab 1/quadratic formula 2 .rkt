;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |quadratic formula 2 |) (read-case-sensitive #t) (teachpacks ((lib "image.ss" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.ss" "teachpack" "2htdp")))))
(define a 3)
(define b 6)
(define c 3)
(define det (* 4 a c))

(define quadneg (/ (* b b (-(sqrt det)))(* 2 a)))

(define quadpos (/ (* b b (sqrt det))(* 2 a)))

(if (< det 0) "no real roots"
               quadpos
               )

(if (< quadneg 0) quadneg
              "no real roots"
              )
               