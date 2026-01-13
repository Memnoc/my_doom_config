;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;;; Identity
;; (setq user-full-name "Your Name"
;;       user-mail-address "your@email.com")

;;; Banner
;;; https://github.com/Schievel1/doom-emacs-splash/blob/main/svg/doom/doomEmacsTokyoNight.svg
(setq fancy-splash-image (concat doom-user-dir "images/banner.svg"))
;; (defun memnoc-doom-banner ()
;;   (let* ((banner '("                _       _"
;;                    "               ( \\     / )"
;;                    "            __  \\ \\   / /  __"
;;                    "           /  \\  \\ \\ / /  /  \\"
;;                    "          / /\\ \\  \\ V /  / /\\ \\"
;;                    "          \\_\\ \\_\\  \\_/  /_/ /_/"
;;                    ""
;;                    "   ███╗   ███╗███████╗███╗   ███╗███╗   ██╗ ██████╗  ██████╗"
;;                    "   ████╗ ████║██╔════╝████╗ ████║████╗  ██║██╔═══██╗██╔════╝"
;;                    "   ██╔████╔██║█████╗  ██╔████╔██║██╔██╗ ██║██║   ██║██║     "
;;                    "   ██║╚██╔╝██║██╔══╝  ██║╚██╔╝██║██║╚████║██║   ██║██║     "
;;                    "   ██║ ╚═╝ ██║███████╗██║ ╚═╝ ██║██║ ╚███║╚██████╔╝╚██████╗"
;;                    "   ╚═╝     ╚═╝╚══════╝╚═╝     ╚═╝╚═╝  ╚══╝ ╚═════╝  ╚═════╝"
;;                    ""
;;                    "                    < The Devil >"))
;;          (longest-line (apply #'max (mapcar #'length banner))))
;;     (put-text-property
;;      (point)
;;      (dolist (line banner (point))
;;        (insert (+doom-dashboard--center
;;                 +doom-dashboard--width line)
;;                "\n"))
;;      'face 'doom-dashboard-banner)))

;; (setq +doom-dashboard-ascii-banner-fn #'memnoc-doom-banner)

;;; Appearance
(setq doom-font (font-spec :family "JetBrains Mono" :size 15))
(setq doom-theme 'doom-rose-pine)
(setq display-line-numbers-type t)

;; Window dividers (rose-pine rose accent)
(setq window-divider-default-places t
      window-divider-default-bottom-width 3
      window-divider-default-right-width 3)
(window-divider-mode +1)
(custom-set-faces!
  '(window-divider :foreground "#524f67")
  '(window-divider-first-pixel :foreground "#524f67")
  '(window-divider-last-pixel :foreground "#524f67"))

;; Yank flash effect
(use-package! evil-goggles
  :config
  (evil-goggles-mode)
  (setq evil-goggles-duration 0.2)
  (custom-set-faces!
    '(evil-goggles-yank-face :background "#eb6f92" :foreground "#191724")))

;; Visual selection (rose-pine palette)
(custom-set-faces!
  ;; '(region :background "#524f67" :foreground "#e0def4")
  ;; Iris (purple) selection
  '(region :background "#c4a7e7" :foreground "#191724")

  ;; Pine (teal) selection
  ;; '(region :background "#31748f" :foreground "#e0def4")

  ;; Rose (soft pink) selection
  ;; '(region :background "#ebbcba" :foreground "#191724")

  ;; Subtle overlay
  ;; '(region :background "#26233a" :foreground "#e0def4")
  )

;;; Org
(setq org-directory "~/org/")

;;; Keybindings
(map! "C-s" #'save-buffer)                ;; save
(map! :leader "e" #'+neotree/open)        ;; file tree
(map! :leader "9" #'+vterm/toggle)        ;; floating terminal
(map! :leader "q q" #'save-all-and-quit)  ;; save and quit
(map! "C-h" #'evil-window-left
      "C-j" #'evil-window-down
      "C-k" #'evil-window-up
      "C-l" #'evil-window-right)
(map! :leader "d x" #'+default/diagnostics)
(map! :leader "c a" #'lsp-execute-code-action)
(map! :leader "c a" #'eglot-code-actions)
(map! :leader "c q" #'eglot-code-action-quickfix)
(map! :leader "c r" #'eglot-code-action-rewrite)
(map! :leader "c o" #'eglot-code-action-organize-imports)
(map! :n "H" #'+workspace/switch-left
      :n "L" #'+workspace/switch-right)
(map! :n "H" #'previous-buffer
      :n "L" #'next-buffer)

;;; Neotree
(after! neotree
  (map! :map neotree-mode-map
        "a" #'neotree-create-node
        "d" #'neotree-delete-node
        "r" #'neotree-rename-node
        "<backspace>" #'neotree-select-up-node))

;;; Functions
(defun save-all-and-quit ()
  (interactive)
  (save-some-buffers t)
  (kill-emacs))

;;; Detect OS and load the proper config
(pcase system-type
  ('darwin (load! "machines/macos"))
  ('gnu/linux
   (cond
    ((executable-find "niri") (load! "machines/arch-niri"))
    ((executable-find "bspc") (load! "machines/arch-bspwm"))
    ((file-exists-p "/etc/pop-os/os-release") (load! "machines/popos")))))
