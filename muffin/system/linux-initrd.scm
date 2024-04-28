(define-module (muffin system linux-initrd)
  #:use-module (muffin packages klibc)
  #:use-module (gnu)
  #:use-module (gnu system linux-initrd)
  #:use-module (gnu packages admin)
  #:use-module (guix gexp)
  #:use-module (guix modules)
  #:export (with-guix-build-utils
	    net-initrd
	    net-initrd-with-klibc))

(define-syntax-rule (with-guix-build-utils script ...)
  "Sugar for running a guile program with `(guix build utils)'."
  (with-imported-modules
      (source-module-closure
       '((guix build utils)))
    #~(begin
	(use-modules ((guix build utils) #:hide (delete)))
	script ...
	#t)))

(define %klibc-pre-mount
  (with-guix-build-utils
   (symlink #$(file-append klibc "/lib") "/lib")
   (symlink #$(file-append klibc "/usr") "/usr")
   (system* "/usr/lib/klibc/bin/ipconfig" "eth0")))

(define %dhclient-pre-mount
  (with-guix-build-utils
   (system* "dhclient"
	    "-cf" "/usr/dhclient.conf"
	    "-pf" "/usr/dhclient.pid"
	    "-lf" "/usr/dhclient.leases")
   (system* "dhclient" "-x"
	    "-pf" "/usr/dhclient.pid")))

(define (net-initrd file-systems . rest)
  (apply raw-initrd file-systems
	 #:helper-packages (list isc-dhcp)
	 #:pre-mount %dhclient-pre-mount
	 rest))

(define (net-initrd-with-klibc file-systems . rest)
  (apply raw-initrd file-systems
	 #:pre-mount %klibc-pre-mount
	 rest))
