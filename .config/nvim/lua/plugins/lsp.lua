-- ~/.config/nvim/lua/plugins/lsp.lua
return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				clangd = {}, -- for C/C++ used by PlatformIO
			},
		},
	},
}
