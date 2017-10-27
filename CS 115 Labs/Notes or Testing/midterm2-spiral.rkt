;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname midterm2-spiral) (read-case-sensitive #t) (teachpacks ((lib "universe.ss" "teachpack" "2htdp") (lib "image.ss" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.ss" "teachpack" "2htdp") (lib "image.ss" "teachpack" "2htdp")))))
(define *base* (square 300 'outline 'black))

(define (next ws)
  (overlay (scale .75 (rotate 5 ws)) *base*))

(define (render ws)
  (overlay ws
           *base*))

(big-bang *base*
          (on-tick next)
          (to-draw render))