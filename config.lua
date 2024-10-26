-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example config: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

-- ShaDa (shared data) configuration
vim.opt.shadafile = ""  -- Temporarily disable ShaDa
vim.schedule(function()
    vim.opt.shadafile = vim.opt.shadafile._default
end)

-- General Settings
lvim.log.level = "warn"
lvim.format_on_save.enabled = true
lvim.colorscheme = "dracula"
lvim.transparent_window = true

-- Leader key configuration
lvim.leader = "space"

-- Check the operating system
if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
    -- PowerShell Configuration for Windows
    vim.opt.shell = "pwsh.exe"
    vim.opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
    vim.cmd [[
        let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
        let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
        set shellquote= shellxquote=
    ]]
else
    -- Bash Configuration for Linux and Unix-like systems
    vim.opt.shell = "bash"
    vim.opt.shellcmdflag = "-c"
    vim.cmd [[
        let &shellredir = '2>&1 | tee %s | exit $LastExitCode'
        let &shellpipe = '2>&1 | tee %s | exit $LastExitCode'
        set shellquote= shellxquote=
    ]]
end

-- Clipboard Configuration
vim.g.clipboard = {
    copy = {
        ["+"] = "win32yank.exe -i --crlf",
        ["*"] = "win32yank.exe -i --crlf",
    },
    paste = {
        ["+"] = "win32yank.exe -o --lf",
        ["*"] = "win32yank.exe -o --lf",
    },
}

-- Core Editor Settings
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.cursorline = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Additional Plugins
lvim.plugins = {
    -- Git Integration
    {
        'SuperBo/fugit2.nvim',
        opts = { width = 100 },
        dependencies = {
            'MunifTanjim/nui.nvim',
            'nvim-tree/nvim-web-devicons',
            'nvim-lua/plenary.nvim',
            {
                'chrisgrieser/nvim-tinygit',
                dependencies = { 'stevearc/dressing.nvim' }
            },
        },
        cmd = { 'Fugit2', 'Fugit2Diff', 'Fugit2Graph' },
        keys = {
            { '<leader>F', '<cmd>Fugit2<cr>', mode = 'n' }
        }
    },
    -- Better diagnostics display
    {
        "folke/trouble.nvim",
        cmd = "TroubleToggle",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            require("trouble").setup {
                position = "bottom",
                height = 10,
                icons = true,
                mode = "workspace_diagnostics",
                fold_open = "",
                fold_closed = "",
                group = true,
                padding = true,
                auto_preview = false,
                action_keys = {
                    close = "q",
                    cancel = "<esc>",
                    refresh = "r",
                    jump = {"<cr>", "<tab>"},
                    open_split = { "<c-x>" },
                    open_vsplit = { "<c-v>" },
                    open_tab = { "<c-t>" },
                    jump_close = {"o"},
                    toggle_mode = "m",
                    toggle = {"<leader>x"},
                    preview = "P",
                },
            }
        end
    },
}

-- TreeSitter Configuration
lvim.builtin.treesitter.ensure_installed = {
    "lua", "vim", "vimdoc", "python", "javascript", 
    "typescript", "java", "html", "css", "json", 
    "markdown", "yaml", "toml"
}
lvim.builtin.treesitter.highlight.enable = true
lvim.builtin.treesitter.indent.enable = true
lvim.builtin.treesitter.auto_install = true

-- Telescope Configuration
lvim.builtin.telescope.defaults = {
    file_ignore_patterns = { "node_modules", ".git/" },
    layout_strategy = 'horizontal',
    layout_config = {
        horizontal = {
            preview_width = 0.6,
        },
    },
}

-- NvimTree Configuration
lvim.builtin.nvimtree.setup.view.width = 30
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true
lvim.builtin.nvimtree.setup.filters.dotfiles = false

-- Which Key Configuration
lvim.builtin.which_key.mappings["t"] = {
    name = "Diagnostics",
    t = { "<cmd>TroubleToggle<cr>", "trouble" },
    w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "workspace" },
    d = { "<cmd>TroubleToggle document_diagnostics<cr>", "document" },
    q = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
    l = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
    r = { "<cmd>TroubleToggle lsp_references<cr>", "references" },
}

-- LSP Configuration
lvim.lsp.installer.setup.automatic_installation = true

-- Format on save configuration
lvim.format_on_save = {
    enabled = true,
    pattern = { "*.lua", "*.py", "*.js", "*.jsx", "*.ts", "*.tsx" }
}

