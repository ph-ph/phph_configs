(load "server")
(unless (server-running-p) (server-start))
(setq ns-pop-up-frames nil)
(setq dired-use-ls-dired nil)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4) ; set tab width to 4 for all buffers

(global-auto-revert-mode t)

(setq-default org-startup-truncated nil)
(global-set-key [f5] 'revert-buffer)
(global-set-key (kbd "C-x C-b") 'buffer-menu)
(global-set-key (kbd "C-c l") 'org-store-link)

; Move all backup files to one folder
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
  backup-by-copying t    ; Don't delink hardlinks
  version-control t      ; Use version numbers on backups
  delete-old-versions t  ; Automatically delete excess backups
  kept-new-versions 10   ; how many of the newest versions to keep
  kept-old-versions 2    ; and how many of the old
  )

; setup package installs
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

; Allow to edit file permissions in dired mode
(setq wdired-allow-to-change-permissions 'advanced)

; Delete selection on edit (like any other sane editor does)
(delete-selection-mode 1)

; Use ssh for remote file opening
(setq tramp-default-method "ssh")
(setq tramp-ssh-controlmaster-options "")

(add-to-list 'load-path "/Applications/Emacs.app/Contents/Resources/lisp/progmodes/")
(add-to-list 'load-path "~/.emacs.d/site-lisp/other/")
(add-to-list 'load-path "~/.emacs.d/site-lisp/ess/lisp/")
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(require 'inf-ruby)

; Install mode-compile to give friendlier compiling support!
(add-to-list 'load-path "~/.emacs.d/site-lisp/mode-compile/")
(autoload 'mode-compile "mode-compile"
   "Command to compile current buffer file based on the major mode" t)
(global-set-key "\C-cc" 'mode-compile)
(autoload 'mode-compile-kill "mode-compile"
 "Command to kill a compilation launched by `mode-compile'" t)
(global-set-key "\C-ck" 'mode-compile-kill)

; fancy js mode
;; (add-to-list 'load-path "~/.emacs.d/site-lisp/js2-mode/")
;; (autoload 'js2-mode "js2-mode" nil t)
;; (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

; js interpreter
(require 'js-comint)
;; Use node as our repl
(setq inferior-js-program-command "node")

(setq inferior-js-mode-hook
      (lambda ()
        ;; We like nice colors
        (ansi-color-for-comint-mode-on)
        ;; Deal with some prompt nonsense
        (add-to-list 'comint-preoutput-filter-functions
                     (lambda (output)
                       (replace-regexp-in-string ".*1G\.\.\..*[0-9]G" "..."
                     (replace-regexp-in-string ".*1G.*3G" ">" output)
)
)
)))

(add-hook 'js-mode-hook '(lambda ()
			    (local-set-key "\C-x\C-e" 'js-send-last-sexp)
			    (local-set-key "\C-\M-x" 'js-send-last-sexp-and-go)
			    (local-set-key "\C-cc" 'js-send-buffer)
			    (local-set-key "\C-c\C-c" 'js-send-buffer-and-go)
                (local-set-key "\C-cl" 'org-store-link)
                (setq comment-style 'extra-line)
                (setq comment-start "/**")
                (setq comment-continue " *")
                (setq comment-end "*/")
			    ))
;; change js indent to 2
(setq js-indent-level 2)

;;(add-to-list 'grep-find-ignored-directories "lib/layouts/*")

;; Yaml mode
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-hook 'yaml-mode-hook
      '(lambda ()
        (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

;; Uniquify
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)

;; require quack for better Scheme support
(require 'quack)

;; Enable git-gutter global mode
(global-git-gutter-mode +1)
(setq git-gutter:added-sign "+ ")
(setq git-gutter:deleted-sign "- ")
(setq git-gutter:modified-sign "= ")
(setq git-gutter:hide-gutter t)

;; Expand region for smarter block selection
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;; Configuration for multiple cursors
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; Configure column marker to be displayed in js mode
(require 'column-marker)
(add-hook 'js-mode-hook (lambda () (interactive) (column-marker-1 100)))
(add-hook 'web-mode-hook (lambda () (interactive) (column-marker-1 100)))
;; Same thing in ruby mode
(add-hook 'enh-ruby-mode-hook (lambda () (interactive) (column-marker-1 100)))

;; Pymacs craziness
;; (setenv "PYMACS_PYTHON" "/usr/local/bin/python2.7")
;; (autoload 'pymacs-apply "pymacs")
;; (autoload 'pymacs-call "pymacs")
;; (autoload 'pymacs-eval "pymacs" nil t)
;; (autoload 'pymacs-exec "pymacs" nil t)
;; (autoload 'pymacs-load "pymacs" nil t)
;; (autoload 'pymacs-autoload "pymacs")
;;(eval-after-load "pymacs"
;;  '(add-to-list 'pymacs-load-path YOUR-PYMACS-DIRECTORY"))

;; Install ropemacs
;; This package is for Python refactoring and working with Python projects in general
;; Provides things like "jump to definition etc".
;; (require 'pymacs)
;; (pymacs-load "ropemacs" "rope-")

;; Set font size to 14pt
(set-face-attribute 'default nil :height 160)
;; Display column in the status bar
(column-number-mode)
;; Set window margins to 0
;;(setq-default left-margin-width 0 right-margin-width 0)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(css-indent-offset 2)
 '(custom-enabled-themes '(tango-dark))
 '(desktop-auto-save-timeout 30)
 '(desktop-save-mode t)
 '(enh-ruby-add-encoding-comment-on-save nil)
 '(enh-ruby-bounce-deep-indent t t)
 '(enh-ruby-use-encoding-map nil)
 '(git-commit-fill-column 255)
 '(ido-enable-flex-matching t)
 '(magit-revert-buffers nil t)
 '(magit-status-headers-hook
   '(magit-insert-error-header magit-insert-diff-filter-header magit-insert-head-branch-header magit-insert-upstream-branch-header magit-insert-push-branch-header))
 '(org-babel-load-languages '((ruby . t) (emacs-lisp . t)))
 '(org-src-fontify-natively t)
 '(package-selected-packages
   '(lua-mode sql-presto yasnippet yaml-mode web-mode undo-tree thrift smartparens scss-mode quack projectile nvm neotree multiple-cursors markdown-mode magit js-comint inf-ruby ido-vertical-mode hive grizzl git-gutter flx-ido expand-region exec-path-from-shell ess enh-ruby-mode column-marker coffee-mode browse-at-remote auto-complete ag))
 '(projectile-tags-command "ripper-tags -R -f \"%s\" %s")
 '(python-check-command
   "pylint  --msg-template=\"{path}:{line}: [{msg_id}({symbol}), {obj}] {msg}\"")
 '(ruby-encoding-magic-comment-style 'custom)
 '(ruby-insert-encoding-magic-comment nil)
 '(ruby-use-encoding-map nil)
 '(scss-compile-at-save nil)
 '(show-paren-mode t)
 '(sql-hive-options '("--emr-cluster infra-shared-prod --hive-cluster silver"))
 '(tool-bar-mode nil)
 '(tooltip-mode nil)
 '(web-mode-attr-indent-offset 2)
 '(web-mode-code-indent-offset 2)
 '(web-mode-markup-indent-offset 2))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-marker-1 ((t (:background "disabledControlTextColor"))))
 '(sp-pair-overlay-face ((t (:background "selectedTextBackgroundColor" :foreground "selectedTextColor")))))

;; Magit - better git
(require 'magit)
(global-set-key (kbd "C-x m") 'magit-status)
(setq git-commit-summary-max-length 100)
(remove-hook 'magit-refs-sections-hook 'magit-insert-tags)
(remove-hook 'magit-refs-sections-hook 'magit-insert-remote-branches)
(setq magit-refresh-verbose t)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html$" . web-mode))
(add-to-list 'auto-mode-alist '("/vamo/blueprints/content_editor/templates/" . web-mode))
;; Configure Jinja2 mode for files in certain folders
;; I'm not using it now, though.
;; (setq web-mode-engines-alist '(("jinja" . "/vamo/templates/.*\\.html$")) )
;; (add-to-list 'web-mode-engines-alist '("jinja" . "/vamo/blueprints/content_editor/templates/.*\\.html$"))

;; Web mode for all erb files
(add-to-list 'auto-mode-alist '("\\.erb$" . web-mode))
(add-to-list 'web-mode-engines-alist '("erb" . "\\.erb$"))

;; Web mode for jsx files
(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))
(defadvice web-mode-highlight-part (around tweak-jsx activate)
  (if (equal web-mode-content-type "jsx")
      (let ((web-mode-enable-part-face nil))
        ad-do-it)
    ad-do-it))

;; Web mode for hbs files
(add-to-list 'auto-mode-alist '("\\.hbs$" . web-mode))

;; Custom commands for Python mode
;; Requires pylint to be installed.
(defun my-python-check (command)
  "Check a Python file (default current buffer's file).
Runs COMMAND, a shell command, as if by `compile'.
See `python-check-command' for the default."
  (interactive
   (list (read-string "Check command: "
                      (or python-check-custom-command
                          (concat python-check-command " "
                                  (shell-quote-argument
                                   (or
                                    (let ((name (buffer-file-name)))
                                      (and name
                                           (file-name-nondirectory name)))
                                    "")))))))
  ;; (setq python-check-custom-command command)
  (save-some-buffers (not compilation-ask-about-save) nil)
  (let ((process-environment (python-shell-calculate-process-environment))
        (exec-path (python-shell-calculate-exec-path)))
    (compilation-start command nil
                       (lambda (_modename)
                         "*Python check*"))))

(add-hook 'python-mode-hook '(lambda ()
                               (local-set-key "\C-c\C-v" 'my-python-check)
                               (local-set-key "\C-c\C-b" 'toggle-breakpoint)))

;; Markdown mode
(require 'markdown-mode)
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
;; enable by default on vamo docs
(add-to-list 'auto-mode-alist '("/vamo/docs/" . markdown-mode))

;; Undo tree mode - undo tree visualization
(require 'undo-tree)
(global-undo-tree-mode)

;; Use iPython as default Python interpreter
(when (executable-find "ipython")
  (setq
   python-shell-interpreter "ipython"
   python-shell-interpreter-args ""
   python-shell-prompt-regexp "In \\[[0-9]+\\]: "
   python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
   python-shell-completion-setup-code
   "from IPython.core.completerlib import module_completion"
   python-shell-completion-module-string-code
   "';'.join(module_completion('''%s'''))\n"
   python-shell-completion-string-code
   "';'.join(get_ipython().Completer.all_completions('''%s'''))\n"))

;; Custom command to run ipython with cs231n venv
(defun run-cs231-ipython ()
  (interactive)
  (let (old-buffer-name python-shell-buffer-name)
    (setq python-shell-buffer-name "Python")
    (run-python "bash -c \"source ~/.bash_profile && workon cs231n && cd /Users/dzmitry_kishylau/Dropbox/src/cs231n && frameworkpython -m IPython\"" nil t)
    (setq python-shell-buffer-name old-buffer-name))
  )
;; I don't need that anymore, but let's keep it as an example of what can be done
;; (global-set-key (kbd "C-x r p") 'run-cs231-ipython)

;; mode for editing scss files
(require 'scss-mode)

;; delete trailing whitespace before saving
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; highlight lines with python breakpoints
(defun annotate-pdb ()
  (interactive)
  (highlight-lines-matching-regexp "import pdb")
  (highlight-lines-matching-regexp "pdb.set_trace()"))

(add-hook 'python-mode-hook 'annotate-pdb)
(put 'upcase-region 'disabled nil)

;; function to toggle Python breakpoint
(defun toggle-breakpoint()
  "Set/unset Python breakpoint on the current line"
  (interactive)
  (goto-char (line-beginning-position))
  (if (string-match "set_trace" (thing-at-point 'line))
      (progn
       (kill-line)
       (kill-line))
    (open-line 1)
    (insert "import ipdb; ipdb.set_trace()")
    (indent-for-tab-command))
  )

;; function to close bury other window
(defun hide-opposite-window()
  (interactive)
  (save-excursion
    (other-window 1)
    (quit-window)))

(global-set-key (kbd "C-c q") 'hide-opposite-window)

;; enable groovy mode for gradle config files
(add-to-list 'auto-mode-alist '("*.gradle" . groovy-mode))

;; autocomplete package: display completions where they should be
(require 'auto-complete-config)
(ac-config-default)
(setq ac-ignore-case nil)
(add-to-list 'ac-modes 'enh-ruby-mode)
(add-to-list 'ac-modes 'web-mode)
;; add custom sources for autocomplete
(setq web-mode-ac-sources-alist
  '(("css" . (ac-source-css-property))
    ("html" . (ac-source-words-in-buffer ac-source-abbrev))
    ("django" . (ac-source-words-in-buffer))
    ("jsx" . (ac-source-words-in-buffer))))

;; enhanced ruby mode
(add-to-list 'auto-mode-alist '("\\.rb$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . enh-ruby-mode))

(add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))

(setq enh-ruby-bounce-deep-indent t)
(setq enh-ruby-hanging-brace-indent-level 2)

;; smartparens - because closing parentheses is too hard
(require 'smartparens-config)
(require 'smartparens-ruby)
(require 'smartparens-html)
(smartparens-global-mode t)
(show-smartparens-global-mode t)
(sp-with-modes '(rhtml-mode web-mode)
  (sp-local-pair "<" ">")
  (sp-local-pair "<%" "%>")
  (sp-local-pair "{% " " %}")
  (sp-local-pair "{{ " " }}"))

;; making sure web mode doesn't conflict with smartparens
(defun my-web-mode-hook ()
  (setq web-mode-enable-auto-pairing nil))
(add-hook 'web-mode-hook  'my-web-mode-hook)
(defun sp-web-mode-is-code-context (id action context)
  (when (and (eq action 'insert)
             (not (or (get-text-property (point) 'part-side)
                      (get-text-property (point) 'block-side))))
    t))
(sp-local-pair 'web-mode "<" nil :when '(sp-web-mode-is-code-context))

;; ag search
(require 'ag)
(setq ag-reuse-buffers t)
(setq ag-highlight-search t)
(defun ag-project-files-regexp (string file-type)
  "Search using ag for a given search STRING,
limited to files that match FILE-TYPE. STRING defaults to the
symbol under point.
The only difference from ag-project-files is that it treats the string
as regex.

If called with a prefix, prompts for flags to pass to ag."
  (interactive (list (ag/read-from-minibuffer "Search string")
                     (ag/read-file-type)))
  (apply 'ag/search string (ag/project-root default-directory) :regexp t file-type))

(defun ag-files-regexp (string file-type directory)
  "Search using ag in a given DIRECTORY for a given search STRING,
limited to files that match FILE-TYPE. STRING defaults to
the symbol under point.
The only difference from ag-files is that it treats the string
as regex.

If called with a prefix, prompts for flags to pass to ag."
  (interactive (list (ag/read-from-minibuffer "Search string")
                     (ag/read-file-type)
                     (read-directory-name "Directory: ")))
  (apply #'ag/search string directory :regexp t file-type))

(global-set-key (kbd "M-r") 'ag-project-files-regexp)

;; use sql-mode for hive files
(add-to-list 'auto-mode-alist '("\.hql$" . sql-mode))
(put 'downcase-region 'disabled nil)

;; Function to find non-ascii characters in the current buffer
(defun find-first-non-ascii-char ()
  "Find the first non-ascii character from point onwards."
  (interactive)
  (let (point)
    (save-excursion
      (setq point
            (catch 'non-ascii
              (while (not (eobp))
                (or (eq (char-charset (following-char))
                        'ascii)
                    (throw 'non-ascii (point)))
                (forward-char 1)))))
    (if point
        (goto-char point)
        (message "No non-ascii characters."))))

;; So that we can use TAGs file more efficiently
(global-set-key (kbd "C-c g") 'find-tag)
(global-set-key (kbd "C-c u") 'pop-tag-mark)

;; neotree - folder tree panel
;; I tried using it for a while, but it didn't stick
;; (require 'neotree)
;; (global-set-key [f8] 'neotree-toggle)

;; Linter command for javascript files
(defun airbnb-js-lint ()
  "Check a Javascript/React file (default current buffer's file)."
  (interactive
   ;; Generate linter command
   (let (
         (linter-command
          (concat
           (projectile-project-root)
           "node_modules/.bin/eslint --ext .js,.jsx --ignore-path="
           (concat (projectile-project-root) ".eslintignore")
           " --format compact "
           (buffer-file-name)
           " | sed -E 's/(.*): line ([0-9]+), col [0-9]+, (.*)/\\1:\\2: \\3/'")))

     (compilation-start linter-command nil
                       (lambda (_modename)
                         "*JS lint*")))
   )
  )

(defun airbnb-js-lint-keybinding ()
  (local-set-key "\C-c\C-v" 'airbnb-js-lint))
(add-hook 'web-mode-hook 'airbnb-js-lint-keybinding)
(add-hook 'js-mode-hook 'airbnb-js-lint-keybinding)
;; ========== End of linter stuff

;; Linter command for ruby files
(defun airbnb-ruby-lint ()
  "Check a Ruby file (default current buffer's file)."
  (interactive
   ;; Generate linter command
   (let (
         (linter-command
          (concat
           "pushd "
           (projectile-project-root)
           "; rubocop --config ./.rubocop.yml "
           (buffer-file-name)
           ";popd"
           )))

     (compilation-start linter-command nil
                       (lambda (_modename)
                         "*Rubocop*")))
   )
  )
(add-hook 'enh-ruby-mode-hook (lambda () (local-set-key "\C-c\C-v" 'airbnb-ruby-lint)))
;; ======== End of ruby linter stuff

;; Add a way to browse files on GHE
(require 'browse-at-remote)

(defun open-on-ghe ()
  "Open selected line/region in GHE webview"
  (interactive)
  (browse-url (get-ghe-url)))

(defun get-ghe-url ()
  "Get GHE url for the current line/region"

  (cond
   ;; We're inside of file-attached buffer with active region
   ((and buffer-file-name (use-region-p))
    (let ((point-begin (min (region-beginning) (region-end)))
          (point-end (max (region-beginning) (region-end))))
      (get-ghe-file-url
       buffer-file-name point-begin
       (if (eq (char-before point-end) ?\n) (- point-end 1) point-end))
      ))

   ;; We're inside of file-attached buffer without region
   (buffer-file-name
    (get-ghe-file-url (buffer-file-name) (point))
    )

   (t (error "Sorry, I'm not sure what to do with this."))
   )
  )

(defun get-ghe-file-url (filename &optional start end)
  "Get GHE url for the specified file from lines start to end"

  (let* (
         (relname (f-relative filename (f-expand (vc-git-root filename))))
         ;; (remote-ref (browse-at-remote/remote-ref filename))
         (remote (browse-at-remote--get-remote-url "origin"))
         (ref "master")
         (target-repo (browse-at-remote--get-url-from-remote remote))
         (remote-type "github")
         (repo-url (cdr target-repo))
         (url-formatter (browse-at-remote--get-formatter 'region-url remote-type))
         (start-line (when start (line-number-at-pos start)))
         (end-line (when end (line-number-at-pos end))))
    (unless url-formatter
      (error (format "Origin repo parsing failed: %s" repo-url)))
    (funcall url-formatter repo-url ref relname
             (if start-line start-line)
             (if (and end-line (not (equal start-line end-line))) end-line))))

;; =============================================================================
;; Projectile, ido etc, all in one place
(ido-mode t)

(require 'ido-vertical-mode)
(ido-vertical-mode 1)
(setq ido-vertical-define-keys 'C-n-and-C-p-only)

(require 'flx-ido)
(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-use-faces nil)

;; Projectile, to make working with projects easier
(projectile-global-mode)
(setq projectile-enable-caching t)

;; End of projectile stuff =====================================================

;; =============================================================================
;; Override enh-ruby function that inserts encoding header into ruby files,
;; to match Airbnb style
(defun enh-ruby-mode-set-encoding ()
  (save-excursion
    (widen)
    (goto-char (point-min))
    (when (re-search-forward "[^\0-\177]" nil t)
      (goto-char (point-min))
      (let ((coding-system
             (or coding-system-for-write
                 buffer-file-coding-system)))
        (if coding-system
            (setq coding-system
                  (or (coding-system-get coding-system 'mime-charset)
                      (coding-system-change-eol-conversion coding-system nil))))
        (setq coding-system
              (if coding-system
                  (symbol-name
                   (or (and enh-ruby-use-encoding-map
                            (cdr (assq coding-system enh-ruby-encoding-map)))
                       coding-system))
                "ascii-8bit"))
        (if (looking-at "^#!") (beginning-of-line 2))
        (cond ((looking-at "\\s *#.*-\*-\\s *\\(en\\)?coding\\s *:\\s *\\([-a-z0-9_]*\\)\\s *\\(;\\|-\*-\\)")
               (unless (string= (match-string 2) coding-system)
                 (goto-char (match-beginning 2))
                 (delete-region (point) (match-end 2))
                 (and (looking-at "-\*-")
                      (let ((n (skip-chars-backward " ")))
                        (cond ((= n 0) (insert "  ") (backward-char))
                              ((= n -1) (insert " "))
                              ((forward-char)))))
                 (insert coding-system)))
              ((looking-at "\\s *#.*coding\\s *[:=]"))
              (t (insert "# encoding: " coding-system "\n"))
              )))))
;; ==============================================================================

;; Yasnippet
(require 'yasnippet)
(yas-global-mode 1)
