#lang scribble/manual
@(require (for-label typed/racket/base))

@title{Camélia Developer's Manual}
@author{Rocky☆Star}

This manual is intented for developers who want to contribute to Camélia or write additional modules & managers.

@section[#:tag "depman"]{Dependency Management}

@(require (for-label camelia/depman))
@defmodule[camelia/depman]

The dependency management module in Camélia doesn't implicitly loading missing dependencies and solving conflicts.
Instead, modules & managers must explicitly register themselves in the registry.
By doing this, during the registration, the dependency management module will be able to find missing dependencies and raise exceptions in need.

@subsection{Registrations}

@deftogether[(
  @defproc[(load-manager [id Symbol] [info Dep-Info] [deps (Listof Dep-Spec)]) Void]
  @defproc[(load-module [id Symbol] [info Dep-Info] [deps (Listof Dep-Spec)]) Void]
)]{
These functions registers a new manager or module into the registry.
If any dependencies specified in @tt{deps} is not loaded, a @racket[exn:fail:user?] will be raised.
}

@deftogether[(
  @defstruct*[dep-info ([name String] [version String] [authors (Pairof String String)])]
  @defthing[#:kind "type" Dep-Info dep-info?]
)]{
Represents detailed information of dependencies.
@tt{name} is a friendly name.
@tt{version} is a version name.
@tt{authors} is a list that contains pairs of author names & e-mail addresses.
}

@defthing[#:kind "type" Dep-Spec (Pairof (U 'man 'mod) Symbol)]{
Represents a dependency specification.
It is a pair.
For managers, the first element should be @racket['man].
For modules, use @racket['mod].
The second element is a symbol representing the ID of the dependency.
}

@subsection{Querying}

@deftogether[(
  @defproc[(loaded-manager? [id Symbol]) Boolean]
  @defproc[(loaded-module? [id Symbol]) Boolean]
)]{
These predicates check whether the specified manager or module has been loaded.
Returns @racket[#t] if loaded, @racket[#f] otherwise.
}

@deftogether[(
  @defproc[(get-loaded-managers) (Listof (Pairof Symbol Dep-Info))]
  @defproc[(get-loaded-modules) (Listof (Pairof Symbol Dep-Info))]
)]{
Returns a list that contains all loaded managers or modules.
}
