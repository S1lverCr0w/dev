;; auto_skip

;; this skips over the clsoign brackets.quotes in insert mode while typing
(local keys {
	")" ")"
	"]" "]"
	"}" "}"
	:> ">"
	"'" "'"
	"\"" "\""
	"`" "`"
	";" ";"
	":" ":"
	; " " " " ;; skips spaces
	})

(local filetypes [;; apply only to these filetypes
	:c
	:zig
	:java
	:fortran
	:make
	:python
	:lua])

(vim.api.nvim_create_autocmd :FileType
	{:pattern filetypes

	:callback (fn []
		(each [key char (pairs keys)]
			(vim.keymap.set :i key (fn []
				; _ is a throwaway variable as we only need the column where the cursor is (_ represents the row)
				(local [_ col] (unpack (vim.api.nvim_win_get_cursor 0)))
				(local line (vim.api.nvim_get_current_line))
				(local next-char (line:sub (+ col 1) (+ col 1)))
				
				(if (= next-char char)
					:<Right>;; move the cursor to the right one char
					key))
			{:expr true :buffer true})))}) ;; expr turns <Right> to expresion from string, buffer applies the command only to current buffer

