;; add-keybind does not exist in the default version of emacs, and this config should not
;; break the normal version of emacs, so add-keybind needs to be replaced with a stub
;; if it does not exist
(if (not (fboundp 'add-keybind))
    (defun add-keybind (map keys function)
      'nil)
  'nil
  )


;; somehow, these still got through even with no define-key...
(add-keybind global-map (kbd "C-f") 'nil)
(add-keybind global-map (kbd "C-b") 'nil)
(add-keybind global-map (kbd "C-x") 'nil)
(add-keybind global-map (kbd "M-c") 'nil)



(add-keybind global-map (kbd "C-h") 'describe-key-briefly)
(add-keybind global-map (kbd "<return>") 'newline)

(add-keybind global-map (kbd "<up>") 'previous-line)
(add-keybind global-map (kbd "<down>") 'next-line)
(add-keybind global-map (kbd "<left>") 'left-char)
(add-keybind global-map (kbd "<right>") 'right-char)
(add-keybind global-map (kbd "<prior>") 'scroll-down-command)
(add-keybind global-map (kbd "<next>") 'scroll-up-command)
(add-keybind global-map (kbd "<mouse-1>") 'mouse-set-point)
(add-keybind global-map (kbd "<mouse-2>") 'mouse-yank-primary)

(add-keybind global-map (kbd "C-q") 'save-buffers-kill-terminal)
(add-keybind global-map (kbd "C-o") 'find-file)

(add-keybind global-map (kbd "C-a") 'move-beginning-of-line)
(add-keybind global-map (kbd "C-e") 'move-end-of-line)
(add-keybind global-map (kbd "<backspace>") 'delete-backward-char)
(add-keybind global-map (kbd "<delete>") 'delete-forward-char)

(add-keybind minibuffer-local-map (kbd "<return>") 'exit-minibuffer)
(add-keybind minibuffer-local-must-match-map (kbd "<return>") 'minibuffer-complete-and-exit)
(add-keybind global-map (kbd "<escape>") 'keyboard-escape-quit)

(add-keybind global-map (kbd "<C-backspace>") 'backward-kill-word)
(add-keybind global-map (kbd "C-s") 'save-buffer)

(add-keybind global-map (kbd "C-v") 'yank)
(add-keybind global-map (kbd "M-v") 'yank-pop)
(add-keybind global-map (kbd "C-z") 'undo)
(add-keybind global-map (kbd "C-x") 'kill-region)
(add-keybind global-map (kbd "C-c") 'kill-ring-save)

(add-keybind emacs-lisp-mode-map (kbd "C-b") 'eval-buffer)


(add-keybind global-map (kbd "M-3") 'split-window-horizontally)
(add-keybind global-map (kbd "M-2") 'split-window-vertically)
(add-keybind global-map (kbd "M-0") 'delete-window)
(add-keybind global-map (kbd "<f11>") 'toggle-frame-fullscreen)
(add-keybind global-map (kbd "M-o") 'other-window)
(add-keybind global-map (kbd "M-b") 'next-buffer)
(add-keybind global-map (kbd "C-w") 'kill-this-buffer)

(add-keybind global-map (kbd "<mouse-4>") 'mwheel-scroll)
(add-keybind global-map (kbd "<mouse-5>") 'mwheel-scroll)
(add-keybind global-map (kbd "C-f") 'isearch-forward)

(add-keybind global-map (kbd "<tab>") 'indent-for-tab-command)



(defun backspace-whitespace ()
  (interactive)
  (setq deleted-something nil)
  (while (string-match " " (string (preceding-char)))
    (backward-delete-char 1)
    (setq deleted-something t))
  (if (string-match "\n" (string (preceding-char)))
      (setq deleted-something t))
  (if (string-match "\n" (string (preceding-char)))
      (backward-delete-char 1))
  (if (not deleted-something)
      (backward-delete-char 1)))
(add-keybind global-map [backspace] 'backspace-whitespace)


;; Bright-red TODOs.
(setq fixme-modes '(c++-mode c-mode emacs-lisp-mode python-mode))
(make-face 'font-lock-fixme-face)
(make-face 'font-lock-note-face)
(mapc (lambda (mode)
        (font-lock-add-keywords
         mode
         '(("\\<\\(TODO\\)" 1 'font-lock-fixme-face t)
           ("\\<\\(NOTE\\)" 1 'font-lock-note-face t))))
      fixme-modes)
(modify-face 'font-lock-fixme-face "Red" nil nil t nil t nil nil)
(modify-face 'font-lock-note-face "Dark Green" nil nil t nil t nil nil)



(defun find-corresponding-file ()
  "Find the file that corresponds to this one."
  (interactive)
  (setq CorrespondingFileName nil)
  (setq BaseFileName (file-name-sans-extension buffer-file-name))
  (if (string-match "\\.c" buffer-file-name)
      (setq CorrespondingFileName (concat BaseFileName ".h")))
  (if (string-match "\\.h" buffer-file-name)
      (if (file-exists-p (concat BaseFileName ".c")) (setq CorrespondingFileName (concat BaseFileName ".c"))
	(setq CorrespondingFileName (concat BaseFileName ".cpp"))))
  (if (string-match "\\.cpp" buffer-file-name)
      (setq CorrespondingFileName (concat BaseFileName ".h")))
  (if CorrespondingFileName (find-file CorrespondingFileName)
    (error "Unable to find a corresponding file")))

(add-keybind global-map (kbd "<f12>") 'find-corresponding-file)



(setq inhibit-startup-screen t)
(setq make-backup-files nil)
(setq vc-handled-backends nil)


(set-frame-parameter nil 'fullscreen 'fullboth)
(scroll-bar-mode -1)
(tool-bar-mode 0)

(package-initialize)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl ())
  ;; (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  (add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  )
(package-initialize)


(require 'evil)
(evil-mode)


(defun dead () (interactive) 'nil)

(add-keybind evil-normal-state-map (kbd "`") 'dead)
(add-keybind evil-normal-state-map (kbd "1") 'dead)
(add-keybind evil-normal-state-map (kbd "2") 'dead)
(add-keybind evil-normal-state-map (kbd "3") 'dead)
(add-keybind evil-normal-state-map (kbd "4") 'dead)
(add-keybind evil-normal-state-map (kbd "5") 'dead)
(add-keybind evil-normal-state-map (kbd "6") 'dead)
(add-keybind evil-normal-state-map (kbd "7") 'dead)
(add-keybind evil-normal-state-map (kbd "8") 'dead)
(add-keybind evil-normal-state-map (kbd "9") 'dead)
(add-keybind evil-normal-state-map (kbd "0") 'dead)
(add-keybind evil-normal-state-map (kbd "-") 'dead)
(add-keybind evil-normal-state-map (kbd "=") 'dead)

(add-keybind evil-normal-state-map (kbd "q") 'dead)
(add-keybind evil-normal-state-map (kbd "w") 'left-char)
(add-keybind evil-normal-state-map (kbd "e") 'backward-paragraph)
(add-keybind evil-normal-state-map (kbd "r") 'dead)
(add-keybind evil-normal-state-map (kbd "t") 'dead)
(add-keybind evil-normal-state-map (kbd "y") 'dead)
(add-keybind evil-normal-state-map (kbd "u") 'dead)
(add-keybind evil-normal-state-map (kbd "i") 'evil-insert)
(add-keybind evil-normal-state-map (kbd "o") 'dead)
(add-keybind evil-normal-state-map (kbd "p") 'dead)
(add-keybind evil-normal-state-map (kbd "[") 'dead)
(add-keybind evil-normal-state-map (kbd "]") 'dead)

(add-keybind evil-normal-state-map (kbd "a") 'dead)
(add-keybind evil-normal-state-map (kbd "s") 'dead)
(add-keybind evil-normal-state-map (kbd "d") 'forward-paragraph)
(add-keybind evil-normal-state-map (kbd "f") 'right-char)
(add-keybind evil-normal-state-map (kbd "g") 'dead)
(add-keybind evil-normal-state-map (kbd "h") 'dead)
(add-keybind evil-normal-state-map (kbd "j") 'dead)
(add-keybind evil-normal-state-map (kbd "k") 'previous-line)
(add-keybind evil-normal-state-map (kbd "l") 'right-word)
(add-keybind evil-normal-state-map (kbd ";") 'dead)
(add-keybind evil-normal-state-map (kbd "'") 'dead)
(add-keybind evil-normal-state-map (kbd "\\") 'dead)

(add-keybind evil-normal-state-map (kbd "z") 'dead)
(add-keybind evil-normal-state-map (kbd "x") 'dead)
(add-keybind evil-normal-state-map (kbd "c") 'dead)
(add-keybind evil-normal-state-map (kbd "v") 'dead)
(add-keybind evil-normal-state-map (kbd "b") 'dead)
(add-keybind evil-normal-state-map (kbd "n") 'dead)
(add-keybind evil-normal-state-map (kbd "m") 'left-word)
(add-keybind evil-normal-state-map (kbd ",") 'next-line)
(add-keybind evil-normal-state-map (kbd ".") 'dead)
(add-keybind evil-normal-state-map (kbd "/") 'dead)

(add-keybind evil-insert-state-map (kbd "<escape>") 'evil-normal-state)
(add-keybind evil-normal-state-map (kbd "SPC") 'set-mark)



(add-keybind evil-normal-state-map (kbd "~") 'dead)
(add-keybind evil-normal-state-map (kbd "!") 'dead)
(add-keybind evil-normal-state-map (kbd "@") 'dead)
(add-keybind evil-normal-state-map (kbd "#") 'dead)
(add-keybind evil-normal-state-map (kbd "$") 'dead)
(add-keybind evil-normal-state-map (kbd "%") 'dead)
(add-keybind evil-normal-state-map (kbd "^") 'dead)
(add-keybind evil-normal-state-map (kbd "&") 'dead)
(add-keybind evil-normal-state-map (kbd "*") 'dead)
(add-keybind evil-normal-state-map (kbd "(") 'dead)
(add-keybind evil-normal-state-map (kbd ")") 'dead)
(add-keybind evil-normal-state-map (kbd "_") 'dead)
(add-keybind evil-normal-state-map (kbd "+") 'dead)

(add-keybind evil-normal-state-map (kbd "Q") 'dead)
(add-keybind evil-normal-state-map (kbd "W") 'dead)
(add-keybind evil-normal-state-map (kbd "E") 'dead)
(add-keybind evil-normal-state-map (kbd "R") 'dead)
(add-keybind evil-normal-state-map (kbd "T") 'dead)
(add-keybind evil-normal-state-map (kbd "Y") 'dead)
(add-keybind evil-normal-state-map (kbd "U") 'dead)
(add-keybind evil-normal-state-map (kbd "I") 'dead)
(add-keybind evil-normal-state-map (kbd "O") 'dead)
(add-keybind evil-normal-state-map (kbd "P") 'dead)
(add-keybind evil-normal-state-map (kbd "{") 'dead)
(add-keybind evil-normal-state-map (kbd "}") 'dead)

(add-keybind evil-normal-state-map (kbd "A") 'dead)
(add-keybind evil-normal-state-map (kbd "S") 'dead)
(add-keybind evil-normal-state-map (kbd "D") 'dead)
(add-keybind evil-normal-state-map (kbd "F") 'dead)
(add-keybind evil-normal-state-map (kbd "G") 'dead)
(add-keybind evil-normal-state-map (kbd "H") 'dead)
(add-keybind evil-normal-state-map (kbd "J") 'dead)

(add-keybind evil-normal-state-map (kbd "K") 'dead)
(add-keybind evil-normal-state-map (kbd "L") 'dead)
(add-keybind evil-normal-state-map (kbd ":") 'dead)
(add-keybind evil-normal-state-map (kbd "\"") 'dead)
(add-keybind evil-normal-state-map (kbd "|") 'dead)

(add-keybind evil-normal-state-map (kbd "Z") 'dead)
(add-keybind evil-normal-state-map (kbd "X") 'dead)
(add-keybind evil-normal-state-map (kbd "C") 'dead)
(add-keybind evil-normal-state-map (kbd "V") 'dead)
(add-keybind evil-normal-state-map (kbd "B") 'dead)
(add-keybind evil-normal-state-map (kbd "N") 'dead)
(add-keybind evil-normal-state-map (kbd "M") 'dead)
(add-keybind evil-normal-state-map (kbd "<") 'dead)
(add-keybind evil-normal-state-map (kbd ">") 'dead)
(add-keybind evil-normal-state-map (kbd "?") 'dead)


(add-keybind evil-normal-state-map "/" 'evil-search-forward)
(add-keybind evil-normal-state-map "n" 'evil-search-next)

(add-keybind isearch-mode-map "\C-f" 'isearch-yank-word-or-char)
(add-keybind isearch-mode-map (kbd "<return>") 'isearch-repeat-forward)
(add-keybind isearch-mode-map (kbd "<S-return>") 'isearch-repeat-backward)

(custom-set-variables
 '(evil-move-beyond-eol t)
 '(evil-move-cursor-back nil)
 '(package-selected-packages (quote (goto-chg))))
(custom-set-faces
 )
