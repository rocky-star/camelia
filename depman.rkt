#lang typed/racket/base

(struct dep-info
  ([name : String]
   [version : String]
   [authors : (Listof (Pairof String String))])
  #:type-name Dep-Info)
(provide (struct-out dep-info) Dep-Info)

(: loaded-managers (Listof (Pairof Symbol Dep-Info)))
(define loaded-managers '())

(: loaded-modules (Listof (Pairof Symbol Dep-Info)))
(define loaded-modules '())

(define-type Dep-Spec (Pairof (U 'man 'mod) Symbol))
(provide Dep-Spec)

(: loaded-dep? (-> Dep-Spec Boolean))
(define (loaded-dep? dep)
  (let loop ([loadeds (if (eq? (car dep) 'man) loaded-managers loaded-modules)])
    (if (null? loadeds)
        #f
        (if (eq? (car (car loadeds)) (cdr dep))
            #t
            (loop (cdr loadeds))))))

(: find-non-loaded-dep (-> (Listof Dep-Spec) (U Dep-Spec False)))
(define (find-non-loaded-dep deps)
  (let loop ([deps deps])
    (if (null? deps)
        #f
        (let ([dep (car deps)])
          (if (loaded-dep? dep)
              (loop (cdr deps))
              dep)))))

(: raise-dep-not-loaded-error (-> Symbol Dep-Spec Nothing))
(define (raise-dep-not-loaded-error source dep)
  (raise-user-error "dependency not loaded" source dep))

(: load-manager (-> Symbol Dep-Info (Listof Dep-Spec) Void))
(define (load-manager id info deps)
  (let ([dep (find-non-loaded-dep deps)])
    (when dep (raise-dep-not-loaded-error id dep)))
  (set! loaded-managers (cons (cons id info) loaded-managers)))
(provide load-manager)

(: load-module (-> Symbol Dep-Info (Listof Dep-Spec) Void))
(define (load-module id info deps)
  (let ([dep (find-non-loaded-dep deps)])
    (when dep (raise-dep-not-loaded-error id dep)))
  (set! loaded-modules (cons (cons id info) loaded-modules)))
(provide load-module)
