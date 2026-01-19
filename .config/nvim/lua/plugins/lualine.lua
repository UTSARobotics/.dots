return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "lewis6991/gitsigns.nvim",
  },
  config = function()
    -- Nerd Font fallback detection
    local function has_nerd_font()
      return vim.fn.has("multi_byte") == 1 and vim.fn.strdisplaywidth("") == 1
    end

    --  Custom Theme  --
    local custom_theme = {
      normal = {
        a = { fg = "#cdd6f4", bg = "#875faf", gui = "bold" },
        b = { fg = "#cdd6f4", bg = "#313244" },
        c = { fg = "#cdd6f4", bg = "#303030" },
      },
      insert = {
        a = { fg = "#1e1e2e", bg = "#94e2d5", gui = "bold" },
      },
      visual = {
        a = { fg = "#1e1e2e", bg = "#f38ba8", gui = "bold" },
      },
      replace = {
        a = { fg = "#1e1e2e", bg = "#fab387", gui = "bold" },
      },
      command = {
        a = { fg = "#1e1e2e", bg = "#f9e2af", gui = "bold" },
      },
      inactive = {
        a = { fg = "#6c7086", bg = "#1e1e2e", gui = "bold" },
        b = { fg = "#6c7086", bg = "#1e1e2e" },
        c = { fg = "#6c7086", bg = "#1e1e2e" },
      },
    }

    --  Macro recording indicator
    local function recording_macro()
      local reg = vim.fn.reg_recording()
      if reg == "" then
        return ""
      end
      return " Recording @" .. reg
    end

    --  LSP client name
    local function active_lsp()
      local clients = vim.lsp.get_active_clients({ bufnr = 0 })
      if next(clients) == nil then
        return "No LSP"
      end
      return "  " .. clients[1].name
    end

    --  File size --
    local function file_size()
      local f = vim.fn.expand("%:p")
      if f == "" or vim.fn.getfsize(f) < 0 then
        return ""
      end
      local size = vim.fn.getfsize(f)
      if size < 1024 then
        return size .. " B"
      end
      if size < 1024 * 1024 then
        return string.format("%.1f KB", size / 1024)
      end
      return string.format("%.1f MB", size / (1024 * 1024))
    end

    --   Git blame (via gitsigns) --
    local function git_blame()
      local gs = package.loaded.gitsigns
      if gs and gs.get_blame_text then
        local text = gs.get_blame_text()
        return text or ""
      end
      return ""
    end

    require("lualine").setup({
      options = {
        theme = custom_theme,
        globalstatus = true,
        section_separators = "",
        component_separators = "",
        icons_enabled = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          {
            "branch",
            icon = has_nerd_font() and "" or "",
          },
          "diff",
          "diagnostics",
        },
        lualine_c = {
          {
            "filename",
            path = 1,
            symbols = {
              modified = " [+]",
              readonly = " ",
              unnamed = "[No Name]",
            },
          },
          file_size,
        },
        lualine_x = {
          active_lsp,
          "encoding",
          "fileformat",
          "filetype",
        },
        lualine_y = {
          git_blame,
        },
        lualine_z = {
          {
            recording_macro,
            color = { fg = "#f38ba8", gui = "reverse" },
          },
          "location",
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
    })
  end,
}
