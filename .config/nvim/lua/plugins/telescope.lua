return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required
      "BurntSushi/ripgrep", -- Optional (for better grep support)
      "sharkdp/fd", -- Optional (for faster file finding)
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make", -- Optional sorter, requires make and gcc/clang
      "nvim-treesitter/nvim-treesitter", -- Optional (for better preview and symbol search)
      -- You can add more Telescope extensions here, if desired
    },
  },
}
