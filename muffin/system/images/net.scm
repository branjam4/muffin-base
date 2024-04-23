(define-module (muffin system images net)
  #:use-module (muffin)
  #:use-module (muffin packages klibc)
  #:use-module (muffin system images core)
  #:use-module (gnu)
  #:use-module (gnu packages linux)
  #:use-module (gnu services networking)
  #:use-module (guix)
  #:use-module (guix modules)
  #:use-module (srfi srfi-1)
  #:export (%muffin-net-layer))

(define %muffin-net-layer
  (operating-system
    (inherit %jam-core)
    (host-name "muffinet")
    (services
     (append
      (list (service dhcp-client-service-type))
      (remove (lambda (service)
		(let ((type (service-kind service)))
		  (or (memq type
			    (list network-manager-service-type))
		      (eq? 'network-manager-applet
			   (service-type-name type)))))
	      (operating-system-user-services %jam-core))))
    (bootloader
     (bootloader-configuration
      (bootloader grub-efi-netboot-bootloader)
      (targets '("/boot/"))
      (keyboard-layout (operating-system-keyboard-layout %jam-core))))
    (initrd-modules
     (cons* "overlay" "realtek" "r8169" "nfsv4" "nfs"
	    %base-initrd-modules))
    (kernel-arguments (cons* "ip=dhcp" %default-kernel-arguments))
    (kernel (customize-linux #:linux linux-libre-lts
			     #:configs '("CONFIG_NFS_SWAP=y")))
    (initrd (lambda (file-systems . rest)
	      (apply raw-initrd file-systems
		     #:pre-mount (with-imported-modules
				     (source-module-closure
				      '((guix build utils)))
				   #~(begin
				       (use-modules ((guix build utils) #:hide (delete)))
				       (symlink (string-append #$klibc "/lib") "/lib")
				       (symlink (string-append #$klibc "/usr") "/usr")
				       (system* "/usr/lib/klibc/bin/ipconfig" "eth0")
				       #t))
		     rest)))
    (file-systems %muffin-net-file-systems)))
