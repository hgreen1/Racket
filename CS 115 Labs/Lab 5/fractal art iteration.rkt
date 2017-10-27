;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |fractal art iteration|) (read-case-sensitive #t) (teachpacks ((lib "universe.ss" "teachpack" "2htdp") (lib "image.ss" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.ss" "teachpack" "2htdp") (lib "image.ss" "teachpack" "2htdp")))))
(define *img* (star 250 'solid 'purple))
(define *background* (empty-scene 1000 1000))

(define (fractal ws)
  (if (= ws 1)
      *img*
      (above (beside (scale 0.5 (rotate 35 (fractal (- ws 1))))
                     (scale 0.5 (rotate -35 (fractal (- ws 1)))))
             *img*)))

(define (render ws)
  (overlay (fractal ws)
           *background*))

(define (key-handler ws key)
  (cond
    ((key=? key " ") (add1 ws))
    (else ws)))

(define (start ws)
  (big-bang ws
            (to-draw render)
            (on-key key-handler)))