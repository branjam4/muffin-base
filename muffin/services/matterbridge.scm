(define-module (muffin services matterbridge)
  #:use-module (gnu)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages messaging)
  #:use-module (gnu services configuration)
  #:use-module (gnu services shepherd)
  #:use-module (guix gexp)
  #:use-module (guix records)
  #:export (matterbridge-configuration
	    matterbridge-service-type))

(define-configuration matterbridge-configuration
  (matterbridge
   (file-like matterbridge)
   "Matterbridge package to use.")
  (config-file
   (file-like (plain-file "blank.toml" ""))
   "Where the matterbridge config lives.")
  (no-serialization))

(define %matterbridge-accounts
  (list (user-group (name "matterbridge") (system? #t))
        (user-account
         (name "matterbridge")
         (group "matterbridge")
         (system? #t)
         (comment "Matterbridge daemon")
         (shell (file-append shadow "/sbin/nologin")))))

(define (matterbridge-shepherd-service config)
  "Service for running matterbridge."
  (match-record
   config <matterbridge-configuration> (matterbridge
					config-file)
    
   (shepherd-service
    (documentation "Run matterbridge.")
    (provision '(matterbridge))
    (requirement '(networking))
    (actions	(list
		 (shepherd-configuration-action config-file)))
    ;; (respawn-limit '(4 . 1000))
    (respawn-delay 60)
    (start #~(make-forkexec-constructor
              '(#$(file-append matterbridge "/bin/matterbridge")
		"-conf"
		#$config-file)
	      #:user "matterbridge"
	      #:group "matterbridge"
	      ;; #:pid-file "/var/run/matterbridge.pid"
	      #:log-file "/var/log/matterbridge.log"))
    (stop #~(make-kill-destructor)))))

(define matterbridge-service-type
  (service-type
   (name 'matterbridge)
   (description
    "Run matterbridge via shepherd.")
   (extensions
    (list (service-extension shepherd-root-service-type
                             (compose list matterbridge-shepherd-service))
	  (service-extension account-service-type (const %matterbridge-accounts))))
   (default-value (matterbridge-configuration))))
