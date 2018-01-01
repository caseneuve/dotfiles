;; ~/Dropbox/EMACS/.load/pk-header-line.el
;; Created:     30.12.17, 17:05    @lenovo
;; Last update: 31.12.17, 17:39:23 @lenovo

;; Status: In progress
;;TODO:
;;- co powinno być w h-l? 

;; Doc:
;;
;; My custom header line fomrat (replacing default mode line).
;; Items:
;; 1. buffer-modified - red, buffer-savedl - none
;; 2. buffer-name
;; 3. major mode symbol (salmon like color)
;; 4. minor modes symbols (grey)
;; 5. (opt.) edit mode indicators
;; 6. (opt.) position indicator (current page/total number of pages for pdf view mode /and number of words for org-mode // or current line/total number of lines for other modes)
;; 7. (opt.) org-clock-in indicator [file: header name]
;; 8. ??? 

;; ================
;; Code starts here:
;; ================

;; todo: wysłać to do init.org?
(diminish 'overwrite-mode "")
(diminish 'emacs-lock-mode "")
(diminish 'server-mode "")

(defun pk-get-major-mode-name ()
  "Does what the name says."
  (if (listp mode-name)
      (nth 1 mode-name)
    mode-name))

(defun pk-is-maj-mode-active (name)
  "Returns t if major mode indicated by name (arg) is active in the current buffer; otherwise returns nil."
  (if (string= (pk-get-major-mode-name) name)
      (eq t t) (eq t nil)))

(defun pk-list-active-minor-modes ()
  "Returns sequence of diminished names of actice minor modes in the current buffer."
  (diminish 'rainbow-mode "rb")
  (diminish 'auto-revert-mode "rv")
  (diminish 'semantic-minor-modes-format "")
  (let ((y))
    (remove nil
            (mapcar (lambda (x) (if (and (symbolp x)(symbol-value x))
                                    (add-to-list 'y x)))
                    (mapcar 'car minor-mode-alist))) 
    (apply 'append (remove '("") (mapcar (lambda (x) (assoc-default x minor-mode-alist)) y)))))

(defun pk-get-word-and-pages ()
  "Returns number of the page where the point is, total number of pages and number of words in the buffer; page is defined by `charsperpage' variable (which defaults to 1800 chars), you may change this value by invoking `set-chars-per-page' function."
  (format " %d/%d (%d)"
          (if (< (/ (% (- (point) charsperpage) charsperpage) charsperpage) 1) (+ 1 (/ (point) charsperpage)) (/ (point) charsperpage))
          (if (< (% (point-max) charsperpage) charsperpage) (+ 1 (/ (point-max)charsperpage)) (/ (point-max) charsperpage))
          (count-words (point-min) (point-max))
          ))

(setq charsperpage 1800)

(defun set-chars-per-page (arg)
  "Prompts for new value of number characters per page. Used by `pk-get-word-and-pages' function which returns relative values and prints them into header-line."
  (interactive
   (list (read-number "Insert number of characters per page: " (print charsperpage))))
  (setq charsperpage arg)
  (force-mode-line-update)
  (message "Characters per page value changed to %d." charsperpage))


;; HEDER FORMAT
(setq-default header-line-format                                                                   
              (list
               '(:eval (if (and (buffer-modified-p) (eq buffer-read-only nil))
                           (propertize "●" 'face '(:foreground "red" :height 1.3)) ;;✍
                         (propertize "●" 'face '(:foreground "black" :height 1.3)))) ;;☂
               '(:eval (propertize " %b " 'face '(:foreground "#f1c40f" :height 1.2 :family "Ubuntu Mono" :weight bold ;;light salmon
                                                              )
                                   'help-echo (buffer-file-name)))
               " "
               ;; MAJOR MODE
               '(:eval (cond ((pk-is-maj-mode-active "PDFView") (propertize "PDF" 'face '(:foreground "#e74c3c" :height 1.0 :weight bold :family "DejaVu Sans Mono")))
                             ((pk-is-maj-mode-active "LaTeX/P") (propertize "LTX" 'face '(:foreground "#e74c3c" :height 1.0 :weight bold :family "DejaVu Sans Mono")))
                             (t (propertize (mapconcat 'identity (last mode-name) "") 'face '(:foreground "#e74c3c" :height 1.0 :weight bold :family "DejaVu Sans Mono")))
                             ))
               ;;'(:eval (when (pk-is-maj-mode-active "PDFView") (propertize "PDF" 'face '(:foreground "grey70" :height 0.9 :weight bold :family "DejaVu Sans Mono"))))
               ;; MINOR MODES >> which active modes
               '(:eval (mapcar (lambda (x) (propertize x 'face '(:foreground "grey40" :height 0.8 :family "DejaVu Sans Mono")))
                               (pk-list-active-minor-modes)))
               '(:eval (when mc/temporarily-disabled-minor-modes mc/mode-line))
               ;;; EDIT MODE INDICATORS
               '(:eval (when (buffer-narrowed-p) (propertize " N" 'face '(:foreground "LimeGreen" :height 0.8))))
               '(:eval (propertize (if overwrite-mode " O" "") 'face '(:foreground "red" :height 0.8)))
               '(:eval (propertize (if (bound-and-true-p emacs-lock-mode) " L" "") 'face '(:foreground "blue" :height 0.8)))
               '(:eval (propertize (if buffer-read-only " R" "") 'face '(:foreground "orange" :height 0.8)))
               ;; POSITION
               " "
               '(:eval (cond ((pk-is-maj-mode-active "Org") (propertize (pk-get-word-and-pages) 'face '(:height 0.7 :foreground "#2980b9")))
                             ((pdf-tools-pdf-buffer-p) (propertize (concat (number-to-string (image-mode-window-get 'page)) "/" (number-to-string (pdf-info-number-of-pages)) " ") 'face '(:foreground "#2980b9" :height 0.7)))
                             (t (propertize (concat "%l" (format "/%d" (count-lines (point-min) (point-max)))) 'face '(:foreground "#2980b9" :height 0.7)))
                             ))
               ;;                   '(:eval (propertize " @" 'face '(:foreground "darkmagenta" :height 0.8)))
               ;;                   '(:eval (propertize (format-time-string "%H:%M") 'face '(:foreground "darkmagenta" :height 0.9)
               ;;                                     'help-echo (concat (format-time-string "%c; ") (emacs-uptime "Uptime:%hh"))))
               " "
               '(:eval (when (not (string= org-clock-current-task nil))
                         (concat ;;(propertize "  & " 'face '(:foreground "orange" :height 0.8))
                          (propertize (concat "[" (buffer-name (org-clocking-buffer)) ": " org-clock-current-task "]")
                                      'face '(:foreground "#27ae60" :height 0.9 )))))
               ))

;; EOF
