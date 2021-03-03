;; Checklist
;; 1. all-the-icons-install-fonts

;; Notes
;; Create bind for mode example
;; (define-key emacs-lisp-mode-map (kbd "C-x M-t") 'counsel-load-theme)
;; Usually use use-package instead of this, or general.el

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
(menu-bar-mode -1)

(set-face-attribute 'default nil :font "Source Code Pro" :height 130)

(load-theme 'doom-dracula t)

;; Initialize package sources (just in case)
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/") ; Variable alist of package archives to fetch
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents             ; For new computers
  (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)   ; unless 'use-package is already installed, install it
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#1b1d1e" "#d02b61" "#60aa00" "#d08928" "#6c9ef8" "#b77fdb" "#00aa80" "#dddddd"])
 '(custom-safe-themes
   '("e6ff132edb1bfa0645e2ba032c44ce94a3bd3c15e3929cdf6c049802cf059a2a" "990e24b406787568c592db2b853aa65ecc2dcd08146c0d22293259d400174e37" default))
 '(fci-rule-color "#505050")
 '(jdee-db-active-breakpoint-face-colors (cons "#1b1d1e" "#fc20bb"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#1b1d1e" "#60aa00"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#1b1d1e" "#505050"))
 '(objed-cursor-color "#d02b61")
 '(package-selected-packages
   '(visual-fill-column org-bullets avy magit counsel-projectile projectile undo-tree evil-collection evil doom-themes helpful ivy-rich which-key rainbow-delimiters elcord doom-modeline counsel ivy command-log-mode use-package))
 '(pdf-view-midnight-colors (cons "#dddddd" "#1b1d1e"))
 '(rustic-ansi-faces
   ["#1b1d1e" "#d02b61" "#60aa00" "#d08928" "#6c9ef8" "#b77fdb" "#00aa80" "#dddddd"])
 '(vc-annotate-background "#1b1d1e")
 '(vc-annotate-color-map
   (list
    (cons 20 "#60aa00")
    (cons 40 "#859f0d")
    (cons 60 "#aa931a")
    (cons 80 "#d08928")
    (cons 100 "#d38732")
    (cons 120 "#d6863d")
    (cons 140 "#da8548")
    (cons 160 "#ce8379")
    (cons 180 "#c281aa")
    (cons 200 "#b77fdb")
    (cons 220 "#bf63b2")
    (cons 240 "#c74789")
    (cons 260 "#d02b61")
    (cons 280 "#b0345c")
    (cons 300 "#903d58")
    (cons 320 "#704654")
    (cons 340 "#505050")
    (cons 360 "#505050")))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Enable line numbers
(column-number-mode)
(global-display-line-numbers-mode t)

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                treemacs-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package counsel)

(use-package swiper)

(use-package ivy
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :init
  (ivy-mode 1))

(use-package all-the-icons) ; all-the-icons-install-fonts

(use-package doom-modeline
  :init (doom-modeline-mode 1))

(use-package elcord
  :config
  (elcord-mode))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-switch-buffer)
	 ("C-c C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history))
  :config
  (setq ivy-initial-inputs-alist nil)) ;; Don't start searches with ^

(use-package helpful
  :commands (helpful-callable helpful-variable helpful-command helpful-key)
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key)) ; Remap changes the function not the key

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package doom-themes
  :config
  (doom-themes-org-config))

(use-package general
  :after evil
  :config
  (general-create-definer rune/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC"))

  ;; (efs/leader-keys
  ;;   "t"  '(:ignore t :which-key "toggles")
  ;;   "tt" '(counsel-load-theme :which-key "choose theme")
  ;;   "fde" '(lambda () (interactive) (find-file (expand-file-name "~/.emacs.d/Emacs.org")))))

(use-package undo-tree
  :config
  (global-undo-tree-mode))

(use-package evil
  :after undo-tree
  :init
  (setq evil-undo-system 'undo-tree)
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t) ; Rebinds universal argument and sets the key back to Vim's default
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  (add-to-list 'evil-emacs-state-modes 'dired-mode)
  ;; (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  ;; (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  ;; (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  ;; (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  ;; (evil-set-initial-state 'messages-buffer-mode 'normal)
  ;; (evil-set-initial-state 'dashboard-mode 'normal))
  )

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package hydra)

(defhydra hydra-text-scale (:timeout nil)
  "scale text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finished" :exit t))

(rune/leader-keys
 "j" '(avy-goto-char-timer :which-key "jump")
 "ts" '(hydra-text-scale/body :which-key "scale text"))

(use-package command-log-mode
  :config
  (global-command-log-mode)) ; Toggle with C-c o

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  ;; NOTE: Set this to the folder where you keep your Git repos!
  (when (file-directory-p "~/Projects")
    (setq projectile-project-search-path '("~/Projects/Code")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :config (counsel-projectile-mode))

(use-package magit)

(use-package avy)

(use-package org
  :config
  (visual-line-mode 1)
  (setq org-ellipsis " ▾"))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode))
