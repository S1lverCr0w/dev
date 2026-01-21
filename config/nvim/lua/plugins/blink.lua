return {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets" },
	version = "1.*",
	opts = {
		keymap = {
			preset = "default",
			-- ['<C-k>'] = { 'select_prev', 'fallback' },
			-- ['<C-j>'] = { 'select_next', 'fallback' },
			-- ['<C-e>'] = { 'hide', 'fallback' },
			-- ['<Tab>'] = { 'accept', 'fallback' },
		},

		appearance = {
			nerd_font_variant = "mono",
		},

		completion = {
			-- ghost_text = {
			-- 	enabled = true,
			-- },
			menu = {
				border = "single",
				scrollbar = true,

				-- max_height = 20,
				-- auto_show = false, -- hide menu if ghost text is enabled
			},
			documentation = {
				auto_show = false,
				auto_show_delay_ms = 500,
				window = {
					border = "single",
					scrollbar = true,
				},
			},
		},

		-- Default list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, due to `opts_extend`
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},

		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