-- Additional key mappings
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

-- Terminal configuration
lvim.builtin.terminal.active = true
lvim.builtin.terminal.direction = "horizontal"
lvim.builtin.terminal.size = 15

-- Dashboard Configuration
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"

lvim.builtin.alpha.dashboard.section.header.val = {
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⡀⡀⣀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣶⣾⣾⣿⣿⣿⣿⣿⣿⣿⣿⣆⣄⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⢰⣿⢻⡿⡏⡟⣿⣱⣿⣧⣿⣯⣽⠻⣿⣿⣷⣦⠄⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⣸⣿⣷⣷⣿⢿⠿⡏⠻⡀⢻⠙⣿⣿⣧⣽⣿⣿⣿⣄⠀⠀⠀",
    "⢽⡽⠒⠄⠀⠀⠘⡼⡟⠇⡇⢋⠈⢆⡽⠶⠾⢾⠆⠘⢿⣿⡻⣿⣿⣿⣿⣂⠀⠀",
    "⡙⢷⣦⣰⠀⠀⠀⢱⡥⠵⠈⠲⢯⣵⣶⣶⡒⠎⠀⠀⢸⣿⣿⣿⣿⣿⣿⡇⠀⠀",
    "⢶⣱⠛⢛⡄⠀⠀⠀⢟⡟⠁⠀⠀⠀⠀⣰⣶⣖⡆⠀⠸⡟⣵⡿⣿⣿⣿⠁⠀⠀",
    "⢀⢳⢈⠠⣴⡀⠀⠀⠈⢿⠷⠂⠀⠀⠀⠹⣿⡟⠒⠀⠀⢐⡗⠚⣹⣿⠏⠀⠀⠀",
    "⢸⠜⣷⠁⠄⠳⡀⠀⡇⣯⠭⣐⠠⠀⠀⠀⠹⡧⠀⠀⠀⡴⡤⢺⣿⠏⠀⠀⠀⠀",
    "⡎⢰⠀⢗⡝⠁⠱⡀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⡜⠀⡇⠈⡏⠀⠀⠀⠀⠀",
    "⢁⢸⠀⠀⢿⡍⠀⠑⣡⣤⣴⣤⣤⣤⣤⣴⣶⡾⠛⢡⠃⠠⡇⠀⡇⠀⠀⠀⠀⠀",
    "⠘⣌⠀⠀⠈⢿⣏⠠⠵⡄⠉⢻⡿⢿⣿⠟⠉⠀⢀⡟⠀⠀⠇⠀⢡⠀⠀⠀⠀⠀",
    "⠀⠘⠀⠀⠀⠘⡵⡆⠄⠚⢄⠈⡟⠉⠀⠀⠀⠀⣨⠇⠀⠀⢸⣀⡨⠔⠂⠈⠁⠒",
    "⠀⠀⠀⠀⠀⠀⠸⣳⡄⣂⠭⢦⣽⡄⠀⠀⠀⠀⡟⢀⠤⢒⣉⣠⣴⣶⣿⣷⣴⡿",
    "⠀⠀⠀⠀⡠⣴⣶⣟⣥⣀⣉⣛⣿⣔⣀⣀⡠⠔⣩⣴⣾⣷⣿⣿⣿⡿⠟⢋⣁⣤",
    "It does not matter how slowly you go",
    "    as long as you do not stop."
}

-- Apply transparent background
vim.cmd([[
    highlight Normal guibg=NONE ctermbg=NONE
    highlight SignColumn guibg=NONE ctermbg=NONE
    highlight NormalNC guibg=NONE ctermbg=NONE
    highlight LineNr guibg=NONE ctermbg=NONE
    highlight Folded guibg=NONE ctermbg=NONE
    highlight NonText guibg=NONE ctermbg=NONE
    highlight SpecialKey guibg=NONE ctermbg=NONE
    highlight VertSplit guibg=NONE ctermbg=NONE
    highlight EndOfBuffer guibg=NONE ctermbg=NONE
]])

-- Status line configuration
lvim.builtin.lualine.style = "default"
lvim.builtin.lualine.options.theme = "dracula"

-- Buffer line configuration
lvim.builtin.bufferline.active = true
lvim.builtin.bufferline.options.always_show_bufferline = true

-- Project configuration
lvim.builtin.project.active = true
lvim.builtin.project.detection_methods = { "pattern", "lsp" }

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true