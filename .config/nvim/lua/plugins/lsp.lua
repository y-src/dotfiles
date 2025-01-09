return {
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    ---@type lspconfig.options
    servers = {
      clangd = {
        init_options = {
          fallbackFlags = { "-std=c++20" },
        },
      },
    },
  },
}
