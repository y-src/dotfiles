-- autoformat.lua
-- Use language server to automatically format

return {
  'neovim/nvim-lspconfig',
  config = function()
    -- :AutoFormatToggle to turn autoformatting on or off
    local format_is_enabled = true
    vim.api.nvim_create_user_command('AutoFormatToggle', function()
      format_is_enabled = not format_is_enabled
      print('Setting autoformatting to: ' .. tostring(format_is_enabled))
    end, {})

    -- Groups used for managing formatting autocmds
    local _afgroups = {}
    local get_afgroups = function(client)
      if not _afgroups[client.id] then
        local group_name = 'autofmt-lsp-format-' .. client.name
        local id = vim.api.nvim_create_augroup(group_name, { clear = true })
        _afgroups[client.id] = id
      end
      return _afgroups[client.id]
    end

    -- Run when language server attaches to a buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('autofmt-lsp-attach-format', { clear = true }),

      -- Attach autoformatting
      callback = function(args)
        local client_id = args.data.client_id
        local client = vim.lsp.get_client_by_id(client_id)
        local bufnr = args.buf

        -- Only clients that support document formatting
        if not client.server_capabilities.documentFormattingProvider then
          return
        end

        -- Autocmd that runs `format` for the attached client
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = get_afgroups(client),
          buffer = bufnr,
          callback = function()
            if not format_is_enabled then
              return
            end
            vim.lsp.buf.format {
              async = false,
              filter = function(c)
                return c.id == client.id
              end,
            }
          end,
        })
      end,
    })
  end,
}
