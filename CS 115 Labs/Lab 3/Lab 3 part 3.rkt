;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |exercise 1 ehp  life|) (read-case-sensitive #t) (teachpacks ((lib "image.ss" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.ss" "teachpack" "2htdp")))))
;Passed
(check-within (dr-armor 63 4000) 0.5594 0.0001)
(define (dr-armor mlvl armor)  
  (/ armor (+ armor (* mlvl 50))))

;Passed
(check-within (dr-resistance 63 200) 0.3883 0.0001)
(define (dr-resistance mlvl resists)
  (/ resists (+ resists (* mlvl 5))))

(check-expect (dodge% 50)   0.05)
(check-expect (dodge% 250)  0.1375)
(check-expect (dodge% 750)  0.25)
(check-expect (dodge% 1500) 0.35)
(define (dodge% dex)
  (if (<= dex 100) (* dex 0.001) 
      (if (<= 101 dex 500) 
          (+ .1 (* (/ 0.025 100) (- dex 100))) 
          (if (<= 501 dex 1000) 
              (+ .2 (* (/ 0.02 100) (- dex 500)))
              (if (> dex 1000) 
                  (+ .3 (* (/ 0.01 100) (- dex 1000))) 0)))))
  

(check-within (damage-taken 63 300 4000 200) 0.1603 0.0001)
(define (damage-taken mlvl dex armor resists)
  (* (- 1 (dr-armor mlvl armor))
        (- 1 (dr-resistance mlvl resists))
        (- 1 (dodge% dex))
        (- 1 0.3)))

 ;passed        
(check-expect (base-hp 20 1000 .0013) 11431.08)
(check-expect (base-hp 60 1000 .0013) 39861.88)
(define (base-hp lvl vit life%)
 (if (> lvl 35) (+ (+ 36 (+ (* vit (- lvl 25)) (* 4 lvl))) (* 0.13 (+ 36 (+ (* vit (- lvl 25)) (* 4 lvl))))) 
     (if (<= lvl 35) (+ (+ 36 (+ (* 4 lvl) (* 10 vit))) (* 0.13 (+ 36 (+ (* 4 lvl) (* 10 vit))))) 0)))

(check-within (ehp 60 63 1000 300 .0013 4000 200) 248618.23 0.1)
(define (ehp lvl mlvl vit dex life% armor resists)
  (/ (base-hp lvl vit life%) (damage-taken mlvl dex armor resists)))

(ehp 60 63 1000 300 .0013 4000 200) 