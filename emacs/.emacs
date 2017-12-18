(setq gc-cons-threshold 400000000)

;;; Begin initialization
;; Turn off mouse interface early in startup to avoid momentary display
(when window-system
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (tooltip-mode -1)
  (blink-cursor-mode 0))

(setq ring-bell-function 'ignore)

(setq inhibit-startup-message t)
(setq initial-scratch-message ";;; scratch\n\n")

;(setq default-directory "~/Dropbox/EMACS")

;(toggle-frame-fullscreen)

;;; Set up package
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
;; (when (boundp 'package-pinned-packages)
;;   (setq package-pinned-packages
;;         '((org-plus-contrib . "org"))))
(package-initialize)

;;; Bootstrap use-package
;; Install use-package if it's not already installed.
;; use-package is used to configure the rest of the packages.
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; From use-package README
(eval-when-compile
  (require 'use-package))
(require 'diminish)                ;; if you use :diminish
(require 'bind-key)
;; (setq use-package-verbose t)

;;(server-start)

;; auto-revert dla plików z dropboxa
(defun dropbox-auto-revert ()
  (when (string-match "Dropbox" buffer-file-name)
    (auto-revert-mode 1)
    (diminish 'auto-revert-mode)))

(add-hook 'find-file-hook 'dropbox-auto-revert)

(add-to-list 'load-path "/usr/share/emacs/25.3/lisp")
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp")

;;; Load the config
(org-babel-load-file "~/Dropbox/EMACS/.load/init.org")

(setq gc-cons-threshold 800000)
