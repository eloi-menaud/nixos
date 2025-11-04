
;; Config
(menu-bar-mode -1)
(tool-bar-mode -1)
(setq ring-bell-function 'ignore)
(setq make-backup-files nil)
(setq auto-save-default nil)
;;(global-display-line-numbers-mode 1)

(xterm-mouse-mode 1)

;;theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'noctilux t)



(global-set-key (kbd "<escape>") 'keyboard-quit)
;; remove other key to not be lost
(dolist (char '(?a ?b ?c ?d ?e ?f ?g ?h ?i ?j ?k ?l ?m ?n ?o ?p ?q ?r ?s ?t ?u ?v ?w ?x ?y ?z))
  (let ((key-sequence (kbd (concat "C-" (char-to-string char)))))
    (global-unset-key key-sequence)))

(dolist (char '(?a ?b ?c ?d ?e ?f ?g ?h ?i ?j ?k ?l ?m ?n ?o ?p ?q ?r ?s ?t ?u ?v ?w ?x ?y ?z))
  (let ((key-sequence (kbd (concat "M-" (char-to-string char)))))
    (global-unset-key key-sequence)))

(global-set-key (kbd "RET") 'newline) 



(defun indent-region-or-buffer ()
  (interactive)
  (if (use-region-p)
      (indent-region (region-beginning) (region-end))
    (indent-region (point-min) (point-max))))
(global-set-key (kbd "TAB") 'indent-region-or-buffer)

(defun dedent-region (start end &optional count)
  (interactive "r\np")
  (let ((decrement (or count tab-width)))
    (save-excursion
      (indent-rigidly start end (- decrement)))))
(global-set-key (kbd "<backtab>") 'dedent-region)


;; Ctrl+S → Save buffer
(global-set-key (kbd "C-s") 'save-buffer)

;; Ctrl+Q → Quit Emacs
(global-set-key (kbd "C-q") (lambda () (interactive) (kill-emacs)))

;; Alt+S → Save + Quit
(defun my-save-and-quit ()
  "Save all buffers and quit Emacs."
  (interactive)
  (save-some-buffers t)
  (save-buffers-kill-terminal))
(global-set-key (kbd "C-x") 'my-save-and-quit)


;; C-c Copy (wl-copy)
(defun wlcopy ()
  (interactive)
  (if (use-region-p)
      (let ((text (buffer-substring-no-properties (region-beginning) (region-end))))
        (call-process-region (region-beginning) (region-end) "wl-copy" nil 0)
        (message "Copied: %s" (truncate-string-to-width text 50 nil nil t)))
    (message "No region active")))
(global-set-key (kbd "C-y") 'wlcopy)
(keyboard-translate ?\C-c ?\C-y)


;; C-v Paste (wl-paste)
(defun wlpaste ()
  (interactive)
  (let ((text (string-trim-right (shell-command-to-string "wl-paste"))))
    (if (not (string= text ""))
        (insert text)
      (message "Clipboard is empty"))))
(defun my-delete-region-and-always-wlpaste ()
  (interactive)
  (when (use-region-p)
    (delete-region (region-beginning) (region-end))
    (deactivate-mark))
  (wlpaste))
(global-set-key (kbd "C-v") 'wlpaste)

;; Ctrl+z -> undo
(global-unset-key (kbd "C-z"))
(global-set-key  (kbd "C-z") 'undo)



;; Ctrl+Shift+z -> redo
(define-key global-map (kbd "C-S-z") 'undo-redo)

;; Ctrl+a -> select all
(define-key global-map (kbd "C-a") 'mark-whole-buffer)

;; Ctrl+backspace -> delete workd
;; check with 'cat' the code used by Ctrl+Backspace
(defun backward-kill-word-smart ()
  (interactive)
  (if (looking-back "[ \t]" 1)
      (progn
        (delete-region (save-excursion
                         (skip-chars-backward " \t")
                         (point))
                       (point)))
    (delete-region (save-excursion
                     (skip-chars-backward "^ \t")
                     (point))
                   (point))))
(global-set-key (kbd "C-h") 'backward-kill-word-smart)



;; Ctrl+p -> go to end of line
(define-key global-map (kbd "C-p") 'end-of-line)

;; Ctrl+o -> go to first char of the line
(global-set-key (kbd "C-o") 'back-to-indentation)

;; Ctrl+f -> select full block () {} []
(defun select-code-block ()
  (interactive)
  (let ((start (point)))
    (condition-case nil
        (progn
          (backward-up-list 1 t t)
          (set-mark-command nil)
          (forward-list)
          (exchange-point-and-mark))
      (error (goto-char start)))))
(define-key global-map (kbd "C-f") 'select-code-block)


;; Ctrl+l -> select all ligne
(defun select-current-line ()
  (interactive)
  (beginning-of-line)
  (set-mark-command nil)
  (end-of-line))
(define-key global-map (kbd "C-l") 'select-current-line)

;; Ctrl+g -> glue selection
(define-key global-map (kbd "C-g") 'set-mark-command)

(defun glue-select ()
  (interactive)
  (if (region-active-p)
      (keyboard-quit)
    (set-mark-command nil)))

(global-set-key (kbd "C-g") 'glue-select)


;; Alt+up/down -> move selection
(defun move-text-internal (arg)
  (cond
   ((and mark-active transient-mark-mode)
    (let ((col (current-column))
          (text (delete-and-extract-region (region-beginning) (region-end))))
      (forward-line arg)
      (move-to-column col)
      (set-mark (point))
      (insert text)
      (exchange-point-and-mark)
      (setq deactivate-mark nil)))
   (t
    (let ((col (current-column)))
      (beginning-of-line)
      (when (or (> arg 0) (not (bobp)))
        (forward-line)
        (transpose-lines arg)
        (forward-line -1))
      (move-to-column col)))))

(defun move-text-down (arg)
  (interactive "*p")
  (move-text-internal arg))
(global-set-key (kbd "M-<up>") 'move-text-up)

(defun move-text-up (arg)
  (interactive "*p")
  (move-text-internal (- arg)))
(global-set-key (kbd "M-<down>") 'move-text-down)














