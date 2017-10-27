;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |CS116 inlab 3|) (read-case-sensitive #t) (teachpacks ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp")))))
(define (sort-list lst cmp)
  (if (empty? lst)
      empty
      (sorted-insert (first lst)
                     cmp
                     (sort-list (rest lst) cmp))))

(define (sorted-insert n cmp lst)
  (if (empty? lst)
      (list n)
      (if (cmp n (first lst))
          (cons n lst)
          (cons (first lst) (sorted-insert n cmp (rest lst))))))

(sort-list (list 9 9 5 2 4 9 63 2 85 8 6 23 89) <)
(sort-list (list "a" "b" "r" "o" "a" "r") string<?)
(sort-list (list 9 9 5 2 4 9 63 2 85 8 6 23 89) >)
(sort-list (list "a" "b" "r" "o" "a" "r") string>?)


;; rand-list :: Number Number -> list of numbers
(define (rand-list max n)
  (if (= n 0)
      empty
      (cons (random max)
            (rand-list max (sub1 n)))))

(rand-list 15 15)
