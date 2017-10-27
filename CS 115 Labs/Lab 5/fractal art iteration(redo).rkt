;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |fractal art iteration(redo)|) (read-case-sensitive #t) (teachpacks ((lib "universe.ss" "teachpack" "2htdp") (lib "image.ss" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.ss" "teachpack" "2htdp") (lib "image.ss" "teachpack" "2htdp")))))
(define *img* (circle 250 'solid 'orange))
(define *background* (empty-scene 1000 1000))

; Fractal : WorldState -> Image
; Given the image (as a worldstate) and places it above the previous image.
(check-expect (fractal *img*) (above (beside (scale 0.5 (rotate 35 *img*))
                                          (scale 0.5 (rotate -35 *img*)))
                                  *img*))
(define (fractal ws)
  (above (beside (scale 0.5 (rotate 35 ws))
                 (scale 0.5 (rotate -35 ws)))
         *img*))

(define (render ws)
  (overlay ws *background*))

(define (key-handler ws key)
  (cond
    ((key=? key " ") (fractal ws))
    (else ws)))

(define (start ws)
  (big-bang ws
            (to-draw render)
            (on-key key-handler)))