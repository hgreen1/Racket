;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname midterm2-arith) (read-case-sensitive #t) (teachpacks ((lib "universe.ss" "teachpack" "2htdp") (lib "image.ss" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.ss" "teachpack" "2htdp") (lib "image.ss" "teachpack" "2htdp")))))
(define *bg* (empty-scene 500 500))                                                        

(define (key-handler ws key)                                                               
  (cond
    ((key=? key "+") (+ ws 1))
    ((key=? key "-") (- ws 1))
    ((key=? key "d") (* ws 2))
    ((key=? key "h") (/ ws 2))
    (else ws)))

(define (render ws)                                                                        
  (overlay (text (number->string ws) 128 'black)
           *bg*))

(big-bang 0
          (on-key key-handler)
          (to-draw render))