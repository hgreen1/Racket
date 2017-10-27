;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |diablo iii ehp inlab|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; passed ;;
(check-within (dr-armor 63 4000) 0.5594 0.0001)
(define (dr-armor mlvl armor)  
  (/ armor 
     (+ armor 
        (* mlvl 50))))
;; passed ;;
(check-within (dr-resistance 63 200) 0.3883 0.0001)
(define (dr-resistance mlvl resists)
  (/ resists 
     (+ resists 
        (* mlvl 5))))
;; passed ;;
(check-expect (dodge% 50)   0.05)
(check-expect (dodge% 250)  0.1375)
(check-expect (dodge% 750)  0.25)
(check-expect (dodge% 1500) 0.35)
(define (dodge% dex)
  (if (<= dex 100) 
      (* dex 0.001)
           (if (<= 101 dex 500) 
               (+ .1 (* (- dex 100) .00025))
               (if (<= 501 dex 1000)
                   (+ .2 (* (- dex 500) .0002))
                      (+ .3 (* (- dex 1000) .0001))))))
;; Passed ;;
(check-within (damage-taken 63 300 4000 200) 0.1603 0.0001)
(define (damage-taken mlvl dex armor resists)
  (* (- 1 (dr-armor mlvl armor)) 
     (- 1 (dr-resistance mlvl resists))
     (- 1 (dodge% dex))
     (- 1 .3)))

(check-expect (base-hp 20 1000) 10116)
(check-expect (base-hp 60 1000) 35276)
(define (base-hp lvl vit)
  (if  (> lvl 35) (+ 36 (* 4 lvl) (* (- lvl 25) vit))
                  (+ 36 (* 4 lvl) (* 10 vit))))


(check-within (ehp 60 63 1000 300 4000 200) 220016.1 0.1)
(define (ehp lvl mlvl vit dex armor resists)
  (/ (base-hp lvl vit) (damage-taken mlvl dex armor resists)))