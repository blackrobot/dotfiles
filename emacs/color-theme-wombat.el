; Wombat
; Original color scheme for vim by: Lars H. Nielson
; Homepage: http://dengmao.wordpress.com/2007/01/22/vim-color-scheme-wombat/)
;
; Emacs port by Peter Severin
; At: http://dengmao.wordpress.com/2007/01/22/vim-color-scheme-wombat/#comment-1051
(require 'color-theme)
(defun color-theme-wombat ()
  "Wombat color theme, created 2009-03-20."
  (interactive)
  (color-theme-install
   '(color-theme-wombat
     ((background-color . "#000000")
      (background-mode . dark)
      (border-color . "black")
      (cursor-color . "#656565")
      (foreground-color . "#f6f3e8")
      (mouse-color . "black"))
     ((list-matching-lines-buffer-name-face . underline)
      (list-matching-lines-face . match)
      (view-highlight-face . highlight)
      (widget-mouse-face . highlight))
     (default ((t (:background "#242424" :foreground "#f6f3e8"))))
     (bold ((t (:bold t :weight bold))))
     (bold-italic ((t (:italic t :bold t :slant italic :weight bold))))
     (border ((t (nil))))
     (buffer-menu-buffer ((t (:bold t :weight bold))))
     (button ((t (:underline t))))
     (completions-common-part ((t (:foreground "#f6f3e8" :background "#242424"))))
     (completions-first-difference ((t (:bold t :weight bold))))
     (cursor ((t (:background "#656565"))))
     (escape-glyph ((t (:foreground "cyan"))))
     (file-name-shadow ((t (:foreground "grey70"))))
     (fixed-pitch ((t (:family "Monospace"))))
     (font-lock-builtin-face ((t (:foreground "#8ac6f2"))))
     (font-lock-comment-delimiter-face ((t (:italic t :slant italic :foreground "#99968b"))))
     (font-lock-comment-face ((t (:italic t :foreground "#99968b" :slant italic))))
     (font-lock-constant-face ((t (:foreground "#e5786d"))))
     (font-lock-doc-face ((t (:italic t :foreground "#99968b" :slant italic))))
     (font-lock-function-name-face ((t (:foreground "#cae682"))))
     (font-lock-keyword-face ((t (:foreground "#8ac6f2"))))
     (font-lock-negation-char-face ((t (:foreground "#e7f6da"))))
     (font-lock-preprocessor-face ((t (:foreground "#e5786d"))))
     (font-lock-regexp-grouping-backslash ((t (:bold t :weight bold))))
     (font-lock-regexp-grouping-construct ((t (:bold t :weight bold))))
     (font-lock-string-face ((t (:italic t :foreground "#95e454" :slant italic))))
     (font-lock-type-face ((t (:foreground "#cae682"))))
     (font-lock-variable-name-face ((t (:foreground "#cae682"))))
     (font-lock-warning-face ((t (:bold t :foreground "Pink" :weight bold))))
     (fringe ((t (:background "grey10"))))
     (header-line ((t (:box (:line-width -1 :style released-button) :background "grey20" :foreground "grey90" :box nil))))
     (highlight ((t (:background "darkolivegreen"))))
     (isearch ((t (:background "palevioletred2" :foreground "brown4"))))
     (isearch-fail ((t (:background "red4"))))
     (iswitchb-current-match ((t (:foreground "#cae682"))))
     (iswitchb-invalid-regexp ((t (:bold t :weight bold :foreground "Pink"))))
     (iswitchb-single-match ((t (:italic t :slant italic :foreground "#99968b"))))
     (iswitchb-virtual-matches ((t (:foreground "#8ac6f2"))))
     (italic ((t (:underline t))))
     (lazy-highlight ((t (:background "paleturquoise4"))))
     (link ((t (:bold t :foreground "#8ac6f2" :underline t :weight bold))))
     (link-visited ((t (:bold t :weight bold :underline t :foreground "violet"))))
     (match ((t (:background "RoyalBlue3"))))
     (menu ((t (nil))))
     (minibuffer-prompt ((t (:foreground "cyan"))))
     (mode-line ((t (:background "grey75" :foreground "black" :box (:line-width -1 :style released-button)))))
     (mode-line-buffer-id ((t (:bold t :weight bold))))
     (mode-line-emphasis ((t (:bold t :weight bold))))
     (mode-line-highlight ((t (:box (:line-width 2 :color "grey40" :style released-button)))))
     (mode-line-inactive ((t (:background "grey30" :foreground "grey80" :box (:line-width -1 :color "grey40" :style nil) :weight light))))
     (mouse ((t (nil))))
     (next-error ((t (:background "blue3"))))
     (nobreak-space ((t (:foreground "cyan" :underline t))))
     (query-replace ((t (:foreground "brown4" :background "palevioletred2"))))
     (region ((t (:background "palevioletred2" :foreground "brown4"))))
     (scroll-bar ((t (nil))))
     (secondary-selection ((t (:background "SkyBlue4"))))
     (shadow ((t (:foreground "grey70"))))
     (tool-bar ((t (:background "grey75" :foreground "black" :box (:line-width 1 :style released-button)))))
     (tooltip ((t (:family "Sans Serif" :background "lightyellow" :foreground "black"))))
     (trailing-whitespace ((t (:background "red1"))))
     (underline ((t (:underline t))))
     (variable-pitch ((t (:family "Sans Serif"))))
     (vertical-border ((t (nil))))
     (widget-button ((t (:bold t :weight bold))))
     (widget-button-pressed ((t (:foreground "red1"))))
     (widget-documentation ((t (:foreground "lime green"))))
     (widget-field ((t (:background "dim gray"))))
     (widget-inactive ((t (:foreground "grey70"))))
     (widget-single-line-field ((t (:background "dim gray")))))))

(provide 'color-theme-wombat)