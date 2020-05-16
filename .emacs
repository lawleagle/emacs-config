;; add-keybind does not exist in the default version of emacs, and this config should not throw errors because of it, so add-keybind is replaced with a stub that does nothing on versions of emacs that don't have it
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
;;(add-keybind global-map (kbd "<vertical-scroll-bar> <mouse-1>") 'i)

(setq inhibit-startup-screen t)
(setq make-backup-files nil)

(package-initialize)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
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
(add-keybind evil-normal-state-map (kbd "w") 'dead)
(add-keybind evil-normal-state-map (kbd "e") 'dead)
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
(add-keybind evil-normal-state-map (kbd "d") 'dead)
(add-keybind evil-normal-state-map (kbd "f") 'dead)
(add-keybind evil-normal-state-map (kbd "g") 'dead)
(add-keybind evil-normal-state-map (kbd "h") 'dead)
(add-keybind evil-normal-state-map (kbd "j") 'dead)
(add-keybind evil-normal-state-map (kbd "k") 'previous-line)
(add-keybind evil-normal-state-map (kbd "l") 'right-char)
(add-keybind evil-normal-state-map (kbd ";") 'dead)
(add-keybind evil-normal-state-map (kbd "'") 'dead)
(add-keybind evil-normal-state-map (kbd "\\") 'dead)

(add-keybind evil-normal-state-map (kbd "z") 'dead)
(add-keybind evil-normal-state-map (kbd "x") 'dead)
(add-keybind evil-normal-state-map (kbd "c") 'dead)
(add-keybind evil-normal-state-map (kbd "v") 'dead)
(add-keybind evil-normal-state-map (kbd "b") 'dead)
(add-keybind evil-normal-state-map (kbd "n") 'dead)
(add-keybind evil-normal-state-map (kbd "m") 'left-char)
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




(custom-set-variables
 '(evil-move-beyond-eol t)
 '(evil-move-cursor-back nil)
 '(package-selected-packages (quote (goto-chg))))
(custom-set-faces
 )
