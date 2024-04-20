(define-module (muffin system images core)
  #:use-module (muffin)
  #:use-module (gnu)
  #:use-module (gnu services admin)
  #:use-module (gnu services desktop)
  #:use-module (gnu services ssh)
  #:use-module (gnu services vnc)
  #:use-module (gnu services xorg)
  #:use-module (guix)
  #:export (%jam-core))

(define %jam-core
 (operating-system
  (locale "en_US.utf8")
  (locale-libcs (list (canonical-package glibc)))
  (timezone "Etc/UTC")
  (keyboard-layout (keyboard-layout "us"))
  (host-name "jam-core")
  (users (cons* %muffin-user
		%base-user-accounts))
  (packages %base-packages)
  (services
   (append
    (list (service openssh-service-type
		   (openssh-configuration
		    (allow-empty-passwords? #t)
		    (gateway-ports? #t)
		    (x11-forwarding? #t)))
	  (set-xorg-configuration
	   (xorg-configuration
	    (keyboard-layout keyboard-layout)))
	  (service xvnc-service-type (xvnc-configuration
				      (display-number 5)
				      (xdmcp? #t)
				      (inetd? #t)))
	  (service gnome-desktop-service-type)
	  (service package-database-service-type
		   (package-database-configuration
		    (channels #~%muffin-channels)))
	  (simple-service 'sway-service
			  profile-service-type
			  (map specification->package
			       '("swayfx"
				 "swaynotificationcenter"
				 "kitty"
				 "foot"
				 "fuzzel"
				 "waybar-experimental"
				 "wtype"
				 "xremap-sway"
				 "bemenu"))))
    (modify-services
		%desktop-services
	      (gdm-service-type config => (gdm-configuration
					   (inherit config)
					   (auto-suspend? #f)
					   (xdmcp? #t))))))
  (bootloader
   (bootloader-configuration
    (bootloader grub-efi-bootloader)
    (targets '("/boot/efi"))
    (keyboard-layout keyboard-layout)))
  (file-systems %muffin-server-file-systems)))
