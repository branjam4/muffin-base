(define-module (muffin packages klibc)
  #:use-module (gnu packages)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages perl)
  #:use-module (guix build-system gnu)
  #:use-module (guix build utils)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix packages)
  #:use-module ((guix licenses) #:prefix license:))

(define-public klibc
  (package
    (name "klibc")
    (version "2.0.13")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://git.kernel.org/pub/scm/libs/klibc/klibc.git")
                    (commit (string-append name "-" version))
                    (recursive? #t)))
              (file-name (git-file-name name version))
              (sha256
               (base32
		"0yw586d28f7kpr9rw8d6vmkisrzbw2s7lfhm26j054bn1l8ngpa2"))))
    (build-system gnu-build-system)
    (arguments
     (list #:make-flags #~(list
			   (string-append
			    "KLIBCKERNELSRC=" #$linux-libre-headers)
			   (string-append
			    "INSTALLROOT=" #$output))
	   #:phases #~(modify-phases %standard-phases
			(delete 'check)
			(delete 'configure))))
    (native-inputs (list perl))
    (propagated-inputs (list linux-libre-headers))
    (synopsis "Minimalistic libc subset for use with initramfs.")
    (description
     "This is klibc, what is intended to be a minimalistic libc subset for
use with initramfs.  It is deliberately written for small size,
minimal entanglement, and portability, not speed.  It is definitely a
work in progress, and a lot of things are still missing.")
    (home-page "https://git.kernel.org/pub/scm/libs/klibc/klibc.git/about")
    (license license:gpl2)))
