-- debug.lua

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- Creates a debugger UI
    'rcarriga/nvim-dap-ui',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Extensions
    'mfussenegger/nvim-dap-python',
    'rcarriga/cmp-dap',
    'theHamsta/nvim-dap-virtual-text',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'
    local dapvtext = require 'nvim-dap-virtual-text'

    -- Set lldb-vscode adapters
    -- NOTE: Ensure `llvm` is installed
    local lldb_command = "lldb-vscode";
    if vim.loop.os_uname().sysname == "Linux" then
      lldb_command = "lldb-vscode-15"
    end
    dap.adapters.lldb = {
      type = 'executable',
      command = lldb_command,
      name = 'lldb'
    }

    -- Set C++ config
    dap.configurations.cpp = {
      {
        name = 'Launch',
        type = 'lldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = function()
          local args_string = vim.fn.input("Arguments: ")
          return vim.split(args_string, " ")
        end,
        -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
        --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
        -- Otherwise you might get the following error:
        --    Error on launch: Failed to attach to the target process
        -- But you should be aware of the implications:
        -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
        -- runInTerminal = false,
      },
    }

    require('mason-nvim-dap').setup {
      automatic_setup = true,
      ensure_installed = {
        'python',
      },
      handlers = {},
    }

    dapvtext.setup {
      enabled = true,
      highlight_changed_variables = true,
      show_stop_reason = true,
      virt_text_pos = 'eol',
      virt_text_win_col = 80,
    }

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })

    -- UI setup
    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '॥',
          play = '▶',
          step_into = '↧',
          step_over = '↦',
          step_out = '↥',
          step_back = '↤',
          run_last = '▶▶',
          terminate = '◻︎',
          disconnect = '☒',
        },
      },
    }

    local debug_win = nil
    local debug_tab = nil
    local debug_tabnr = nil

    -- Open UI in new tab
    local function open_in_tab()
      if debug_win and vim.api.nvim_win_is_valid(debug_win) then
        vim.api.nvim_set_current_win(debug_win)
        return
      end
      vim.cmd('tabedit %')
      debug_win = vim.fn.win_getid()
      debug_tab = vim.api.nvim_win_get_tabpage(debug_win)
      debug_tabnr = vim.api.nvim_tabpage_get_number(debug_tab)
      dapui.open()
    end

    -- Close tab after UI is closed
    local function close_tab()
      dapui.close()
      if debug_tab and vim.api.nvim_tabpage_is_valid(debug_tab) then
        vim.api.nvim_exec('tabclose ' .. debug_tabnr, false)
      end
      debug_win = nil
      debug_tab = nil
      debug_tabnr = nil
    end

    -- Toggle UI
    vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

    -- Attach UI to dap events
    dap.listeners.after.event_initialized['dapui_config'] = function()
      open_in_tab()
    end
    dap.listeners.before.event_terminated['dapui_config'] = function()
      close_tab()
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
      close_tab()
    end

    -- Setup python to point to `debugpy` virtualenv
    require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
  end,
}
