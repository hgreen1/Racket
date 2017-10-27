;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname final-timer) (read-case-sensitive #t) (teachpacks ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp")))))
(define-struct timer (running? start curr))

(define (render ws)
  (if (timer-running? ws)
      (place-image (text (number->string (timer-start ws)) 64 'red)
                   250
                   250
                   (empty-scene 500 500))
      (place-image (text (number->string (timer-curr ws)) 64 'blue)
                   250
                   250
                   (empty-scene 500 500))))


(define (tick-handler ws)
  (if (timer-running? ws)
      (make-timer false (timer-start ws) (timer-curr ws))
      (make-timer true  (timer-start ws) (timer-curr ws))))

(define (key-handler ws key)
  (cond
    ((key=? key " ") (if (boolean=? (timer-running? ws) true)
                         (make-timer true 100 (sub1 (timer-curr ws)))
                         (make-timer false (timer-start ws) (timer-curr ws))))
    ((key=? key "r") (if (boolean=? (timer-running? ws) true)
                         ws
                         (make-timer false (timer-start ws) (timer-start ws))))
    ((key=? key "i") (if (boolean=? (timer-running? ws) true)
                         ws
                         (make-timer false (timer-start ws) (+ (timer-curr ws) 10))))
    ((key=? key "d") (if (boolean=? (timer-running? ws) true)
                         ws
                         (make-timer false (timer-start ws) (- (timer-curr ws) 10))))
    (else ws)))

(define (start ws)
  (big-bang (make-timer false 100 0)
            (on-key key-handler)
            (on-tick tick-handler 1/10)
            (to-draw render)))

(start (make-timer false 100 0))