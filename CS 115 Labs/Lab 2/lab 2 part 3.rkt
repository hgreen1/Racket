;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |lab 2 part 3|) (read-case-sensitive #t) (teachpacks ((lib "image.ss" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.ss" "teachpack" "2htdp")))))
(define image (rectangle 1280 720 'solid 'red))

(define hd-ready? (= (/ 16 9) (/ (image-width image) 
                                 (image-height image))))

(if hd-ready? "yes" "no")
