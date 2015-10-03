(message "shell.el evaluating")

;;;;;;;;;;;
;;;Magit;;;
;;;;;;;;;;;
(require 'magit)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;Autocomplete with company;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'company)
(add-hook 'haskell-mode-hook 'company-mode)
(add-to-list 'company-backends 'company-ghc)
(custom-set-variables '(company-ghc-show-info t))

;;;;;;;;;;;;;
;;;ghc-mod;;;
;;;;;;;;;;;;;
(add-hook 'haskell-mode-hook (lambda () (ghc-init)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;Structured Haskell Mode;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'haskell-mode-hook 'structured-haskell-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;
;;;Rainbow parentheses;;;
;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'rainbow-delimiters)
(add-hook 'haskell-mode-hook #'rainbow-delimiters-mode)

;;;;;;;;;;;;;;
;;;CUA mode;;;
;;;;;;;;;;;;;;
(cua-mode t)

;;;;;;;;;;;;;;
;;;org-mode;;;
;;;;;;;;;;;;;;
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)



(message "shell.el finished evaluating")
