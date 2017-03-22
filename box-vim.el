;; Get package installation ready
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
;; Get Vim keybindings
(use-package evil
  :ensure t)
(evil-mode 1)
;; intero itself
(use-package intero
  :ensure t)
(add-hook 'haskell-mode-hook 'intero-mode)
(require 'haskell-mode)
(define-key haskell-mode-map [f5] (lambda () (interactive) (compile "stack build --fast")))
(define-key haskell-mode-map [f12] 'intero-devel-reload)
;; hindent
(use-package hindent
  :ensure t)
(add-hook 'haskell-mode-hook #'hindent-mode)
(setq hindent-style "johan-tibell")
; Some general editor niceties
(global-linum-mode t)
(column-number-mode t)
(setq-default indent-tabs-mode nil)
(setq-default show-trailing-whitespace t)
;; http://stackoverflow.com/questions/354490/preventing-automatic-change-of-default-directory
(add-hook 'find-file-hook
          (lambda ()
            (setq default-directory command-line-default-directory)))
;; Make flycheck more to my liking
(setq flycheck-check-syntax-automatically '(save))
;; Get Haskell indentation which mirrors what I'm used to from Vim
(defun haskell-setup ()
  "Setup variables for editing Haskell files."
  (make-local-variable 'tab-stop-list)
  (setq tab-stop-list (number-sequence 0 120 4))
  (setq indent-line-function 'tab-to-tab-stop)
  ; Backspace: delete spaces up until a tab stop
  (defvar my-offset 4 "My indentation offset. ")
  (defun backspace-whitespace-to-tab-stop ()
    "Delete whitespace backwards to the next tab-stop, otherwise delete one character."
    (interactive)
      (let ((movement (% (current-column) my-offset))
            (p (point)))
        (when (= movement 0) (setq movement my-offset))
        ;; Account for edge case near beginning of buffer
        (setq movement (min (- p 1) movement))
        (save-match-data
          (if (string-match "[^\t ]*\\([\t ]+\\)$" (buffer-substring-no-properties (- p movement) p))
              (backward-delete-char (- (match-end 1) (match-beginning 1)))
            (call-interactively 'backward-delete-char)))))
  (local-set-key (kbd "DEL") 'backspace-whitespace-to-tab-stop))
(add-hook 'haskell-mode-hook 'haskell-setup)
;; Markdown
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))
;; yaml
(use-package yaml-mode
  :ensure t)
;; Misc
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
