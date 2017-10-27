;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |exercise 3 fractal art|) (read-case-sensitive #t) (teachpacks ((lib "universe.ss" "teachpack" "2htdp") (lib "image.ss" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.ss" "teachpack" "2htdp") (lib "image.ss" "teachpack" "2htdp")))))
(define *star* (star 250 'solid 'purple))

(check-expect (fractal-lvl-1 (rectangle 10 30 'solid 'red))
              (above (beside (scale 0.5 (rotate 35 
                                                (rectangle 10 30 'solid 'red)))
                             (scale 0.5 (rotate -35 
                                                (rectangle 10 30 'solid 'red))))
                     (rectangle 10 30 'solid 'red)))
(define (fractal-lvl-1 img)
  (above (beside (scale 0.5 (rotate 35 img))
                 (scale 0.5 (rotate -35 img)))
                 img))

(define (fractal-lvl-2 img)
  (above (beside (scale 0.5 (rotate 35 (fractal-lvl-1 img)))
                 (scale 0.5 (rotate -35 (fractal-lvl-1 img))))
                 img))

(define (fractal-lvl-3 img)
  (above (beside (scale 0.5 (rotate 35 (fractal-lvl-2 img)))
                 (scale 0.5 (rotate -35 (fractal-lvl-2 img))))
                 img))

(define (fractal img lvl)
  (if (= lvl 1)
      img
      (above (beside (scale 0.5 (rotate 35 (fractal img (- lvl 1))))
                 (scale 0.5 (rotate -35 (fractal img (- lvl 1)))))
                 img)))