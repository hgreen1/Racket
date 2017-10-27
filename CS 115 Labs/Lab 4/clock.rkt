;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname clock) (read-case-sensitive #t) (teachpacks ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp")))))
(define *transparent-layer* (circle 100 'outline 'gray))
(define *second-hand* (overlay/align 'center 'top
                                     (rectangle 1 100 'solid 'black)
                                     *transparent-layer*))
(define *minute-hand* (overlay/align/offset 'center 'top
                                            (rectangle 3 80 'solid 'blue)
                                            0 -20
                                            *transparent-layer*))
(define *hour-hand* (overlay/align/offset 'center 'top
                                          (rectangle 5 60 'solid 'red)
                                          0 -40
                                          *transparent-layer*))
(define *hz* 28)

; Secondhandangle :: Number -> Number
; return the number of degrees to rotate the second hand by
(check-expect (secondhandangle 0) (remainder (* 0 6) 360))
(check-expect (secondhandangle 50) (remainder (* 50 6) 360))
(check-expect (secondhandangle 92) (remainder (* 92 6) 360))

(define (secondhandangle s)
  (remainder (* s 6) 360))

; minutehandangle :: Number-> Number
; return the number of degrees to rotate the minute hand by, given the time in seconds
(check-expect (minutehandangle 6) (remainder (* (quotient 6 60) 6) 360)) 
(check-expect (minutehandangle 180) (remainder (* (quotient 180 60) 6) 360)) 
(check-expect (minutehandangle 94) (remainder (* (quotient 94 60) 6) 360)) 
              
(define (minutehandangle s)
  (remainder (* (quotient s 60) 6) 360))

; hourhandangle :: Number -> Number
; return the number of degrees to rotate the hour hand by, given the time in minutes

(check-expect (hourhandangle 0) 
              (remainder (* (quotient 0 360) 6) 360))
(check-expect (hourhandangle 15) 
              (remainder (* (quotient 15 360) 6) 360))
(check-expect (hourhandangle 155) 
              (remainder (* (quotient 155 360) 6) 360))
(define (hourhandangle s)
  (remainder (* (quotient s 360) 6) 360))

; Draw-hand :: Number -> Image
; combine secondhandangle, minutehandangle, and hourhandangle to produce a clock
(check-expect (draw-clock 0) (overlay (rotate (- (secondhandangle (quotient 0 *hz*))) *second-hand*)
                                      (rotate (- (minutehandangle (quotient 0 *hz*))) *minute-hand*)
                                      (rotate (- (hourhandangle (quotient 0 *hz*))) *hour-hand*)))
(check-expect (draw-clock 54) (overlay (rotate (- (secondhandangle (quotient 54 *hz*))) *second-hand*)
                                      (rotate (- (minutehandangle (quotient 54 *hz*))) *minute-hand*)
                                      (rotate (- (hourhandangle (quotient 54 *hz*))) *hour-hand*)))
(check-expect (draw-clock 85) (overlay (rotate (- (secondhandangle (quotient 85 *hz*))) *second-hand*)
                                      (rotate (- (minutehandangle (quotient 85 *hz*))) *minute-hand*)
                                      (rotate (- (hourhandangle (quotient 85 *hz*))) *hour-hand*)))
(define (draw-clock t)
  (overlay (rotate (- (secondhandangle (quotient t *hz*))) *second-hand*)
           (rotate (- (minutehandangle (quotient t *hz*))) *minute-hand*)
           (rotate (- (hourhandangle (quotient t *hz*))) *hour-hand*)))