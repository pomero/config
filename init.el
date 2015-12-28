(add-to-list 'load-path (expand-file-name "~/.emacs.d/major-mode/"))
(add-to-list 'exec-path (expand-file-name "/usr/local/go/bin/"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/elisps/"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/org/"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/auto-install/"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/third-repo/logcat-mode/"))

(defconst my-elisp-directory "~/.emacs.d/elpa")
(dolist (dir (let ((dir (expand-file-name my-elisp-directory)))
               (list dir (format "%s%d" dir emacs-major-version))))
  (when (and (stringp dir) (file-directory-p dir))
    (let ((default-directory dir))
      (add-to-list 'load-path default-directory)
      (normal-top-level-add-subdirs-to-load-path))))


(require 'migemo)
(setq migemo-command "cmigemo")
(setq migemo-options '("-q" "--emacs"))

;; Set your installed path
(setq migemo-dictionary "/usr/share/cmigemo/utf-8/migemo-dict")

(setq migemo-user-dictionary nil)
(setq migemo-regex-dictionary nil)
(setq migemo-coding-system 'utf-8-unix)
(load-library "migemo")
(migemo-init)

;; delete-b-word
(defun delete-word (arg)
  "Delete characters forward until encountering the end of a word.
With argument, do this that many times."
  (interactive "p")
  (delete-region (point) (progn (forward-word arg) (point))))

(defun backward-delete-word (arg)
  "Delete characters backward until encountering the end of a word.
With argument, do this that many times."
  (interactive "p")
  (delete-word (- arg)))
(global-set-key (kbd "M-h") 'backward-delete-word)
(global-set-key (kbd "M-d") 'delete-word)

(defun copy-line (arg)
  "Copy lines (as many as prefix argument) in the kill ring"
  (interactive "p")
  (kill-ring-save (line-beginning-position)
                  (line-beginning-position (+ 1 arg)))
  (message "%d line%s copied" arg (if (= 1 arg) "" "s")))

(defun my-kill-ring-save ()
  (interactive)
  (if (equal mark-active nil) (kill-ring-save (line-beginning-position) (line-end-position)) (kill-ring-save (point) (mark))))
(global-set-key "\M-w" 'my-kill-ring-save)

(require 'auto-install)
;(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (manoj-dark)))
 '(custom-safe-themes (quote ("a3132bd39a977ddde4c002f8bd0ef181414c3fbe9228e3643b999491192680ad" "12722541c8998f056b761bf63a92216aaf4610e4eb1afe7991842a31fa28b6d8" "90d329edc17c6f4e43dbc67709067ccd6c0a3caa355f305de2041755986548f2" "f08c2405a7e71e568b784ae0145a86e48e1b4ea8ba33d231a4ad21b52495de5e" "40b7687853f3d6921eba3afed50c532bbf4a66959554d32adf1899a675926b2d" "eb94779756914b07baac5b6f0cf74b4a0fe46572d34229b5dba848cca8073771" "69ee2feca8e30c618daf0e888ad65cb14fa3751c835d69b4973a25612be37187" "8d6fb24169d94df45422617a1dfabf15ca42a97d594d28b3584dc6db711e0e0b" "108b3724e0d684027c713703f663358779cc6544075bc8fd16ae71470497304f" "588b1ec3f63dfbd7ab2ba7eda4b1b6009dd1c8ed6a321fa98c492d8a63f1bba7" "0c387e27a3dd040b33c6711ff92e13bd952369a788eee97e4e4ea2335ac5528f" "ea489f6710a3da0738e7dbdfc124df06a4e3ae82f191ce66c2af3e0a15e99b90" "08efabe5a8f3827508634a3ceed33fa06b9daeef9c70a24218b70494acdf7855" "764e3a6472a3a4821d929cdbd786e759fab6ef6c2081884fca45f1e1e3077d1d" "e80932ca56b0f109f8545576531d3fc79487ca35a9a9693b62bf30d6d08c9aaf" "f0d8af755039aa25cd0792ace9002ba885fd14ac8e8807388ab00ec84c9497d7" "dc77fb4e02417a6a932599168bd61927f6f2fe4fe3dbc4e4086a0bfb25babd67" "146d24de1bb61ddfa64062c29b5ff57065552a7c4019bee5d869e938782dfc2a" "7ed6913f96c43796aa524e9ae506b0a3a50bfca061eed73b66766d14adfa86d1" "8b231ba3e5f61c2bb1bc3a2d84cbd16ea17ca13395653566d4dfbb11feaf8567" default)))
 '(flycheck-display-errors-function (function flycheck-pos-tip-error-messages))
 '(google-translate-default-source-language "en")
 '(google-translate-default-target-language "ja")
 '(menu-bar-mode nil)
 '(tool-bar-mode nil))

(setq inhibit-startup-screen t)
(setq initial-scratch-message "")
(setq x-select-enable-clipboard t)
(setq mode-require-final-newline nil)
; クリップボードとキルリングを同期させる
(cond (window-system
(setq x-select-enable-clipboard t)
))

;;; *.~ とかのバックアップファイルを作らない
(setq make-backup-files nil)
;;; .#* とかのバックアップファイルを作らない
(setq auto-save-default nil)

(require 'go-mode-load)

(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

(require 'grep-edit)
;(require 'anything) 
;(require 'anything-config) 
;(require 'anything-gtags) 

;; w3m
(require 'w3m)
(setq w3m-use-cookies t)
(setq w3m-favicon-cache-expire-wait nil)
(setq w3m-home-page "http://www.google.co.jp/") ;起動時に開くページ

(desktop-save-mode t)
(setq desktop-globals-to-save '(extended-command-history))
(setq desktop-files-not-to-save "")

;;undo-tree
(require 'undo-tree)
(global-undo-tree-mode t)
;(global-set-key (kbd "M-/") 'undo-tree-redo)

;;switch-window
(require 'switch-window)
(global-set-key (kbd "M-o") 'switch-window)
;;owdriver
;;(require 'owdriver)
;;(global-unset-key (kbd "M-o"))
;;(setq owdriver-prefix-key "M-o")
;;(owdriver-config-default)
;;(owdriver-add-keymap owdriver-prefix-key 'owdriver-next-window)
;;(owdriver-mode 1)

;;undo-hist
(require 'undohist)
(undohist-initialize)
(setq undohist-ignored-files '("/tmp/"))

;;anzu
(require 'anzu)
(global-anzu-mode t)

;;hlinum
(require 'hlinum)

;;howm
; howmが生成するファイルの置き場所
(setq howm-home-directory "~/.emacs.d/data/howm/")
; キーワード一覧
(setq howm-keyword-file (concat howm-home-directory ".howm-keys"))
; 履歴一覧
(setq howm-history-file (concat howm-home-directory ".howm-history"))


;;rainbow
(require 'rainbow-mode)
(rainbow-mode t)
(add-hook 'css-mode-hook 'rainbow-mode)
(add-hook 'scss-mode-hook 'rainbow-mode)
(add-hook 'php-mode-hook 'rainbow-mode)
(add-hook 'html-mode-hook 'rainbow-mode)
(require 'rainbow-delimiters)

(require 'helm-config)
(helm-mode t)
(global-set-key (kbd "C-x b") 'helm-for-files)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(when (require 'helm-config nil t)
  (define-key global-map (kbd "M-x")     'helm-M-x)
  (define-key global-map (kbd "C-x C-f") 'helm-find-files)
  (define-key global-map (kbd "C-x C-r") 'helm-recentf)
  (define-key global-map (kbd "M-y")     'helm-show-kill-ring)
  (define-key global-map (kbd "C-c i")   'helm-imenu)
  (define-key global-map (kbd "C-x b")   'helm-buffers-list)
  (define-key helm-map (kbd "C-h") 'delete-backward-char)
  (define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)
  (define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
  (define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)
)

(require 'helm-git-grep)
(define-key isearch-mode-map (kbd "M-g") 'helm-git-grep-from-isearch)
(global-set-key (kbd "M-l") 'helm-git-grep)
(global-set-key (kbd "M-L") 'helm-git-grep-at-point)

(require 'helm-git-files)
(global-set-key (kbd "C-x C-e") 'helm-git-files)

;(require 'helm-ag)
;(require 'helm-descbinds)

;(helm-descbinds-mode)

(require 'helm-bm) ;; Not necessary if using ELPA package
(global-set-key (kbd "C-c b") 'helm-bm)

(require 'helm-swoop)
(define-key helm-swoop-map (kbd "C-r") 'helm-previous-line)
(define-key helm-swoop-map (kbd "C-s") 'helm-next-line)
(global-set-key (kbd "M-i") 'helm-swoop)
(global-set-key (kbd "M-I") 'helm-multi-swoop-all)

(require 'ace-isearch)
(global-ace-isearch-mode 1)
;; (setq ace-isearch-use-ace-jump nil)

(defun isearch-forward-or-helm-swoop (use-helm-swoop)
  (interactive "p")
  (let (current-prefix-arg
        (helm-swoop-pre-input-function 'ignore))
    (call-interactively
     (case use-helm-swoop
       (1 'isearch-forward)
       (4 'helm-swoop)
       (16 'helm-swoop-nomigemo)))))
;(global-set-key (kbd "C-s") 'isearch-forward-or-helm-swoop)

(require 'ace-window)
;(global-set-key (kbd "M-o") 'ace-window)

;;auto-complete
(require 'auto-complete-config)
(ac-set-trigger-key "TAB")
(setq ac-use-menu-map t)       ;; 補完メニュー表示時にC-n/C-pで補完候補選択
(setq ac-use-fuzzy t)          ;; 曖昧マッチ
(ac-config-default)

(require 'all-ext)

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(package-initialize)

;;smartparent
(require 'smartparens-config)
(smartparens-global-mode t)

;;expand-region
(require 'expand-region)
(global-set-key (kbd "M-[") 'er/expand-region)
(global-set-key (kbd "M-]") 'er/contract-region)
(transient-mark-mode t)

;; theme
(require 'atom-dark-theme)
;(require 'ample-theme)
;(require 'grandshell-theme)

(require 'which-func)
; java-mode と javascript-mode でも which-func を使う
;(setq which-func-modes (append which-func-modes '(java-mode javascript-mode)))
;(which-func-mode t)

(which-function-mode 1)
(recentf-mode)
(show-paren-mode 1)
(setq completion-ignore-case t)
;(partial-completion-mode 1)
;(icomplete-mode 1)
(column-number-mode t)
(line-number-mode t)
(setq kill-whole-line t)


;; google-translate.el
(require 'google-translate)

;; 翻訳のデフォルト値を設定（en ->OB ja）




(defun my-term-switch-line-char ()
  "Switch `term-in-line-mode' and `term-in-char-mode' in `ansi-term'"
  (interactive)
  (cond
   ((term-in-line-mode)
    (term-char-mode)
    (hl-line-mode -1))
   ((term-in-char-mode)
    (term-line-mode)
    (hl-line-mode 1))))

;;golden-ratio
(require 'golden-ratio)
;(golden-ratio-mode t)

;;auto-hilight-symbol
(require 'auto-highlight-symbol)
(global-auto-highlight-symbol-mode t)
(setq ahs-idle-interval 0.5)

;;yasnippet
(require 'yasnippet)
(setq yas-sinippet-dirs
      '("~/.emacs.d/snippets/"))
(yas-global-mode t)

;; other
(setq completion-ignore-case t)
(global-auto-revert-mode 1)
(cua-mode t)
(setq cua-enable-cua-keys nil)


;; ============================================================
;; ansi-term
;; ============================================================

(defadvice ansi-term (after ansi-term-after-advice (arg))
  "run hook as after advice"
  (run-hooks 'ansi-term-after-hook))
(ad-activate 'ansi-term)

(defun my-term-switch-line-char ()
  "Switch `term-in-line-mode' and `term-in-char-mode' in `ansi-term'"
  (interactive)
  (cond
   ((term-in-line-mode)
    (term-char-mode)
    (hl-line-mode -1))
   ((term-in-char-mode)
    (term-line-mode)
    (hl-line-mode 1))))

(defadvice anything-c-kill-ring-action (around my-anything-kill-ring-term-advice activate)
  "In term-mode, use `term-send-raw-string' instead of `insert-for-yank'"
  (if (eq major-mode 'term-mode)
      (letf (((symbol-function 'insert-for-yank) (symbol-function 'term-send-raw-string)))
        ad-do-it)
    ad-do-it))

(defvar ansi-term-after-hook nil)
(add-hook 'ansi-term-after-hook
          (lambda ()
            ;; これがないと M-x できなかったり
            (define-key term-raw-map (kbd "M-x") 'nil)
            (define-key term-raw-map (kbd "M-z") 'nil)
            (define-key term-raw-map (kbd "M-o") 'nil)
            (define-key term-raw-map (kbd "C-z") 'nil)
            (define-key term-raw-map (kbd "C-s") 'nil)
            (define-key term-raw-map (kbd "M-!") 'nil)
            (define-key term-raw-map (kbd "M-g") 'nil)
            ;; コピー, 貼り付け
            (define-key term-raw-map (kbd "C-k")
              (lambda (&optional arg) (interactive "P") (funcall 'kill-line arg) (term-send-raw)))
            (define-key term-raw-map (kbd "C-y") 'term-paste)
            (define-key term-raw-map (kbd "M-y") 'anything-show-kill-ring)
            ;; C-t で line-mode と char-mode を切り替える
            (define-key term-raw-map  my-ansi-term-toggle-mode-key 'my-term-switch-line-char)
            (define-key term-mode-map my-ansi-term-toggle-mode-key 'my-term-switch-line-char)
            ;; Tango!
            (setq ansi-term-color-vector
                  [unspecified
                   "#000000"           ; black
                   "#ff3c3c"           ; red
                   "#84dd27"           ; green
                   "#eab93d"           ; yellow
                   "#89b6e2"           ; blue
                   "#f47006"           ; magenta
                   "#89b6e2"           ; cyan
                   "#ffffff"]          ; white
                  )
            ))


;; dired
;; diredを2つのウィンドウで開いている時に、デフォルトの移動orコピー先をもう一方のdiredで開いているディレクトリにする
(setq dired-dwim-target t)
;; ディレクトリを再帰的にコピーする
(setq dired-recursive-copies 'always)
;; diredバッファでC-sした時にファイル名だけにマッチするように
(setq dired-isearch-filenames t)

;;w3m拡張
(eval-after-load "w3m-search"
  '(progn
     (add-to-list 'w3m-search-engine-alist
                '("alc"
                  "http://eow.alc.co.jp/%s/UTF-8/"
                  utf-8))
     (add-to-list 'w3m-search-engine-alist
                '("android"
                  "http://tools.oesf.biz/android-5.1.1_r1.0/search?q=%s&defs=&refs=&path=&hist="
                  utf-8))
     (add-to-list 'w3m-uri-replace-alist
                  '("\\`alc:" w3m-search-uri-replace "alc"))
     (add-to-list 'w3m-uri-replace-alist
                  '("\\`android:" w3m-search-uri-replace "android"))
     ))

(require 'w3m-search)
(defun w3m-search-alc (url)
  "alc検索コマンド"
  (interactive
   (list
    (if (use-region-p)
                 (buffer-substring-no-properties (region-beginning) (region-end))
               (or (current-word t t)
                   (error "No word at point.")))))
  (interactive (list (read-from-minibuffer "alc: ")))
  (w3m-goto-url (concat "alc:" url)))
(define-key w3m-mode-map "U" 'w3m-search-alc)
(defun w3m-search-android (url)
  "android検索コマンド"
  (interactive
   (list
    (if (use-region-p)
                 (buffer-substring-no-properties (region-beginning) (region-end))
               (or (current-word t t)
                   (error "No word at point.")))))
  (w3m-goto-url (concat "android:" url))
  (define-key w3m-mode-map "W" 'w3m-search-android))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'vc)
(remove-hook 'find-file-hooks 'vc-find-file-hook)

(require 'magit)
(setq magit-auto-revert-mode nil)
(setq magit-last-seen-setup-instructions "1.4.0")


;; コントロール用のバッファを同一フレーム内に表示
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
;; diffのバッファを上下ではなく左右に並べる
(setq ediff-split-window-function 'split-window-horizontally)

(require 'flycheck)
(require ' flycheck-pos-tip)
(eval-after-load 'flycheck
  '(custom-set-variables
   '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages)))

(require 'jira)


;; for vnc
(setq x-alt-keysym 'meta)
(add-hook 'term-mode-hook (lambda()
                            (yas-minor-mode -1)))
;; (add-hook 'term-mode-hook (lambda()
;;         (setq yas-dont-activate t)))

;;(custom-set-variables
;; '(initial-frame-alist (quote ((fullscreen . maximized)))))
(if (boundp 'window-system)
    (setq default-frame-alist
          (append (list
                   '(top . 0) ; ウィンドウの表示位置（Y座標）
                   '(left . 0) ; ウィンドウの表示位置（X座標）
                   '(width . 150) ; ウィンドウの幅（文字数）
                   '(height . 40) ; ウィンドウの高さ（文字数）
                   )
                  default-frame-alist)))
(setq initial-frame-alist default-frame-alist )
(global-set-key (kbd "C-h") 'backward-delete-char)

;;misc
(global-set-key (kbd "C-z") 'repeat)
(global-set-key (kbd "M-p") 'imenu)
(global-set-key (kbd "C-x z") 'suspend-frame)
(global-set-key (kbd "M-g s") 'rgrep)
(global-set-key (kbd "M-g r") 'revert-buffer)
(global-set-key (kbd "M-g e") 'rename-buffer)
(global-set-key (kbd "M-g t") 'google-translate-at-point)
(global-set-key (kbd "M-g h") 'highlight-regexp)
(add-to-list 'auto-mode-alist (cons "\\.jad\\'" 'java-mode))
(defalias 'yes-or-no-p 'y-or-n-p)

(require 'sr-speedbar)
(setq speedbar-use-images nil)
(setq sr-speedbar-right-side nil) 

;; indent
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(setq tab-width 4)
(defvaralias 'c-basic-offset 'tab-width)
(setq c-default-style "linux")

;; open this file
(defun open-config-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

;; Enable helm-gtags-mode
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)
(add-hook 'java-mode-hook 'helm-gtags-mode)

;; Set key bindings
(eval-after-load "helm-gtags"
  '(progn
     (define-key helm-gtags-mode-map (kbd "M-t") 'helm-gtags-find-tag)
     (define-key helm-gtags-mode-map (kbd "M-r") 'helm-gtags-find-rtag)
     (define-key helm-gtags-mode-map (kbd "M-s") 'helm-gtags-find-symbol)
     (define-key helm-gtags-mode-map (kbd "M-g M-p") 'helm-gtags-parse-file)
     (define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
     (define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)
     (define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)))

(require 'logcat)

(eval-after-load "isearch"
  '(progn
     (require 'isearch-dabbrev)
     (define-key isearch-mode-map (kbd "<tab>") 'isearch-dabbrev-expand)))

(require 'wgrep)
(setq wgrep-enable-key "r")

;; (setq-default truncate-lines 0)
;; (setq-default truncate-partial-width-windows 0)

(defun kill-buffer-name ()
  (interactive)
  (kill-new (buffer-file-name)))

(defun resize-window ()
  "Control window size and position."
  (interactive)
  (let ((window-obj (selected-window))
        (current-width (window-width))
        (current-height (window-height))
        (dx (if (= (nth 0 (window-edges)) 0) 1
              -1))
        (dy (if (= (nth 1 (window-edges)) 0) 1
              -1))
        c)
    (catch 'end-flag
      (while t
        ;; (message "size[%dx%d]"
        ;;          (window-width) (window-height))
        (setq s (read-key ""))
        (setq c (format "%s" s))
        (cond
          ((string= c "right")
              (enlarge-window-horizontally dx))
          ((string= c "left")
              (shrink-window-horizontally dx))
          ((string= c "down")
              (enlarge-window dy))
          ((string= c "up")
              (shrink-window dy))
          (t
           (message "Quit")
           (throw 'end-flag t)))))))


(add-hook 'pre-command-hook
          (lambda ()
            (setq abbrev-mode nil)))

(require 'edbi)
(autoload 'edbi:open-db-viewer "edbi")