;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |list and cons|) (read-case-sensitive #t) (teachpacks ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp")))))
(define-struct numbers (1st rest))

; add-1-to-all :: Numbers->Numbers
(check-expect (add-1-to-all empty) empty)
(check-expect (add-1-to-all empty) empty)
(define (add-1-to-all numbers)
  (if (empty? numbers) 
      empty
      (make-numbers (add1 (numbers-1st numbers))
                    (add-1-to-all (numbers-rest numbers)))))

;;how to implement (add-1-to-all (make-numbers 1 (make-numbers 2 (make-numbers 3 empty))))


(define (mult-all-by-2 numbers)
  (if (empty? numbers)
      empty
      (make-numbers (* 2 (numbers-1st numbers))
                    (mult-all-by-2 (numbers-rest numbers)))))