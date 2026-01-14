;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;;; Identity
;; (setq user-full-name "Your Name"
;;       user-mail-address "your@email.com")

;;; Banner
(defun memnoc-doom-banner ()
  (let* ((banner '("                _       _"
                   "               ( \\     / )"
                   "            __  \\ \\   / /  __"
                   "           /  \\  \\ \\ / /  /  \\"
                   "          / /\\ \\  \\ V /  / /\\ \\"
                   "          \\_\\ \\_\\  \\_/  /_/ /_/"
                   ""
                   "   ███╗   ███╗███████╗███╗   ███╗███╗   ██╗ ██████╗  ██████╗"
                   "   ████╗ ████║██╔════╝████╗ ████║████╗  ██║██╔═══██╗██╔════╝"
                   "   ██╔████╔██║█████╗  ██╔████╔██║██╔██╗ ██║██║   ██║██║     "
                   "   ██║╚██╔╝██║██╔══╝  ██║╚██╔╝██║██║╚████║██║   ██║██║     "
                   "   ██║ ╚═╝ ██║███████╗██║ ╚═╝ ██║██║ ╚███║╚██████╔╝╚██████╗"
                   "   ╚═╝     ╚═╝╚══════╝╚═╝     ╚═╝╚═╝  ╚══╝ ╚═════╝  ╚═════╝"
                   ""
                   "                    < The Devil >"))
         (longest-line (apply #'max (mapcar #'length banner))))
    (put-text-property
     (point)
     (dolist (line banner (point))
       (insert (+doom-dashboard--center
                +doom-dashboard--width line)
               "\n"))
     'face 'doom-dashboard-banner)))

(setq +doom-dashboard-ascii-banner-fn #'memnoc-doom-banner)

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
  '(window-divider :foreground "#eb6f92")
  '(window-divider-first-pixel :foreground "#eb6f92")
  '(window-divider-last-pixel :foreground "#eb6f92"))

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

;;; Neotree
(after! neotree
  (map! :map neotree-mode-map
        "a" #'neotree-create-node
        "d" #'neotree-delete-node
        "r" #'neotree-rename-node))

;;; Functions
(defun save-all-and-quit ()
  (interactive)
  (save-some-buffers t)
  (kill-emacs))

