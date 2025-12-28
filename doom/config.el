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

(setq doom-font (font-spec :family "Maple Mono NF" :size 15))


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
(use-package! denote
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
      ;; :desc "Create link and open grep" "d q c" #'denote-query-contents-link
      ;; :desc "Create link and open dired" "d q f" #'denote-query-filenames-link
      :desc "Rename" "d r" #'denote-rename-file
      :desc "Rename using front-matter" "d R" #'denote-rename-file-using-front-matter)

;; denote-journal
(use-package! denote-journal
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
;;     ("j" "Journal" entry (file+datree "~/org/journal.org") "* %?\n %i\n")
;;   ))
;; (load "/Users/marcin/Downloads/odin-mode.el")
;; Enable odin-mode and configure OLS as the language server
;; (use-package! odin-mode
;;   :mode ("\\.odin\\'" . odin-mode)
;;   :hook (odin-mode . lsp))


;; Odin
(use-package! odin-ts-mode
  :mode "\\.odin\\'")

;;(after! lsp-mode
;;(setq lsp-odin-ls-path "/Users/marcin/development/ols/ols"))

;;(add-hook 'odin-mode-hook #'lsp-deferred)
(add-hook 'odin-ts-mode-hook #'lsp-deferred)


;; (add-to-list 'load-path "~/.emacs.d/packages/odin-mode")

;; ;; Set up OLS as the language server for Odin, ensuring lsp-mode is loaded first
;;                                         ;(with-eval-after-load 'lsp-mode
;;                                         ;(lsp-register-client
;;                                         ; (make-lsp-client :new-connection (lsp-stdio-connection "~/development/ols/ols")))
;;                                         ;:major-modes '(odin-mode);; This is just so lsp-mode sends the "workspaceFolders" param to server the.

;;                                         ;(add-hook 'odin-mode-hook 'lsp)
;; ;; Set up OLS as the language server for Odin, ensuring lsp-mode is loaded first
;; (with-eval-after-load 'lsp-mode
;;   (setq-default lsp-auto-guess-root t) ;; Helps find the ols.json file with Projectile or project.el
;;   (setq lsp-language-id-configuration (cons '(odin-mode . "odin") lsp-language-id-configuration))

;;   (lsp-register-client
;;    (make-lsp-client :new-connection (lsp-stdio-connection "ols OR path_to_ols_binary")
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
(map! :leader :desc "Open Dired" "e" #'dired-jump)
(map! :leader :desc "Export to Reveal and open" "r"
      (lambda ()
        (interactive)
        (save-buffer)
        (org-re-reveal-export-to-html-and-browse)))


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
(setq-default vterm-shell "/opt/homebrew/bin/fish")
(setq-default explicit-shell-file-name "/opt/homebrew/bin/fish")


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

;;; zig
(setq lsp-zig-zls-executable "/Users/marcin/proj/zig/zls/zig-out/bin/zls")
(setq lsp-zig-zig-exe-path "/opt/homebrew/bin/zig")

;;; org-gcal
(require 'auth-source)
(setq org-gcal-client-id ""
      org-gcal-client-secret (funcall (plist-get (car (auth-source-search :host "calendar.google.com")) :secret))
      org-gcal-fetch-file-alist '(("marcin.kuder@gmail.com" . "~/task.org")))
(require 'org-gcal)

;;; Launch Neovim in Ghostty, utilizing the external shell script.
(defun mq/ghostty-nvim-current-dir ()
  "Opens a new Ghostty terminal in the current file path, or the project directory"
  (interactive)
  
  (let* (;; 1. Determine the target path (file or directory).
         ;; Priority: 
         ;; 1. Current file path (if visiting a file).
         ;; 2. Project root (via Projectile/Project.el).
         ;; 3. Current buffer's default directory (e.g., Dired path).
         ;; 4. Home directory (safe fallback).
         (target-path (or (buffer-file-name) ; Pass file name if one exists
                          (when (fboundp 'projectile-project-root) (projectile-project-root))
                          (when (fboundp 'project-current) (project-root (project-current)))
                          default-directory 
                          (getenv "HOME")))
         
         ;; 2. Define the absolute path to the shell script.
         (script-path (expand-file-name "~/bin/open-nvim-ghostty.sh"))
         
         ;; 3. Ensure the script path is quoted for the shell command.
         (quoted-script-path (shell-quote-argument script-path))
         
         ;; 4. Ensure the target path is quoted, as it's passed as an argument to the script.
         (quoted-path (shell-quote-argument target-path))
         
         ;; 5. Construct the full shell command string.
         ;; We pass the target path (file or directory) as the first argument to the script.
         (full-command (format "%s %s > /dev/null 2>&1 & disown"
                               quoted-script-path
                               quoted-path)))
    
    (if (file-exists-p script-path)
        (progn
          (message "Calling script for Neovim with target: %s" target-path)
          ;; Execute the script asynchronously.
          (shell-command full-command)
          ;; Return focus to Emacs.
          (select-window (minibuffer-selected-window)))
      
      ;; Error message if the script is not found.
      (user-error "Shell script not found. Expected: %s. Did you save it and run 'chmod +x'?" script-path))))

;; Keybinding: Bind the function to a convenient key sequence.
(map! :leader
      :desc "Open nvim" "o n" 'mq/ghostty-nvim-current-dir)

(map! :leader
      :desc "Comment line" "-" #'comment-line)

;; For lsp-mode (which Doom uses by default for :tools lsp)
;; (add-hook 'odin-mode-hook #'lsp-deferred)

;; --- OR ---

;; ;; If you need to define the LSP client for ols explicitly:
;; (after! lsp-mode
;;   (lsp-register-client
;;    (make-lsp-client :new-connection (lsp-stdio-connection "ols")
;;                     :major-modes '(odin-mode)
;;                     :server-id 'ols)))

;; (add-hook 'odin-mode-hook #'lsp-deferred)


;; meow
;; -------------------- ;;
;;         UTILS        ;;
;; -------------------- ;;
(defun meow-word ()
  "Expand word/symbol under cursor."
  (interactive)
  (if (and (use-region-p)
           (equal (car (region-bounds))
                  (bounds-of-thing-at-point 'word)))
      (meow-mark-symbol 1)
    (progn
      (when (and (mark)
                 (equal (car (region-bounds))
                        (bounds-of-thing-at-point 'symbol)))
        (meow-pop-selection))
      (meow-mark-word 1))))

(defun meow-kill-line ()
  "Kill till the end of line."
  (interactive)
  (let ((select-enable-clipboard meow-use-clipboard))
    (kill-line)))

(defun meow-change-line ()
  "Kill till end of line and switch to INSERT state."
  (interactive)
  (meow--cancel-selection)
  (meow-end-of-thing
   (car (rassoc 'line meow-char-thing-table)))
  (meow-change))

(defun meow-save-clipboard ()
  "Copy in clipboard."
  (interactive)
  (let ((meow-use-clipboard t))
    (meow-save)))

(defvar meow--trim-yank nil)

(defun meow-insert-for-yank-advice (orig-fn str)
  "Advice for `insert-for-yank' function to correctly insert lines."
  (when meow--trim-yank
    (set 'str (string-trim-right str "\n")))
  (if (and (not (eq (point) (+ 1 (line-end-position 0))))
           (string-match-p "^.+\n$" str))
      (save-excursion
        (beginning-of-line)
        (funcall orig-fn str))
    (funcall orig-fn str)))

(defun meow-yank-dwim ()
  "Smart yank."
  (interactive)
  (advice-add 'insert-for-yank :around 'meow-insert-for-yank-advice)
  (if (use-region-p)
      (let ((meow--trim-yank t))
        (delete-region (region-beginning) (region-end))
        (meow-yank))
    (meow-yank))
  (advice-remove 'insert-for-yank 'meow-insert-for-yank-advice))

(defun meow-yank-pop-dwim ()
  "Smart yank pop."
  (interactive)
  (advice-add 'insert-for-yank :around 'meow-insert-for-yank-advice)
  (if (use-region-p)
      (let ((meow--trim-yank t))
        (delete-region (region-beginning) (region-end))
        (meow-yank-pop))
    (meow-yank-pop))
  (advice-remove 'insert-for-yank 'meow-insert-for-yank-advice))

(defun meow-smart-reverse ()
  "Reverse selection or begin negative argument."
  (interactive)
  (if (use-region-p)
      (meow-reverse)
    (negative-argument nil)))

(defun meow-kmacro ()
  "Toggle recording of kmacro."
  (interactive)
  (if defining-kbd-macro
      (meow-end-kmacro)
    (meow-start-kmacro)))

(defun meow-eldoc ()
  "Toggle the display of the eldoc window."
  (interactive)
  (if (get-buffer-window eldoc--doc-buffer)
      (delete-window (get-buffer-window eldoc--doc-buffer))
    (eldoc-doc-buffer t)))

;; -------------------- ;;
;;      THING TABLE     ;;
;; -------------------- ;;
;;
(meow-thing-register 'angle
                     '(pair ("<") (">"))
                     '(pair ("<") (">")))

(setq meow-char-thing-table
      '((?r . round)
        (?s . square)
        (?c . curly)
        (?a . angle)
        (?g . string)
        (?p . paragraph)
        (?l . line)
        (?b . buffer)))

;; -------------------- ;;
;;       MAPPINGS       ;;
;; -------------------- ;;

(defun meow-setup ()
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
  (meow-motion-define-key
   '("a" . meow-next)
   '("e" . meow-prev)
   '("<escape>" . ignore))
  (meow-leader-define-key
   ;; Use SPC (0-9) for digit arguments.
   '("1" . meow-digit-argument)
   '("2" . meow-digit-argument)
   '("3" . meow-digit-argument)
   '("4" . meow-digit-argument)
   '("5" . meow-digit-argument)
   '("6" . meow-digit-argument)
   '("7" . meow-digit-argument)
   '("8" . meow-digit-argument)
   '("9" . meow-digit-argument)
   '("0" . meow-digit-argument)
   '("/" . meow-keypad-describe-key)
   '("?" . meow-cheatsheet))
  (meow-normal-define-key
   '("0" . meow-expand-0)
   '("9" . meow-expand-9)
   '("8" . meow-expand-8)
   '("7" . meow-expand-7)
   '("6" . meow-expand-6)
   '("5" . meow-expand-5)
   '("4" . meow-expand-4)
   '("3" . meow-expand-3)
   '("2" . meow-expand-2)
   '("1" . meow-expand-1)
   '("^" . negative-argument)
   
   '("b" . meow-join)

   '(";" . meow-reverse)
   '("k" . meow-inner-of-thing)
   '("K" . meow-bounds-of-thing)
   '("y" . meow-beginning-of-thing)
   '("," . meow-end-of-thing)
   '("s" . meow-append)
   '("S" . meow-open-below)
   '("'" . meow-back-word)
   '("\"" . meow-back-symbol)
   '("c" . meow-change)
   '("x" . meow-delete)
   '("X" . meow-backward-delete)
   '("/" . meow-next-word)
   '("?" . meow-next-symbol)
   '("f" . meow-find)
   '("F" . meow-pop-to-mark)
   '("<" . meow-unpop-to-mark)
   '("g" . meow-cancel-selection)
   '("G" . meow-grab)
   '("h" . meow-left)
   '("H" . meow-left-expand)
   '("n" . meow-insert)
   '("N" . meow-open-above)
   '("a" . meow-next)
   '("A" . meow-next-expand)
   '("e" . meow-prev)
   '("E" . meow-prev-expand)
   '("i" . meow-right)
   '("I" . meow-right-expand)
   '("j" . repeat)
   '("z" . meow-search)
   '("o" . meow-block)
   '("O" . meow-to-block)
   '("w" . meow-yank)
   '("q" . meow-quit)
   '("Q" . meow-goto-line)
   '("R" . meow-replace)
   ;;'("R" . meow-swap-grab)
   '("d" . meow-kill)
   '("t" . meow-till)
   '("u" . meow-undo)
   '("U" . undo-redo)
   ;;'("U" . meow-undo-in-selection)
   '("v" . meow-visit)
   '("." . meow-mark-word)
   '(">" . meow-mark-symbol)
   '("l" . meow-line)
   '("L" . meow-goto-line)
   '("m" . meow-save)
   ;;'("Y" . meow-sync-grab)
   '("Z" . meow-pop-selection)
   '("{" . backward-paragraph)
   '("}" . forward-paragraph)
   '(":" . execute-extended-command)
   '("$" . save-buffer)
   '("_" . avy-goto-char-timer)
   '("-" . switch-to-buffer)                                     ; prefix a(
   '("#" . comment-line)
   '("=" . +lookup/references)
   ;; '("=" . indent-region)                                   ; prefix b))
   
   '("<escape>" . ignore)))

                                        ; prefix n
;;'("nf" . meow-comment)
;;'("nt" . meow-start-kmacro-or-insert-counter)
;;'("nr" . meow-start-kmacro)
;;'("ne" . meow-end-or-call-kmacro)
;; ...etc

                                        ; prefix ;
;;'(";f" . save-buffer
;;'(";F" . save-some-buffers)
;;'(";d" . meow-query-replace-regexp)

;; ... etc
;;


(meow-setup)


;; odin-ts-mode tree-sitter faces
;; (after! odin-ts-mode
;; (custom-set-faces!
;;   '(tree-sitter-hl-face:function :foreground (doom-color 'yellow))
;;   '(tree-sitter-hl-face:function.call :foreground (doom-color 'cyan))))

(custom-set-faces!
  ;; Color for function definitions
  `(font-lock-function-name-face :foreground ,(doom-color 'aqua) :weight bold)

  ;; use colors from doom-tomorrow-night theme
  `(font-lock-function-call-face :foreground ,(doom-color 'aqua))

  ;; Color for keywords
  `(font-lock-keyword-face :foreground ,(doom-color 'orange) :weight bold)

  ;; Color for types
  `(font-lock-type-face :foreground ,(doom-color 'green) :weight bold)

  ;; Color for variables
  `(font-lock-variable-name-face :foreground ,(doom-color 'blue))

  ;; Color for constants
  `(font-lock-constant-face :foreground ,(doom-color 'purple) :weight bold)

  ;; Color for comments
  `(font-lock-comment-face :foreground ,(doom-color 'grey) :slant italic)

  ;; Color for strings
  `(font-lock-string-face :foreground ,(doom-color 'green)))

;; In your config.el
(after! meow
  (custom-set-faces!
    ;; Using Doom theme's comment color for subtle appearance
    `(meow-position-highlight-number :foreground "#ffffff" :background ,(doom-darken (doom-color 'base3) 0.3) :weight normal)
    `(meow-position-highlight-number-1 :foreground "#777777" :background ,(doom-darken (doom-color 'base3) 0.3) :weight normal)
    `(meow-position-highlight-number-2 :foreground "#999999" :background ,(doom-darken (doom-color 'base3) 0.2) :weight normal)
    `(meow-position-highlight-number-3 :foreground "#aaaaaa" :background ,(doom-darken (doom-color 'base3) 0.1) :weight normal)))

;;; Ensure Emacs can find executables in ~/.local/bin
(add-to-list 'exec-path "/Users/marcin/.local/bin")

;;; -------------------- ;;
;;; claude-code-ide
;;; -------------------- ;;
;; (use-package! claude-code-ide
;;   :init
;;   ;; Set the executable path BEFORE the package loads
;;   (setq claude-code-ide-claude-executable "/Users/marcin/.local/bin/claude")
;;   :bind ("C-c C-'" . claude-code-ide-menu)
;;   :config
;;   (claude-code-ide-emacs-tools-setup))

(use-package! claude-code-ide
  :init
  ;; Set the CLI path - this is what the package actually uses!
  (setq claude-code-ide-cli-path "/Users/marcin/.local/bin/claude")
  :bind ("C-c C-'" . claude-code-ide-menu)
  :config
  (claude-code-ide-emacs-tools-setup))


;;; -------------------- ;;
;;; Claude Code anti-flicker settings
;;; -------------------- ;;

;; Set character widths for Unicode ranges used by Claude Code spinners/UI
(dolist (range '((#x23FA . #x23FA)   ; ⏺ bullet
                 (#x2700 . #x27BF)   ; Dingbats (spinner chars ✢✳✻✽)
                 (#x2200 . #x22FF)   ; Math operators (∗)
                 (#x2800 . #x28FF)   ; Braille patterns (common spinners)
                 (#x25A0 . #x25FF)   ; Geometric shapes
                 (#x2580 . #x259F)   ; Block elements
                 (#x2500 . #x257F)   ; Box drawing
                 (#x1F500 . #x1F5FF) ; Miscellaneous symbols
                 (#xE000 . #xF8FF))) ; Private use area (Nerd Fonts)
  (set-char-table-range char-width-table range 1))

(defun my/setup-claude-fontset ()
  "Set up fonts for Claude Code Unicode characters to prevent flicker."
  ;; Use your main font for all these ranges to prevent font fallback flicker
  (let ((font "Maple Mono NF"))
    (set-fontset-font t '(#x23FA . #x23FA) font)    ; bullet
    (set-fontset-font t '(#x2700 . #x27BF) font)    ; Dingbats (spinners)
    (set-fontset-font t '(#x2800 . #x28FF) font)    ; Braille patterns
    (set-fontset-font t '(#x25A0 . #x25FF) font)    ; Geometric shapes
    (set-fontset-font t '(#x2580 . #x259F) font)))  ; Block elements
(my/setup-claude-fontset)
(add-hook 'after-setting-font-hook #'my/setup-claude-fontset)

;; Global anti-flicker settings
(setq redisplay-skip-fontification-on-input t)
(setq fast-but-imprecise-scrolling t)
(blink-cursor-mode -1)

;; vterm settings to reduce flicker
(after! vterm
  ;; Slower timer reduces flicker (0.05 is often too fast)
  (setq vterm-timer-delay 0.2)
  ;; Disable title updates that can cause flicker
  (setq vterm-set-title-functions nil)
  ;; Reduce unnecessary redraws
  (setq vterm-max-scrollback 5000))

;; Disable Claude Code terminal title updates
(setenv "CLAUDE_CODE_DISABLE_TERMINAL_TITLE" "1")
