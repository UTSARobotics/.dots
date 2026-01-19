-- lazy.nvim or other lua-based managers

return {
  "rrethy/vim-hexokinase",
  build = "make hexokinase",
  event = "BufReadPost", -- optional: for lazy loading on file open
}
