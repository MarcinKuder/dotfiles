;;; doom-matccha-theme.el --- A Catppuccin-inspired matcha green theme -*- lexical-binding: t; no-byte-compile: t; -*-
;;
;; Author:      Your Name
;; URL:         https://github.com/you/doom-matccha
;; Version:     1.0.0
;; Keywords:    custom themes, faces
;; Package-Requires: ((emacs "27.1") (doom-themes "2.2.1"))
;;
;;; Commentary:
;;
;; Matccha is a Catppuccin-inspired dark theme steeped in the serene greens
;; of ceremonial matcha. It follows Catppuccin's palette conventions
;; (crust → mantle → base → surface → overlay → text) but shifts the entire
;; hue space into deep earthy greens, with a tea-ceremony accent palette:
;;   green    → fresh sencha       #7dba85
;;   teal     → ceremonial matcha  #5db3a0  (primary accent)
;;   yellow   → golden gyokuro     #c8b870
;;   peach    → roasted hojicha    #c89468
;;   rosewater→ warm cream         #e8d5c4
;;
;; Installation:
;;   1. Copy this file to ~/.doom.d/themes/doom-matccha-theme.el
;;   2. In ~/.doom.d/config.el add:
;;        (setq doom-theme 'doom-matccha)
;;   3. Run `doom sync` and restart Emacs.
;;
;;; Code:

(require 'doom-themes)


;;; Variables

(defgroup doom-matccha-theme nil
  "Options for the doom-matccha theme."
  :group 'doom-themes)

(defcustom doom-matccha-brighter-modeline nil
  "If non-nil, use a slightly brighter background for the mode-line."
  :group 'doom-matccha-theme
  :type 'boolean)

(defcustom doom-matccha-brighter-comments nil
  "If non-nil, comments are rendered with a slightly brighter foreground."
  :group 'doom-matccha-theme
  :type 'boolean)

(defcustom doom-matccha-padded-modeline doom-themes-padded-modeline
  "If non-nil, add padding to the mode-line."
  :group 'doom-matccha-theme
  :type '(or integer boolean))


;;; Theme definition

(def-doom-theme doom-matccha
  "A Catppuccin-inspired theme steeped in the serene greens of ceremonial matcha."

  ;; -----------------------------------------------------------------------
  ;; Core UI palette
  ;; name          default          256              16
  ;; -----------------------------------------------------------------------
  ((bg            '("#161f19"       "color-234"      "black"        ))
   (fg            '("#cde8d3"       "color-253"      "brightwhite"  ))

   ;; These are used heavily throughout
   (bg-alt        '("#111a15"       "color-233"      "black"        ))
   (fg-alt        '("#a3bfa8"       "color-248"      "white"        ))

   (base0         '("#0d1410"       "color-232"      "black"        ))
   (base1         '("#111a15"       "color-233"      "brightblack"  ))
   (base2         '("#161f19"       "color-234"      "brightblack"  ))
   (base3         '("#1e2b21"       "color-235"      "brightblack"  ))
   (base4         '("#26362a"       "color-236"      "brightblack"  ))
   (base5         '("#2f4034"       "color-237"      "brightblack"  ))
   (base6         '("#3d5443"       "color-238"      "brightblack"  ))
   (base7         '("#5f8267"       "color-243"      "white"        ))
   (base8         '("#8aaa8f"       "color-246"      "white"        ))

   ;; -----------------------------------------------------------------------
   ;; Accent colors — Tea Ceremony palette
   ;; -----------------------------------------------------------------------
   (grey          '("#4e6b55"       "color-240"      "brightblack"  ))

   ;; Primary accent (ceremonial teal is the "blue" role here)
   (blue          '("#5db3a0"       "color-73"       "cyan"         ))  ; teal / ceremonial
   (dark-blue     '("#3d8a79"       "color-66"       "blue"         ))
   (cyan          '("#7ec4c1"       "color-116"      "brightcyan"   ))  ; sky / morning mist
   (dark-cyan     '("#5a9e9b"       "color-73"       "cyan"         ))  ; deeper morning mist

   ;; Green family (the heart of matccha)
   (green         '("#7dba85"       "color-114"      "green"        ))  ; fresh sencha
   (dark-green    '("#5f9968"       "color-72"       "green"        ))
   (teal          '("#5db3a0"       "color-73"       "brightgreen"  ))  ; alias for convenience
   (dark-teal     '("#3d8a79"       "color-66"       "green"        ))  ; deeper ceremonial

   ;; Warm accents
   (yellow        '("#c8b870"       "color-179"      "yellow"       ))  ; golden gyokuro
   (dark-yellow   '("#a89450"       "color-136"      "yellow"       ))
   (orange        '("#c89468"       "color-173"      "brightyellow" ))  ; hojicha / peach

   ;; Cool accents
   (violet        '("#a09cc8"       "color-183"      "magenta"      ))  ; lavender / wisteria
   (magenta       '("#9b8fc2"       "color-140"      "brightmagenta"))  ; mauve / purple ink

   ;; Red / warning
   (red           '("#c96b6b"       "color-167"      "red"          ))  ; koi red
   (dark-red      '("#b55e5e"       "color-131"      "brightred"    ))  ; maroon

   ;; -----------------------------------------------------------------------
   ;; Face-specific derived colors
   ;; -----------------------------------------------------------------------
   (highlight          blue)
   (vertical-bar       base3)
   (selection          base4)
   (builtin            teal)
   (comments           (if doom-matccha-brighter-comments base7 grey))
   (doc-comments       (doom-lighten (if doom-matccha-brighter-comments base7 grey) 0.1))
   (constants          orange)
   (functions          blue)
   (keywords           magenta)
   (methods            cyan)
   (operators          teal)
   (type               yellow)
   (strings            green)
   (variables          fg)
   (numbers            orange)
   (region             base4)
   (error              red)
   (warning            yellow)
   (success            green)
   (vc-modified        yellow)
   (vc-added           green)
   (vc-deleted         red)

   ;; Mode-line
   (modeline-fg           fg)
   (modeline-fg-alt       base8)
   (modeline-bg           (if doom-matccha-brighter-modeline base4 base3))
   (modeline-bg-alt       (if doom-matccha-brighter-modeline base3 base2))
   (modeline-bg-inactive  base2)
   (modeline-bg-inactive-alt base1)

   (-modeline-pad
    (when doom-matccha-padded-modeline
      (if (integerp doom-matccha-padded-modeline)
          doom-matccha-padded-modeline 4))))


  ;; ==========================================================================
  ;; Base theme face overrides
  ;; ==========================================================================
  (((line-number &override)                :foreground base6)
   ((line-number-current-line &override)   :foreground teal :bold t)
   ((font-lock-comment-face &override)     :slant 'italic)
   ((font-lock-doc-face &override)         :slant 'italic :foreground doc-comments)

   ;; Fringe
   (fringe :background bg)

   ;; Highlight line
   (hl-line :background base3)

   ;; Links
   (link :foreground teal :underline t)

   ;; -------------------------------------------------------------------------
   ;; Mode-line
   ;; -------------------------------------------------------------------------
   (mode-line
    :background modeline-bg
    :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive
    :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis :foreground green :bold t)

   ;; -------------------------------------------------------------------------
   ;; Search & match
   ;; -------------------------------------------------------------------------
   (lazy-highlight         :background (doom-darken teal 0.45) :foreground fg :bold t)
   (isearch                :background teal :foreground base0 :bold t)
   (isearch-fail           :background (doom-darken red 0.3)  :foreground red)
   (evil-search-highlight-persist-highlight-face :background (doom-darken teal 0.4))

   ;; -------------------------------------------------------------------------
   ;; Company (completion popup)
   ;; -------------------------------------------------------------------------
   (company-tooltip            :background base2 :foreground fg)
   (company-tooltip-selection  :background base4 :foreground green)
   (company-tooltip-common     :foreground teal :bold t)
   (company-tooltip-annotation :foreground base8)
   (company-scrollbar-bg       :background base3)
   (company-scrollbar-fg       :background teal)
   (company-preview-common     :foreground teal)

   ;; -------------------------------------------------------------------------
   ;; Corfu
   ;; -------------------------------------------------------------------------
   (corfu-default      :background base2)
   (corfu-current      :background base4 :foreground green)
   (corfu-bar          :background teal)
   (corfu-border       :background base5)

   ;; -------------------------------------------------------------------------
   ;; Ivy / Vertico / Consult
   ;; -------------------------------------------------------------------------
   (ivy-current-match           :background base4 :foreground green :bold t)
   (ivy-minibuffer-match-face-1 :foreground teal)
   (ivy-minibuffer-match-face-2 :foreground green :bold t)
   (ivy-minibuffer-match-face-3 :foreground yellow)
   (ivy-minibuffer-match-face-4 :foreground orange)
   (ivy-virtual                 :foreground base8)

   (vertico-current             :background base4)
   (consult-preview-line        :background base3)
   (consult-preview-cursor      :background (doom-darken teal 0.3))

   ;; -------------------------------------------------------------------------
   ;; Helm
   ;; -------------------------------------------------------------------------
   (helm-selection             :background base4)
   (helm-match                 :foreground teal :bold t)
   (helm-source-header         :foreground green :bold t :height 1.1)

   ;; -------------------------------------------------------------------------
   ;; Treemacs / Neotree
   ;; -------------------------------------------------------------------------
   (treemacs-root-face         :foreground green :bold t :height 1.1)
   (treemacs-directory-face    :foreground fg-alt)
   (treemacs-file-face         :foreground fg)
   (treemacs-git-modified-face :foreground yellow)
   (treemacs-git-added-face    :foreground green)
   (treemacs-git-untracked-face :foreground base8)

   ;; -------------------------------------------------------------------------
   ;; Magit
   ;; -------------------------------------------------------------------------
   (magit-branch-local        :foreground teal)
   (magit-branch-remote       :foreground green)
   (magit-tag                 :foreground yellow)
   (magit-hash                :foreground base8)
   (magit-section-heading     :foreground green :bold t)
   (magit-section-highlight   :background base3)
   (magit-diff-added          :background (doom-darken green 0.55) :foreground (doom-lighten green 0.2))
   (magit-diff-removed        :background (doom-darken red 0.55)   :foreground (doom-lighten red 0.2))
   (magit-diff-added-highlight   :background (doom-darken green 0.4) :foreground (doom-lighten green 0.3) :bold t)
   (magit-diff-removed-highlight :background (doom-darken red 0.4)   :foreground (doom-lighten red 0.3) :bold t)
   (magit-diff-context-highlight :background base3 :foreground fg-alt)
   (magit-blame-heading       :background base3 :foreground teal)
   (magit-log-author          :foreground orange)
   (magit-log-date            :foreground base8)
   (magit-log-graph           :foreground base7)

   ;; -------------------------------------------------------------------------
   ;; Git-gutter / diff-hl
   ;; -------------------------------------------------------------------------
   (git-gutter:added     :foreground green)
   (git-gutter:modified  :foreground yellow)
   (git-gutter:deleted   :foreground red)
   (diff-hl-add          :background (doom-darken green 0.5) :foreground green)
   (diff-hl-change       :background (doom-darken yellow 0.5) :foreground yellow)
   (diff-hl-delete       :background (doom-darken red 0.5) :foreground red)

   ;; -------------------------------------------------------------------------
   ;; Org-mode
   ;; -------------------------------------------------------------------------
   (org-block            :background base2)
   (org-block-begin-line :foreground base7 :background base2 :slant 'italic)
   (org-block-end-line   :foreground base7 :background base2 :slant 'italic)
   (org-level-1          :foreground green  :bold t)
   (org-level-2          :foreground orange :bold t)
   (org-level-3          :foreground yellow :bold t)
   (org-level-4          :foreground cyan   :bold nil)
   (org-level-5          :foreground orange :bold nil)
   (org-level-6          :foreground violet :bold nil)
   (org-level-7          :foreground magenta :bold nil)
   (org-level-8          :foreground base8  :bold nil)
   (org-headline-done    :foreground base7 :strike-through t)
   (org-todo             :foreground red    :bold t)
   (org-done             :foreground green  :bold t)
   (org-date             :foreground teal)
   (org-tag              :foreground base8 :bold nil)
   (org-priority         :foreground orange)
   (org-checkbox         :foreground teal)
   (org-table            :foreground fg-alt)
   (org-special-keyword  :foreground base8 :slant 'italic)
   (org-drawer           :foreground base7)
   (org-verbatim         :foreground yellow)
   (org-code             :foreground green)
   (org-ellipsis         :foreground base7)
   (org-link             :foreground teal :underline t)
   (org-quote            :background base2 :slant 'italic)

   ;; Org-mode agenda
   (org-agenda-date          :foreground teal)
   (org-agenda-date-today    :foreground green :bold t)
   (org-agenda-date-weekend  :foreground base8)
   (org-scheduled-today      :foreground green)
   (org-upcoming-deadline    :foreground red)
   (org-warning              :foreground yellow)

   ;; -------------------------------------------------------------------------
   ;; Markdown
   ;; -------------------------------------------------------------------------
   (markdown-header-face-1   :foreground green  :bold t)
   (markdown-header-face-2   :foreground orange :bold t)
   (markdown-header-face-3   :foreground yellow :bold t)
   (markdown-header-face-4   :foreground cyan   :bold nil)
   (markdown-code-face       :background base2)
   (markdown-inline-code-face :foreground green)
   (markdown-url-face        :foreground teal)
   (markdown-link-face       :foreground teal :underline t)
   (markdown-bold-face       :foreground fg :bold t)
   (markdown-italic-face     :foreground fg-alt :slant 'italic)

   ;; -------------------------------------------------------------------------
   ;; LSP / Eglot
   ;; -------------------------------------------------------------------------
   (lsp-ui-doc-background        :background base2)
   (lsp-ui-doc-border            :foreground teal)
   (lsp-face-highlight-textual   :background (doom-darken teal 0.45))
   (lsp-face-highlight-read      :background (doom-darken green 0.5))
   (lsp-face-highlight-write     :background (doom-darken yellow 0.5))
   (lsp-headerline-breadcrumb-path-face      :foreground base8)
   (lsp-headerline-breadcrumb-separator-face :foreground base7)
   (lsp-headerline-breadcrumb-symbols-face   :foreground teal :bold t)

   ;; -------------------------------------------------------------------------
   ;; Flycheck / Flymake
   ;; -------------------------------------------------------------------------
   (flycheck-error             :underline `(:style wave :color ,red))
   (flycheck-warning           :underline `(:style wave :color ,yellow))
   (flycheck-info              :underline `(:style wave :color ,teal))
   (flymake-error              :underline `(:style wave :color ,red))
   (flymake-warning            :underline `(:style wave :color ,yellow))
   (flymake-note               :underline `(:style wave :color ,teal))

   ;; -------------------------------------------------------------------------
   ;; Rainbow delimiters
   ;; -------------------------------------------------------------------------
   (rainbow-delimiters-depth-1-face  :foreground teal)
   (rainbow-delimiters-depth-2-face  :foreground green)
   (rainbow-delimiters-depth-3-face  :foreground yellow)
   (rainbow-delimiters-depth-4-face  :foreground cyan)
   (rainbow-delimiters-depth-5-face  :foreground orange)
   (rainbow-delimiters-depth-6-face  :foreground violet)
   (rainbow-delimiters-depth-7-face  :foreground magenta)
   (rainbow-delimiters-depth-8-face  :foreground blue)
   (rainbow-delimiters-depth-9-face  :foreground base8)
   (rainbow-delimiters-mismatched-face :foreground red :bold t)
   (rainbow-delimiters-unmatched-face  :foreground red :bold t)

   ;; -------------------------------------------------------------------------
   ;; which-key
   ;; -------------------------------------------------------------------------
   (which-key-key-face            :foreground green :bold t)
   (which-key-group-description-face :foreground teal)
   (which-key-command-description-face :foreground fg)
   (which-key-separator-face      :foreground base7)
   (which-key-local-map-description-face :foreground yellow)

   ;; -------------------------------------------------------------------------
   ;; Dired / Dirvish
   ;; -------------------------------------------------------------------------
   (dired-directory          :foreground teal :bold t)
   (dired-symlink            :foreground cyan)
   (dired-marked             :foreground yellow :bold t)
   (dired-flagged            :foreground red)
   (dired-header             :foreground green :bold t)

   ;; -------------------------------------------------------------------------
   ;; Terminal / Vterm / Eshell
   ;; -------------------------------------------------------------------------
   (term-color-black   :foreground base5  :background base5)
   (term-color-red     :foreground red    :background red)
   (term-color-green   :foreground green  :background green)
   (term-color-yellow  :foreground yellow :background yellow)
   (term-color-blue    :foreground blue   :background blue)
   (term-color-magenta :foreground magenta :background magenta)
   (term-color-cyan    :foreground cyan   :background cyan)
   (term-color-white   :foreground fg     :background fg)

   (vterm-color-black   :foreground base5  :background base5)
   (vterm-color-red     :foreground red    :background red)
   (vterm-color-green   :foreground green  :background green)
   (vterm-color-yellow  :foreground yellow :background yellow)
   (vterm-color-blue    :foreground teal   :background teal)
   (vterm-color-magenta :foreground magenta :background magenta)
   (vterm-color-cyan    :foreground cyan   :background cyan)
   (vterm-color-white   :foreground fg     :background fg)

   (eshell-prompt    :foreground green :bold t)
   (eshell-ls-directory :foreground teal :bold t)
   (eshell-ls-symlink   :foreground cyan)
   (eshell-ls-executable :foreground green)
   (eshell-ls-missing   :foreground red)

   ;; -------------------------------------------------------------------------
   ;; Doom Emacs specific
   ;; -------------------------------------------------------------------------
   (doom-modeline-bar             :background teal)
   (doom-modeline-bar-inactive    :background base5)
   (doom-modeline-buffer-file     :foreground fg :bold t)
   (doom-modeline-buffer-modified :foreground yellow)
   (doom-modeline-buffer-minor-mode :foreground base8)
   (doom-modeline-project-dir     :foreground teal)
   (doom-modeline-persp-name      :foreground orange)
   (doom-modeline-lsp-success     :foreground green)
   (doom-modeline-lsp-warning     :foreground yellow)
   (doom-modeline-lsp-error       :foreground red)
   (doom-modeline-evil-normal-state  :foreground green  :bold t)
   (doom-modeline-evil-insert-state  :foreground teal   :bold t)
   (doom-modeline-evil-visual-state  :foreground yellow :bold t)
   (doom-modeline-evil-replace-state :foreground red    :bold t)
   (doom-modeline-evil-emacs-state   :foreground violet :bold t)
   (doom-modeline-evil-motion-state  :foreground cyan   :bold t)
   (doom-modeline-evil-operator-state :foreground orange :bold t)

   ;; -------------------------------------------------------------------------
   ;; Popup / Posframe
   ;; -------------------------------------------------------------------------
   (popup-face             :background base2 :foreground fg)
   (popup-tip-face         :background base3 :foreground fg)
   (popup-menu-mouse-face  :background base4)
   (popup-menu-selection-face :background base4 :foreground green)

   ;; -------------------------------------------------------------------------
   ;; Highlight TODO / keywords
   ;; -------------------------------------------------------------------------
   (hl-todo :foreground red :bold t)

   ;; -------------------------------------------------------------------------
   ;; Paren matching
   ;; -------------------------------------------------------------------------
   (show-paren-match    :background (doom-darken teal 0.3) :foreground teal :bold t)
   (show-paren-mismatch :background (doom-darken red 0.3)  :foreground red  :bold t)

   ;; -------------------------------------------------------------------------
   ;; Avy
   ;; -------------------------------------------------------------------------
   (avy-lead-face   :background teal   :foreground base0 :bold t)
   (avy-lead-face-0 :background green  :foreground base0 :bold t)
   (avy-lead-face-1 :background yellow :foreground base0 :bold t)
   (avy-lead-face-2 :background orange :foreground base0 :bold t)

   ;; -------------------------------------------------------------------------
   ;; Meow (modal editing — since you use it!)
   ;; -------------------------------------------------------------------------
   (meow-normal-indicator    :foreground green  :bold t)
   (meow-insert-indicator    :foreground teal   :bold t)
   (meow-keypad-indicator    :foreground yellow :bold t)
   (meow-beacon-indicator    :foreground cyan   :bold t)
   (meow-motion-indicator    :foreground orange :bold t)

   ;; -------------------------------------------------------------------------
   ;; Denote
   ;; -------------------------------------------------------------------------
   (denote-faces-title       :foreground green  :bold t)
   (denote-faces-date        :foreground teal)
   (denote-faces-keywords    :foreground yellow)
   (denote-faces-signature   :foreground orange)
   (denote-faces-identifier  :foreground base8)
   (denote-faces-link        :foreground teal :underline t)

   ;; -------------------------------------------------------------------------
   ;; nov.el (EPUB reader)
   ;; -------------------------------------------------------------------------
   (nov-text-face          :foreground fg   :height 1.05)
   (nov-button-face        :foreground teal :underline t)
   (nov-header-face        :foreground green :bold t)

   ;; -------------------------------------------------------------------------
   ;; Highlight indentation
   ;; -------------------------------------------------------------------------
   (indent-guide-face           :foreground base5)
   (highlight-indent-guides-character-face :foreground base5)
   (highlight-indent-guides-stack-character-face :foreground base6)
   (highlight-indent-guides-top-character-face   :foreground teal))

  ;; ==========================================================================
  ;; Extra variables
  ;; ==========================================================================
  ;; ==========================================================================
  ;; Extra variables — each entry is (VARIABLE VALUE)
  ;; ==========================================================================
  ((ansi-color-names-vector [bg red green yellow teal magenta cyan fg])
   (left-fringe-width  8)
   (right-fringe-width 8)))

;;; doom-matccha-theme.el ends here
