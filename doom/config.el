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
;; (setq doom-theme 'doom-one)

;; kanagawa theme
;; (add-to-list 'load-path (concat user-emacs-directory "themes"))
;; (require 'kanagawa-themes)
;; (setq doom-theme 'kanagawa-wave)

;; theme
(setq doom-theme 'doom-tomorrow-night)

(setq doom-font (font-spec :family "Maple Mono NF" :size 16))


;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
;; (setq display-line-numbers-type 'relative)

;; IF YOU USE `ORG' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org")

;; denote
;; (add-hook 'dired-mode-hook #'denote-dired-mode)
;; (after! denote
;; (setq denote-dired-directories
;; (list denote-directory
;; (expand-file-name "~/Documents/notes")))
;; (add-hook 'dired-mode-hook #'denote-dired-mode-in-directories))


;; Remember that the website version of this manual shows the latest
;; developments, which may not be available in the package you are
;; using.  Instead of copying from the web site, refer to the version
;; of the documentation that comes with your package.  Evaluate:
;;
;;     (info "(denote) Sample configuration")
(use-package denote
  :ensure t
  :hook
  ( ;; If you use Markdown or plain text files, then you want to make
   ;; the Denote links clickable (Org renders links as buttons right
   ;; away)
   (text-mode . denote-fontify-links-mode-maybe)
   ;; Apply colours to Denote names in Dired.  This applies to all
   ;; directories.  Check `denote-dired-directories' for the specific
   ;; directories you may prefer instead.  Then, instead of
   ;; `denote-dired-mode', use `denote-dired-mode-in-directories'.
   (dired-mode . denote-dired-mode))

  :bind
  ;; Denote DOES NOT define any key bindings.  This is for the user to
  ;; decide.  For example:
  ( :map global-map
         ("C-c n n" . denote)
         ("C-c n d" . denote-dired)
         ("C-c n g" . denote-grep)
         ;; If you intend to use Denote with a variety of file types, it is
         ;; easier to bind the link-related commands to the `global-map', as
         ;; shown here.  Otherwise follow the same pattern for `org-mode-map',
         ;; `markdown-mode-map', and/or `text-mode-map'.
         ("C-c n l" . denote-link)
         ("C-c n L" . denote-add-links)
         ("C-c n b" . denote-backlinks)
         ("C-c n q c" . denote-query-contents-link) ; create link that triggers a grep
         ("C-c n q f" . denote-query-filenames-link) ; create link that triggers a dired
         ;; Note that `denote-rename-file' can work from any context, not just
         ;; Dired bufffers.  That is why we bind it here to the `global-map'.
         ("C-c n r" . denote-rename-file)
         ("C-c n R" . denote-rename-file-using-front-matter)

         ;; Key bindings specifically for Dired.
         :map dired-mode-map
         ("C-c C-d C-i" . denote-dired-link-marked-notes)
         ("C-c C-d C-r" . denote-dired-rename-files)
         ("C-c C-d C-k" . denote-dired-rename-marked-files-with-keywords)
         ("C-c C-d C-R" . denote-dired-rename-marked-files-using-front-matter))

  :config
  ;; Remember to check the doc string of each of those variables.
  (setq denote-directory (expand-file-name "~/Documents/notes/"))
  (setq denote-save-buffers nil)
  (setq denote-known-keywords '("emacs" "kb"))
  (setq denote-infer-keywords t)
  (setq denote-sort-keywords t)
  (setq denote-prompts '(title keywords))
  (setq denote-excluded-directories-regexp nil)
  (setq denote-excluded-keywords-regexp nil)
  (setq denote-rename-confirmations '(rewrite-front-matter modify-file-name))
  (setq denote-dired-directories-include-subdirectories t)

  (defun +denote/search-in-all-notes ()
    (interactive)
    (consult-ripgrep denote-directory))

  ;; Pick dates, where relevant, with Org's advanced interface:
  (setq denote-date-prompt-use-org-read-date t)


  ;; Automatically rename Denote buffers using the `denote-rename-buffer-format'.
  (denote-rename-buffer-mode 1))

;; keybindings
(map! :leader
      :desc "New (de)Note" "d n" #'denote
      :desc "Denote dired" "d d" #'denote-dired
      :desc "Search in all notes" "d s" #'+denote/search-in-all-notes
      :desc "Grep denotes" "d g" #'denote-grep
      :desc "Open or create denote" "d o" #'denote-open-or-create
      :desc "Link" "d l" #'denote-link
      :desc "Add links" "d L" #'denote-add-links
      :desc "Backlinks" "d b" #'denote-backlinks
      :desc "Create link and open grep" "d q c" #'denote-query-contents-link
      :desc "Create link and open dired" "d q f" #'denote-query-filenames-link
      :desc "Rename" "d r" #'denote-rename-file
      :desc "Rename using front-matter" "d R" #'denote-rename-file-using-front-matter)

;; denote-journal
(use-package denote-journal
  :ensure t
  ;; Bind those to some key for your convenience.
  :commands ( denote-journal-new-entry
              denote-journal-new-or-existing-entry
              denote-journal-link-or-create-entry )
  :hook (calendar-mode . denote-journal-calendar-mode)
  :config
  ;; Use the "journal" subdirectory of the `denote-directory'.  Set this
  ;; to nil to use the `denote-directory' instead.
  (setq denote-journal-directory
        (expand-file-name "journal" denote-directory))
  ;; Default keyword for new journal entries. It can also be a list of
  ;; strings.
  (setq denote-journal-keyword "journal")
  ;; Read the doc string of `denote-journal-title-format'.
  (setq denote-journal-title-format 'day-date-month-year))


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (AFTER! PACKAG
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
;; ALTERNATIVELY, USE `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; (after! org
;;   '(
;;     ("j" "Joournal" entry (file+datree "~/org/journal.org") "* %?\n %i\n")
;;   ))
;; (load "/Users/marcin/Downloads/odin-mode.el")
;; Enable odin-mode and configure OLS as the language server
;; (use-package! odin-mode
;;   :mode ("\\.odin\\'" . odin-mode)
;;   :hook (odin-mode . lsp))

;; ;; Set up OLS as the language server for Odin, ensuring lsp-mode is loaded first
;; (with-eval-after-load 'lsp-mode
;;   (setq-default lsp-auto-guess-root t) ;; Helps find the ols.json file with Projectile or project.el
;;   (setq lsp-language-id-configuration (cons '(odin-mode . "odin") lsp-language-id-configuration))

;;   (lsp-register-client
;;     (make-lsp-client :new-connection (lsp-stdio-connection "ols OR path_to_ols_binary")
;;                     :major-modes '(odin-mode)
;;                     :server-id 'ols
;;                     :multi-root t))) ;; Ensures lsp-mode sends "workspaceFolders" to the server

;; ;; Pull the lsp-mode package
;; (package! lsp-mode
;;   :commands (lsp lsp-deferred))

;; ;; Set up OLS as the language server for Odin, ensuring lsp-mode is loaded first
;; (with-eval-after-load 'lsp-mode
;;   (setq-default lsp-auto-guess-root t) ;; Helps find the ols.json file with Projectile or project.el
;;   (add-to-list 'lsp-language-id-configuration '(odin-mode . "odin"))
;;   (add-to-list 'lsp-language-id-configuration '(odin-ts-mode . "odin"))

;;   (lsp-register-client
;;    (make-lsp-client :new-connection (lsp-stdio-connection "/Users/marcin/development/ols/") ;; Adjust the path here
;;                     :major-modes '(odin-mode odin-ts-mode)
;;                     :server-id 'ols
;;                     :multi-root t))) ;; Ensures lsp-mode sends "workspaceFolders" to the server

;; ;; Add a hook to autostart OLS
;; (add-hook 'odin-mode-hook #'lsp-deferred)
;; (add-hook 'odin-ts-mode-hook #'lsp-deferred) ;; If you're using the TS mode
                                        ; (use-package! odin-ts-mode
                                        ;   :config
                                        ;   (add-to-list 'auto-mode-alist '("\\.odin\\'" . odin-ts-mode))
                                        ;   (add-to-list 'treesit-language-source-alist '(odin "https://github.com/tree-sitter-grammars/tree-sitter-odin"))
                                        ;
                                        ;   (when (modulep! +lsp)
                                        ;     (add-hook 'odin-ts-mode-local-vars-hook #'lsp! 'append)))
                                        ;

(after! org
  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t))


;; gdscript
(setq gdscript-godot-executable "/Applications/Godot.app/Contents/MacOS/Godot")


;; keymaps
(map! :leader
      :desc "Open Dired"
      "e" #'dired-jump)


;; Copilot
;; accept completion from copilot and fallback to company
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)
              ("C-n" . 'copilot-next-completion)
              ("C-p" . 'copilot-previous-completion))

  :config
  (add-to-list 'copilot-indentation-alist '(prog-mode 2))
  (add-to-list 'copilot-indentation-alist '(org-mode 2))
  (add-to-list 'copilot-indentation-alist '(text-mode 2))
  (add-to-list 'copilot-indentation-alist '(emacs-lisp-mode 2)))


;; disable exit confirmation
(setq confirm-kill-emacs nil)


;; use bash as intenal shell commands (fish doesn't work well with emacs)
(setq shell-file-name (executable-find "bash"))
;; Emacs' terminal emulators can be safely configured to use fish
(setq-default vterm-shell "/opt/homebrew/bin/fish") (setq-default explicit-shell-file-name "/opt/homebrew/bin/fish")


;; format on save
;; (setq +format-on-save-enabled-modes
;;       '(not emacs-lisp-mode    ; disable for elisp if you want fine control
;;         sql-mode
;;         tex-mode
;;         latex-mode))
;; (add-hook 'emacs-lisp-mode-hook #'format-all-mode)


;; macOS specific settings
;; (cond (IS-MAC
;; (setq mac-control-modifier       'command
;; mac-pass-control-to-system nil)))

;; disable exit confirmation
(setq confirm-kill-emacs nil)

;; maximize the window on startup
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; todo: org-archive configuration
(use-package! org-archive
  :after org
  :config
  (setq org-archive-location "archive.org::datetree/"))


(use-package! org-super-agenda
  :after org-agenda
  :config
  ;; (setq org-super-agenda-groups '((:auto-dir-name t)))
  (org-super-agenda-mode))

;; reformat org buffer
(defun mq/org-reformat-buffer ()
  (interactive)
  (when (y-or-n-p "Really format current buffer? ")
    (let ((document (org-element-interpret-data (org-element-parse-buffer))))
      (erase-buffer)
      (insert document)
      (goto-char (point-min)))))

;; zig
(setq lsp-zig-zls-executable "/Users/marcin/Desktop/Projects/zls/zig-out/bin/zls")

(setq org-gcal-client-id ""
      org-gcal-client-secret ""
      org-gcal-fetch-file-alist '(
                                  ("marcin.kuder@gmail.com" .  "~/task.org")))
(require 'org-gcal)
