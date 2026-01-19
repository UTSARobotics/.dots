return {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require("lspconfig")

    lspconfig.clangd.setup({
      cmd = { "clangd", "--background-index" },
      filetypes = { "c", "cpp", "objc", "objcpp" },
      root_dir = lspconfig.util.root_pattern("platformio.ini", ".git"),
    })

    -- Auto-generate .clangd if missing
    vim.api.nvim_create_autocmd("BufReadPre", {
      callback = function()
        local root = vim.fn.getcwd()
        local ini = root .. "/platformio.ini"
        local clangd_conf = root .. "/.clangd"

        if vim.fn.filereadable(ini) == 1 and vim.fn.filereadable(clangd_conf) == 0 then
          vim.fn.system("pio init --ide vim >/dev/null 2>&1")
          vim.notify("Generated .clangd for PlatformIO project", vim.log.levels.INFO)
        end
      end,
    })
  end,
}
