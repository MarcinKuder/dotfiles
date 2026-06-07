;;; rinde-modus-theme.el --- A minimalist dark theme with modus-vivendi influence -*- lexical-binding: t -*-

;; Author: Marcin Kuder
;; Version: 1.0.0
;; Package-Requires: ((emacs "29.1"))
;; Keywords: faces, theme
;; License: Apache-2.0

;;; Commentary:

;; Rinde-Modus — a variant of Rinde built on modus-vivendi principles:
;; pure-black background, WCAG-mindful contrast, and principled semantic
;; color mapping.  Retains rinde's earthy olive-green / warm-orange palette
;; with minimal colour count.
;;
;; Key difference from rinde: variables are olive green, constants and
;; numbers are warm orange/amber.
;;
;; Palette (dark variant):
;;   bg        #000000   pure black (modus-vivendi base)
;;   bg-alt    #0f0f0f   slightly lifted background
;;   line      #1a1a1a   current-line / subtle highlight
;;   dim       #585858   subdued / deemphasised text
;;   comment   #585858   comments
;;   keyword   #8a8a8a   keywords
;;   fg        #c6c6c6   default foreground
;;   emphasis  #f0f0f0   bold / important text, functions
;;   variable  #8a9a5c   variables (olive green)
;;   string    #a08050   strings (warm amber)
;;   const     #c0956c   constants, numbers (warm orange)
;;   info      #6b7a4b   diagnostics info, type hints
;;   success   #8a9a6b   added lines, ok state
;;   warning   #c08040   warnings
;;   danger    #c05050   errors, deleted lines
;;   highlight #1a2a10   selection, search, links
;;
;; Usage:
;;   (load-theme 'rinde-modus t)
;;
;; For Doom Emacs, drop this file into ~/.doom.d/themes/ and add:
;;   (setq doom-theme 'rinde-modus)

;;; Code:

(deftheme rinde-modus "Bark — minimalist dark theme, modus-vivendi base, earthy accents.")

;;; -----------------------------------------------------------------------
;;; Palette
;;; -----------------------------------------------------------------------

(let* (
       ;; Backgrounds — pure black base à la modus-vivendi
       (bg        "#000000")
       (bg-alt    "#0f0f0f")
       (bg-popup  "#141414")
       (line      "#1a1a1a")   ; current line, very subtle raise
       (border    "#282828")   ; UI borders

       ;; Foregrounds — higher contrast than rinde, modus-influenced
       (fg        "#c6c6c6")   ; default text
       (dim       "#585858")   ; deemphasised, line-numbers
       (comment   "#585858")   ; comments
       (keyword   "#8a8a8a")   ; keywords
       (emphasis  "#f0f0f0")   ; functions, bold, emphasis
       (string    "#a08050")   ; strings — warm amber

       ;; Accent colours — olive greens + warm orange
       (variable  "#8a9a5c")   ; variables → olive green (key change)
       (const     "#c0956c")   ; constants, numbers → warm orange
       (info      "#6b7a4b")   ; info diagnostics, types — dark olive
       (success   "#8a9a6b")   ; added lines, ok — olive green
       (warning   "#c08040")   ; warnings — orange
       (danger    "#c05050")   ; errors, danger — muted red

       ;; Interactive
       (highlight "#1a2a10")   ; selection, search matches — dark forest
       (hl-fg     "#8a9a5c")   ; foreground on highlight bg — olive green
       (search-bg "#5a4830")   ; lazy search / incremental match bg — warm amber
       )

  (custom-theme-set-faces
   'rinde-modus

   ;; -----------------------------------------------------------------------
   ;; Fundamental
   ;; -----------------------------------------------------------------------
   `(default                          ((t (:background ,bg :foreground ,fg))))
   `(cursor                           ((t (:background ,emphasis))))
   `(fringe                           ((t (:background ,bg :foreground ,dim))))
   `(region                           ((t (:background ,highlight :foreground ,hl-fg :extend t))))
   `(secondary-selection              ((t (:background ,search-bg))))
   `(highlight                        ((t (:background ,line))))
   `(hl-line                          ((t (:background ,line :extend t))))
   `(match                            ((t (:background ,search-bg :foreground ,const :weight bold))))
   `(trailing-whitespace              ((t (:background ,danger))))
   `(vertical-border                  ((t (:foreground ,border))))
   `(window-divider                   ((t (:foreground ,border))))
   `(window-divider-first-pixel       ((t (:foreground ,border))))
   `(window-divider-last-pixel        ((t (:foreground ,border))))
   `(fill-column-indicator            ((t (:foreground ,line))))
   `(link                             ((t (:foreground ,info :underline t))))
   `(link-visited                     ((t (:foreground ,dim :underline t))))
   `(shadow                           ((t (:foreground ,dim))))
   `(error                            ((t (:foreground ,danger :weight bold))))
   `(warning                          ((t (:foreground ,warning :weight bold))))
   `(success                          ((t (:foreground ,success :weight bold))))

   ;; -----------------------------------------------------------------------
   ;; Line numbers
   ;; -----------------------------------------------------------------------
   `(line-number                      ((t (:background ,bg :foreground "#303030"))))
   `(line-number-current-line         ((t (:background ,line :foreground ,fg :weight bold))))
   `(line-number-major-tick           ((t (:foreground ,keyword))))
   `(line-number-minor-tick           ((t (:foreground ,dim))))

   ;; -----------------------------------------------------------------------
   ;; Mode line
   ;; -----------------------------------------------------------------------
   `(mode-line                        ((t (:background ,line :foreground ,fg :box (:line-width 1 :color ,border)))))
   `(mode-line-inactive               ((t (:background ,bg-alt :foreground ,dim :box (:line-width 1 :color ,border)))))
   `(mode-line-highlight              ((t (:foreground ,emphasis :weight bold))))
   `(mode-line-buffer-id              ((t (:foreground ,emphasis :weight bold))))

   ;; -----------------------------------------------------------------------
   ;; Header line
   ;; -----------------------------------------------------------------------
   `(header-line                      ((t (:foreground ,fg :background ,bg-alt :extend t))))
   `(header-line-highlight            ((t (:foreground ,emphasis :background ,line))))

   ;; -----------------------------------------------------------------------
   ;; Minibuffer / echo area
   ;; -----------------------------------------------------------------------
   `(minibuffer-prompt                ((t (:foreground ,info :weight bold))))
   `(menu                             ((t (:foreground ,fg :background ,bg))))

   ;; -----------------------------------------------------------------------
   ;; Font-lock (syntax highlighting)
   ;; -----------------------------------------------------------------------
   `(font-lock-comment-face           ((t (:foreground ,comment :slant italic))))
   `(font-lock-comment-delimiter-face ((t (:foreground ,comment :slant italic))))
   `(font-lock-doc-face               ((t (:foreground ,dim :slant italic))))
   `(font-lock-doc-markup-face        ((t (:foreground ,dim))))
   `(font-lock-string-face            ((t (:foreground ,string))))
   `(font-lock-keyword-face           ((t (:foreground ,keyword))))
   `(font-lock-builtin-face           ((t (:foreground ,keyword))))
   `(font-lock-function-name-face     ((t (:foreground ,emphasis :weight bold))))
   `(font-lock-function-call-face     ((t (:foreground ,emphasis :weight bold))))
   `(font-lock-variable-name-face     ((t (:foreground ,variable))))
   `(font-lock-variable-use-face      ((t (:foreground ,variable))))
   `(font-lock-type-face              ((t (:foreground ,fg))))
   `(font-lock-constant-face          ((t (:foreground ,const))))
   `(font-lock-number-face            ((t (:foreground ,const))))
   `(font-lock-preprocessor-face      ((t (:foreground ,keyword :slant italic))))
   `(font-lock-negation-char-face     ((t (:foreground ,danger))))
   `(font-lock-regexp-grouping-backslash ((t (:foreground ,const))))
   `(font-lock-regexp-grouping-construct ((t (:foreground ,const))))
   `(font-lock-escape-face            ((t (:foreground ,const))))
   `(font-lock-operator-face          ((t (:foreground ,dim))))
   `(font-lock-delimiter-face         ((t (:foreground ,dim))))
   `(font-lock-bracket-face           ((t (:foreground ,dim))))
   `(font-lock-misc-punctuation-face  ((t (:foreground ,dim))))
   `(font-lock-property-name-face     ((t (:foreground ,fg))))
   `(font-lock-property-use-face      ((t (:foreground ,fg))))
   `(font-lock-warning-face           ((t (:foreground ,warning :weight bold))))

   ;; -----------------------------------------------------------------------
   ;; Search & isearch
   ;; -----------------------------------------------------------------------
   `(isearch                          ((t (:background ,highlight :foreground ,hl-fg :weight bold))))
   `(isearch-fail                     ((t (:background ,danger :foreground ,bg :weight bold))))
   `(isearch-group-1                  ((t (:background ,search-bg :foreground ,variable))))
   `(isearch-group-2                  ((t (:background ,search-bg :foreground ,const))))
   `(lazy-highlight                   ((t (:background ,search-bg :foreground ,fg))))
   `(query-replace                    ((t (:background ,warning :foreground ,bg))))

   ;; -----------------------------------------------------------------------
   ;; Diffs
   ;; -----------------------------------------------------------------------
   `(diff-header                      ((t (:foreground ,info :weight bold))))
   `(diff-file-header                 ((t (:foreground ,emphasis :weight bold))))
   `(diff-added                       ((t (:background "#0a1f0a" :foreground ,success :extend t))))
   `(diff-removed                     ((t (:background "#1f0a0a" :foreground ,danger :extend t))))
   `(diff-changed                     ((t (:background "#1f1a0a" :foreground ,warning :extend t))))
   `(diff-refine-added                ((t (:background "#1a3a1a" :foreground ,success :weight bold))))
   `(diff-refine-removed              ((t (:background "#3a1a1a" :foreground ,danger :weight bold))))
   `(diff-context                     ((t (:foreground ,dim))))
   `(diff-hunk-header                 ((t (:foreground ,const :weight bold))))

   ;; -----------------------------------------------------------------------
   ;; Completions
   ;; -----------------------------------------------------------------------
   `(completions-common-part          ((t (:foreground ,variable :weight bold))))
   `(completions-first-difference     ((t (:foreground ,emphasis :weight bold))))
   `(completions-annotations          ((t (:foreground ,dim :slant italic))))

   ;; -----------------------------------------------------------------------
   ;; Popup / tooltip
   ;; -----------------------------------------------------------------------
   `(popup-face                       ((t (:background ,bg-popup :foreground ,fg))))
   `(popup-menu-selection-face        ((t (:background ,highlight :foreground ,hl-fg))))
   `(tooltip                          ((t (:background ,bg-popup :foreground ,fg))))
   `(corfu-default                    ((t (:background ,bg-popup :foreground ,fg))))
   `(corfu-current                    ((t (:background ,highlight :foreground ,hl-fg))))
   `(corfu-border                     ((t (:background ,border))))
   `(corfu-annotations                ((t (:foreground ,dim :slant italic))))
   `(corfu-deprecated                 ((t (:foreground ,dim :strike-through t))))
   `(company-tooltip                  ((t (:background ,bg-popup :foreground ,fg))))
   `(company-tooltip-selection        ((t (:background ,highlight :foreground ,hl-fg))))
   `(company-tooltip-common           ((t (:foreground ,variable :weight bold))))
   `(company-tooltip-annotation       ((t (:foreground ,dim :slant italic))))
   `(company-scrollbar-bg             ((t (:background ,bg-alt))))
   `(company-scrollbar-fg             ((t (:background ,dim))))

   ;; -----------------------------------------------------------------------
   ;; Vertico / Consult / Marginalia
   ;; -----------------------------------------------------------------------
   `(vertico-current                  ((t (:background ,line :extend t))))
   `(vertico-group-title              ((t (:foreground ,dim :slant italic))))
   `(vertico-group-separator          ((t (:foreground ,border :strike-through t))))
   `(marginalia-documentation         ((t (:foreground ,dim :slant italic))))
   `(marginalia-file-priv-dir         ((t (:foreground ,info))))
   `(marginalia-file-priv-exec        ((t (:foreground ,success))))
   `(marginalia-type                  ((t (:foreground ,info))))
   `(consult-preview-match            ((t (:background ,search-bg :foreground ,fg))))
   `(consult-highlight-match          ((t (:background ,highlight :foreground ,hl-fg))))

   ;; -----------------------------------------------------------------------
   ;; Orderless
   ;; -----------------------------------------------------------------------
   `(orderless-match-face-0           ((t (:foreground ,variable :weight bold))))
   `(orderless-match-face-1           ((t (:foreground ,const :weight bold))))
   `(orderless-match-face-2           ((t (:foreground ,success :weight bold))))
   `(orderless-match-face-3           ((t (:foreground ,warning :weight bold))))

   ;; -----------------------------------------------------------------------
   ;; Flycheck / Flymake
   ;; -----------------------------------------------------------------------
   `(flycheck-error                   ((t (:underline (:style wave :color ,danger)))))
   `(flycheck-warning                 ((t (:underline (:style wave :color ,warning)))))
   `(flycheck-info                    ((t (:underline (:style wave :color ,info)))))
   `(flycheck-fringe-error            ((t (:foreground ,danger))))
   `(flycheck-fringe-warning          ((t (:foreground ,warning))))
   `(flycheck-fringe-info             ((t (:foreground ,info))))
   `(flycheck-posframe-background-face ((t (:background ,bg-popup))))
   `(flycheck-posframe-face           ((t (:background ,bg-popup :foreground ,fg))))
   `(flycheck-posframe-info-face      ((t (:foreground ,info :background ,bg-popup))))
   `(flycheck-posframe-warning-face   ((t (:foreground ,warning :background ,bg-popup))))
   `(flycheck-posframe-error-face     ((t (:foreground ,danger :background ,bg-popup))))
   `(flymake-error                    ((t (:underline (:style wave :color ,danger)))))
   `(flymake-warning                  ((t (:underline (:style wave :color ,warning)))))
   `(flymake-note                     ((t (:underline (:style wave :color ,info)))))

   ;; -----------------------------------------------------------------------
   ;; LSP (eglot & lsp-mode)
   ;; -----------------------------------------------------------------------
   `(eglot-diagnostic-tag-unnecessary-face ((t (:foreground ,dim :underline (:style wave :color ,dim)))))
   `(eglot-diagnostic-tag-deprecated-face  ((t (:foreground ,dim :strike-through t))))
   `(lsp-face-highlight-textual       ((t (:background ,line))))
   `(lsp-face-highlight-read          ((t (:background ,line))))
   `(lsp-face-highlight-write         ((t (:background ,line :underline t))))
   `(lsp-headerline-breadcrumb-path-face           ((t (:foreground ,dim))))
   `(lsp-headerline-breadcrumb-symbols-face        ((t (:foreground ,fg :weight bold))))
   `(lsp-headerline-breadcrumb-separator-face      ((t (:foreground ,dim))))
   `(lsp-ui-doc-background            ((t (:background ,bg-popup))))
   `(lsp-ui-sideline-code-action      ((t (:foreground ,const))))

   ;; -----------------------------------------------------------------------
   ;; Git / Magit / diff-hl
   ;; -----------------------------------------------------------------------
   `(magit-section-heading            ((t (:foreground ,emphasis :weight bold))))
   `(magit-section-highlight          ((t (:background ,line))))
   `(magit-diff-added                 ((t (:background "#0a1f0a" :foreground ,success :extend t))))
   `(magit-diff-removed               ((t (:background "#1f0a0a" :foreground ,danger :extend t))))
   `(magit-diff-added-highlight       ((t (:background "#1a3a1a" :foreground ,success :extend t))))
   `(magit-diff-removed-highlight     ((t (:background "#3a1a1a" :foreground ,danger :extend t))))
   `(magit-diff-context               ((t (:foreground ,dim :extend t))))
   `(magit-diff-context-highlight     ((t (:background ,line :foreground ,fg :extend t))))
   `(magit-diff-hunk-heading          ((t (:foreground ,const :weight bold))))
   `(magit-diff-hunk-heading-highlight ((t (:background ,line :foreground ,const :weight bold))))
   `(magit-hash                       ((t (:foreground ,dim))))
   `(magit-branch-local               ((t (:foreground ,variable))))
   `(magit-branch-remote              ((t (:foreground ,success))))
   `(magit-tag                        ((t (:foreground ,const))))
   `(magit-process-ok                 ((t (:foreground ,success :weight bold))))
   `(magit-process-ng                 ((t (:foreground ,danger :weight bold))))
   `(diff-hl-insert                   ((t (:background ,success :foreground ,success))))
   `(diff-hl-delete                   ((t (:background ,danger :foreground ,danger))))
   `(diff-hl-change                   ((t (:background ,info :foreground ,info))))
   `(diff-hl-margin-insert            ((t (:foreground ,success :background "#0a1f0a"))))
   `(diff-hl-margin-delete            ((t (:foreground ,danger :background "#1f0a0a"))))
   `(diff-hl-margin-change            ((t (:foreground ,info :background "#0a1f1f"))))

   ;; -----------------------------------------------------------------------
   ;; Org-mode
   ;; -----------------------------------------------------------------------
   `(org-level-1                      ((t (:foreground ,emphasis :weight bold :height 1.15))))
   `(org-level-2                      ((t (:foreground ,fg :weight bold :height 1.1))))
   `(org-level-3                      ((t (:foreground ,fg :weight bold :height 1.05))))
   `(org-level-4                      ((t (:foreground ,dim :weight bold))))
   `(org-level-5                      ((t (:foreground ,dim))))
   `(org-level-6                      ((t (:foreground ,dim))))
   `(org-level-7                      ((t (:foreground ,dim))))
   `(org-level-8                      ((t (:foreground ,dim))))
   `(org-document-title               ((t (:foreground ,emphasis :weight bold :height 1.3))))
   `(org-document-info-keyword        ((t (:foreground ,dim))))
   `(org-document-info                ((t (:foreground ,fg))))
   `(org-date                         ((t (:foreground ,info :underline t))))
   `(org-tag                          ((t (:foreground ,dim :weight normal))))
   `(org-todo                         ((t (:foreground ,danger :weight bold))))
   `(org-done                         ((t (:foreground ,success :weight bold))))
   `(org-headline-done                ((t (:foreground ,dim :strike-through t))))
   `(org-special-keyword              ((t (:foreground ,dim))))
   `(org-property-value               ((t (:foreground ,const))))
   `(org-drawer                       ((t (:foreground ,dim))))
   `(org-indent                        ((t (:inherit org-hide))))
   `(org-hide                         ((t (:foreground ,bg :background unspecified))))
   `(org-ellipsis                     ((t (:foreground ,dim :weight bold))))
   `(org-block                        ((t (:background ,bg-alt :extend t))))
   `(org-block-begin-line             ((t (:background ,bg-alt :foreground ,dim :extend t))))
   `(org-block-end-line               ((t (:background ,bg-alt :foreground ,dim :extend t))))
   `(org-code                         ((t (:foreground ,string :background ,bg-alt))))
   `(org-verbatim                     ((t (:foreground ,const :background ,bg-alt))))
   `(org-link                         ((t (:foreground ,info :underline t))))
   `(org-footnote                     ((t (:foreground ,dim :underline t))))
   `(org-table                        ((t (:foreground ,fg))))
   `(org-formula                      ((t (:foreground ,const))))
   `(org-column                       ((t (:background ,line))))
   `(org-column-title                 ((t (:background ,line :foreground ,emphasis :weight bold))))
   `(org-checkbox                     ((t (:foreground ,keyword :weight bold))))
   `(org-checkbox-statistics-done     ((t (:foreground ,success))))
   `(org-checkbox-statistics-todo     ((t (:foreground ,warning))))
   `(org-priority                     ((t (:foreground ,warning))))
   `(org-scheduled                    ((t (:foreground ,success))))
   `(org-scheduled-today              ((t (:foreground ,emphasis :weight bold))))
   `(org-scheduled-previously         ((t (:foreground ,warning))))
   `(org-upcoming-deadline            ((t (:foreground ,warning))))
   `(org-imminent-deadline            ((t (:foreground ,danger :weight bold))))
   `(org-agenda-date                  ((t (:foreground ,info :weight bold))))
   `(org-agenda-date-today            ((t (:foreground ,emphasis :weight bold :underline t))))
   `(org-agenda-date-weekend          ((t (:foreground ,dim))))
   `(org-agenda-structure             ((t (:foreground ,keyword :weight bold))))
   `(org-agenda-done                  ((t (:foreground ,success))))
   `(org-agenda-dimmed-todo-face      ((t (:foreground ,dim))))

   ;; -----------------------------------------------------------------------
   ;; Markdown
   ;; -----------------------------------------------------------------------
   `(markdown-header-face-1           ((t (:foreground ,emphasis :weight bold :height 1.15))))
   `(markdown-header-face-2           ((t (:foreground ,fg :weight bold :height 1.1))))
   `(markdown-header-face-3           ((t (:foreground ,fg :weight bold :height 1.05))))
   `(markdown-header-face-4           ((t (:foreground ,dim :weight bold))))
   `(markdown-code-face               ((t (:background ,bg-alt :extend t))))
   `(markdown-inline-code-face        ((t (:foreground ,string :background ,bg-alt))))
   `(markdown-link-face               ((t (:foreground ,info :underline t))))
   `(markdown-url-face                ((t (:foreground ,dim :underline t))))
   `(markdown-bold-face               ((t (:foreground ,emphasis :weight bold))))
   `(markdown-italic-face             ((t (:foreground ,fg :slant italic))))
   `(markdown-markup-face             ((t (:foreground ,dim))))
   `(markdown-list-face               ((t (:foreground ,keyword))))

   ;; -----------------------------------------------------------------------
   ;; Treemacs / Dired / Dirvish
   ;; -----------------------------------------------------------------------
   `(treemacs-root-face               ((t (:foreground ,emphasis :weight bold))))
   `(treemacs-directory-face          ((t (:foreground ,fg))))
   `(treemacs-file-face               ((t (:foreground ,fg))))
   `(treemacs-git-added-face          ((t (:foreground ,success))))
   `(treemacs-git-modified-face       ((t (:foreground ,warning))))
   `(treemacs-git-deleted-face        ((t (:foreground ,danger))))
   `(treemacs-git-untracked-face      ((t (:foreground ,dim))))
   `(dired-directory                  ((t (:foreground ,info :weight bold))))
   `(dired-symlink                    ((t (:foreground ,const :slant italic))))
   `(dired-marked                     ((t (:foreground ,warning :weight bold))))
   `(dired-flagged                    ((t (:foreground ,danger :weight bold))))
   `(dired-header                     ((t (:foreground ,emphasis :weight bold))))
   `(dired-ignored                    ((t (:foreground ,dim))))
   `(dired-mark                       ((t (:foreground ,const :weight bold))))
   `(dired-perm-write                 ((t (:foreground ,fg))))
   `(dired-warning                    ((t (:foreground ,danger))))
   ;; diredfl (used by Doom's dired module)
   `(diredfl-dir-name                 ((t (:foreground ,info :weight bold))))
   `(diredfl-dir-heading              ((t (:foreground ,emphasis :weight bold :background ,bg-alt))))
   `(diredfl-file-name                ((t (:foreground ,fg))))
   `(diredfl-file-suffix              ((t (:foreground ,dim))))
   `(diredfl-symlink                  ((t (:foreground ,const :slant italic))))
   `(diredfl-no-priv                  ((t (:foreground ,dim))))
   `(diredfl-dir-priv                 ((t (:foreground ,info))))
   `(diredfl-read-priv                ((t (:foreground ,fg))))
   `(diredfl-write-priv               ((t (:foreground ,warning))))
   `(diredfl-exec-priv                ((t (:foreground ,success))))
   `(diredfl-rare-priv                ((t (:foreground ,const))))
   `(diredfl-other-priv               ((t (:foreground ,const))))
   `(diredfl-link-priv                ((t (:foreground ,info))))
   `(diredfl-number                   ((t (:foreground ,const))))
   `(diredfl-date-time                ((t (:foreground ,dim))))
   `(diredfl-deletion                 ((t (:foreground ,danger :weight bold :strike-through t))))
   `(diredfl-deletion-file-name       ((t (:foreground ,danger :strike-through t))))
   `(diredfl-flag-mark                ((t (:foreground ,warning :weight bold))))
   `(diredfl-flag-mark-line           ((t (:background ,line :extend t))))
   `(diredfl-tagged-autofile-name     ((t (:foreground ,dim))))
   `(diredfl-autofile-name            ((t (:foreground ,fg))))
   `(diredfl-compressed-file-name     ((t (:foreground ,dim))))
   `(diredfl-compressed-file-suffix   ((t (:foreground ,dim))))
   `(diredfl-ignored-file-name        ((t (:foreground ,dim))))
   ;; dirvish
   `(dirvish-hl-line                  ((t (:background ,line :extend t))))
   `(dirvish-subtree-guide            ((t (:foreground ,border))))
   `(dirvish-subtree-state            ((t (:foreground ,dim))))

   ;; -----------------------------------------------------------------------
   ;; Treesitter highlight groups (Emacs 29+)
   ;; -----------------------------------------------------------------------
   `(treesit-font-lock-face           ((t (:inherit default))))

   ;; -----------------------------------------------------------------------
   ;; hl-todo
   ;; -----------------------------------------------------------------------
   `(hl-todo                          ((t (:foreground ,danger :weight bold :slant italic))))

   ;; -----------------------------------------------------------------------
   ;; Ansi colors
   ;; -----------------------------------------------------------------------
   `(ansi-color-black                 ((t (:foreground ,bg))))
   `(ansi-color-red                   ((t (:foreground ,danger))))
   `(ansi-color-green                 ((t (:foreground ,success))))
   `(ansi-color-yellow                ((t (:foreground ,const))))
   `(ansi-color-blue                  ((t (:foreground ,variable))))
   `(ansi-color-magenta               ((t (:foreground ,info))))
   `(ansi-color-cyan                  ((t (:foreground ,info))))
   `(ansi-color-white                 ((t (:foreground ,emphasis))))
   `(ansi-color-bright-black          ((t (:foreground ,dim))))
   `(ansi-color-bright-red            ((t (:foreground ,danger))))
   `(ansi-color-bright-green          ((t (:foreground ,success))))
   `(ansi-color-bright-yellow         ((t (:foreground ,const))))
   `(ansi-color-bright-blue           ((t (:foreground ,variable))))
   `(ansi-color-bright-magenta        ((t (:foreground ,info))))
   `(ansi-color-bright-cyan           ((t (:foreground ,info))))
   `(ansi-color-bright-white          ((t (:foreground ,emphasis))))

   ;; -----------------------------------------------------------------------
   ;; Tab line
   ;; -----------------------------------------------------------------------
   `(tab-line                         ((t (:background ,bg-alt))))
   `(tab-bar                          ((t (:background ,bg-alt))))

   ;; -----------------------------------------------------------------------
   ;; Message (mu4e compose)
   ;; -----------------------------------------------------------------------
   `(message-header-name              ((t (:foreground ,keyword :weight bold :family "Victor Mono"))))
   `(message-header-to                ((t (:foreground ,fg :family "Victor Mono"))))
   `(message-header-cc                ((t (:foreground ,fg :family "Victor Mono"))))
   `(message-header-subject           ((t (:foreground ,emphasis :weight bold :family "Victor Mono"))))
   `(message-header-other             ((t (:foreground ,dim :family "Victor Mono"))))
   `(message-header-xheader           ((t (:foreground ,dim :family "Victor Mono"))))
   `(message-separator                ((t (:foreground ,border))))
   `(message-cited-text-1             ((t (:foreground ,dim))))
   `(message-cited-text-2             ((t (:foreground ,dim))))
   `(message-cited-text-3             ((t (:foreground ,dim))))
   `(message-cited-text-4             ((t (:foreground ,dim))))
   `(message-mml                      ((t (:foreground ,success))))

   ;; -----------------------------------------------------------------------
   ;; mu4e
   ;; -----------------------------------------------------------------------
   `(mu4e-header-highlight-face       ((t (:background ,line :extend t))))
   `(mu4e-header-key-face             ((t (:foreground ,keyword :weight bold :family "Victor Mono"))))
   `(mu4e-header-value-face           ((t (:foreground ,fg :family "Victor Mono"))))
   `(mu4e-header-marks-face           ((t (:foreground ,dim))))
   `(mu4e-unread-face                 ((t (:foreground ,emphasis :weight bold))))
   `(mu4e-flagged-face                ((t (:foreground ,const))))
   `(mu4e-replied-face                ((t (:foreground ,dim))))
   `(mu4e-forwarded-face              ((t (:foreground ,dim))))
   `(mu4e-trashed-face                ((t (:foreground ,dim :strike-through t))))
   `(mu4e-draft-face                  ((t (:foreground ,warning))))
   `(mu4e-title-face                  ((t (:foreground ,emphasis :weight bold))))
   `(mu4e-context-face                ((t (:foreground ,info :weight bold))))
   `(mu4e-contact-face                ((t (:foreground ,string :family "Victor Mono"))))
   `(mu4e-compose-header-face         ((t (:foreground ,dim :slant italic))))
   `(mu4e-compose-separator-face      ((t (:foreground ,border))))
   `(mu4e-highlight-face              ((t (:foreground ,variable))))
   `(mu4e-region-code                 ((t (:background ,bg-alt))))
   `(mu4e-link-face                   ((t (:foreground ,info :underline t))))

   ;; -----------------------------------------------------------------------
   ;; Elfeed (RSS)
   ;; -----------------------------------------------------------------------
   `(elfeed-search-feed-face          ((t (:foreground ,info))))
   `(elfeed-search-tag-face           ((t (:foreground ,const))))
   `(elfeed-search-title-face         ((t (:foreground ,fg))))
   `(elfeed-search-unread-title-face  ((t (:foreground ,emphasis :weight bold))))
   `(elfeed-search-date-face          ((t (:foreground ,dim))))
   `(elfeed-search-unread-count-face  ((t (:foreground ,variable))))
   `(elfeed-log-error-level-face      ((t (:foreground ,danger))))
   `(elfeed-log-warn-level-face       ((t (:foreground ,warning))))
   `(elfeed-log-info-level-face       ((t (:foreground ,info))))

   ;; -----------------------------------------------------------------------
   ;; Eldoc
   ;; -----------------------------------------------------------------------
   `(elisp-short-fn-in-doc-face ((t (:foreground ,emphasis :weight bold :underline t))))

   ;; -----------------------------------------------------------------------
   ;; Meow modal editing
   ;; -----------------------------------------------------------------------
   `(meow-normal-indicator            ((t (:foreground ,variable :weight bold))))
   `(meow-insert-indicator            ((t (:foreground ,success :weight bold))))
   `(meow-motion-indicator            ((t (:foreground ,const :weight bold))))
   `(meow-keypad-indicator            ((t (:foreground ,danger :weight bold))))
   `(meow-beacon-indicator            ((t (:foreground ,warning :weight bold))))
   `(meow-search-highlight            ((t (:background ,search-bg :foreground ,variable))))
   `(meow-search-indicator            ((t (:foreground ,variable :weight bold))))

   ;; -----------------------------------------------------------------------
   ;; Which-key
   ;; -----------------------------------------------------------------------
   `(which-key-key-face               ((t (:foreground ,variable :weight bold))))
   `(which-key-separator-face         ((t (:foreground ,dim))))
   `(which-key-command-description-face ((t (:foreground ,fg))))
   `(which-key-group-description-face  ((t (:foreground ,const :weight bold))))
   `(which-key-local-map-description-face ((t (:foreground ,const))))
   `(which-key-posframe               ((t (:background ,bg-popup))))
   `(which-key-posframe-border        ((t (:background ,border))))

   ;; -----------------------------------------------------------------------
   ;; Doom Emacs specific
   ;; -----------------------------------------------------------------------
   `(doom-modeline-bar                ((t (:background ,dim))))
   `(doom-modeline-bar-inactive       ((t (:background ,border))))
   `(doom-modeline-buffer-file        ((t (:foreground ,fg :weight bold))))
   `(doom-modeline-buffer-modified    ((t (:foreground ,warning :weight bold))))
   `(doom-modeline-buffer-major-mode  ((t (:foreground ,info :weight bold))))
   `(doom-modeline-buffer-path        ((t (:foreground ,dim))))
   `(doom-modeline-project-dir        ((t (:foreground ,dim))))
   `(doom-modeline-error              ((t (:foreground ,danger))))
   `(doom-modeline-warning            ((t (:foreground ,warning))))
   `(doom-modeline-info               ((t (:foreground ,success))))
   `(doom-modeline-lsp-running        ((t (:foreground ,info :slant italic))))
   `(doom-modeline-panel              ((t (:foreground ,hl-fg :background ,highlight))))
   `(doom-modeline-battery-critical   ((t (:foreground ,danger))))
   `(doom-modeline-battery-warning    ((t (:foreground ,warning))))
   `(doom-modeline-battery-charging   ((t (:foreground ,dim))))
   `(doom-modeline-battery-normal     ((t (:foreground ,success))))
   `(doom-modeline-battery-full       ((t (:foreground ,success))))
   `(doom-themes-visual-bell          ((t (:background ,danger))))
   `(+workspace-tab-selected-face     ((t (:background ,highlight :foreground ,hl-fg :weight bold))))
   `(+workspace-tab-face              ((t (:background ,bg-alt :foreground ,dim))))
   ;; solaire-mode (Doom uses this for "unreal" buffers)
   `(solaire-default-face             ((t (:background ,bg-alt :foreground ,fg))))
   `(solaire-fringe-face              ((t (:background ,bg-alt :foreground ,dim))))
   `(solaire-hl-line-face             ((t (:background ,border :extend t))))
   `(solaire-mode-line-face           ((t (:background ,border :foreground ,fg :box (:line-width 1 :color ,border)))))
   `(solaire-mode-line-inactive-face  ((t (:background ,bg-alt :foreground ,dim :box (:line-width 1 :color ,border)))))
   `(solaire-org-hide-face            ((t (:foreground ,bg-alt :background unspecified))))
   ;; doom-dashboard
   `(doom-dashboard-banner            ((t (:foreground ,dim))))
   `(doom-dashboard-menu-title        ((t (:foreground ,variable :weight bold))))
   `(doom-dashboard-menu-desc         ((t (:foreground ,dim))))
   `(doom-dashboard-footer-icon       ((t (:foreground ,dim))))
   `(doom-dashboard-footer            ((t (:foreground ,dim :slant italic))))
   `(doom-dashboard-loaded            ((t (:foreground ,dim))))

   ;; -----------------------------------------------------------------------
   ;; Parentheses / rainbow-delimiters
   ;; -----------------------------------------------------------------------
   `(show-paren-match                 ((t (:background ,search-bg :foreground ,variable :weight bold))))
   `(show-paren-mismatch              ((t (:background ,danger :foreground ,bg :weight bold))))
   `(rainbow-delimiters-depth-1-face  ((t (:foreground ,fg))))
   `(rainbow-delimiters-depth-2-face  ((t (:foreground ,variable))))
   `(rainbow-delimiters-depth-3-face  ((t (:foreground ,const))))
   `(rainbow-delimiters-depth-4-face  ((t (:foreground ,success))))
   `(rainbow-delimiters-depth-5-face  ((t (:foreground ,keyword))))
   `(rainbow-delimiters-depth-6-face  ((t (:foreground ,dim))))
   `(rainbow-delimiters-depth-7-face  ((t (:foreground ,fg))))
   `(rainbow-delimiters-depth-8-face  ((t (:foreground ,variable))))
   `(rainbow-delimiters-depth-9-face  ((t (:foreground ,const))))
   `(rainbow-delimiters-unmatched-face ((t (:foreground ,danger :weight bold))))

   ;; -----------------------------------------------------------------------
   ;; Whitespace
   ;; -----------------------------------------------------------------------
   `(whitespace-space                 ((t (:foreground ,line))))
   `(whitespace-tab                   ((t (:foreground ,line))))
   `(whitespace-newline               ((t (:foreground ,line))))
   `(whitespace-trailing              ((t (:background ,danger :foreground ,danger))))

   ;; -----------------------------------------------------------------------
   ;; Pulse / pulse highlight
   ;; -----------------------------------------------------------------------
   `(pulse-highlight-start-face       ((t (:background ,search-bg))))
   `(pulse-highlight-face             ((t (:background ,search-bg))))

   ;; -----------------------------------------------------------------------
   ;; Term / vterm / eshell
   ;; -----------------------------------------------------------------------
   `(vterm-color-default              ((t (:foreground ,fg :background ,bg))))
   `(vterm-color-black                ((t (:foreground ,bg :background ,bg))))
   `(vterm-color-red                  ((t (:foreground ,danger :background ,danger))))
   `(vterm-color-green                ((t (:foreground ,success :background ,success))))
   `(vterm-color-yellow               ((t (:foreground ,const :background ,const))))
   `(vterm-color-blue                 ((t (:foreground ,variable :background ,variable))))
   `(vterm-color-magenta              ((t (:foreground ,info :background ,info))))
   `(vterm-color-cyan                 ((t (:foreground ,info :background ,info))))
   `(vterm-color-white                ((t (:foreground ,emphasis :background ,emphasis))))
   `(eshell-prompt                    ((t (:foreground ,variable :weight bold))))
   `(eshell-ls-directory              ((t (:foreground ,info :weight bold))))
   `(eshell-ls-symlink                ((t (:foreground ,const :slant italic))))
   `(eshell-ls-executable             ((t (:foreground ,success))))
   `(eshell-ls-missing                ((t (:foreground ,danger))))

   ;; -----------------------------------------------------------------------
   ;; Button / custom widgets
   ;; -----------------------------------------------------------------------
   `(button                           ((t (:foreground ,info :underline t))))
   `(custom-button                    ((t (:background ,bg-alt :foreground ,fg :box (:line-width 2 :color ,border)))))
   `(custom-button-mouse              ((t (:background ,line :foreground ,emphasis :box (:line-width 2 :color ,border)))))
   `(custom-button-pressed            ((t (:background ,highlight :foreground ,hl-fg))))
   `(custom-variable-tag              ((t (:foreground ,variable :weight bold))))
   `(custom-group-tag                 ((t (:foreground ,emphasis :weight bold :height 1.1))))
   `(custom-state                     ((t (:foreground ,success))))
   `(widget-field                     ((t (:background ,bg-alt :foreground ,fg :box (:line-width 1 :color ,border)))))

   ;; -----------------------------------------------------------------------
   ;; vi-tilde-fringe
   ;; -----------------------------------------------------------------------
   `(vi-tilde-fringe-face             ((t (:foreground ,border))))

   ;; -----------------------------------------------------------------------
   ;; Multiple cursors
   ;; -----------------------------------------------------------------------
   `(mc/cursor-face                   ((t (:background ,emphasis :foreground ,bg))))
   `(mc/cursor-bar-face               ((t (:background ,emphasis :height 1))))
   `(mc/region-face                   ((t (:background ,highlight :foreground ,hl-fg))))

   ;; -----------------------------------------------------------------------
   ;; Yasnippet
   ;; -----------------------------------------------------------------------
   `(yas-field-highlight-face         ((t (:background ,line :extend t))))

   ;; -----------------------------------------------------------------------
   ;; Undo (vundo)
   ;; -----------------------------------------------------------------------
   `(vundo-node                       ((t (:foreground ,variable))))
   `(vundo-stem                       ((t (:foreground ,border))))
   `(vundo-highlight                  ((t (:foreground ,emphasis :weight bold))))
   `(vundo-saved                      ((t (:foreground ,success))))
   `(vundo-last-saved                 ((t (:foreground ,success :weight bold))))

   ;; -----------------------------------------------------------------------
   ;; PDF tools
   ;; -----------------------------------------------------------------------
   `(pdf-isearch-match                ((t (:background ,highlight :foreground ,hl-fg))))
   `(pdf-isearch-lazy                 ((t (:background ,search-bg :foreground ,fg))))

   ;; -----------------------------------------------------------------------
   ;; EMMS
   ;; -----------------------------------------------------------------------
   `(emms-playlist-track-face         ((t (:foreground ,fg))))
   `(emms-playlist-selected-face      ((t (:foreground ,emphasis :weight bold))))

   ;; -----------------------------------------------------------------------
   ;; LaTeX / AUCTeX
   ;; -----------------------------------------------------------------------
   `(font-latex-bold-face             ((t (:foreground ,emphasis :weight bold))))
   `(font-latex-italic-face           ((t (:foreground ,fg :slant italic))))
   `(font-latex-math-face             ((t (:foreground ,const))))
   `(font-latex-string-face           ((t (:foreground ,string))))
   `(font-latex-warning-face          ((t (:foreground ,warning))))
   `(font-latex-sectioning-0-face     ((t (:foreground ,emphasis :weight bold :height 1.3))))
   `(font-latex-sectioning-1-face     ((t (:foreground ,emphasis :weight bold :height 1.2))))
   `(font-latex-sectioning-2-face     ((t (:foreground ,emphasis :weight bold :height 1.15))))
   `(font-latex-sectioning-3-face     ((t (:foreground ,fg :weight bold :height 1.1))))
   `(font-latex-sectioning-4-face     ((t (:foreground ,fg :weight bold :height 1.05))))
   `(font-latex-sectioning-5-face     ((t (:foreground ,fg :weight bold))))
   `(font-latex-script-char-face      ((t (:foreground ,const))))
   `(font-latex-sedate-face           ((t (:foreground ,keyword))))
   `(font-latex-verbatim-face         ((t (:foreground ,string :background ,bg-alt))))

   ;; -----------------------------------------------------------------------
   ;; Transient (Magit popups)
   ;; -----------------------------------------------------------------------
   `(transient-key                    ((t (:foreground ,variable :weight bold))))
   `(transient-heading                ((t (:foreground ,emphasis :weight bold))))
   `(transient-argument               ((t (:foreground ,const :weight bold))))
   `(transient-value                  ((t (:foreground ,const))))
   `(transient-inactive-argument      ((t (:foreground ,dim))))
   `(transient-inactive-value         ((t (:foreground ,dim))))
   `(transient-unreachable            ((t (:foreground ,dim))))
   `(transient-unreachable-key        ((t (:foreground ,dim))))
   `(transient-enabled-suffix         ((t (:background "#0a1f0a" :foreground ,success))))
   `(transient-disabled-suffix        ((t (:background "#1f0a0a" :foreground ,danger))))

   ;; -----------------------------------------------------------------------
   ;; Ediff
   ;; -----------------------------------------------------------------------
   `(ediff-current-diff-A             ((t (:background "#1f0a0a" :extend t))))
   `(ediff-current-diff-B             ((t (:background "#0a1f0a" :extend t))))
   `(ediff-current-diff-C             ((t (:background "#1f1a0a" :extend t))))
   `(ediff-fine-diff-A                ((t (:background "#3a1a1a" :weight bold :extend t))))
   `(ediff-fine-diff-B                ((t (:background "#1a3a1a" :weight bold :extend t))))
   `(ediff-fine-diff-C                ((t (:background "#3a2a0a" :weight bold :extend t))))
   `(ediff-even-diff-A                ((t (:background ,bg-alt :extend t))))
   `(ediff-even-diff-B                ((t (:background ,bg-alt :extend t))))
   `(ediff-even-diff-C                ((t (:background ,bg-alt :extend t))))
   `(ediff-odd-diff-A                 ((t (:background ,line :extend t))))
   `(ediff-odd-diff-B                 ((t (:background ,line :extend t))))
   `(ediff-odd-diff-C                 ((t (:background ,line :extend t))))

   ;; -----------------------------------------------------------------------
   ;; Compilation
   ;; -----------------------------------------------------------------------
   `(compilation-error                ((t (:foreground ,danger :weight bold))))
   `(compilation-warning              ((t (:foreground ,warning :weight bold))))
   `(compilation-info                 ((t (:foreground ,info))))
   `(compilation-line-number          ((t (:foreground ,dim))))
   `(compilation-column-number        ((t (:foreground ,dim))))
   `(compilation-mode-line-exit       ((t (:foreground ,success :weight bold))))
   `(compilation-mode-line-fail       ((t (:foreground ,danger :weight bold))))
   `(compilation-mode-line-run        ((t (:foreground ,info :weight bold))))

   ;; -----------------------------------------------------------------------
   ;; Outline
   ;; -----------------------------------------------------------------------
   `(outline-1                        ((t (:foreground ,emphasis :weight bold :height 1.15))))
   `(outline-2                        ((t (:foreground ,fg :weight bold :height 1.1))))
   `(outline-3                        ((t (:foreground ,fg :weight bold :height 1.05))))
   `(outline-4                        ((t (:foreground ,dim :weight bold))))
   `(outline-5                        ((t (:foreground ,dim))))
   `(outline-6                        ((t (:foreground ,dim))))
   `(outline-7                        ((t (:foreground ,dim))))
   `(outline-8                        ((t (:foreground ,dim))))

   ;; -----------------------------------------------------------------------
   ;; Help
   ;; -----------------------------------------------------------------------
   `(help-key-binding                 ((t (:foreground ,variable :background ,bg-alt :box (:line-width -1 :color ,border)))))

   ;; -----------------------------------------------------------------------
   ;; Embark
   ;; -----------------------------------------------------------------------
   `(embark-keybinding                ((t (:foreground ,variable :weight bold)))))  ; end custom-theme-set-faces

  ;; -----------------------------------------------------------------------
  ;; Variables
  ;; -----------------------------------------------------------------------
  (custom-theme-set-variables
   'rinde-modus
   '(ansi-color-names-vector
     ["#000000" "#c05050" "#8a9a6b" "#c0956c"
      "#8a9a5c" "#6b7a4b"  "#6b7a4b" "#c6c6c6"])
   '(pdf-view-midnight-colors '("#c6c6c6" . "#000000"))))

;;;###autoload
(when (and (boundp 'custom-theme-load-path) load-file-name)
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'rinde-modus)

;;; rinde-modus-theme.el ends here
