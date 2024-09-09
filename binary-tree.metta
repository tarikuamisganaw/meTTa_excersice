;; Define the binary tree structure
(: Tree Type)
(: Nil Tree)
(: Node (-> Number Tree Tree Tree))

;; Insert a value into the binary tree
(= (insert Nil $value)
   (Node $value Nil Nil))  ;; Insert into an empty tree

(= (insert (Node $root $left $right) $value)
   (if (< $value $root)
       (Node $root (insert $left $value) $right)  ;; Insert in the left subtree if value is less
       (if (> $value $root)
           (Node $root $left (insert $right $value))  ;; Insert in the right subtree if value is greater
           (Node $root $left $right))))  ;; Do nothing if the value already exists

;; Search for a value in the binary tree
(= (search Nil $value) false)  ;; Base case: Empty tree, value not found
(= (search (Node $root $left $right) $value)
   (if (== $value $root)
       true  ;; Found the value
       (if (< $value $root)
           (search $left $value)  ;; Search in the left subtree
           (search $right $value))))  ;; Search in the right subtree

;; Find the minimum value in a tree (used for deletion)
(= (find-min (Node $root Nil $right)) $root)  ;; Minimum is the leftmost node
(= (find-min (Node $root $left $right)) (find-min $left))

;; Delete a value from the binary tree
(= (delete Nil $value) Nil)  ;; Base case: Empty tree, nothing to delete
(= (delete (Node $root $left $right) $value)
   (if (< $value $root)
       (Node $root (delete $left $value) $right)  ;; Recursively delete from the left subtree
       (if (> $value $root)
           (Node $root $left (delete $right $value))  ;; Recursively delete from the right subtree
           ;; Value found, now we handle the three cases
           (if (== $left Nil) $right  ;; Case 1: No left child, return right subtree
               (if (== $right Nil) $left  ;; Case 2: No right child, return left subtree
                   ;; Case 3: Node has two children
                   (let $min-right (find-min $right)
                        (Node $min-right $left (delete $right $min-right))))))))  ;; Replace with in-order successor

;; In-order traversal: left -> root -> right
(= (in-order Nil) ())  ;; Base case: Empty tree
(= (in-order (Node $value $left $right))
   (append (in-order $left) (Cons $value (in-order $right))))  ;; Recursively traverse left, root, right

;; Pre-order traversal: root -> left -> right
(= (pre-order Nil) ())  ;; Base case: Empty tree
(= (pre-order (Node $value $left $right))
   (append (Cons $value (pre-order $left)) (pre-order $right)))  ;; Root, then recursively left and right

;; Post-order traversal: left -> right -> root
(= (post-order Nil) ())  ;; Base case: Empty tree
(= (post-order (Node $value $left $right))
   (append (post-order $left) (append (post-order $right) (Cons $value ()))))  ;; Recursively left, right, then root

;; Helper function to append lists
(= (append () $list) $list)
(= (append (Cons $x $xs) $list)
   (Cons $x (append $xs $list)))

;; Testing the insert, search, delete, and traversal functions
(: my-tree Tree)
(= (my-tree) Nil)  ;; Initialize an empty tree

;; Test insert and traversals
!(in-order (insert(insert(insert(insert (my-tree) 10)5)15)20))  ;; Expected: (Cons 5 (Cons 10 (Cons 15 (Cons 20 ()))))
!(post-order (insert(insert(insert(insert (my-tree) 10)5)15)20))  ;; Expected: (Cons 5 (Cons 20 (Cons 15 (Cons 10 ()))))
!(pre-order (insert(insert(insert(insert (my-tree) 10)5)15)20))  ;; Expected: (Cons 10 (Cons 5 (Cons 15 (Cons 20 ()))))

;; Test search
!(search (insert(insert(insert(insert (my-tree) 10)5)15)20) 15)  ;; Expected: true
!(search (insert(insert(insert(insert (my-tree) 10)5)15)20) 7)   ;; Expected: false

;; Test delete
!(in-order (delete (insert(insert(insert(insert (my-tree) 10)5)15)20) 15))  ;; Expected: (Cons 5 (Cons 10 (Cons 20 ())))
