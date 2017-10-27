;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |iit logo|) (read-case-sensitive #t) (teachpacks ((lib "image.ss" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.ss" "teachpack" "2htdp")))))
(define iit (rotate 180 (triangle 500 'solid 'red)))
(define ray (triangle/ass 5 600 600 'solid 'white))

(define iitpt1(overlay/align "left" "top" 
                              (rotate -5 ray) 
                              (rotate -15 ray) 
                              (rotate -25 ray) 
                              iit))

(define iitpt2(overlay/offset (rotate 88 ray)
                              15 15 
                              iitpt1))

(define iitpt3(overlay/offset (rotate 77 ray)
                              -27 0 
                              iitpt2))

(define iitfinal (overlay/offset (rotate 68 ray)
                                 -70 0
                                 iitpt3))

iitfinal