;; add-keybind does not exist in the default version of emacs, and this config should not
;; break the normal version of emacs, so add-keybind needs to be replaced with a stub
;; if it does not exist
(if (not (fboundp 'add-keybind))
    (defun add-keybind (map keys function)
      'nil)
  'nil
  )

;; somebody complained that this function does not exist, so now it exists.
(defun tramp-theme-hook-function () 'nil)

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


(defun nil-bell ())
(setq ring-bell-function 'nil-bell)


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



(add-to-list 'default-frame-alist '(font . "Liberation Mono-11"))
(set-face-attribute 'default t :font "Liberation Mono-11")
;;(set-face-attribute 'font-lock-builtin-face nil :foreground "#DAB98F")
;;(set-face-attribute 'font-lock-comment-face nil :foreground "gray50")
;;(set-face-attribute 'font-lock-constant-face nil :foreground "olive drab")
;;(set-face-attribute 'font-lock-doc-face nil :foreground "gray50")
;;(set-face-attribute 'font-lock-function-name-face nil :foreground "burlywood3")
;;(set-face-attribute 'font-lock-keyword-face nil :foreground "DarkGoldenrod3")
;;(set-face-attribute 'font-lock-string-face nil :foreground "olive drab")
;;(set-face-attribute 'font-lock-type-face nil :foreground "burlywood3")
;;(set-face-attribute 'font-lock-variable-name-face nil :foreground "burlywood3")
(defun post-load-stuff ()
  (interactive)
  (menu-bar-mode -1)
  (set-foreground-color "burlywood3")
  (set-background-color "#161616")
  (set-cursor-color "#40FF40"))
;;(add-hook 'window-setup-hook 'post-load-stuff t)



;; Set transparency of emacs
(defun transparency ()
  "Sets the transparency of the frame window. 0=transparent/100=opaque"
  (interactive "nTransparency Value 0 - 100 opaque:")
  (set-frame-parameter (selected-frame) 'alpha 100))
(transparency)



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
(add-keybind evil-normal-state-map (kbd "[") 'start-kbd-macro)
(add-keybind evil-normal-state-map (kbd "]") 'end-kbd-macro)


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
(add-keybind evil-normal-state-map (kbd "\\") 'call-last-kbd-macro)

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
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-term-color-vector
   [unspecified "#1e1f29" "#ff5c57" "#5af78e" "#f3f99d" "#57c7ff" "#ff6ac1" "#57c7ff" "#eff0eb"])
 '(beacon-color "#ed0547ad8099")
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#839496")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-enabled-themes (quote (srcery)))
 '(custom-safe-themes
   (quote
    ("27b97024320d223cbe0eb73104f2be8fcc55bd2c299723fc61d20057f313b51c"
     "dd2346baba899fa7eee2bba4936cfcdf30ca55cdc2df0a1a4c9808320c4d4b22"
     "2ed177de0dfc32a6a32d6109ddfd1782a61bcc23916b7b967fa212666d1aa95c"
     "cffc64e7e3f0639cfeee833856beeb879e8f03e47901b24ca6ddd67d9a761df5"
     "a8021746a98a8147069ce4f31e14368c4e7dcf334fe1adff1408b4590d15fb4d"
     "8c01cb4cf9ee298d30a0456b1e90c575d8f5a047e35a5380a5f955c59ed17d2f"
     "d2a14f85e1ba5b28433b96e4628444a4c6a2334368ddc2d568b06eb631492681"
     "0141fea4ffa9c1fa02834b8681bdddac1b5e7e2bfce6b3c77c5cf0fc604ee8e3"
     "9fcc7f1f4c90b6cd8507984c1628061d6c3f7cf0307777da25aa1ef4b11e1d91"
     "390af3f30c5d5b76739983cf8b85c8bbd04a46ac1488b11d150dec565ba82f55"
     "f544e09cb6c2a1047a751bcf5623ad70eb45981847b1c673263ce7de4858ae6b"
     "180821795742c64e155841e8f9351b9d818e865d79dfc72f1aeab16b8724c9e4"
     "e6cdd07a8475458edf8dfd8b5cb3d81c6bb9aa0cb8535322c21d2e242dd044ed"
     "7de0917b4064219c0580397495d47b89a5f93d76724504d0ea8d2eea83542167"
     "2f26d251e2b0d11e0a5f16b21785ab42192374259cfe41eed67262869c1b387f"
     "7356632cebc6a11a87bc5fcffaa49bae528026a78637acd03cae57c091afd9b9"
     "04dd0236a367865e591927a3810f178e8d33c372ad5bfef48b5ce90d4b476481"
     "ab04c00a7e48ad784b52f34aa6bfa1e80d0c3fcacc50e1189af3651013eb0d58"
     "a0feb1322de9e26a4d209d1cfa236deaf64662bb604fa513cca6a057ddf0ef64"
     "5e3fc08bcadce4c6785fc49be686a4a82a356db569f55d411258984e952f194a"
     "7153b82e50b6f7452b4519097f880d968a6eaf6f6ef38cc45a144958e553fbc6"
     "5a0eee1070a4fc64268f008a4c7abfda32d912118e080e18c3c865ef864d1bea"
     "c3e6b52caa77cb09c049d3c973798bc64b5c43cc437d449eacf35b3e776bf85c"
     "70f5a47eb08fe7a4ccb88e2550d377ce085fedce81cf30c56e3077f95a2909f2"
     "59171e7f5270c0f8c28721bb96ae56d35f38a0d86da35eab4001aebbd99271a8"
     "5b340b4eb24c3c006972f3bc3aee26b7068f89ba9580d9a4211c1db5d0a70ea2"
     "431bd1db6a749936af5f891c9e3b6f23acbac275fc6073da48bc63db82dca1fa"
     "45caeeb594422c20499f96b51c73f9bc04d666983d0a1d16f5b9f51a9ec874fa"
     "a455366c5cdacebd8adaa99d50e37430b0170326e7640a688e9d9ad406e2edfd"
     "be5b03913a1aaa3709d731e1fcfd4f162db6ca512df9196c8d4693538fa50b86"
     "7bd626fcc9fbfb44186cf3f08b8055d5a15e748d5338e47f9391d459586e20db"
     "392f19e7788de27faf128a6f56325123c47205f477da227baf6a6a918f73b5dc"
     "2d5c40e709543f156d3dee750cd9ac580a20a371f1b1e1e3ecbef2b895cf0cd2"
     "39a854967792547c704cbff8ad4f97429f77dfcf7b3b4d2a62679ecd34b608da"
     "0c5204945ca5cdf119390fe7f0b375e8d921e92076b416f6615bbe1bd5d80c88"
     "9bd5ee2b24759fbc97f86c2783d1bf8f883eb1c0dd2cf7bda2b539cd28abf6a9"
     "a513bb141af8ece2400daf32251d7afa7813b3a463072020bb14c82fd3a5fe30"
     "77515a438dc348e9d32310c070bfdddc5605efc83671a159b223e89044e4c4f1"
     "da8e6e5b286cbcec4a1a99f273a466de34763eefd0e84a41c71543b16cd2efac"
     "5c83b15581cb7274085ba9e486933062652091b389f4080e94e4e9661eaab1aa"
     "3fe4861111710e42230627f38ebb8f966391eadefb8b809f4bfb8340a4e85529"
     "67b11ee5d10f1b5f7638035d1a38f77bca5797b5f5b21d16a20b5f0452cbeb46"
     "6e03b7f86fcca5ce4e63cda5cd0da592973e30b5c5edf198eddf51db7a12b832"
     "db510eb70cf96e3dbd48f5d24de12b03db30674ea0853f06074d4ccf7403d7d3"
     "05d009b7979e3887c917ef6796978d1c3bbe617e6aa791db38f05be713da0ba0"
     "1a094b79734450a146b0c43afb6c669045d7a8a5c28bc0210aba28d36f85d86f"
     "8530b2f7b281ea6f263be265dd8c75b502ecd7a30b9a0f28fa9398739e833a35"
     "4c8372c68b3eab14516b6ab8233de2f9e0ecac01aaa859e547f902d27310c0c3"
     "b8c5adfc0230bd8e8d73450c2cd4044ad7ba1d24458e37b6dec65607fc392980"
     "5eb4b22e97ddb2db9ecce7d983fa45eb8367447f151c7e1b033af27820f43760"
     "ed92c27d2d086496b232617213a4e4a28110bdc0730a9457edf74f81b782c5cf"
     "595099e6f4a036d71de7e1512656e9375dd72cf60ff69a5f6d14f0171f1de9c1"
     "11e5e95bd3964c7eda94d141e85ad08776fbdac15c99094f14a0531f31a156da"
     "f831c1716ebc909abe3c851569a402782b01074e665a4c140e3e52214f7504a0"
     "6cf0e8d082a890e94e4423fc9e222beefdbacee6210602524b7c84d207a5dfb5"
     "9dc64d345811d74b5cd0dac92e5717e1016573417b23811b2c37bb985da41da2"
     "9a3c51c59edfefd53e5de64c9da248c24b628d4e78cc808611abd15b3e58858f"
     "09feeb867d1ca5c1a33050d857ad6a5d62ad888f4b9136ec42002d6cdf310235"
     "b4fd44f653c69fb95d3f34f071b223ae705bb691fb9abaf2ffca3351e92aa374"
     "d9e811d5a12dec79289c5bacaecd8ae393d168e9a92a659542c2a9bab6102041"
     "57d7e8b7b7e0a22dc07357f0c30d18b33ffcbb7bcd9013ab2c9f70748cfa4838"
     "63aff36a40f41b28b0265ac506faa098fd552fac0a1813b745ba7c27efa5a943"
     "780c67d3b58b524aa485a146ad9e837051918b722fd32fd1b7e50ec36d413e70"
     "a11043406c7c4233bfd66498e83600f4109c83420714a2bd0cd131f81cbbacea"
     "fe349b21bb978bb1f1f2db05bc87b2c6d02f1a7fe3f27584cd7b6fbf8e53391a"
     "aad7fd3672aad03901bf91e338cd530b87efc2162697a6bef79d7f8281fd97e3"
     "fc1137ae841a32f8be689e0cfa07c872df252d48426a47f70dba65f5b0f88ac4"
     "0ca71d3462db28ebdef0529995c2d0fdb90650c8e31631e92b9f02bd1bfc5f36"
     "cb39485fd94dabefc5f2b729b963cbd0bac9461000c57eae454131ed4954a8ac"
     "1f126eb4a1e5d6b96b3faf494c8c490f1d1e5ad4fc5a1ce120034fe140e77b88"
     "2ae4b0c50dd49a5f74edeae3e49965bf8853954b63c5712a7967ea0a008ecd5b"
     "5f4dfda04fbf7fd55228266c8aab73953d3087cea7fd06dd7f8ff1e4a497c739"
     "3ed2e1653742e5059e3d77af013ee90c1c1b776d83ec33e1a9ead556c19c694b"
     "b5cff93c3c6ed12d09ce827231b0f5d4925cfda018c9dcf93a2517ce3739e7f1"
     "8e7044bfad5a2e70dfc4671337a4f772ee1b41c5677b8318f17f046faa42b16b"
     "31772cd378fd8267d6427cec2d02d599eee14a1b60e9b2b894dd5487bd30978e"
     "4bcdfc98cf64ce6145684dc8288fd87489cfa839e07f95f6c791d407624d04f8"
     "335ad769bcd7949d372879ec10105245255beec6e62213213835651e2eb0b8e0"
     "6c0d748fb584ec4c8a0a1c05ce1ae8cde46faff5587e6de1cc59d3fc6618e164"
     "6291d73aaeb6a3d7e455d85ca3865260a87afe5f492b6d0e2e391af2d3ea81dd"
     "01e0367d8c3249928a2e0ebc9807b2f791f81a0d2a7c8656e1fbf4b1dbaa404c"
     "6b4f7bde1ce64ea4604819fe56ff12cda2a8c803703b677fdfdb603e8b1f8bcb"
     "cb30d82b05359203c8378638dec5ad6e37333ccdda9dee8b9fdf0c902e83fad7"
     "28818b9b1d9e58c4fb90825a1b07b0f38286a7d60bf0499bc2dea7eea7e36782"
     "011d4421eedbf1a871d1a1b3a4d61f4d0a2be516d4c94e111dfbdc121da0b043"
     "70b2d5330a8dd506accac4b51aaa7e43039503d000852d7d152aec2ce779d96d"
     "995d0754b79c4940d82bd430d7ebecca701a08631ec46ddcd2c9557059758d33"
     "b6f06081b007b57be61b82fb53f27315e2cf38fa690be50d6d63d2b62a408636"
     "5c5de678730ceb4e05794431dd65f30ffe9f1ed6c016fa766cdf909ba03e4df4"
     "ec0c9d1715065a594af90e19e596e737c7b2cdaa18eb1b71baf7ef696adbefb0"
     "9d9b2cf2ced850aad6eda58e247cf66da2912e0722302aaa4894274e0ea9f894"
     "aaf783d4bfae32af3e87102c456fba8a85b79f6e586f9911795ea79055dee3bf"
     "aae40caa1c4f1662f7cae1ebfbcbb5aa8cf53558c81f5bc15baefaa2d8da0241"
     "2047464bf6781156ebdac9e38a17b97bd2594b39cfeaab561afffcbbe19314e2"
     "0f302165235625ca5a827ac2f963c102a635f27879637d9021c04d845a32c568"
     "62a6731c3400093b092b3837cff1cb7d727a7f53059133f42fcc57846cfa0350"
     "76935a29af65f8c915b1b3b4f6326e2e8d514ca098bd7db65b0caa533979fc01"
     "880f541eabc8c272d88e6a1d8917fe743552f17cedd8f138fe85987ee036ad08"
     "1a2cde373eff9ffd5679957c7ecfc6249d353e1ee446d104459e73e924fe0d8a"
     "a621dd9749f2651e357a61f8d8d2d16fb6cacde3b3784d02151952e1b9781f05"
     "53de65a1e7300e0f1a4f8bf317530a5008e9d06a0e2f8863b80dc56d77f844cf"
     "938f120eeda938eef2c36b4cc9609d1ad91b3a3666cd63a4be5b70b739004942"
     "45482e7ddf47ab1f30fe05f75e5f2d2118635f5797687e88571842ff6f18b4d5"
     "bce1c321471d37b875f99c83cb7b451fd8386001259e1c0909d6e078ea60f00b"
     "f19d195fa336e9904303eea20aad35036b79cfde72fa6e76b7462706acd52920"
     "2ea9afebc23cca3cd0cd39943b8297ce059e31cb62302568b8fa5c25a22db5bc"
     "44f5578eccb2cde3b196dfa86a298b75fe39ceff975110c091fa8c874c338b50"
     "1342a81078bdac27f80b86807b19cb27addc1f9e4c6a637a505ae3ba4699f777"
     "80a23d559a5c5343a0882664733fd2c9e039b4dbf398c70c424c8d6858b39fc5"
     "1c10e946f9a22b28613196e4c02b6508970e3b34660282ec92d9a1c293ee81bb"
     "68b847fac07094724e552eeaf96fa4c7e20824ed5f3f225cad871b8609d50ace"
     "a5a2954608aac5c4dcf9659c07132eaf0da25a8f298498a7eacf97e2adb71765"
     "cc2f32f5ee19cbd7c139fc821ec653804fcab5fcbf140723752156dc23cdb89f"
     "d422c7673d74d1e093397288d2e02c799340c5dabf70e87558b8e8faa3f83a6c"
     "c51e302edfe6d2effca9f7c9a8a8cfc432727efcf86246002a3b45e290306c1f"
     "b48599e24e6db1ea612061252e71abc2c05c05ac4b6ad532ad99ee085c7961a7"
     "daeaa8249f0c275de9e32ed822e82ff40457dabe07347fe06afc67d962a3b1e9"
     "ff6a8955945028387ed1a2b0338580274609fbb0d40cd011b98ca06bd00d9233"
     "5e402ccb94e32d7d09e300fb07a62dc0094bb2f16cd2ab8847b94b01b9d5e866"
     "6a674ffa24341f2f129793923d0b5f26d59a8891edd7d9330a258b58e767778a"
     "4e7e04c4b161dd04dc671fb5288e3cc772d9086345cb03b7f5ed8538905e8e27"
     "701b4b4e7989329a0704b92fc17e6600cc18f9df4f2466617ec91c932b5477eb"
     "ff8c6c2eb94e776c9eed9299a49e07e70e1b6a6f926dec429b99cf5d1ddca62a"
     "b71da830ae97a9b70d14348781494b6c1099dbbb9b1f51494c3dfa5097729736"
     "1127f29b2e4e4324fe170038cbd5d0d713124588a93941b38e6295a58a48b24f"
     "abd7719fd9255fcd64f631664390e2eb89768a290ee082a9f0520c5f12a660a8"
     "0973b33d2f15e6eaf88400eee3dc8357ad8ae83d2ca43c125339b25850773a70"
     "deb7ae3a735635a85c984ece4ce70317268df6027286998b0ea3d10f00764c9b"
     "e26e879d250140e0d4c4d5ab457c32bcb29742599bd28c1ce31301344c6f2a11"
     "cdc2a7ba4ecf0910f13ba207cce7080b58d9ed2234032113b8846a4e44597e41"
     "a02c000c95c43a57fe1ed57b172b314465bd11085faf6152d151385065e0e4b1"
     "0e8c264f24f11501d3f0cabcd05e5f9811213f07149e4904ed751ffdcdc44739"
     "fb09acc5f09e521581487697c75b71414830b1b0a2405c16a9ece41b2ae64222"
     "72c530c9c8f3561b5ab3bf5cda948cd917de23f48d9825b7a781fe1c0d737f2f"
     "d8a7a7d2cffbc55ec5efbeb5d14a5477f588ee18c5cddd7560918f9674032727"
     "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328"
     "4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4"
     "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016"
     "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e"
     "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58"
     "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d"
     "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a"
     "f5f41901c774d420e39f960ad61812d9e17ce05574ef4e0b8bc493099affe627"
     "c1de07961a3b5b49bfd50080e7811eea9c949526084df8d64ce1b4e0fdc076ff"
     "addfaf4c6f76ef957189d86b1515e9cf9fcd603ab6da795b82b79830eed0b284"
     "8eafb06bf98f69bfb86f0bfcbe773b44b465d234d4b95ed7fa882c99d365ebfd"
     "ec5f761d75345d1cf96d744c50cf7c928959f075acf3f2631742d5c9fe2153ad"
     "fe1c13d75398b1c8fd7fdd1241a55c286b86c3e4ce513c4292d01383de152cb7"
     "21fb497b14820147b2b214e640b3c5ee19fcadc15bc288e3c16c9c9575d95d66"
     "2035a16494e06636134de6d572ec47c30e26c3447eafeb6d3a9e8aee73732396"
     "8a379e7ac3a57e64de672dd744d4730b3bdb88ae328e8106f95cd81cbd44e0b6"
     "a3fa4abaf08cc169b61dea8f6df1bbe4123ec1d2afeb01c17e11fdc31fc66379"
     "d2e9c7e31e574bf38f4b0fb927aaff20c1e5f92f72001102758005e53d77b8c9"
     "f0dc4ddca147f3c7b1c7397141b888562a48d9888f1595d69572db73be99a024"
     "3a3de615f80a0e8706208f0a71bbcc7cc3816988f971b6d237223b6731f91605"
     "fe666e5ac37c2dfcf80074e88b9252c71a22b6f5d2f566df9a7aa4f9bea55ef8"
     "b35a14c7d94c1f411890d45edfb9dc1bd61c5becd5c326790b51df6ebf60f402"
     "4697a2d4afca3f5ed4fdf5f715e36a6cac5c6154e105f3596b44a4874ae52c45"
     "b54826e5d9978d59f9e0a169bbd4739dd927eead3ef65f56786621b53c031a7c"
     "6b2636879127bf6124ce541b1b2824800afc49c6ccd65439d6eb987dbf200c36"
     "cd736a63aa586be066d5a1f0e51179239fe70e16a9f18991f6f5d99732cabb32"
     "d1b4990bd599f5e2186c3f75769a2c5334063e9e541e37514942c27975700370"
     "151bde695af0b0e69c3846500f58d9a0ca8cb2d447da68d7fbf4154dcf818ebc"
     "ecba61c2239fbef776a72b65295b88e5534e458dfe3e6d7d9f9cb353448a569e"
     "93a0885d5f46d2aeac12bf6be1754faa7d5e28b27926b8aa812840fe7d0b7983"
     "6b289bab28a7e511f9c54496be647dc60f5bd8f9917c9495978762b99d8c96a0"
     "356e5cbe0874b444263f3e1f9fffd4ae4c82c1b07fe085ba26e2a6d332db34dd"
     "1c082c9b84449e54af757bcae23617d11f563fc9f33a832a8a2813c4d7dfb652"
     "8438ae81ffa7e54f87a6361c4f71129f8df14ebb69bd57e4e919ac84fde6c73a"
     "63672954a3450ec5ae8d9be4ec1c3d321ba0de3eff27b59d6b040ffa9296122b"
     "196d111a2fa54d8e2a89ff3fb236ceaceb225c6d5512ba25e3440498baa9d640"
     "c03971de0943d7ad6a7ca5bab3c92801fc57e2a73e5e3c0da4cbff38cc3049c1"
     "fb9b8800f74ef69db9653251fa24cec64e27059b7eb2bff2aaf2894a05f68fe1"
     "6383f86cac149fb10fc5a2bac6e0f7985d9af413c4be356cab4bfea3c08f3b42"
     "d7441a80851d30a369268e50bbad6777a82ff37405f70328f21a8f30a7c6e31d"
     "115d42fa02a5ce6a759e38b27304e833d57a48422c2408d5455f14450eb96554"
     "8343be3a733414342075a9a42c6fa1ee9f64c2af179e5fec68febba34f05bd06"
     "89336ca71dae5068c165d932418a368a394848c3b8881b2f96807405d8c6b5b6"
     "a22f40b63f9bc0a69ebc8ba4fbc6b452a4e3f84b80590ba0a92b4ff599e53ad0"
     "8f97d5ec8a774485296e366fdde6ff5589cf9e319a584b845b6f7fa788c9fa9a"
     "585942bb24cab2d4b2f74977ac3ba6ddbd888e3776b9d2f993c5704aa8bb4739"
     "b583823b9ee1573074e7cbfd63623fe844030d911e9279a7c8a5d16de7df0ed0"
     "2b9dc43b786e36f68a9fd4b36dd050509a0e32fe3b0a803310661edb7402b8b6"
     "8e797edd9fa9afec181efbfeeebf96aeafbd11b69c4c85fa229bb5b9f7f7e66c"
     "1436d643b98844555d56c59c74004eb158dc85fc55d2e7205f8d9b8c860e177f"
     "b25964a29dbf00628876a845ee6b5f26784928f4d1a10576ac3765495ea59c64"
     "b48150eac948d6de3f8103e6e92f105979277b91c96e9687c13f2d80977d381d"
     "fcecf5757b909acbacc4fea2fa6a5fb9a63776be43cbff1dc0dffc9c02674478"
     "0eb3c0868ff890b0c4ee138069ce2a8936a8a69ba150efa6bfb9fb7c05af5ec3"
     "2f945b8cbfdd750aeb82c8afb3753ebf76a1c30c2b368d9d1f13ca3cc674c7bc"
     "f47f2c6b2052c81ecf8f2da64f481a92b53a3fd17680b054ea9b81c916dee4b9"
     "a70b47c87e9b0940f6fece46656200acbfbc55e129f03178de8f50934ac89f58"
     "b69323309e5839676409607f91c69da2bf913914321c995f63960c3887224848"
     "1f36ca86913068b7d8377a327394eecfff71be34119619f779cb229875ceec0c"
     "7533e1fc8345739ea0ace60330ebffdf9da46398490b4c36c7e48775e5621052"
     "ea44def1fa1b169161512d79a65f54385497a6a5fbc96d59c218f852ce35b2ab"
     "53993d7dc1db7619da530eb121aaae11c57eaf2a2d6476df4652e6f0bd1df740"
     "83ec4c87dac3a99036129a674ec2ef50468b3a854098e994e9b6a226ab63510b"
     "f0a76ae259b7be77e59f98501957eb45a10af0839dd9eb29fdd5691ed74771d4"
     "3ee39fe8a6b6e0f1cbdfa33db1384bc778e3eff4118daa54af7965e9ab8243b3"
     "7e7c9639e7b83c3271e427becc0336b85116cee201b11b7b8e9e9474c812633d"
     "89c937a845f927206e7039af4ca3aa8b18f2dfcd49b342e6ee76406cdc5d2879"
     "732b807b0543855541743429c9979ebfb363e27ec91e82f463c91e68c772f6e3"
     "a24c5b3c12d147da6cef80938dca1223b7c7f70f2f382b26308eba014dc4833a"
     "8136cbb3b29b4c86ca3354d85005f527adcf9393b227980fc144a2c24ba63688"
     "5f27195e3f4b85ac50c1e2fac080f0dd6535440891c54fcfa62cdcefedf56b1b"
     "2f500eee0a1d3cba9a69f2b599f6edcf147626bb14c44ba1a1172b81b61168bf"
     "4aa183d57d30044180d5be743c9bd5bf1dde686859b1ba607b2eea26fe63f491"
     "af6d045e678f37d548bad4829c09e4ee57841fb0fc94138cbee3a49ec8417177"
     "4ea1959cfaa526b795b45e55f77724df4be982b9cd33da8d701df8cdce5b2955"
     "89f231794114755aaf2e60ac800c4b19ac82010fccbf4f8bc83df7b9b5c8137c"
     "dcf7154867ba67b250fe2c5cdc15a7d170acd9cbe6707cc36d9dd1462282224d"
     "00ec8d97422271b36fa865ecb0649b415c8394576dc844ab175e1f932515952a"
     "1debfdc8f9be3acb9d5c99bb595090ae899c68a4fed961b29bd1eb85ace15f38"
     "92747def068bb9aefaeacc149913ab8c349da57ceff2b86ed977995dfe6785b9"
     "41576d31aa4aba50b68c66bc186c4a756241e0745ad4d7ff0e25ecbc21642c0b"
     "08ba513f6b6cab24f4b338739f3d7a964737dd0b6fd1c0f26c3a2f6985abff96"
     "a5f068e6c26c2ed952096c034eb49f3ad15a329c905bf3475fae63c1ddb9f402"
     "e24354a65a015a7da682314ab0cea65346dec2fc8d51d3849e5b990673b992fd"
     "f09acf642ecd837d2691ba05c6f3e1d496f7930b45bf41903e7b37ea6579aa79"
     "ef0fa37f084e12ab30fdf09a5903d48c2bdadb094f413a40e9dbe84553dc3db8"
     "bdc90f305ecd4008fd39174adebfcdaf729e38aac1222a872b1f054d97adbc3d"
     "653574dd35a64b45030075c99bb9e73f26d8abc7f21e145321e64fa2659fb6f5"
     "b9e9ba5aeedcc5ba8be99f1cc9301f6679912910ff92fdf7980929c2fc83ab4d"
     "84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279"
     "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa"
     "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e"
     "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223"
     "0fa684b6cf782ee4fef96863b4921641c8b38c9d246f4bddd1e9277369c3e02a"
     "b3bcf1b12ef2a7606c7697d71b934ca0bdd495d52f901e73ce008c4c9825a3aa"
     "34ed3e2fa4a1cb2ce7400c7f1a6c8f12931d8021435bad841fdc1192bd1cc7da"
     "760ce657e710a77bcf6df51d97e51aae2ee7db1fba21bbad07aab0fa0f42f834"
     "c614d2423075491e6b7f38a4b7ea1c68f31764b9b815e35c9741e9490119efc0"
     "1d079355c721b517fdc9891f0fda927fe3f87288f2e6cc3b8566655a64ca5453"
     "a61109d38200252de49997a49d84045c726fa8d0f4dd637fce0b8affaa5c8620"
     "cabc32838ccceea97404f6fcb7ce791c6e38491fd19baa0fcfb336dcc5f6e23c"
     "b67b2279fa90e4098aa126d8356931c7a76921001ddff0a8d4a0541080dee5f6"
     "3e34e9bf818cf6301fcabae2005bba8e61b1caba97d95509c8da78cff5f2ec8e"
     "0961d780bd14561c505986166d167606239af3e2c3117265c9377e9b8204bf96"
     "fc7fd2530b82a722ceb5b211f9e732d15ad41d5306c011253a0ba43aaf93dccc"
     "732ccca2e9170bcfd4ee5070159923f0c811e52b019106b1fc5eaa043dff4030"
     "41eb3fe4c6b80c7ad156a8c52e9dd6093e8856c7bbf2b92cc3a4108ceb385087"
     "69e7e7069edb56f9ed08c28ccf0db7af8f30134cab6415d5cf38ec5967348a3c"
     "45a8b89e995faa5c69aa79920acff5d7cb14978fbf140cdd53621b09d782edcf"
     "ec3e6185729e1a22d4af9163a689643b168e1597f114e1cec31bdb1ab05aa539"
     "ffac21ab88a0f4603969a24b96993bd73a13fe0989db7ed76d94c305891fad64"
     "304c39b190267e9b863c0cf9c989da76dcfbb0649cbcb89592e7c5c08348fce9"
     "542e6fee85eea8e47243a5647358c344111aa9c04510394720a3108803c8ddd1"
     "b0c5c6cc59d530d3f6fbcfa67801993669ce062dda1435014f74cafac7d86246"
     "f5f3a6fb685fe5e1587bafd07db3bf25a0655f3ddc579ed9d331b6b19827ea46"
     "428bdd4b98d4d58cd094e7e074c4a82151ad4a77b9c9e30d75c56dc5a07f26c5"
     "04790c9929eacf32d508b84d34e80ad2ee233f13f17767190531b8b350b9ef22"
     "a62f0662e6aa7b05d0b4493a8e245ab31492765561b08192df61c9d1c7e1ddee"
     "840db7f67ce92c39deb38f38fbc5a990b8f89b0f47b77b96d98e4bf400ee590a"
     "5a39d2a29906ab273f7900a2ae843e9aa29ed5d205873e1199af4c9ec921aaab"
     "1025e775a6d93981454680ddef169b6c51cc14cea8cb02d1872f9d3ce7a1da66"
     "808b47c5c5583b5e439d8532da736b5e6b0552f6e89f8dafaab5631aace601dd"
     "e1498b2416922aa561076edc5c9b0ad7b34d8ff849f335c13364c8f4276904f0"
     "264b639ee1d01cd81f6ab49a63b6354d902c7f7ed17ecf6e8c2bd5eb6d8ca09c"
     "36282815a2eaab9ba67d7653cf23b1a4e230e4907c7f110eebf3cdf1445d8370"
     "146061a7ceea4ccc75d975a3bb41432382f656c50b9989c7dc1a7bb6952f6eb4"
     "85d609b07346d3220e7da1e0b87f66d11b2eeddad945cac775e80d2c1adb0066"
     "9c4acf7b5801f25501f0db26ac3eee3dc263ed51afd01f9dcfda706a15234733"
     "f984e2f9765a69f7394527b44eaa28052ff3664a505f9ec9c60c088ca4e9fc0b"
     "dd4628d6c2d1f84ad7908c859797b24cc6239dfe7d71b3363ccdd2b88963f336"
     "16dd114a84d0aeccc5ad6fd64752a11ea2e841e3853234f19dc02a7b91f5d661"
     "2a998a3b66a0a6068bcb8b53cd3b519d230dd1527b07232e54c8b9d84061d48d"
     "b8929cff63ffc759e436b0f0575d15a8ad7658932f4b2c99415f3dde09b32e97"
     "9be1d34d961a40d94ef94d0d08a364c3d27201f3c98c9d38e36f10588469ea57"
     "73ad471d5ae9355a7fa28675014ae45a0589c14492f52c32a4e9b393fcc333fd"
     "93268bf5365f22c685550a3cbb8c687a1211e827edc76ce7be3c4bd764054bad"
     "1263771faf6967879c3ab8b577c6c31020222ac6d3bac31f331a74275385a452"
     "aea30125ef2e48831f46695418677b9d676c3babf43959c8e978c0ad672a7329"
     "36746ad57649893434c443567cb3831828df33232a7790d232df6f5908263692"
     "12670281275ea7c1b42d0a548a584e23b9c4e1d2dabb747fd5e2d692bcd0d39b"
     "8cf1002c7f805360115700144c0031b9cfa4d03edc6a0f38718cef7b7cabe382"
     "4a91a64af7ff1182ed04f7453bb5a4b0c3d82148d27db699df89a5f1d449e2a4"
     "6daa09c8c2c68de3ff1b83694115231faa7e650fdbb668bc76275f0f2ce2a437"
     "4feee83c4fbbe8b827650d0f9af4ba7da903a5d117d849a3ccee88262805f40d"
     "50d07ab55e2b5322b2a8b13bc15ddf76d7f5985268833762c500a90e2a09e7aa"
     "fee4e306d9070a55dce4d8e9d92d28bd9efe92625d2ba9d4d654fc9cd8113b7f"
     "100eeb65d336e3d8f419c0f09170f9fd30f688849c5e60a801a1e6addd8216cb"
     "d83e34e28680f2ed99fe50fea79f441ca3fddd90167a72b796455e791c90dc49"
     "ad16a1bf1fd86bfbedae4b32c269b19f8d20d416bd52a87cd50e355bf13c2f23"
     "6271fc9740379f8e2722f1510d481c1df1fcc43e48fa6641a5c19e954c21cc8f"
     "fec45178b55ad0258c5f68f61c9c8fd1a47d73b08fb7a51c15558d42c376083d"
     "8543b328ed10bc7c16a8a35c523699befac0de00753824d7e90148bca583f986"
     "dad1453029a183e5837ebfd7de65f74df7e06554e39468c758c8197bfa749fec"
     "3f67aee8f8d8eedad7f547a346803be4cc47c420602e19d88bdcccc66dba033b"
     "5b8eccff13d79fc9b26c544ee20e1b0c499587d6c4bfc38cabe34beaf2c2fc77"
     "d96587ec2c7bf278269b8ec2b800c7d9af9e22d816827639b332b0e613314dfd"
     "250268d5c0b4877cc2b7c439687f8145a2c85a48981f7070a72c7f47a2d2dc13"
     "d9dab332207600e49400d798ed05f38372ec32132b3f7d2ba697e59088021555"
     "196df8815910c1a3422b5f7c1f45a72edfa851f6a1d672b7b727d9551bb7c7ba"
     "350dc341799fbbb81e59d1e6fff2b2c8772d7000e352a5c070aa4317127eee94"
     "80930c775cef2a97f2305bae6737a1c736079fdcc62a6fdf7b55de669fbbcd13"
     "446cc97923e30dec43f10573ac085e384975d8a0c55159464ea6ef001f4a16ba"
     "7a2ac0611ded83cdd60fc4de55ba57d36600eae261f55a551b380606345ee922"
     "d9850d120be9d94dd7ae69053630e89af8767c36b131a3aa7b06f14007a24656"
     "85e6bb2425cbfeed2f2b367246ad11a62fb0f6d525c157038a0d0eaaabc1bfee"
     "c968804189e0fc963c641f5c9ad64bca431d41af2fb7e1d01a2a6666376f819c"
     "527df6ab42b54d2e5f4eec8b091bd79b2fa9a1da38f5addd297d1c91aa19b616"
     "78c1c89192e172436dbf892bd90562bc89e2cc3811b5f9506226e735a953a9c6"
     "5a7830712d709a4fc128a7998b7fa963f37e960fd2e8aa75c76f692b36e6cf3c"
     "c9f102cf31165896631747fd20a0ca0b9c64ecae019ce5c2786713a5b7d6315e"
     "6145e62774a589c074a31a05dfa5efdf8789cf869104e905956f0cbd7eda9d0e"
     "ffe80c88e3129b2cddadaaf78263a7f896d833a77c96349052ad5b7753c0c5a5"
     "cbd8e65d2452dfaed789f79c92d230aa8bdf413601b261dbb1291fb88605110c"
     "df21cdadd3f0648e3106338649d9fea510121807c907e2fd15565dde6409d6e9"
     "4bf5c18667c48f2979ead0f0bdaaa12c2b52014a6abaa38558a207a65caeb8ad"
     "7a1190ad27c73888f8d16142457f59026b01fa654f353c17f997d83565c0fc65"
     "eae831de756bb480240479794e85f1da0789c6f2f7746e5cc999370bbc8d9c8a"
     "50b64810ed1c36dfb72d74a61ae08e5869edc554102f20e078b21f84209c08d1"
     "50ff65ab3c92ce4758cc6cd10ebb3d6150a0e2da15b751d7fbee3d68bba35a94"
     "986e7e8e428decd5df9e8548a3f3b42afc8176ce6171e69658ae083f3c06211c"
     "87d46d0ad89557c616d04bef34afd191234992c4eb955ff3c60c6aa3afc2e5cc"
     "ef04dd1e33f7cbd5aa3187981b18652b8d5ac9e680997b45dc5d00443e6a46e3"
     "25c242b3c808f38b0389879b9cba325fb1fa81a0a5e61ac7cae8da9a32e2811b"
     "0c3b1358ea01895e56d1c0193f72559449462e5952bded28c81a8e09b53f103f"
     "aded4ec996e438a5e002439d58f09610b330bbc18f580c83ebaba026bbef6c82"
     "60e09d2e58343186a59d9ed52a9b13d822a174b33f20bdc1d4abb86e6b17f45b"
     "cc71cf67745d023dd2e81f69172888e5e9298a80a2684cbf6d340973dd0e9b75"
     "3380a2766cf0590d50d6366c5a91e976bdc3c413df963a0ab9952314b4577299"
     "cea3ec09c821b7eaf235882e6555c3ffa2fd23de92459751e18f26ad035d2142"
     "722e1cd0dad601ec6567c32520126e42a8031cd72e05d2221ff511b58545b108"
     "7bef2d39bac784626f1635bd83693fae091f04ccac6b362e0405abf16a32230c"
     "3de3f36a398d2c8a4796360bfce1fa515292e9f76b655bb9a377289a6a80a132"
     "a85e40c7d2df4a5e993742929dfd903899b66a667547f740872797198778d7b5"
     "8be07a2c1b3a7300860c7a65c0ad148be6d127671be04d3d2120f1ac541ac103"
     "d2bd16a8bcf295dce0b70e1d2b5c17bb34cb28224a86ee770d56e6c22a565013"
     "25c06a000382b6239999582dfa2b81cc0649f3897b394a75ad5a670329600b45"
     "0598c6a29e13e7112cfbc2f523e31927ab7dce56ebb2016b567e1eff6dc1fd4f"
     "d91ef4e714f05fff2070da7ca452980999f5361209e679ee988e3c432df24347"
     "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0"
     "96bfc952ae7c93984085406c44d9ec3b98784a9de445d35958588ac9e303af1d"
     "a317b11ec40485bf2d2046d2936946e38a5a7440f051f3fcc4cdda27bde6c5d4"
     "439d4ce8295685fc36fc119a062d0283bb05436ae841b053af76e9a5e42bc670"
     "801a567c87755fe65d0484cb2bded31a4c5bb24fd1fe0ed11e6c02254017acb2"
     "dbade2e946597b9cda3e61978b5fcc14fa3afa2d3c4391d477bdaeff8f5638c5"
     "d6b0d76d584523e903ed1099a7f52619d21a23dc34404c115c65d6099c56ca5f"
     "d71af91a5c31ad4f8b751a3d5aa4104e705890bb5845faf78ae81c8309f38ed3"
     "6ebdb33507c7db94b28d7787f802f38ac8d2b8cd08506797b3af6cdfd80632e0"
     "b25040da50ef56b81165676fdf1aecab6eb2c928fac8a1861c5e7295d2a8d4dd"
     "ed4b75a4f5cf9b1cd14133e82ce727166a629f5a038ac8d91b062890bc0e2d1b"
     "0f63b94e366a6a9cd3ac12b3f5e7b88ba214fd592a99fb5bc55af33fb2280c7f"
     "c51345f0b4464f4b294d6fe26efc3df71c25e9af64e2fac0bb974d6d5643a127"
     "da1e1ed737a658c9d9490b29f88764bcde0c134c700962eb8622c47456f86d2e"
     "fca1a1be71d2ec3e18bb96d503ffbe8944eff4be60cdaa83924fd23e81a0e610"
     "65ee54db12a019dd5ad470567598652e619e255c37120dac028eb75c60e02ccc"
     "84890723510d225c45aaff941a7e201606a48b973f0121cb9bcb0b9399be8cba"
     "6fc18b6b991926ea5debf205ee144b1a1fdcfcb69236024cc0bd863b666a1a11"
     default)))
 '(diary-entry-marker (quote font-lock-variable-name-face))
 '(dired-mode-hook
   (cons
    (quote tramp-theme-hook-function)
    (delete
     (quote tramp-theme-hook-function)
     dired-mode-hook)))
 '(emms-mode-line-icon-image-cache
   (quote
    (image :type xpm :ascent center :data "/* XPM */
static char *note[] = {
/* width height num_colors chars_per_pixel */
\"    10   11        2            1\",
/* colors */
\". c #1ba1a1\",
\"# c None s None\",
/* pixels */
\"###...####\",
\"###.#...##\",
\"###.###...\",
\"###.#####.\",
\"###.#####.\",
\"#...#####.\",
\"....#####.\",
\"#..######.\",
\"#######...\",
\"######....\",
\"#######..#\" };")))
 '(ensime-sem-high-faces
   (quote
    ((var :foreground "#9876aa" :underline
	  (:style wave :color "yellow"))
     (val :foreground "#9876aa")
     (varField :slant italic)
     (valField :foreground "#9876aa" :slant italic)
     (functionCall :foreground "#a9b7c6")
     (implicitConversion :underline
			 (:color "#808080"))
     (implicitParams :underline
		     (:color "#808080"))
     (operator :foreground "#cc7832")
     (param :foreground "#a9b7c6")
     (class :foreground "#4e807d")
     (trait :foreground "#4e807d" :slant italic)
     (object :foreground "#6897bb" :slant italic)
     (package :foreground "#cc7832")
     (deprecated :strike-through "#a9b7c6"))))
 '(eshell-directory-change-hook
   (cons
    (quote tramp-theme-hook-function)
    (delete
     (quote tramp-theme-hook-function)
     eshell-directory-change-hook)))
 '(evil-emacs-state-cursor (quote ("#E57373" hbar)) t)
 '(evil-insert-state-cursor (quote ("#E57373" bar)) t)
 '(evil-move-beyond-eol t)
 '(evil-move-cursor-back nil)
 '(evil-normal-state-cursor (quote ("#FFEE58" box)) t)
 '(evil-visual-state-cursor (quote ("#C5E1A5" box)) t)
 '(fci-rule-character-color "#192028")
 '(fci-rule-color "#404040")
 '(find-file-hook
   (cons
    (quote tramp-theme-hook-function)
    (delete
     (quote tramp-theme-hook-function)
     find-file-hook)))
 '(flymake-error-bitmap
   (quote
    (flymake-double-exclamation-mark modus-theme-fringe-red)))
 '(flymake-note-bitmap (quote (exclamation-mark modus-theme-fringe-cyan)))
 '(flymake-warning-bitmap (quote (exclamation-mark modus-theme-fringe-yellow)))
 '(frame-brackground-mode (quote dark))
 '(fringe-mode 10 nil (fringe))
 '(gnus-logo-colors (quote ("#1ec1c4" "#bababa")))
 '(gnus-mode-line-image-cache
   (quote
    (image :type xpm :ascent center :data "/* XPM */
static char *gnus-pointer[] = {
/* width height num_colors chars_per_pixel */
\"    18    13        2            1\",
/* colors */
\". c #1ba1a1\",
\"# c None s None\",
/* pixels */
\"##################\",
\"######..##..######\",
\"#####........#####\",
\"#.##.##..##...####\",
\"#...####.###...##.\",
\"#..###.######.....\",
\"#####.########...#\",
\"###########.######\",
\"####.###.#..######\",
\"######..###.######\",
\"###....####.######\",
\"###..######.######\",
\"###########.######\" };")))
 '(highlight-changes-colors (quote ("#FD5FF0" "#AE81FF")))
 '(highlight-indent-guides-auto-enabled nil)
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#002b36" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#93a1a1")
 '(highlight-tail-colors
   (quote
    (("#3C3D37" . 0)
     ("#679A01" . 20)
     ("#4BBEAE" . 30)
     ("#1DB4D0" . 50)
     ("#9A8F21" . 60)
     ("#A75B00" . 70)
     ("#F309DF" . 85)
     ("#3C3D37" . 100))))
 '(hl-bg-colors
   (quote
    ("#7B6000" "#8B2C02" "#990A1B" "#93115C" "#3F4D91" "#00629D" "#00736F" "#546E00")))
 '(hl-fg-colors
   (quote
    ("#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36")))
 '(hl-paren-colors (quote ("#2aa198" "#b58900" "#268bd2" "#6c71c4" "#859900")))
 '(hl-sexp-background-color "#efebe9")
 '(hl-todo-keyword-faces
   (quote
    (("HOLD" . "#e5f040")
     ("TODO" . "#feacd0")
     ("NEXT" . "#b6a0ff")
     ("THEM" . "#f78fe7")
     ("PROG" . "#00d3d0")
     ("OKAY" . "#4ae8fc")
     ("DONT" . "#58dd13")
     ("FAIL" . "#ff8059")
     ("DONE" . "#44bc44")
     ("NOTE" . "#f0ce43")
     ("KLUDGE" . "#eecc00")
     ("HACK" . "#eecc00")
     ("TEMP" . "#ffcccc")
     ("FIXME" . "#ff9977")
     ("XXX+" . "#f4923b")
     ("REVIEW" . "#6ae4b9")
     ("DEPRECATED" . "#aaeeee"))))
 '(ibuffer-deletion-face (quote dired-flagged))
 '(ibuffer-filter-group-name-face (quote dired-mark))
 '(ibuffer-marked-face (quote dired-marked))
 '(ibuffer-title-face (quote dired-header))
 '(linum-format " %6d ")
 '(magit-diff-use-overlays nil)
 '(main-line-color1 "#222232")
 '(main-line-color2 "#333343")
 '(mode-line-buffer-identification
   (quote
    (:eval
     (tramp-theme-mode-line-buffer-identification))) t)
 '(nrepl-message-colors
   (quote
    ("#dc322f" "#cb4b16" "#b58900" "#546E00" "#B4C342" "#00629D" "#2aa198" "#d33682" "#6c71c4")))
 '(org-drill-done-count-color "#663311")
 '(org-drill-failed-count-color "#880000")
 '(org-drill-mature-count-color "#005500")
 '(org-drill-new-count-color "#004488")
 '(org-fontify-whole-heading-line t)
 '(package-selected-packages
   (quote
    (evil abyss-theme ahungry-theme alect-themes apropospriate-theme atom-one-dark-theme autothemer badwolf-theme base16-theme birds-of-paradise-plus-theme blackboard-theme circadian clues-theme color-theme-modern color-theme-sanityinc-solarized color-theme-sanityinc-tomorrow colorless-themes commentary-theme creamsody-theme cyberpunk-theme darcula-theme darktooth-theme doom-themes dracula-theme eink-theme ewal-doom-themes eziam-theme faff-theme fantom-theme flatui-dark-theme gotham-theme grandshell-theme green-screen-theme gruber-darker-theme gruvbox-theme heaven-and-hell immaterial-theme intellij-theme ir-black-theme kaolin-themes labburn-theme lavenderless-theme material-theme modus-operandi-theme modus-vivendi-theme moe-theme monokai-theme mood-one-theme night-owl-theme nofrils-acme-theme nord-theme nordless-theme org-beautify-theme overcast-theme panda-theme parchment-theme pastelmac-theme plain-theme prassee-theme quasi-monochrome-theme railscasts-reloaded-theme rebecca-theme reverse-theme select-themes sexy-monochrome-theme silkworm-theme smart-mode-line-powerline-theme snazzy-theme solarized-theme soria-theme spaceline-all-the-icons srcery-theme subatomic-theme svg-mode-line-themes tao-theme termbright-theme toxi-theme tramp-theme twilight-anti-bright-theme ubuntu-theme underwater-theme vs-dark-theme vs-light-theme xresources-theme yoshi-theme zenburn-theme zerodark-theme goto-chg)))
 '(pdf-view-midnight-colors (quote ("#ffffff" . "#111111")))
 '(pos-tip-background-color "#1A3734")
 '(pos-tip-foreground-color "#FFFFC8")
 '(powerline-color1 "#222232")
 '(powerline-color2 "#333343")
 '(rainbow-identifiers-choose-face-function (quote rainbow-identifiers-cie-l*a*b*-choose-face))
 '(rainbow-identifiers-cie-l*a*b*-color-count 1024)
 '(rainbow-identifiers-cie-l*a*b*-lightness 80)
 '(rainbow-identifiers-cie-l*a*b*-saturation 25)
 '(red "#ffffff")
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#073642" 0.2))
 '(sml/mode-width
   (if
       (eq
	(powerline-current-separator)
	(quote arrow))
       (quote right)
     (quote full)))
 '(sml/pos-id-separator
   (quote
    (""
     (:propertize " " face powerline-active1)
     (:eval
      (propertize " "
		  (quote display)
		  (funcall
		   (intern
		    (format "powerline-%s-%s"
			    (powerline-current-separator)
			    (car powerline-default-separator-dir)))
		   (quote powerline-active1)
		   (quote powerline-active2))))
     (:propertize " " face powerline-active2))))
 '(sml/pos-minor-modes-separator
   (quote
    (""
     (:propertize " " face powerline-active1)
     (:eval
      (propertize " "
		  (quote display)
		  (funcall
		   (intern
		    (format "powerline-%s-%s"
			    (powerline-current-separator)
			    (cdr powerline-default-separator-dir)))
		   (quote powerline-active1)
		   (quote sml/global))))
     (:propertize " " face sml/global))))
 '(sml/pre-id-separator
   (quote
    (""
     (:propertize " " face sml/global)
     (:eval
      (propertize " "
		  (quote display)
		  (funcall
		   (intern
		    (format "powerline-%s-%s"
			    (powerline-current-separator)
			    (car powerline-default-separator-dir)))
		   (quote sml/global)
		   (quote powerline-active1))))
     (:propertize " " face powerline-active1))))
 '(sml/pre-minor-modes-separator
   (quote
    (""
     (:propertize " " face powerline-active2)
     (:eval
      (propertize " "
		  (quote display)
		  (funcall
		   (intern
		    (format "powerline-%s-%s"
			    (powerline-current-separator)
			    (cdr powerline-default-separator-dir)))
		   (quote powerline-active2)
		   (quote powerline-active1))))
     (:propertize " " face powerline-active1))))
 '(sml/pre-modes-separator (propertize " " (quote face) (quote sml/modes)))
 '(tabbar-background-color "#357535753575")
 '(term-default-bg-color "#002b36")
 '(term-default-fg-color "#839496")
 '(vc-annotate-background "#404040")
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#c83029")
     (40 . "#db4334")
     (60 . "#959508")
     (80 . "#bcaa00")
     (100 . "#dc7700")
     (120 . "#c9d617")
     (140 . "#319448")
     (160 . "#078607")
     (180 . "#60a060")
     (200 . "#29b029")
     (220 . "#47cd57")
     (240 . "#4c8383")
     (260 . "#1ba1a1")
     (280 . "#0a7874")
     (300 . "#1e7bda")
     (320 . "#00a2f5")
     (340 . "#58b1f3")
     (360 . "#da26ce"))))
 '(vc-annotate-very-old-color "#da26ce")
 '(weechat-color-list
   (quote
    (unspecified "#272822" "#3C3D37" "#F70057" "#F92672" "#86C30D" "#A6E22E" "#BEB244" "#E6DB74" "#40CAE4" "#66D9EF" "#FB35EA" "#FD5FF0" "#74DBCD" "#A1EFE4" "#F8F8F2" "#F8F8F0")))
 '(window-divider-default-right-width 1)
 '(window-divider-mode t)
 '(xterm-color-names
   ["#000000" "#ff8059" "#44bc44" "#eecc00" "#33beff" "#feacd0" "#00d3d0" "#a8a8a8"])
 '(xterm-color-names-bright
   ["#181a20" "#f4923b" "#58dd13" "#e5f040" "#72a4ff" "#f78fe7" "#4ae8fc" "#ffffff"]))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

