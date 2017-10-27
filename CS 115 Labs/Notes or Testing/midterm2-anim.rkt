;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname midterm2-anim) (read-case-sensitive #t) (teachpacks ((lib "universe.ss" "teachpack" "2htdp") (lib "image.ss" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.ss" "teachpack" "2htdp") (lib "image.ss" "teachpack" "2htdp")))))
(define *bg* (empty-scene 500 500))                                                        
(define *disc* (place-image (circle 10 'solid 'red)                                        
                            50 10                                                          
                            (circle 50 'solid 'white)))

(define (render t)
  (overlay (rotate (remainder t 360) *disc*)
           *bg*))

(animate render)