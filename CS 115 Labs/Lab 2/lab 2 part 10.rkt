;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |lab 2 part 10|) (read-case-sensitive #t) (teachpacks ((lib "image.ss" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.ss" "teachpack" "2htdp")))))
(define word "apples")

(define i 1)

(define string-last (substring word (- (string-length word) i) (string-length word)))

(define plural? (and (> (string-length word) 2) (string=? string-last "s")))

plural?

;; Replace apples with whatever and change all the numbers to fit the specific rule...