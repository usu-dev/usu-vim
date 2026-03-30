if vim.g.loaded_usu_treesitter then
  return
end
vim.g.loaded_usu_treesitter = true

-- Ensure we only run this in Neovim
if not vim.api then
  return
end

vim.api.nvim_create_autocmd("User", {
  pattern = "TSUpdate",
  callback = function()
    local ok, parsers = pcall(require, "nvim-treesitter.parsers")
    if ok then
      parsers.usu = {
        install_info = {
          url = "https://github.com/usu-dev/tree-sitter-usu",
          files = { "src/parser.c" },
          queries = 'queries'
        },
      
      }
    end
  end,
})

if vim.treesitter and vim.treesitter.language and vim.treesitter.language.register then
  vim.treesitter.language.register("usu", "usu")
end

