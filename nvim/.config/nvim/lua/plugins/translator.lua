return {
	{
		"voldikss/vim-translator",
		keys = {
			-- Обычный режим
			{ "<leader>t", ":TranslateW<CR>", desc = "Translate (Window)", mode = "n" },
			{ "<leader>r", ":TranslateR<CR>", desc = "Translate and Replace", mode = "n" },
			-- Визуальный режим (добавляем <gv для сохранения выделения или просто выполнение)
			{ "<leader>t", ":' <,'>TranslateW<CR>", desc = "Translate (Window)", mode = "v" },
			{ "<leader>r", ":' <,'>TranslateR<CR>", desc = "Translate and Replace", mode = "v" },
		},
		init = function()
			-- Настройки лучше класть в init, чтобы они подтянулись ДО загрузки плагина
			vim.g.translator_target_lang = "ru"
			vim.g.translator_source_lang = "auto"
		end,
	},
}
