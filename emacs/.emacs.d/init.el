;; package -- Summary


;;; Commentary:

;; NOTE: init.el is now generated from Emacs.org.  Please edit that file
;;       in Emacs and init.el will be generated automatically!

;; The default is 800 kilobytes.  Measured in bytes.
(setq gc-cons-threshold (* 50 1000 1000))

(defun efs/display-startup-time ()
  (message "Emacs loaded in %s with %d garbage collections."
           (format "%.2f seconds"
                   (float-time
                     (time-subtract after-init-time before-init-time)))
           gcs-done))

(add-hook 'emacs-startup-hook #'efs/display-startup-time)

;; You will most likely need to adjust this font size for your system!
;; (defvar efs/default-font-size 120)
;; (defvar efs/default-variable-font-size 120)

(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(require 'use-package)
(setq use-package-always-ensure t)

(setq inhibit-startup-message t)

(set-frame-parameter (selected-frame) 'alpha '(95 . 95))
(add-to-list 'default-frame-alist '(alpha . (95 . 95)))
(set-frame-parameter (selected-frame) 'fullscreen 'maximized)
(add-to-list 'default-frame-alist '(fullscreen . maximized))

 (scroll-bar-mode -1)        ; Disable visible scrollbar
 (tool-bar-mode -1)          ; Disable the toolbar
 (tooltip-mode -1)           ; Disable tooltips
 (set-fringe-mode 10)        ; Give some breathing room
 (menu-bar-mode -1)            ; Disable the menu bar

 (setq visible-bell t)
 (setq initial-scratch-message "")	        ; Make *scratch* buffer blank
 (setq use-short-answers t)                   ; y-or-n-p makes answering questions faster
 (global-hl-line-mode 1)			; Highlight the current line 
 (setq read-process-output-max (* 1024 1024))  ; Increase the amount of data which Emacs reads

 ;; turn off auto revert messages
 (setq auto-revert-verbose nil)

 (column-number-mode)
 (global-display-line-numbers-mode t)
 (setq display-line-numbers-type 'relative)

 ;; Disable line numbers for some modes
 (dolist (mode '(org-mode-hook
                 term-mode-hook
                 treemacs-mode-hook
                 shell-mode-hook
                 vterm-mode-hook
                 eshell-mode-hook
                 info-mode-hook))
      (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Dont popup UI dialogs when prompting
;; (setq use-dialog-box nil)

;; Move customization variables to a separate file and load it
(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)

;; Remember and restore the last cursor location of opened files
(save-place-mode 1)

;; Save what you enter into minibuffer prompts
(setq history-length 25)
(savehist-mode 1)

(all-the-icons-completion-mode)
(add-hook 'marginalia-mode-hook #'all-the-icons-completion-marginalia-setup)

(setq read-extended-command-predicate nil)
(setq completions-detailed nil)
;; Always split new windows horizontally
;;  (setq split-width-threshold nil)
;;  (setq split-height-threshold 0)

;; Revert buffers when underlying file has changed
(global-auto-revert-mode 1)

;; Revert Dired and other buffers
(setq global-auto-revert-non-file-buffers t)

;; Remember recently edited files using M-x recentf-open-files
(recentf-mode 1)

(use-package super-save
 :ensure t
 :config
 (super-save-mode +1))     
 (setq super-save-auto-save-when-idle nil)
 ;;(setq auto-save-default nil)

(defun bjm/kill-this-buffer ()
  "Kill the current buffer."
  (interactive)
  (kill-buffer (current-buffer)))

(global-set-key (kbd "C-x k") 'bjm/kill-this-buffer)

(use-package undo-tree) 
(global-undo-tree-mode)

;;(use-package undo-fu)

;; Save whatever’s in the current (system) clipboard before
;; replacing it with the Emacs’ text.
;; https://github.com/dakrone/eos/blob/master/eos.org
(setq save-interprogram-paste-before-kill t)

(setq-default tab-width 2)
(setq-default evil-shift-width tab-width)

;;Use spaces instead of tabs for indentation
(setq-default indent-tabs-mode nil)


  ;; ;; Create a variable for our preferred tab width
  ;; (setq custom-tab-width 4)

  ;; ;; Two callable functions for enabling/disabling tabs in Emacs
  ;; (defun disable-tabs () (setq indent-tabs-mode nil))
  ;; (defun enable-tabs  ()
  ;;   (local-set-key (kbd "TAB") 'tab-to-tab-stop)
  ;;   (setq indent-tabs-mode t)
  ;;   (setq tab-width custom-tab-width))

  ;; ;; Hooks to Enable Tabs
  ;; (add-hook 'prog-mode-hook 'enable-tabs)
  ;; ;; Hooks to Disable Tabs
  ;; (add-hook 'lisp-mode-hook 'disable-tabs)
  ;; (add-hook 'emacs-lisp-mode-hook 'disable-tabs)

  ;; ;; Language-Specific Tweaks
  ;; (setq-default python-indent-offset custom-tab-width) ;; Python
  ;; (setq-default js-indent-level custom-tab-width)      ;; Javascript

  ;; ;; Making electric-indent behave sanely
  ;; (setq-default electric-indent-inhibit t)

  ;; ;; Make the backspace properly erase the tab instead of
  ;; ;; removing 1 space at a time.
  ;; (setq backward-delete-char-untabify-method 'hungry)

(set-face-attribute 'default nil :font "JetBrains Mono" :height 130)

;; Set the fixed pitch face
(set-face-attribute 'fixed-pitch nil :font "JetBrains Mono" :height 130) 

;; Set the variable pitch face
;;(set-face-attribute 'variable-pitch nil :font "Arimo Nerd Font" :height 160 :weight 'regular)
(set-face-attribute 'variable-pitch nil :font "ETBembo" :height 180 :weight 'regular)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(use-package general
  :config
  (general-create-definer my/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (my/leader-keys
    "o"  '(:ignore o :which-key "Org Mode")
    "oc" '(org-capture :which-key "capture")
    "oa" '(org-agenda :which-key "Agenda") 

    "t"  '(:ignore t :which-key "toggles")
    "tt" '(counsel-load-theme :which-key "choose theme")))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  (setq evil-undo-system 'undo-tree)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package doom-themes
  :init (load-theme 'doom-gruvbox 1))

(global-set-key (kbd "M-o") 'ace-window)
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
(setq aw-dispatch-always t)

(use-package highlight-indent-guides
    :config
    (setq highlight-indent-guides-delay '0)
   (setq highlight-indent-guides-responsive 'top)
    (setq highlight-indent-guides-method 'character))

(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)

(use-package all-the-icons
  :ensure t)

(use-package doom-modeline
  :ensure t
  :init   (doom-modeline-mode 1)
  :custom (doom-modeline-height 15)
          (doom-modeline-bar-width 6)
          (doom-modeline-lsp t)
          (doom-modeline-github nil)
          (doom-modeline-mu4e nil)
          (doom-modeline-irc t)
          (doom-modeline-buffer-modification-icon t)
          (doom-modeline-minor-modes t)
          (doom-modeline-modal t)
          (doom-modeline-persp-name nil)
          (doom-modeline-buffer-file-name-style 'truncate-except-project)
          (doom-modeline-major-mode-icon t)
          (doom-modeline-buffer-encoding nil))


(use-package minions
  :config (minions-mode 1))
(global-set-key [S-down-mouse-3] 'minions-minor-modes-menu)

(use-package which-key
  :init (which-key-mode)
        (which-key-setup-minibuffer)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

(use-package dired
   :ensure nil
   :commands (dired dired-jump)
   :bind (("C-x C-j" . dired-jump))
   :custom ((dired-listing-switches "-agho --group-directories-first"))
   :config
   (evil-collection-define-key 'normal 'dired-mode-map
     "h" 'dired-single-up-directory
     "l" 'dired-single-buffer))

   ;; (use-package all-the-icons-dired
   ;;  :hook (dired-mode . all-the-icons-dired-mode)
   ;;  :config (setq all-the-icons-dired-monochrome nil))

(use-package dired-open
  :config
  ;; Doesn't work as expected!
  ;;(add-to-list 'dired-open-functions #'dired-open-xdg t)
  (setq dired-open-extensions '(("png" . "feh")
                                ("mkv" . "mpv"))))

(use-package dired-hide-dotfiles
  :hook (dired-mode . dired-hide-dotfiles-mode)
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "H" 'dired-hide-dotfiles-mode))    


(require 'dired-single)

(setq delete-by-moving-to-trash t)

(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs                   (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay        0.5
          treemacs-directory-name-transformer      #'identity
          treemacs-display-in-side-window          t
          treemacs-eldoc-display                   'simple
          treemacs-file-event-delay                2000
          treemacs-file-extension-regex            treemacs-last-period-regex-value
          treemacs-file-follow-delay               0.2
          treemacs-file-name-transformer           #'identity
          treemacs-follow-after-init               t
          treemacs-expand-after-init               t
          treemacs-find-workspace-method           'find-for-file-or-pick-first
          treemacs-git-command-pipe                ""
          treemacs-goto-tag-strategy               'refetch-index
          treemacs-header-scroll-indicators        '(nil . "^^^^^^")
          treemacs-hide-dot-git-directory          t
          treemacs-indentation                     2
          treemacs-indentation-string              " "
          treemacs-is-never-other-window           nil
          treemacs-max-git-entries                 5000
          treemacs-missing-project-action          'ask
          treemacs-move-forward-on-expand          nil
          treemacs-no-png-images                   nil
          treemacs-no-delete-other-windows         t
          treemacs-project-follow-cleanup          nil
          treemacs-persist-file                    (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                        'left
          treemacs-read-string-input               'from-child-frame
          treemacs-recenter-distance               0.1
          treemacs-recenter-after-file-follow      nil
          treemacs-recenter-after-tag-follow       nil
          treemacs-recenter-after-project-jump     'always
          treemacs-recenter-after-project-expand   'on-distance
          treemacs-litter-directories              '("/node_modules" "/.venv" "/.cask")
          treemacs-show-cursor                     nil
          treemacs-show-hidden-files               t
          treemacs-silent-filewatch                nil
          treemacs-silent-refresh                  nil
          treemacs-sorting                         'alphabetic-asc
          treemacs-select-when-already-in-treemacs 'move-back
          treemacs-space-between-root-nodes        t
          treemacs-tag-follow-cleanup              t
          treemacs-tag-follow-delay                1.5
          treemacs-text-scale                      nil
          treemacs-user-mode-line-format           nil
          treemacs-user-header-line-format         nil
          treemacs-wide-toggle-width               70
          treemacs-width                           35
          treemacs-width-increment                 1
          treemacs-width-is-initially-locked       t
          treemacs-workspace-switch-cleanup        nil)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)
    (when treemacs-python-executable
      (treemacs-git-commit-diff-mode t))

    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple)))

    (treemacs-hide-gitignored-files-mode nil))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t d"   . treemacs-select-directory)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-evil
  :after (treemacs evil)
  :ensure t)

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

(use-package treemacs-icons-dired
  :hook (dired-mode . treemacs-icons-dired-enable-once)
  :ensure t)

(use-package treemacs-magit
  :after (treemacs magit)
  :ensure t)

(use-package treemacs-persp ;;treemacs-perspective if you use perspective.el vs. persp-mode
  :after (treemacs persp-mode) ;;or perspective vs. persp-mode
  :ensure t
  :config (treemacs-set-scope-type 'Perspectives))

(use-package treemacs-tab-bar ;;treemacs-tab-bar if you use tab-bar-mode
  :after (treemacs)
  :ensure t
  :config (treemacs-set-scope-type 'Tabs))

(use-package corfu
  ;; Optional customizations
  ;; :custom
  ;; (corfu-cycle non-nil)                ;; Enable cycling for `corfu-next/previous'
  ;; (corfu-auto t)                 ;; Enable auto completion
  ;; (corfu-separator ?\s)          ;; Orderless field separator
  ;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  ;; (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
  ;; (corfu-preview-current nil)    ;; Disable current candidate preview
  ;; (corfu-preselect-first nil)    ;; Disable candidate preselection
  ;; (corfu-on-exact-match nil)     ;; Configure handling of exact matches
  ;; (corfu-echo-documentation nil) ;; Disable documentation in the echo area
  ;; (corfu-scroll-margin 5)        ;; Use scroll margin

  ;; Enable Corfu only for certain modes.
  ;; :hook ((prog-mode . corfu-mode)
  ;;        (shell-mode . corfu-mode)
  ;;        (eshell-mode . corfu-mode))

  ;; Recommended: Enable Corfu globally.
  ;; This is recommended since Dabbrev can be used globally (M-/).
  ;; See also `corfu-excluded-modes'.
  :init
  (global-corfu-mode))

;; A few more useful configurations...
(use-package emacs
  :init
  ;; TAB cycle if there are only few candidates
  (setq completion-cycle-threshold 3)

  ;; Emacs 28: Hide commands in M-x which do not apply to the current mode.
  ;; Corfu commands are hidden, since they are not supposed to be used via M-x.
  ;; (setq read-extended-command-predicate
  ;;       #'command-completion-default-include-p)

  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  (setq tab-always-indent 'complete))

(use-package embark
  :ensure t

  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("C-;" . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'

  :init

  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)

  :config

  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

;; Consult users will also want the embark-consult package.
(use-package embark-consult
  :ensure t ; only need to install it, embark loads it after consult if found
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package consult
  ;; Replace bindings. Lazily loaded due by `use-package'.
  :bind (;; C-c bindings (mode-specific-map)
         ("C-c h" . consult-history)
         ("C-c m" . consult-mode-command)
         ("C-c k" . consult-kmacro)
         ;; C-x bindings (ctl-x-map)
         ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
         ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
         ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
         ("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer
         ;; Custom M-# bindings for fast register access
         ("M-#" . consult-register-load)
         ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
         ("C-M-#" . consult-register)
         ;; Other custom bindings
         ("M-y" . consult-yank-pop)                ;; orig. yank-pop
         ("<help> a" . consult-apropos)            ;; orig. apropos-command
         ;; M-g bindings (goto-map)
         ("M-g e" . consult-compile-error)
         ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
         ("M-g g" . consult-goto-line)             ;; orig. goto-line
         ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
         ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ;; M-s bindings (search-map)
         ("M-s d" . consult-find)
         ("M-s D" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s m" . consult-multi-occur)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ;; Isearch integration
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
         ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
         ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi)            ;; needed by consult-line to detect isearch
         ;; Minibuffer history
         :map minibuffer-local-map
         ("M-s" . consult-history)                 ;; orig. next-matching-history-element
         ("M-r" . consult-history))                ;; orig. previous-matching-history-element

  ;; Enable automatic preview at point in the *Completions* buffer. This is
  ;; relevant when you use the default completion UI.
  :hook (completion-list-mode . consult-preview-at-point-mode)

  ;; The :init configuration is always executed (Not lazy)
  :init

  ;; Optionally configure the register formatting. This improves the register
  ;; preview for `consult-register', `consult-register-load',
  ;; `consult-register-store' and the Emacs built-ins.
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)

  ;; Optionally tweak the register preview window.
  ;; This adds thin lines, sorting and hides the mode line of the window.
  (advice-add #'register-preview :override #'consult-register-window)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  ;; Configure other variables and modes in the :config section,
  ;; after lazily loading the package.
  :config

  ;; Optionally configure preview. The default value
  ;; is 'any, such that any key triggers the preview.
  ;; (setq consult-preview-key 'any)
  ;; (setq consult-preview-key (kbd "M-."))
  ;; (setq consult-preview-key (list (kbd "<S-down>") (kbd "<S-up>")))
  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   ;; :preview-key (kbd "M-.")
   :preview-key '(:debounce 0.4 any))

  ;; Optionally configure the narrowing key.
  ;; Both < and C-+ work reasonably well.
  (setq consult-narrow-key "<") ;; (kbd "C-+")

  ;; Optionally make narrowing help available in the minibuffer.
  ;; You may want to use `embark-prefix-help-command' or which-key instead.
  ;; (define-key consult-narrow-map (vconcat consult-narrow-key "?") #'consult-narrow-help)

  ;; By default `consult-project-function' uses `project-root' from project.el.
  ;; Optionally configure a different project root function.
  ;; There are multiple reasonable alternatives to chose from.
  ;;;; 1. project.el (the default)
  ;; (setq consult-project-function #'consult--default-project--function)
  ;;;; 2. projectile.el (projectile-project-root)
  ;; (autoload 'projectile-project-root "projectile")
  ;; (setq consult-project-function (lambda (_) (projectile-project-root)))
  ;;;; 3. vc.el (vc-root-dir)
  ;; (setq consult-project-function (lambda (_) (vc-root-dir)))
  ;;;; 4. locate-dominating-file
  ;; (setq consult-project-function (lambda (_) (locate-dominating-file "." ".git")))
)

(use-package vertico
    :ensure t
    :bind (:map vertico-map
           ("C-j" . vertico-next)
           ("C-k" . vertico-previous)
           ("C-f" . vertico-exit)
           :map minibuffer-local-map
           ("C-h" . backward-kill-word))
    :custom
    ;; Show more candidates
    (setq vertico-count 20)

    ;; Grow and shrink the Vertico minibuffer
    (setq vertico-resize t)

    ;; Optionally enable cycling for `vertico-next' and `vertico-previous'.
    (setq vertico-cycle t)
    :init
    (vertico-mode))

(use-package savehist
  :config
  (setq history-length 25)
  (savehist-mode 1))

  ;; Individual history elements can be configured separately
  ;;(put 'minibuffer-history 'history-length 25)
  ;;(put 'evil-ex-history 'history-length 50)
  ;;(put 'kill-ring 'history-length 25))

  (use-package marginalia
    :after vertico
    :ensure t
    :custom
    (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
    :init
    (marginalia-mode))

(use-package orderless
  :init
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (setq orderless-style-dispatchers '(+orderless-dispatch)
  ;;       orderless-component-separator #'orderless-escapable-split-on-space)
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

(use-package yasnippet
  :hook (prog-mode . yas-minor-mode)
  :config
  (yas-reload-all)
  (add-hook 'prog-mode-hook #'yas-minor-mode))

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
 ([remap describe-function] . helpful-function)
 ([remap describe-symbol] . helpful-symbol)
 ([remap describe-variable] . helpful-variable)
 ([remap describe-command] . helpful-command)
 ([remap describe-key] . helpful-key))

(use-package org)
(global-org-modern-mode)

;; Must do this so the agenda knows where to look for my files
(setq org-agenda-files '("~/PIM"))

;; When a TODO is set to a done state, record a timestamp
(setq org-log-done 'time)

;; Follow the links
(setq org-return-follows-link  t)

;; Associate all org files with org mode
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

;; Make the indentation look nicer
(add-hook 'org-mode-hook 'org-indent-mode)

;; Remap the change priority keys to use the UP or DOWN key
(define-key org-mode-map (kbd "C-c <up>") 'org-priority-up)
(define-key org-mode-map (kbd "C-c <down>") 'org-priority-down)

;; Shortcuts for storing links, viewing the agenda, and starting a capture
;; (define-key global-map "\C-cl" 'org-store-link)
;; (define-key global-map "\C-ca" 'org-agenda)
;; (define-key global-map "\C-cc" 'org-capture)

;;capture todo items using C-c c t
(define-key global-map (kbd "C-c c") 'org-capture)
;; set key for agenda
    ;; (global-set-key (kbd "C-c a") 'org-agenda)

;; When you want to change the level of an org item, use SMR
(define-key org-mode-map (kbd "C-c C-g C-r") 'org-shiftmetaright)

;; Hide the markers so you just see bold text as BOLD-TEXT and not *BOLD-TEXT*
(setq org-hide-emphasis-markers t)

;; Wrap the lines in org mode so that things are easier to read
(add-hook 'org-mode-hook 'visual-line-mode)

(setq org-capture-templates
    '(    

      ("g" "General Tasks"
       entry (file+headline "~/PIM/tasks.org" "General Tasks")
       "* TODO [#B] %?\n:Created: %T\n "
       :empty-lines 0)

      ("c" "Code Task"
       entry (file+headline "~/PIM/tasks.org" "Code Tasks")
       "* TODO [#B] %?\n:Created: %T\n%i\n%a\nProposed Solution: "
       :empty-lines 0)

      ("l" "Work Log"
       entry (file+datetree "~/PIM/work-log.org")
       "* %?"
       :empty-lines 0)

      ("n" "Note"
       entry (file+headline "~/PIM/notes.org" "Random Notes")
       "** %?"
       :empty-lines 0)

      ("m" "Meeting"
       entry (file+daoetree "~/PIM/meetings.org")
       "* %? :meeting:%^g \n:Created: %T\n** Attendees\n*** \n** Notes
       \n** Action Items\n*** TODO [#A] "
       :tree-type week
       :clock-in t
       :clock-resume t
       :empty-lines 0)

      )
    )

;; TODO states
(setq org-todo-keywords
    '((sequence "TODO(t)" "PLANNING(p)" "IN-PROGRESS(i@/!)" "VERIFYING(v!)"
                "BLOCKED(b@)"  "|" "DONE(d!)" "OBE(o@!)" "WONT-DO(w@/!)" )
      ))

;; TODO colors
(setq org-todo-keyword-faces
  '(
    ("TODO" . (:foreground "GoldenRod" :weight bold))
    ("PLANNING" . (:foreground "DeepPink" :weight bold))
    ("IN-PROGRESS" . (:foreground "Cyan" :weight bold))
    ("VERIFYING" . (:foreground "DarkOrange" :weight bold))
    ("BLOCKED" . (:foreground "Red" :weight bold))
    ("DONE" . (:foreground "LimeGreen" :weight bold))
    ("OBE" . (:foreground "LimeGreen" :weight bold))
    ("WONT-DO" . (:foreground "LimeGreen" :weight bold))
    ))


;; Tags
(setq org-tag-alist '(
                    ;; Ticket types
                    (:startgroup . nil)
                    ("@bug" . ?b)
                    ("@feature" . ?u)
                    ("@spike" . ?j)                      
                    (:endgroup . nil)

                    ;; Ticket flags
                    ("@write_future_ticket" . ?w)
                    ("@emergency" . ?e)
                    ("@research" . ?r)

                    ;; Meeting types
                    (:startgroup . nil)
                    ("big_sprint_review" . ?i)
                    ("cents_sprint_retro" . ?n)
                    ("dsu" . ?d)
                    ("grooming" . ?g)
                    ("sprint_retro" . ?s)
                    (:endgroup . nil)

                    ;; Code TODOs tags
                    ("QA" . ?q)
                    ("backend" . ?k)
                    ("broken_code" . ?c)
                    ("frontend" . ?f)

                    ;; Special tags
                    ("CRITICAL" . ?x)
                    ("obstacle" . ?o)

                    ;; Meeting tags
                    ("HR" . ?h)
                    ("general" . ?l)
                    ("meeting" . ?m)
                    ("misc" . ?z)
                    ("planning" . ?p)

                    ;; Work Log Tags
                    ("accomplishment" . ?a)
                    ))

;; Tag colors
(setq org-tag-faces
    '(
      ("planning"  . (:foreground "mediumPurple1" :weight bold))
      ("backend"   . (:foreground "royalblue1"    :weight bold))
      ("frontend"  . (:foreground "forest green"  :weight bold))
      ("QA"        . (:foreground "sienna"        :weight bold))
      ("meeting"   . (:foreground "yellow1"       :weight bold))
      ("CRITICAL"  . (:foreground "red1"          :weight bold))
      )
    )

(defun efs/org-font-setup ()
  ;; Replace list hyphen with dot
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

  ;; Set faces for heading levels
  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil :font "ETBembo" :weight 'regular :height 200))

  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table nil   :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch))

 (efs/org-font-setup)

;; (defun efs/org-mode-setup ()
;;   (org-indent-mode)
;;   (variable-pitch-mode 1)
;;   (visual-line-mode 1)
;;   (org-modern-mode))

;; (use-package org
;;   :hook (org-mode . efs/org-mode-setup)
;;   :config)
;;   (setq org-ellipsis " ▾")
;;   (setq org-agenda-start-with-log-mode t)
;;   (setq org-log-done 'time)
;;   (setq org-log-into-drawer t)

;;   (setq org-directory "~/PIM")
;;   (setq org-agenda-files
;;         '("~/PIM/tasks.org"
;;           "~/PIM/habits.org"
;;           "~/PIM/birthdays.org"))


;;   (require 'org-habit)
;;   (add-to-list 'org-modules 'org-habit)
;;   (setq org-habit-graph-column 60)

;;   (setq org-todo-keywords
;;     '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)")
;;       (sequence "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVE(a)" "REVIEW(v)" "WAIT(w@/!)" "HOLD(h)" "|" "COMPLETED(c)" "CANC(k@)")))

;;   (setq org-refile-targets
;;     '(("Archive.org" :maxlevel . 1)
;;       ("tasks.org" :maxlevel . 1)))

;;   ;; Save Org buffers after refiling!
;;   (advice-add 'org-refile :after 'org-save-all-org-buffers)

;;   (setq org-tag-alist
;;     '((:startgroup)
;;        ; Put mutually exclusive tags here
;;        (:endgroup)
;;        ("@errand" . ?E)
;;        ("@home" . ?H)
;;        ("@work" . ?W)
;;        ("agenda" . ?a)
;;        ("planning" . ?p)
;;        ("publish" . ?P)
;;        ("batch" . ?b)
;;        ("note" . ?n)
;;        ("idea" . ?i)))

;;   ;; Configure custom agenda views
;;   (setq org-agenda-custom-commands
;;    '(("d" "Dashboard"
;;      ((agenda "" ((org-deadline-warning-days 7)))
;;       (todo "NEXT"
;;         ((org-agenda-overriding-header "Next Tasks")))
;;       (tags-todo "agenda/ACTIVE" ((org-agenda-overriding-header "Active Projects")))))

;;     ("n" "Next Tasks"
;;      ((todo "NEXT"
;;         ((org-agenda-overriding-header "Next Tasks")))))

;;     ("W" "Work Tasks" tags-todo "+work-email")

;;     ;; Low-effort next actions
;;     ("e" tags-todo "+TODO=\"NEXT\"+Effort<15&+Effort>0"
;;      ((org-agenda-overriding-header "Low Effort Tasks")
;;       (org-agenda-max-todos 20)
;;       (org-agenda-files org-agenda-files)))

;;     ("w" "Workflow Status"
;;      ((todo "WAIT"
;;             ((org-agenda-overriding-header "Waiting on External")
;;              (org-agenda-files org-agenda-files)))
;;       (todo "REVIEW"
;;             ((org-agenda-overriding-header "In Review")
;;              (org-agenda-files org-agenda-files)))
;;       (todo "PLAN"
;;             ((org-agenda-overriding-header "In Planning")
;;              (org-agenda-todo-list-sublevels nil)
;;              (org-agenda-files org-agenda-files)))
;;       (todo "BACKLOG"
;;             ((org-agenda-overriding-header "Project Backlog")
;;              (org-agenda-todo-list-sublevels nil)
;;              (org-agenda-files org-agenda-files)))
;;       (todo "READY"
;;             ((org-agenda-overriding-header "Ready for Work")
;;              (org-agenda-files org-agenda-files)))
;;       (todo "ACTIVE"
;;             ((org-agenda-overriding-header "Active Projects")
;;              (org-agenda-files org-agenda-files)))
;;       (todo "COMPLETED"
;;             ((org-agenda-overriding-header "Completed Projects")
;;              (org-agenda-files org-agenda-files)))
;;       (todo "CANC"
;;             ((org-agenda-overriding-header "Cancelled Projects")
;;              (org-agenda-files org-agenda-files)))))))


;;   (setq org-capture-templates
;;     `(("t" "Tasks / Projects")
;;       ("tt" "Task" entry (file+olp "~/PIM/tasks.org" "Inbox")
;;            "* TODO %?\n  %U\n  %a\n  %i" :empty-lines 1)

;;       ("j" "Journal Entries")
;;       ("jj" "Journal" entry
;;            (file+olp+datetree "~/PIM/journal.org")
;;            "\n* %<%I:%M %p> - Journal :journal:\n\n%?\n\n"
;;            ;; ,(dw/read-file-as-string "~/Notes/Templates/Daily.org")
;;            :clock-in :clock-resume
;;            :empty-lines 1)
;;       ("jm" "Meeting" entry
;;            (file+olp+datetree "~/PIM/journal.org")
;;            "* %<%I:%M %p> - %a :meetings:\n\n%?\n\n"
;;            :clock-in :clock-resume
;;            :empty-lines 1)

;;       ("w" "Workflows")
;;       ("we" "Checking Email" entry (file+olp+datetree "~/PIM/journal")
;;            "* Checking Email :email:\n\n%?" :clock-in :clock-resume :empty-lines 1)

;;       ("m" "Metrics Capture")
;;       ("mw" "Weight" table-line (file+headline "~/PIM/Metrics.org" "Weight")
;;        "| %U | %^{Weight} | %^{Notes} |" :kill-buffer t)))

;;   ;; (define-key global-map (kbd "C-c j")
;;   ;;   (lambda () (interactive) (org-capture nil "t")))

;;   ;;capture todo items using C-c c t
;;   (define-key global-map (kbd "C-c c") 'org-capture)
;;   ;; set key for agenda
;;   (global-set-key (kbd "C-c a") 'org-agenda)

;;   (efs/org-font-setup)

(defun efs/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . efs/org-mode-visual-fill))

(org-babel-do-load-languages
  'org-babel-load-languages
  '((emacs-lisp . t)
    (python . t)))

(push '("conf-unix" . conf-unix) org-src-lang-modes)

(require 'org-tempo)

(add-to-list 'org-structure-template-alist '("sh" . "src shell"))
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("py" . "src python"))

(defun efs/org-babel-tangle-config ()
  (when (string-equal (buffer-file-name)
                      (expand-file-name "~/.emacs.d/emacs.org"))
    ;; Dynamic scoping to the rescue
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'efs/org-babel-tangle-config)))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook 
  (lsp-mode . lsp-enable-which-key-integration)
  (c-mode-hook . lsp-deferred)
  (c-mode . lsp)
  :custom
  (lsp-completion-enable t)
  (lsp-clients-clangd-args '("--clang-tidy" "--header-insertion=never" "-j=8"))
  (lsp-diagnostics-provider :none)
  (lsp-eldoc-enable-hover nil)
  (lsp-headerline-breadcrumb-enable t)
  (lsp-headerline-breadcrumb-segments '(project file symbols))
  (lsp-lens-enable nil)
  (lsp-disabled-clients '((python-mode . pylsp)))
  :init
  (setq lsp-keymap-prefix "C-c l") ;; Or 'C-l', 's-l'
  :config
  )

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-enable)
  (lsp-ui-doc-position 'bottom))

(use-package lsp-treemacs
  :after lsp)

;; (use-package lsp-ivy)

(use-package flycheck
 ; :diminish flycheck-mode
  :ensure t
  :init
  (global-flycheck-mode))

(use-package dap-mode
  ;; Uncomment the config below if you want all UI panes to be hidden by default!
  ;; :custom
  ;; (lsp-enable-dap-auto-configure nil)
  ;; :config
  ;; (dap-ui-mode 1)

  :config
  ;; Set up Node debugging
  ;; (require 'dap-node)
  ;; (dap-node-setup) ;; Automatically installs Node debug adapter if needed

(add-hook 'dap-stopped-hook
          (lambda (arg) (call-interactively #'dap-hydra)))

  ;; Bind `C-c l d` to `dap-hydra` for easy access
  (general-define-key
    :keymaps 'lsp-mode-map
    :prefix lsp-keymap-prefix
    "d" '(dap-hydra t :wk "debugger")))

(use-package python-mode
:ensure t
:hook (python-mode . lsp-deferred)
:custom
;; NOTE: Set these if Python 3 is called "python3" on your system!
;; (python-shell-interpreter "python3")
;; (dap-python-executable "python3")
(dap-python-debugger 'debugpy)
:config
(require 'dap-python))

(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp))))  ; or lsp-deferred

(use-package pyvenv
  :after python-mode
  :config
  (pyvenv-mode 1))

(use-package python-pytest)

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  ;; NOTE: Set this to the folder where you keep your Git repos!
  (when (file-directory-p "~/Code")
    (setq projectile-project-search-path '("~/Code")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :config (counsel-projectile-mode))

(use-package magit
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

;; NOTE: Make sure to configure a GitHub token before using this package!
;; - https://magit.vc/manual/forge/Token-Creation.html#Token-Creation
;; - https://magit.vc/manual/ghub/Getting-Started.html#Getting-Started
;; (use-package forge)

(use-package evil-nerd-commenter
  :bind ("M-/" . evilnc-comment-or-uncomment-lines))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package smartparens)

(use-package smartparens-config
:ensure smartparens
:config (progn (show-smartparens-global-mode t)))

(add-hook 'prog-mode-hook 'turn-on-smartparens-strict-mode)
;;(add-hook 'markdown-mode-hook 'turn-on-smartparens-strict-mode)

(use-package evil-smartparens)
(add-hook 'python-mode-hook #'evil-smartparens-mode)
(add-hook 'c-mode-hook #'evil-smartparens-mode)

;; (use-package company
;;   :after lsp-mode
;;   :ensure t
;;   :defer t
;;   :diminish ""
;;   :bind (:map company-active-map
;;        ("<tab>" . company-complete-selection))
;;       (:map lsp-mode-map
;;        ("<tab>" . company-indent-or-complete-common))
;;   :custom
;;   (company-dabbrev-other-buffers t)
;;   (company-dabbrev-code-other-buffers t)
;;   ;; M-<num> to select an option according to its number.
;;   (company-show-numbers t)
;;   ;; Only 2 letters required for completion to activate.
;;   (company-minimum-prefix-length 1)
;;   ;; Do not downcase completions by default.
;;   (company-dabbrev-downcase nil)
;;   ;; Even if I write something with the wrong case,
;;   ;; provide the correct casing.
;;   (company-dabbrev-ignore-case t)
;;   ;; company completion wait
;;   (company-idle-delay 0.0)
;;   ;; No company-mode in shell & eshell
;;   (company-global-modes '(not eshell-mode shell-mode))
;;   :hook ((text-mode-hook . company-mode)
;;          (lsp-mode . company-mode)
;;            (prog-mode-hook . company-mode)))

;; (use-package company-box
;;   :hook (company-mode . company-box-mode))

(use-package term
    :config
    (setq explicit-shell-file-name "zsh") ;; Change this to zsh, etc
    ;;(setq explicit-zsh-args '())         ;; Use 'explicit-<shell>-args for shell-specific args

    ;; Match the default Bash shell prompt.  Update this if you have a custom prompt
    (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *"))

(use-package eterm-256color
  :hook (term-mode . eterm-256color-mode))

(use-package vterm
  :commands vterm
  :config
  (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *")  ;; Set this to match your custom shell prompt
  (setq vterm-shell "zsh")                       ;; Set this to customize the shell to launch
  (setq vterm-max-scrollback 10000))

(use-package shell-pop
  :bind (("C-t" . shell-pop))
  :config
  (setq shell-pop-shell-type (quote ("ansi-term" "*ansi-term*" (lambda nil (vterm shell-pop-term-shell)))))
  (setq shell-pop-term-shell "/bin/zsh")
  ;; need to do this manually or not picked up by `shell-pop'
  (shell-pop--set-shell-type 'shell-pop-shell-type shell-pop-shell-type))

(use-package anki-editor
  :after org-noter
  :config
  (setq anki-editor-create-decks 't))

(use-package org-drill
:after org)

;; Make gc pauses faster by decreasing the threshold.
(setq gc-cons-threshold (* 2 1000 1000))
