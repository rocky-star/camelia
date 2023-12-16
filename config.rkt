#lang typed/racket/base

(require "depman.rkt")

(load-manager
 'config
 (dep-info "Configuration" "0.1" '(("Rocky☆Star" . "rocky-star22@outlook.com")))
 '())

(define-type Config (Listof Config-Section))
(define-type Config-Section (Pairof Symbol (Listof Config-Item)))
(define-type Config-Item (Pairof Symbol Any))

(: config Config)
(define config '())
