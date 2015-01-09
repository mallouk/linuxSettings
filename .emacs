;;;Changes the default eshell prompter.


(setq eshell-prompt-function
  (lambda nil
    (concat 
     (propertize
      (concat "["  (getenv "USER") " " (format-time-string "%l:%M:%S %p" (current-time))  " " (eshell/pwd) " ] $ " ) 'face `(:foreground "yellow")
     )
    )
  )
)
;;(setq eshell-highlight-prompt nil)




(add-to-list 'load-path "~/.emacs.d/")

;(require 'dirtree)
;(require 'taglist)
;(require 'test-print)


; (require 'tex-site)
; (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
; (setq reftex-plug-into-AUCTeX t)




(put 'eval-expression 'disabled nil)

(autoload 'gtags-mode "gtags" "" t)
(autoload 'c++-mode  "cc-mode" "C++ Editing Mode" t)
(autoload 'c-mode    "cc-mode" "C Editing Mode" t)
;;(autoload 'python-mode "python-mode" "Python Editing Mode" t)
(autoload 'tuareg-mode "tuareg" "Major mode for editing Caml code" t)
(autoload 'camldebug "camldebug" "Run the Caml debugger" t)
(autoload 'verilog-mode "verilog-mode" "Verilog mode" t )
(autoload 'vhdl-mode "vhdl-mode" "VHDL Mode" t)
(autoload 'patch-mode "patch" "" t)



(setq auto-mode-alist
  (append '(("\\.C$"  . c++-mode)
            ("\\.cc$" . c++-mode)
            ("\\.h$"  . c++-mode)
            ("\\.c$"  . c++-mode)
            ("\\.cu$"  . c++-mode)
            ("\\.cl$"  . c++-mode)
            ("\\.sm$"  . c++-mode)
            ("\\.awk$" . awk-mode)
            ("\\.hpf$" . f90-mode)
            ("\\.F90$" . f90-mode)
            ("\\.f90$" . f90-mode)
            ("\\.par$" . fortran-mode)
            ("\\.ml\\w?" . tuareg-mode)
;;            ("\\.py$" . python-mode)
            ("\\.v\\'" . verilog-mode)
            ("\\.vhdl?\\'" . vhdl-mode)
            ) auto-mode-alist))

(defun my-c-mode-common-hook ()
  (c-set-style "Stroustrup")
  (setq tab-width 8 indent-tabs-mode nil)
  (local-set-key "\M-\C-h" 'backward-kill-word)
  (c-toggle-auto-hungry-state 1))

(defun my-awk-mode-hook ()
  (c-set-style "Stroustrup")
  (setq tab-width 8 indent-tabs-mode nil)
  (c-toggle-hungry-state 1))

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)
(add-hook 'awk-mode-hook 'my-awk-mode-hook)
(add-hook 'verilog-mode-hook '(lambda () (font-lock-mode 1)))
(add-hook 'Man-mode-hook '(lambda () (font-lock-mode 1)))
(add-hook 'help-mode-hook '(lambda () (font-lock-mode 1)))

(setq gtags-mode-hook
  '(lambda ()
        (define-key gtags-mode-map "\eh" 'gtags-display-browser)
        (define-key gtags-mode-map "\ec" 'gtags-make-complete-list)
        (define-key gtags-mode-map "\C-]" 'gtags-find-tag-from-here)
        (define-key gtags-mode-map "\C-t" 'gtags-pop-stack)
        (define-key gtags-mode-map "\el" 'gtags-find-file)
        (define-key gtags-mode-map "\eg" 'gtags-find-with-grep)
        (define-key gtags-mode-map "\eI" 'gtags-find-with-idutils)
        (define-key gtags-mode-map "\es" 'gtags-find-symbol)
        (define-key gtags-mode-map "\er" 'gtags-find-rtag)
;        (define-key gtags-mode-map "\et" 'gtags-find-tag)
))

(defun find-in-src()
  (interactive)
  (let ((str (read-from-minibuffer "search-str: "))
    (null-device nil))
  (let ((ext (read-from-minibuffer "extension: "))
    (null-device nil))

     (grep (concat "find -iname '*'" ext "'*' -exec grep -H -n -e " str " '{}' ';'"))
  )
  )
   
)

(defun zip-directory()
  (interactive)
  (let ((name (read-from-minibuffer "zip file name: "))
    (null-device nil))
  (let ((dir (read-from-minibuffer "file/directory: "))
    (null-device nil))
     (grep (concat "zip -r " name " " dir))
  )
  )
)

(defun unzip-directory()
  (interactive)
  (let ((name (read-from-minibuffer "unzip file name: "))
    (null-device nil))
     (grep (concat "unzip " name))
  )
)



(defun latex-pdf()
  (interactive)
  (let ((pdf (read-from-minibuffer "pdf name: "))
    (null-device nil))
    (grep (concat "latexmk -pdf " pdf))
  )
)

(defun untar()
  (interactive)
  (let ((tar (read-from-minibuffer "file to untar: "))
    (null-device nil))
    (grep (concat "tar xvzf " tar))
  )
)


(global-set-key "\C-cf" 'find-in-src)
(global-set-key "\C-cg" 'grep)
(global-set-key "\C-cl" (quote goto-line))
(global-set-key "\C-cw" 'what-line)
(global-set-key "\C-ct" 'text-mode)
(global-set-key "\C-cm" 'c++-mode)
(global-set-key "\C-cr" 'toggle-read-only)
(global-set-key "\C-cz" 'zip-directory)
(global-set-key "\C-cu" 'unzip-directory)
(global-set-key "\C-cd" 'gdb)
(global-set-key [?\C-.] 'tags-search)
(global-set-key "\C-co" 'gtags-mode)
(global-set-key "\C-cx" 'next-multiframe-window)
(global-set-key "\C-ce" 'eshell)
(global-set-key "\C-cr" 'query-replace)
(global-set-key "\C-xl" 'latex-pdf)
(global-set-key "\C-xt" 'taglist)
(global-set-key "\C-cs" 'next-buffer)
(global-set-key "\C-ca" 'previous-buffer)
(global-set-key "\C-ct" 'untar)

(setq fill-column 75)

(setq tex-dvi-view-command "xdvi")


(tty-modify-color-alist '("yellow" 3 139 139 0))
(require 'font-lock)
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)

(cond (window-system
       (setq default-frame-alist
             '((height . 55)(width . 80)
               (font . "-misc-fixed-medium-r-semicondensed--13-120-75-75-c-60-*-1")
               (background-color . "midnightblue")
               (foreground-color . "white")
               (mouse-color . "red")
               (cursor-color . "red")
               ))

       (tool-bar-mode -1)
       (scroll-bar-mode 'nil)
       (menu-bar-mode -1)
;       (blink-cursor-mode -1)
       (cond
        ((string-match "taurus" (system-name))
         (set-face-background 'modeline "lightblue")
         (set-face-foreground 'modeline "black"))
        ((string-match "ironsides" (system-name))
         (set-face-background 'modeline "orange")
         (set-face-foreground 'modeline "black"))
        ((string-match "ram1" (system-name))
         (set-face-background 'modeline "cyan")
         (set-face-foreground 'modeline "black"))
        (t
         (set-face-background 'modeline "orange")
         (set-face-foreground 'modeline "black"))))
      ;; very strange: somehow M-backspace gets mapped to M-C-h...
      (t (global-set-key "\M-\C-h" 'backward-kill-word)
;;       (keyboard-translate ?\C-h ?\C-?)
;;       (keyboard-translate ?\C-? ?\C-h)
         (menu-bar-mode -1)
         (custom-set-faces
          ;; custom-set-faces was added by Custom -- don't edit or cut/paste it!
          ;; Your init file should contain only one such instance.
          '(comint-highlight-input ((t (:foreground "red"))))
;         '(font-lock-function-name-face ((((type tty) (class color)) (:foreground "blue"))))
;         '(font-lock-keyword-face ((((type tty) (class color)) (:foreground "cyan"))))
          '(mode-line ((t (:background "cyan" :foreground "black" :inverse-video nil)))))      )
)

(add-hook 'comint-output-filter-functions 'comint-strip-ctrl-m)
(add-hook 'comint-output-filter-functions 'comint-watch-for-password-prompt)
(add-hook 'comint-output-filter-functions 'comint-truncate-buffer)


(font-lock-add-keywords 'outline-mode
                        '(("//.+" . font-lock-comment-face)
                          ("^[^*\n].*"
           (0
            (or (cdr (assq (outline-font-lock-level)
                           '((1 . font-lock-function-name-face)
                             (2 . font-lock-variable-name-face)
                             (3 . font-lock-keyword-face)
                             (4 . font-lock-builtin-face)
                             (5 . font-lock-comment-face)
                             (6 . font-lock-constant-face)
                             (7 . font-lock-type-face)
                             (8 . font-lock-string-face))))
                font-lock-warning-face) nil t))
                           ))


(setq machine (substring (system-name) 0 (string-match "\\." (system-name))))
(setq frame-title-format '("" machine  ":%b"))
(setq icon-title-format '("" machine  ":%b"))

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(delete-selection-mode nil nil (delsel))
 '(frame-background-mode (quote dark))
 '(scroll-bar-mode (quote right))
 '(shell-file-name "/bin/tcsh")
 '(transient-mark-mode t))


(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(comint-highlight-input ((t (:foreground "red"))))
 '(eshell-ls-directory ((((class color) (background dark)) (:foreground "SkyBlue" :weight normal))))
 '(eshell-ls-executable ((((class color) (background dark)) (:foreground "Green" :weight normal))))
 '(eshell-prompt ((t (:foreground "yellow" :weight normal))))
 '(font-lock-builtin-face ((((type tty) (class color)) (:foreground "blue" :weight bold))))
 '(font-lock-comment-face ((((type tty pc) (class color) (background dark)) (:foreground "red"))))
 '(mode-line ((t (:background "cyan" :foreground "black" :inverse-video nil)))))



(defun eshell/clear ()
  "Clears the eshell buffer."
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer))
)



