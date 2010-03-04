;; start emacs-server!
(server-start)

(add-to-list 'load-path "~/emacs")

;; colors!
(progn (cd "~/emacs") (normal-top-level-add-subdirs-to-load-path))
(add-to-list 'load-path "~/emacs")
(require 'color-theme)
(color-theme-initialize)
;;(load-file "~/emacs/color-theme-blackboard.el")
(require 'color-theme-wombat)
(color-theme-wombat)

;; php mode
(load "php-mode")
(add-to-list 'auto-mode-alist
	     '("\\.php[34]?\\'\\|\\.phtml\\'" . php-mode))

(custom-set-variables
 '(inhibit-startup-screen t))

;; remove toolbar, scrollbar, and menu
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

;; ido (for completion in opening and switching buffers)
(require 'ido)
(ido-mode t)

;; Tabbing
(setq default-tab-width 3); ;; Tab width
(setq-default indent-tabs-mode nil); ;; Use spaces for tabs only!

;; Fonts
(set-default-font "consolas-11");

;; Highlight Column 80 in python mode
;;(require 'column-marker)
;;(add-hook 'python-mode-hook (lambda () (interactive) (column-marker-1 80)))

;; Line Numbers
(global-linum-mode)

;; let me copy and paste between emacs and other applications! Ubuntu only
;; (setq x-select-enable-clipboard t)
;; (setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

;; Yasnippet for templated code-completion
(add-to-list 'load-path
             "~/emacs/plugins/yasnippet")
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/emacs/plugins/yasnippet/snippets")

;; predictive completion
(require 'pabbrev )
(setq pabbrev-read-only-error nil)

;; javascript mode
(autoload 'javascript-mode "javascript" nil t)
(add-to-list 'auto-mode-alist '("\\.js\\'" . javascript-mode))

;; python
(add-hook 'python-mode-hook '(lambda () (define-key python-mode-map "\C-m" 'newline-and-indent)))

;; django-mode
(load "django-mode.elc")

;; use pyFlakes
(when (load "flymake" t) 
  (defun flymake-pyflakes-init () 
    (let* ((temp-file (flymake-init-create-temp-buffer-copy 
                       'flymake-create-temp-inplace)) 
           (local-file (file-relative-name 
                        temp-file 
                        (file-name-directory buffer-file-name)))) 
      (list "pyflakes" (list local-file)))) 
  (add-to-list 'flymake-allowed-file-name-masks 
               '("\\.py\\'" flymake-pyflakes-init)))
(add-hook 'python-mode-hook 'flymake-mode)

;; haml-mode
(require 'haml-mode)

;; stop autosaving!
(setq make-backup-files nil)

;; Set a default starting directory
(setq default-directory "~/" )

;; magit for git!
(when (equal system-type 'darwin)
  (setenv "PATH" (concat "/opt/local/bin:/usr/local/bin:" (getenv "PATH")))
  (push "/usr/local/git/bin" exec-path))

(require 'magit)

;;(global-set-key (kbd "<s-S-return>") 'maximize-frame)
;;(maximize-frame)

;; color my css yo!
(defvar hexcolour-keywords
  '(("#[abcdef[:digit:]]\\{6\\}"
     (0 (put-text-property (match-beginning 0)
                           (match-end 0)
                           'face (list :background 
                                       (match-string-no-properties 0)))))))

(require 'cl)
(defun hexcolour-luminance (color)
  "Calculate the luminance of a color string (e.g. \"#ffaa00\", \"blue\").
  This is 0.3 red + 0.59 green + 0.11 blue and always between 0 and 255."
  (let* ((values (x-color-values color))
         (r (car values))
         (g (cadr values))
         (b (caddr values)))
    (floor (+ (* .3 r) (* .59 g) (* .11 b)) 256)))
(defun hexcolour-add-to-font-lock ()
  (interactive)
  (font-lock-add-keywords nil
                          `((,(concat "#[0-9a-fA-F]\\{3\\}[0-9a-fA-F]\\{3\\}?\\|"
                                      (regexp-opt (x-defined-colors) 'words))
                             (0 (let ((colour (match-string-no-properties 0)))
                                  (put-text-property
                                   (match-beginning 0) (match-end 0)
                                   'face `((:foreground ,(if (> 128.0 (hexcolour-luminance colour))
                                                             "white" "black"))
                                           (:background ,colour)))))))))


(add-hook 'css-mode-hook 'hexcolour-add-to-font-lock)

;; highlight parentheses
(show-paren-mode 1)

;; Don't make me type yes or no in full!
(defalias 'yes-or-no-p 'y-or-n-p)

;; rectangle support without the silly keys
(setq cua-enable-cua-keys nil)

;; UTF-8!
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; scratch message
(setq initial-scratch-message nil)
