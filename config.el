;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;;; Identity
;; (setq user-full-name "Your Name"
;;       user-mail-address "your@email.com")

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
