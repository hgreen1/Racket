;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname worldstate) (read-case-sensitive #t) (teachpacks ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp")))))
; Data definition:
; Worldstate is a Image
(define *bg* (empty-scene 600 600))


; render :: WorldState -> Image
(define (render ws)
  (overlay ws
          (empty-scene 500 500)))

; advance :: WorldState -> WorldState
(define (advance ws)
  ws)

; key-handler :: WorldState KeyEvent -> WorldState
(check-expect (key-handler "abc" "d") "abcd")
(define (key-handler ws k)
  ws)

; Finished :: WorldState -> Boolean
(define (finished? ws)
  (>= (string-length ws) 10))

; mousehandler :: WorldState Number Number MouseEvent -> WorldState
(define (mousehandler ws x y me)
  (place-image (square 5 'solid 'black) 
               x y 
               ws))

(define (start initws)
  (big-bang (empty-scene 500 500)
            (on-tick advance)
            (to-draw render)
            (on-mouse mousehandler)))