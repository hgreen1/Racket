;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |newton's method for cube roots|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))

(define (newtons-cubed-root g x)
  (if (close-enough? g x)
      g
      (newtons-cubed-root (improve g x) x)))

(define *episilon* 0.00000001)

(check-expect (close-enough? 2.481 3) false)
(check-expect (close-enough? 2.955 3) false)
(check-expect (close-enough? (expt 27 1/3) 3) true)
(define (close-enough? g x)
  (< (abs (- x (* g g g))) *episilon* ))

(check-expect (improve 1.5 27) (/ (+ 
      (/ 27 (* 1.5 1.5)) 
             (* 2 1.5))
     3))
(define (improve g x)
  (/ (+ 
      (/ x (* g g)) 
             (* 2 g))
     3))

(check-expect (average 57 62 158) (/ (+ 57 62 158) 3))
(define (average x y z)
  (/ (+ x y z) 3))