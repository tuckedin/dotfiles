;send custom configurations to separate file (OS-based)
(defun get-custom-file-location ()
  (cond
   ((eq system-type 'windows-nt) "C:\\Users\\cooll\\AppData\\Roaming\\emacscustom.el")
   ((eq system-type 'gnu/linux) "~/.emacs.custom.el")))
(setq custom-file (get-custom-file-location))
(load-file custom-file)

;basic window setup
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(global-display-line-numbers-mode 1)

;font (OS-based)
(defun get-default-font ()
  (cond
   ((eq system-type 'windows-nt) "Consolas-11")
   ((eq system-type 'gnu/linux) "Isoevka-20")))
(add-to-list 'default-frame-alist `(font . ,(get-default-font)))

;autocompletion
(fido-vertical-mode 1)

;--------------------
;keybind changes
;--------------------

(global-set-key (kbd "s-x k") 'kill-buffer)
(global-set-key (kbd "C-x k") 'kill-this-buffer)

;--------------------
;functions
;--------------------

;line duplication
(defun duplicate-line ()
  "Duplicate current line"
  (interactive)
  (let ((column (- (point) (point-at-bol)))
        (line (let ((s (thing-at-point 'line t)))
                (if s (string-remove-suffix "\n" s) ""))))
    (move-end-of-line 1)
    (newline)
    (insert line)
    (move-beginning-of-line 1)
    (forward-char column)))
(global-set-key (kbd "C-,") 'duplicate-line)


;--------------------
;packages
;--------------------

;MELPA
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)


;org-roam
(defun get-notes-location ()
  (cond
   ((eq system-type 'windows-nt) "C:\\Users\\cooll\\Desktop\\notes")
   ((eq system-type 'gnu/linux) "~/notes")))

(use-package org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  (setq org-return-follows-link t)
  (setf (cdr (assoc 'file org-link-frame-setup)) 'find-file)
  (setq org-support-shift-select 1)
  :custom
  (org-roam-directory (get-notes-location))
  (org-roam-completion-everywhere t)
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         :map org-mode-map
         ("C-M-i"    . completion-at-point))
  :config
  (org-roam-setup))


;multiple cursors
(use-package multiple-cursors
  :ensure t)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->")         'mc/mark-next-like-this)
(global-set-key (kbd "C-<")         'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<")     'mc/mark-all-like-this)
(global-set-key (kbd "C-\"")        'mc/skip-to-next-like-this)
(global-set-key (kbd "C-:")         'mc/skip-to-previous-like-this)


(package-initialize)
