(defun get-reference()
  (interactive)
  (let (hoge)
    (setq function-name (gtags-current-token))
    (setq file-name
          (substring
           (shell-command-to-string 
            (format "global %s" function-name))
           0 -1))   ;; 最後の改行文字を削除
    (setq start-buffer (current-buffer))
    (with-temp-buffer
      (insert-file-contents file-name)
      (goto-char (point-min))
      (re-search-forward
       (format "\\(\\/\\*.*\\([^\\*][^\\/]*\n\\).*\\)\n.*function.*%s *(" function-name)
       nil t nil)
      (setq tmp (match-string 1)))
    (switch-to-buffer start-buffer)
    (popup-tip tmp)))
file-name
(replace-regexp-in-string "\n.*" "" file-name) ;;2行目移行の結果を削除(一時措置)
(function-name file-name reference-doc start-buffer)
