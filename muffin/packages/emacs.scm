(define-module (muffin packages emacs)
  #:use-module (gnu packages)
  #:use-module (gnu packages emacs-xyz)
  #:use-module (gnu packages python)
  #:use-module (guix build-system emacs)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages))

(define-public emacs-boxy
  (package
    (name "emacs-boxy")
    (version "1.1.4")
    (source
     (origin
       (method url-fetch)
       (uri (string-append "https://elpa.gnu.org/packages/boxy-" version
                           ".tar"))
       (sha256
        (base32 "0mwj1qc626f1iaq5iaqm1f4iwyz91hzqhzfk5f53gsqka7yz2fnf"))))
    (build-system emacs-build-system)
    (home-page "https://gitlab.com/grinn.amy/boxy")
    (synopsis "A boxy layout framework")
    (description
     "Boxy provides an interface to create a 3D representation of boxes.  Each box has
a relationship with one other box.  Multiple boxes can be related to
one box.  The relationship can be any of the following:

 - in
 - on
 - behind
 - on top of
 - in front of
 - above
 - below
 - to the right of
 - to the left of

The relationship determines the ordering and structure of the
resulting boxy diagram.")
    (license license:gpl3+)))

(define-public emacs-boxy-headings
  (package
    (name "emacs-boxy-headings")
    (version "2.1.5")
    (source
     (origin
       (method url-fetch)
       (uri (string-append "https://elpa.gnu.org/packages/boxy-headings-"
                           version ".tar"))
       (sha256
        (base32 "0w3cy2r8iqsb79r33lllj08v719hq0xniq5pbr9sl8kn2raxcjhr"))))
    (build-system emacs-build-system)
    (propagated-inputs (list emacs-boxy emacs-org))
    (home-page "https://gitlab.com/grinn.amy/boxy-headings")
    (synopsis "View org files in a boxy diagram")
    (description
     "To view all headings in an org-mode file as a boxy diagram,
use the interactive function `boxy-headings' Suggested keybinding:

┌────
│(define-key org-mode-map (kbd \"C-c r o\") boxy-headings)
└────

To modify the relationship between a headline and its parent, add the
property REL to the child headline.

Valid values are:
 • on-top
 • in-front
 • behind
 • above
 • below
 • right
 • left

The tooltip for each headline shows the values that would be displayed
if the org file was in org columns view.")
    (license license:gpl3+)))

(define-public emacs-casual
  (package
    (name "emacs-casual")
    (version "20240416.2237")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/kickingvegas/Casual.git")
             (commit "a22cf128c3baa3e11f6aaff7dc44ef91cf0fe9ce")))
       (sha256
        (base32 "0sx3hqpp8ikp3avzcj4d601zh80rs7qi2azl0vmgc4ymrd7g1af8"))))
    (build-system emacs-build-system)
    (arguments
     (list
        #:include #~(cons* "^docs/"
			   "^scripts/"
			   %default-include)
	#:exclude #~(cons* "^tests/"
			   %default-exclude)
	#:phases
	#~(modify-phases %standard-phases
            (add-after 'unpack 'move-clients-libraries
            (lambda _
              (for-each (lambda (f)
                          (install-file f "."))
                        (find-files "lisp/" "\\.el$")))))))
    (inputs
     (list python))
    (home-page "https://github.com/kickingvegas/casual")
    (synopsis "Transient UI for Calc")
    (description
     "Casual is an opinionated Transient-based porcelain for Emacs Calc.  INSTALLATION
(require casual) (define-key calc-mode-map (kbd \"C-o\") casual-main-menu)")
    (license license:gpl3+)))


(define-public emacs-clomacs
  (let ((commit "2b59130b92e12cb8bc9f51aedaa86e7e9253ef21")
	(revision "19"))
    (package
      (name "emacs-clomacs")
      (version (git-version "0.0.5" revision commit))
      (source
       (origin
	 (method git-fetch)
	 (uri (git-reference
               (url "https://github.com/clojure-emacs/clomacs.git")
               (commit commit)))
	 (sha256
          (base32 "15z4441816fghqgxl0zc9570nh9ldnqf0fbj7cab7vw7ns0n8qkw"))))
      (build-system emacs-build-system)
      (propagated-inputs (list emacs-cider emacs-s emacs-simple-httpd emacs-dash))
      (arguments
       '(#:include '("^src/elisp/[^/]+.el$")
	 #:exclude '()))
      (home-page "https://github.com/clojure-emacs/clomacs")
      (synopsis "Simplifies Emacs Lisp interaction with Clojure.")
      (description
       "`clomacs-defun - core Clojure to Elisp function wrapper.  Elisp to Clojure calls
helper functions: `clomacs-create-httpd-start - package-specific httpd
connection setup. `clomacs-create-httpd-stop - package-specific httpd connection
stop.  See README.md for detailed description.")
      (license license:gpl3+))))

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

(define-public emacs-elfeed-tube
  (let ((commit "92c66d6adcebe0588ccf811616decf7ef8a8ac65")
	(revision "20"))
    (package
      (name "emacs-elfeed-tube")
      (version (git-version "0.15" revision commit))
      (source (origin
		(method git-fetch)
		(uri (git-reference
                      (url "https://github.com/karthink/elfeed-tube.git")
                      (commit commit)))
		(sha256
		 (base32
		  "1w22n54gm8my4r4kvi2id6s2wghsqdazzk168v79kw8kfw32vyy9"))))
      (build-system emacs-build-system)
      (propagated-inputs (list emacs-elfeed emacs-aio))
      (arguments
       '(#:include '("^elfeed-tube.el$" "^elfeed-tube-utils.el$")
	 #:exclude '()))
      (home-page "https://github.com/karthink/elfeed-tube")
      (synopsis "YouTube integration for Elfeed")
      (description
       " Elfeed Tube is an extension for Elfeed, the feed reader for Emacs, that
enhances your Youtube RSS feed subscriptions.

Typically Youtube RSS feeds contain only the title and author of each video.
Elfeed Tube adds video descriptions, thumbnails, durations, chapters and \"live\"
transcrips to video entries.  See https://github.com/karthink/elfeed-tube for
demos.  This information can optionally be added to your entry in your Elfeed
database.

The displayed transcripts and chapter headings are time-aware, so you can click
on any transcript segment to visit the video at that time (in a browser or your
video player if you also have youtube-dl).  A companion package,
`elfeed-tube-mpv', provides complete mpv (video player) integration with the
transcript, including video seeking through the transcript and following along
with the video in Emacs.")
      (license license:unlicense))))

(define-public emacs-elfeed-tube-mpv
  (package
    (inherit emacs-elfeed-tube)
    (name "emacs-elfeed-tube-mpv")
    (propagated-inputs (list emacs-elfeed-tube emacs-mpv))
    (arguments
     '(#:include '("^elfeed-tube-mpv.el$")
       #:exclude '()))
    (synopsis "Control mpv from Elfeed")
    (description
     " This package provides integration with the mpv video player for `elfeed-tube'
entries, which see.

With `elfeed-tube-mpv' loaded, clicking on a transcript segment in an Elfeed
Youtube video feed entry will launch mpv at that time, or seek to that point if
already playing.

It defines two commands and a minor mode:

- `elfeed-tube-mpv': Start an mpv session that is \"connected\" to an Elfeed entry
corresponding to a Youtube video.  You can use this command to start playback,
or seek in mpv to a transcript segment, or enqueue a video in mpv if one is
already playing.  Call with a prefix argument to spawn a new instance of mpv
instead.

- `elfeed-tube-mpv-where': Jump in Emacs to the transcript position
corresponding to the current playback time in mpv.

- `elfeed-tube-mpv-follow-mode': Follow along in the transcript in Emacs to the
video playback.")))

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
    (propagated-inputs (list emacs-s emacs-compat))
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

(define-public emacs-mpv
  (let ((commit "2e0234bc21a3dcdf12d94d3285475e7f6769d3e8")
	(revision "20"))
    (package
      (name "emacs-mpv")
      (version (git-version "0.2.0" revision commit))
      (source (origin
		(method git-fetch)
		(uri (git-reference
                      (url "https://github.com/kljohann/mpv.el.git")
                      (commit commit)))
		(sha256
		 (base32
                  "0mvzg2wqpycny2dmiyp8jm0fflvll7ay6scvsb9rxgfwimr2vbw5"))))
      (build-system emacs-build-system)
      (propagated-inputs (list emacs-json-mode emacs-org))
      (home-page "https://github.com/kljohann/mpv.el")
      (synopsis "control mpv for easy note-taking")
      (description
       "This package is a potpourri of helper functions to control a mpv process via its
IPC interface.  You might want to add the following to your init file:

(org-add-link-type \"mpv\" #'mpv-play) (defun org-mpv-complete-link (&optional
arg)   (replace-regexp-in-string    \"file:\" \"mpv:\"    (org-file-complete-link
arg)    t t)) (add-hook 'org-open-at-point-functions
#'mpv-seek-to-position-at-point)")
      (license license:gpl3+))))

(define-public emacs-pkg-overview
  (let ((commit "9b2e416758a6c107bb8cc670ec4d2627f82d5590")
	(revision "10"))
    (package
      (name "emacs-pkg-overview")
      (version (git-version "0.0.0" revision commit))
      (source (origin
		(method git-fetch)
		(uri (git-reference
                      (url "https://github.com/Boruch-Baum/emacs-pkg-overview.git")
                      (commit commit)))
		(sha256
		 (base32
		  "1p15jyjpiikx5y3syvhrdxabhhl898af88dv3fi95gm8v39n35i0"))))
      (build-system emacs-build-system)
      (home-page "https://github.com/Boruch-Baum/emacs-pkg-overview")
      (synopsis "Make org documentation from elisp source file")
      (description
       " This package parses an elisp file's comments, definitions, docstrings, and
other documentation into a hierarchical `org-mode' buffer.  It is intended to
facilitate familiarization with a file's contents and organization / structure.
The viewer can quickly swoop in and out and across the file structure using
standard `org-mode' commands and keybindings.


; Dependencies (all are already part of Emacs):

  org -- for `org-mode'


; Installation:

1) Evaluate or load this file.

2) I don't expect anyone who would want to define a global    keybinding for
this kind of function needs me to tell them how    do so, but I'm mindlessly
filling out my own template, so:

     (global-set-key (kbd \"S-M-C F1 M-x butterfly C-c C-h ?\") 'pkg-overview)")
      (license license:gpl3+))))

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

(define-public emacs-verb
  (let ((commit "ac6c0ca3777431268e1f5a540c003aa16345381d")
	(revision "6"))
    (package
      (name "emacs-verb")
      (version (git-version "2.16.0" revision commit))
      (source (origin
		(method git-fetch)
		(uri (git-reference
                      (url "https://github.com/federicotdn/verb.git")
                      (commit commit)))
		(sha256
		 (base32
		  "15w7m7an2i353yrq9njdcxyawawck2yvaq4ys9m8213wvach21ay"))))
      (build-system emacs-build-system)
      (home-page "https://github.com/federicotdn/verb")
      (synopsis "Organize and send HTTP requests")
      (description
       "Verb is a package that allows you to organize and send HTTP requests from Emacs.

The package introduces a new minor mode, Verb mode, which works as
an extension to [Org mode](https://orgmode.org/). The core idea is to
organize specifications for HTTP requests using Org's tree
structure. Properties defined in the child headings extend or
sometimes override properties defined in the parent headings - this
way, it is easy to define many HTTP request specifications without
having to repeat common components as URL hosts, authentication
headers, ports, etc. Verb tries to combine the usefulness of Org mode
with the common functionality provided by other HTTP clients. However,
very little knowledge of Org mode is needed to use Verb.")
      (license license:gpl3+))))

(define-public emacs-zone-rainbow
  (let ((commit "2ba4f1a87c69c4712124ebf12c1f3ea171e1af36")
	(revision "20160120-1"))
    (package
      (name "emacs-zone-rainbow")
      (version (git-version "0.0.0" revision commit))
      (source (origin
		(method git-fetch)
		(uri (git-reference
                      (url "https://github.com/kawabata/zone-rainbow.git")
                      (commit commit)))
		(sha256
		 (base32
		  "0w550l9im3mhxhja1b7cr9phdcbvx5lprw551lj0d1lv7qvjasz0"))))
      (build-system emacs-build-system)
      (home-page "https://github.com/kawabata/zone-rainbow")
      (synopsis "Zone out with rainbow")
      (description
       "This code is inspired by <https://gist.github.com/mrkuc/7121179>.

It can be directly invoked by `M-x zone-rainbow`.")
      (license license:gpl3+))))
