;;; Directory Local Variables
;;; For more information see (info "(emacs) Directory Variables"

;;((nil
;;  (eval load-file "./shell.el")))

;;

;;; Directory Local Variables
;;; For more information see (info "(emacs) Directory Variables")

;((nil
;  (eval (progn	(setq default-directory	      (locate-dominating-file buffer-file-name ".dir-locals.el"))	(load-file "./shell.el")))))
;;; Directory Local Variables
;;; For more information see (info "(emacs) Directory Variables")

((nil
  (eval progn
	(setq default-directory
	      (locate-dominating-file buffer-file-name ".dir-locals.el"))
	(load-file "./shell.el"))))
