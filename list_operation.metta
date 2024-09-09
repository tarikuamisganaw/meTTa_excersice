;; Define List structure
(: List type)
(: Nil List)
(: Cons (-> Number List List))

;; Length of the list
(= (length Nil) 0)
(= (length (Cons $x $xs))
   (+ 1 (length $xs)))



;; Appending  lists
(= (append Nil $list) $list)
(= (append (Cons $x $xs) $list)
   (Cons $x (append $xs $list)))

;; finding member in list
(= (is-member $x Nil) false)
(= (is-member $x (Cons $y $ys))
   (if (== $x $y)
       true
       (is-member $x $ys)))  ;; Recursively check the rest of the list if no match

;; map operation in list
(= (map $f ()) ())
(= (map $f (Cons $x $xs))
   (Cons ($f $x) (map $f $xs)))
   

;; Remove the first occurrence of an element
(= (remove-element $x Nil) Nil)
(= (remove-element $x (Cons $y $ys))
   (if (== $x $y)
       $ys
       (Cons $y (remove-element $x $ys))))

;; Remove duplicate elements from a list 
(= (remove-duplicates Nil) Nil)
(= (remove-duplicates (Cons $x $xs))
   (Cons $x (remove-duplicates (remove-element $x $xs))))



 

;; Max value in a list
(= (max-value Nil) "undefined")  ;; Optional: handle the case where an empty list is passed
(= (max-value (Cons $x Nil)) $x)  ;; Base case: only one element
(= (max-value (Cons $x $xs))
   (let $max-xs (max-value $xs)
        (if (> $x $max-xs) $x $max-xs)))  ;; Recursive case: compare head with max of tail

;;calculate the minimum value
(= (min-value Nil) "undefined")  ;; Optional: handle the case where an empty list is passed
(= (min-value (Cons $x Nil)) $x)  ;; Base case: only one element
(= (min-value (Cons $x $xs))
   (let $max-xs (min-value $xs)
        (if (< $x $max-xs) $x $max-xs)))  ;; Recursive case: compare head with max of tail

;; Push an element to the front of the list
(= (push $x $list)
   (Cons $x $list))

;; Pop the first element from the list
(= (pop (Cons $x $xs)) $xs)



;; sorting a list
(= (sort Nil) Nil)
(= (sort (Cons $x $xs))
   (insert-sorted $x (sort $xs)))

;; Helper function for inserting into a sorted list
(= (insert-sorted $x Nil) (Cons $x Nil))
(= (insert-sorted $x (Cons $y $ys))
   (if (< $x $y)
       (Cons $x (Cons $y $ys))
       (Cons $y (insert-sorted $x $ys))))



;; Reverse a list
(= (reverse Nil) Nil)
(= (reverse (Cons $x $xs))
   (append (reverse $xs) (Cons $x Nil)))

;; Right fold
(= (foldr $f $acc Nil) $acc)
(= (foldr $f $acc (Cons $x $xs))
   ($f $x (foldr $f $acc $xs)))
 
;; Left fold
(= (foldl $f $acc Nil) $acc)
(= (foldl $f $acc (Cons $x $xs))
   (foldl $f ($f $acc $x) $xs))

;; Filter elements that satisfy a condition
(= (filter $f Nil) Nil)
(= (filter $f (Cons $x $xs))
   (if ($f $x)
       (Cons $x (filter $f $xs))
       (filter $f $xs)))

;; Define a condition function to check if a number is even
(= (is-even $x) (== (% $x 2) 0))



;; Test cases

;; Test length of a list
!(length (Cons A (Cons B (Cons C Nil))))  ;; Expected output: 3

;; Test memeber in a list
!(is-member 1 (Cons 1 (Cons 2 (Cons 3 (Cons 4 Nil)))))  ;; Expected output: true

;; Test appending to a list
!(append (Cons A (Cons B Nil)) (Cons C (Cons D Nil)))  ;; Expected output: (Cons A (Cons B (Cons C (Cons D Nil))))

;;Test removing duplicate in a list
! (remove-duplicates (Cons 1 (Cons 2 (Cons 1 (Cons 3 (Cons 2 Nil)))))) ;; Expected output: [(Cons 1 (Cons 2 (Cons 3 Nil)))]

;; Test mapping a list
! (map A (Cons 1 (Cons 2 (Cons 3 ())))) ;; Expected output: [(Cons (A 1) (Cons (A 2) (Cons (A 3) ())))]

;; Test maximum value of a list
! (max-value (Cons 3 (Cons 1 (Cons 2 Nil)))) ;;Expected value [3]

;; Test minimum value of a list
! (min-value  (Cons 3 (Cons 1 (Cons 2 Nil)))) ;;Expected value [1]

;; Test push to a list
! (push  4 (Cons 3 (Cons 2 (Cons 1 Nil)))) ;;Expected output [(Cons 4 (Cons 3 (Cons 2 (Cons 1 Nil))))]

;; Test poping from a list
! (pop (Cons 1 (Cons 2 (Cons 3 Nil)))) ;;Expected output  [(Cons 2 (Cons 3 Nil))]

;; Test removing an element from a list
! (remove-element 2 (Cons 1 (Cons 2 (Cons 3 Nil))));; Expected output [(Cons 1 (Cons 3 Nil))]

;; Test sorting a list
! (sort  (Cons 2 (Cons 1 (Cons 3  Nil))));;Expected output [(Cons 1 (Cons 2 (Cons 3 Nil)))]

;; Test reversing list
!(reverse  (Cons 3 (Cons 2 (Cons 1 Nil)))) ;;Expected output [(Cons 1 (Cons 2 (Cons 3 Nil)))]

;; Test foldr with a custom addition operation
!(foldr + 1 (Cons 1 (Cons 2 (Cons 3 Nil))))  ;; Expected output: 7

;; Test foldl with a custom addition operation
!(foldl + 1 (Cons 1 (Cons 2 (Cons 3 Nil)))) ;; Expected output: 7

;; Check if the filter function works (filter even numbers)
!(filter is-even (Cons 1 (Cons 2 (Cons 3 (Cons 4 Nil)))))  ;; Expected output: (Cons 2 (Cons 4 Nil))