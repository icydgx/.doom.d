;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/GTD/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; (cnfonts-mode 1)
;; font setting
(defun font-installed-p (font-name)
  ;; "Check if font with FONT-NAME is available."
  (find-font (font-spec :name font-name)))
(when (display-graphic-p)
  (cl-loop for font in '("Cascadia Code" "SF Mono" "Source Code Pro"
                         "Fira Code" "Menlo" "Monaco" "Dejavu Sans Mono"
                         "Lucida Console" "Consolas" "SAS Monospace")
           when (font-installed-p font)
           return (set-face-attribute
                   'default nil
                   :font (font-spec :family font
                                    :weight 'normal
                                    :slant 'normal
                                    :size (cond ((eq system-type 'gnu/linux) 10.5)
                                                ((eq system-type 'windows-nt) 10.5)))))
  (cl-loop for font in '("OpenSansEmoji" "Noto Color Emoji" "Segoe UI Emoji"
                         "EmojiOne Color" "Apple Color Emoji" "Symbola" "Symbol")
           when (font-installed-p font)
           return (set-fontset-font t 'unicode
                                    (font-spec :family font
                                               :size (cond ((eq system-type 'gnu/linux) 10.5)
                                                           ((eq system-type 'windows-nt) 10.5)))
                                    nil 'prepend))
  (cl-loop for font in '("思源黑体 CN" "思源宋体 CN" "微软雅黑 CN"
                         "Source Han Sans CN" "Source Han Serif CN"
                         "WenQuanYi Micro Hei" "文泉驿等宽微米黑"
                         "Microsoft Yahei UI" "Microsoft Yahei")
           when (font-installed-p font)
           return (set-fontset-font t '(#x4e00 . #x9fff)
                                    (font-spec :name font
                                               :weight 'normal
                                               :slant 'normal
                                               :size (cond ((eq system-type 'gnu/linux) 10.5)
                                                           ((eq system-type 'windows-nt) 11.5)))))
  (cl-loop for font in '("HanaMinB" "SimSun-ExtB")
           when (font-installed-p font)
           return (set-fontset-font t '(#x20000 . #x2A6DF)
                                    (font-spec :name font
                                               :weight 'normal
                                               :slant 'normal
                                               :size (cond ((eq system-type 'gnu/linux) 10.5)
                                                           ((eq system-type 'windows-nt) 10.5))))))

;; org mode
;;
(add-hook 'org-mode-hook #'valign-mode)
;; (defun my-org-archive-done-tasks ()
;;   (interactive)
;;   (org-map-entries 'org-archive-subtree "/DONE" 'file))
;; (after! org
;; (setq org-capture-templates
;;       `(("t" "Task" entry (file "inbox.org")
;;          ,(string-join '("* TODO %?"
;;                          ":PROPERTIES:"
;;                          ":CREATED: %U"
;;                          ":END:")
;;                        "\n"))
;;        ("n" "Note" entry (file "inbox.org")
;;          ,(string-join '("* %?"
;;                          ":PROPERTIES:"
;;                          ":CREATED: %U"
;;                          ":END:")
;;                        "\n"))
;;         ("m" "Meeting" entry (file "inbox.org")
;;          ,(string-join '("* %? :meeting:"
;;                          "<%<%Y-%m-%d %a %H:00>>"
;;                          ""
;;                          "/Met with: /")
;;                        "\n"))
;;         ("a" "Appointment" entry (file "inbox.org")
;;          ,(string-join '("* %? :appointment:"
;;                          ":PROPERTIES:"
;;                          ":CREATED: %U"
;;                          ":END:")
;;                        "\n"))
;;         )))

(custom-set-faces
 '(org-level-1 ((t (:inherit outline-1 :weight normal))))
 '(org-level-2 ((t (:inherit outline-2 :weight normal))))
 '(org-level-3 ((t (:inherit outline-3 :weight normal))))
 '(org-level-4 ((t (:inherit outline-4 :weight normal))))
 '(org-level-5 ((t (:inherit outline-5 :weight normal))))
 '(org-level-6 ((t (:inherit outline-6 :weight normal))))
 '(org-level-7 ((t (:inherit outline-7 :weight normal))))
 '(org-level-8 ((t (:inherit outline-8 :weight normal)))))
;; (setq org-todo-keyword-faces
;;       '(("STRT" . "magenta")("KILL" . "#5B6268")))
      ;; '(("TODO" . "red")("DONE" . "green")("KILL" . "#5B6268")))
;; (after! org
;;   (custom-set-faces!
;;     '(org-level-1 :weight normal :underline nil)
;;     '(org-level-2 :weight normal)
;;     '(org-level-3 :weight normal)
;;     '(org-level-4 :weight normal)
;;     ;; Add more levels as needed
;;     ))
(global-set-key (kbd "<f12>") 'org-agenda-list)
;; (setq org-agenda-start-with-log-mode t)
;; (setq org-clock-in-when-starting t)
(setq org-log-done 't)
;; (defun my/org-clock-in-when-started ()
;;   "Start the clock when a task is marked as STARTED."
;;   (when (string= org-state "STRT")
;;     (org-clock-in)))
;; (add-hook 'org-after-todo-state-change-hook 'my/org-clock-in-when-started)

;; ;; fix method change more better
;; (defun emacs-ime-disable ()
;;   (w32-set-ime-open-status nil))

;; (defun emacs-ime-enable ()
;;   (w32-set-ime-open-status t))

;; (add-hook 'evil-insert-state-entry-hook 'emacs-ime-enable)
;; (add-hook 'evil-insert-state-exit-hook 'emacs-ime-disable)

(when (eq system-type 'windows-nt)  (set-next-selection-coding-system 'utf-16-le)  (set-selection-coding-system 'utf-16-le)  (set-clipboard-coding-system 'utf-16-le))
