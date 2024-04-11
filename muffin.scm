(define-module (muffin)
  #:use-module (gnu system accounts)
  #:use-module (gnu system file-systems)
  #:use-module (guix channels)
  #:export (%muffin-user
	    %muffin-server-file-systems
	    %muffin-net-file-systems
	    %muffin-channels))

;; User account.
(define %muffin-user
  (user-account
   (name "muffin")
   (comment "Guest Muffin")
   (group "users")
   (home-directory "/home/muffinjam")
   (password (crypt "muffin" "$6$abc"))
   (supplementary-groups
    '("netdev" "audio" "video" "input"))))

;; Server file systems.
(define %muffin-server-file-systems
  (cons* (file-system
           (mount-point "/")
           (device
            "/dev/sda1")
           (type "ext4"))
         %base-file-systems))

;; Root nfs server record.
(define %muffin-net-file-systems
  (cons*
   (file-system
    (device "muffinet:/muffinfs") ; replace with ip:/nfspath
    (mount-point "/")
    (type "nfs4")
    (options "addr=<nfs-ip-server-addr>"))
   %base-file-systems))

;; Channels
(define %muffin-channels
  (append (list (channel
		 (name 'bran-muffin)
		 (url "https://github.com/branjam4/muffin-base.git")
		 (branch "main")))
	  %default-channels))
