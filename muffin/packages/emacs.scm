(define-module (muffin packages emacs)
  #:use-module (gnu packages)
  #:use-module (gnu packages emacs-xyz)
  #:use-module (guix build-system emacs)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages))

(define-public emacs-dape
  (package
    (name "emacs-dape")
    (version "0.10.0")
    (source
     (origin
       (method url-fetch)
       (uri (string-append "https://elpa.gnu.org/packages/dape-" version
                           ".tar"))
       (sha256
        (base32 "1x6mbis4vmghp3vf4pxyzdp68nnrraw9ayx3gzbp1bvcmr62qdig"))))
    (build-system emacs-build-system)
    (propagated-inputs (list emacs-jsonrpc))
    (home-page "https://github.com/svaante/dape")
    (synopsis "Debug Adapter Protocol for Emacs")
    (description
     "Features:
 ⁃ Log breakpoints
⁃ Conditional breakpoints ⁃ Variable explorer ⁃ Variable watch ⁃ Variable hover
with `eldoc ⁃ REPL ⁃ gdb-mi.el like interface ⁃ Memory viewer with `hexl ⁃
`compile integration ⁃ Debug adapter configuration ergonomics ⁃ No dependencies
(except for jsonrpc which is part of emacs but needed version is not part of
latest stable emacs release 29.1-1 but available on elpa).")
    (license license:gpl3+)))

(define-public emacs-repeat-help
  (let ((commit "41dea6fba2edd6ac748d0ca7a6da4058290feede")
	(revision "12"))
    (package
      (name "emacs-repeat-help")
      (version (git-version "0.0" revision commit))
      (source (origin
		(method git-fetch)
		(uri (git-reference
                      (url "https://github.com/karthink/repeat-help.git")
                      (commit commit)))
		(sha256
		 (base32
		  "1lnwb2z8y9cjah545n27j62a5pdksid0rah2bzws9xi8c7dgavkm"))))
      (build-system emacs-build-system)
      (home-page "https://github.com/karthink/repeat-help")
      (synopsis "Display keybindings for repeat-mode")
      (description
       "repeat-help shows key descriptions when using Emacs' `repeat-mode'.

The description can be in the form a Which Key popup or an Embark indicator
(which see).  To use it, enable `repeat-mode' (Emacs 28.0.5 and up) and
`repeat-help-mode'.  When using a repeated key binding, you can press `C-h' to
toggle a popup with the available keybindings.

To change the key to toggle the popup type, customize `repeat-help-key'.

To have the popup show automatically, set `repeat-help-auto' to true.

By default the package tries to use an Embark key indicator.  To use Which-Key
or the built-in hints, customize `repeat-help-popup-type'.")
      (license license:gpl3+))))

(define-public emacs-empv
  (let ((commit "c48cd223b145806a6a36167c299e9a0384a5f2e6")
	(revision "1"))
    (package
    (name "emacs-empv")
    (version (git-version "4.1.0" revision commit))
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/isamert/empv.el.git")
                    (commit commit)))
              (sha256 (base32
                       "0p62wfsxk0sh8lpjm52md8kaixkfagfsl9gpmps76448iznn04m7"))))
    (build-system emacs-build-system)
    (propagated-inputs (list emacs-s))
    (home-page "https://github.com/isamert/empv.el")
    (synopsis "A multimedia player/manager, YouTube interface")
    (description
     "An Emacs media player, based on mpv.  More precisely this package provides
somewhat comprehensive interface to mpv with bunch of convenient functionality
like an embedded radio manager, @code{YouTube} interface, local music/video
library manager etc.  Lots of interactive functions are at your disposal.  To
view the most essential ones, type `M-x describe-keymap empv-map`.  It is
advised that you bind this keymap to a key for convenience.  Additionally, empv
has versatile customization options.  For an overview of all customization
options, do `M-x customize-group empv`.")
    (license license:gpl3+))))

;;; Embrace
(define-public emacs-embrace
  (let ((commit "c7e748603151d7d91c237fd2d9cdf56e9f3b1ea8")
	(revision "3"))
    (package
      (name "emacs-embrace")
      (version (git-version "0.1.4" revision commit))
      (source (origin
		(method git-fetch)
		(uri (git-reference
                      (url "https://github.com/cute-jumper/embrace.el.git")
                      (commit commit)))
		(sha256 (base32
			 "1c6fbkw1hl9bhdy62g782js8i9kgjr0pr132mpga12jd4cwf8mmz"))))
      (build-system emacs-build-system)
      (propagated-inputs (list emacs-expand-region))
      (home-page "https://github.com/cute-jumper/embrace.el")
      (synopsis "Add/Change/Delete pairs based on `expand-region'")
      (description
       "This package is heavily inspired by [evil-surround] (which is a port
of the vim plugin [surround.vim]).  But instead of using `evil' and its
text objects, this package relies on another excellent package
[expand-region].  For Emacs users who don't like `evil' and thus don't
use `evil-surround', `embrace' provides similar commands that can be
found in `evil-surround'.")
      (license license:gpl3+))))

;;; Macrursors
(define-public emacs-macrursors
  (let ((commit "926d93a4f7b3edb047b79a50f8cfd6072227e94e")
	(revision "53"))
    (package
      (name "emacs-macrursors")
      (version (git-version "0.0" revision commit))
      (source (origin
		(method git-fetch)
		(uri (git-reference
                      (url "https://www.github.com/corytertel/macrursors.git")
                      (commit commit)))
		(sha256 (base32
			 "0igry4q494lsljpzrvcgd23wlzcza8p6fdfbhckl6a4w78qh3mna"))))
      (build-system emacs-build-system)
      (home-page "https://www.github.com/corytertel/macrursors")
      (synopsis "An extremely fast and minimal alternative to multiple-cursors.el.")
      (description
       "Macrursors leverages kmacro and emacs' overlays to make a fast and
extremely minimal multiple-cursor-like editing experience.")
      (license license:gpl3+))))
