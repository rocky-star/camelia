#lang info
(define collection "camelia")
(define deps '("base" "typed-racket-lib" "charterm" "gettext"))
(define build-deps '("scribble-lib" "racket-doc" "typed-racket-doc" "rackunit-lib"))
(define scribblings '(("scribblings/camelia-user.scrbl" ()) ("scribblings/camelia-dev.scrbl" ())))
(define pkg-desc "Home library management software")
(define version "0.1")
(define pkg-authors '("rocky-star22@outlook.com"))
(define license '(Apache-2.0 OR MIT))
