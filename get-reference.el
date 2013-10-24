(defun get-reference()
  (interactive)
  (let (function-name file-name reference-doc start-buffer point-begin point-end)
    (setq function-name (gtags-current-token))
    (setq file-name
          (substring
           (shell-command-to-string 
            (format "global %s" function-name))
           0 -1))   ;; 最後の改行文字を削除
    ;;2行目移行の結果を削除(一時措置)
    (setq file-name
          (replace-regexp-in-string "\n.*" "" file-name))
    (setq start-buffer (current-buffer))
    (with-temp-buffer
      (insert-file-contents file-name)
      (goto-char (point-max))
      (re-search-backward
       (format ".*\n.*function.*%s *(" function-name)
       nil t nil)
      (setq point-end (point))
      (re-search-backward "\\/\\*" nil t nil)
      (setq point-begin (point))
      (setq reference-doc (buffer-substring point-begin point-end)))
    (switch-to-buffer start-buffer)
    (popup-tip reference-doc)))
