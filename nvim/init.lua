vim.o.relativenumber = true
vim.o.number = true
vim.o.cmdheight = 0
vim.g.mapleader = " "
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.termguicolors = true
vim.pack.add({
    { src = "https://github.com/neovim/nvim-lspconfig.git" },
    { src = "https://github.com/saghen/blink.cmp.git" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter.git" },
    { src = "https://github.com/nvim-mini/mini.nvim.git" },
    { src = "https://github.com/ibhagwan/fzf-lua.git" },
    { src = "https://github.com/catppuccin/nvim.git" },
    { src = "https://github.com/nvim-lualine/lualine.nvim.git" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons.git" },
    { src = "https://github.com/stevearc/oil.nvim.git" },
})
require("catppuccin").setup({
    flavour = "mocha",
})
vim.cmd.colorscheme("catppuccin")
require("nvim-web-devicons").setup()
require("lualine").setup({
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff" },
        lualine_c = { "filename" },
        lualine_x = { "diagnostics" },
        lualine_y = { "location" },
        lualine_z = { "progress" },
    },
})
require("mini.indentscope").setup({})
require("mini.pairs").setup({})
----------------------------------------------------------------------
-- LSP, treesitter, and completion
----------------------------------------------------------------------
vim.lsp.config("*", {
    flags = { debounce_text_changes = 0 }, -- make lsp faster
})
vim.lsp.enable({ "lua_ls", "basedpyright", "ruff", "clangd", "csharp_ls" })
local ts_parsers = { "lua", "c", "python", "c_sharp" }
local nts = require("nvim-treesitter")
vim.api.nvim_create_user_command("TSInstall", function() nts.install(ts_parsers) end, {})
vim.api.nvim_create_user_command("TSUpdate", function() nts.update() end, {})
require("blink.cmp").setup({
    keymap = { preset = "super-tab" },
    sources = { default = { "buffer", "lsp", "path", "snippets" } },
})
vim.diagnostic.config({
    signs = false,
    virtual_text = true,
})
vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        pcall(vim.treesitter.start)
    end,
})
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("LspOverrides", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then return end
    -- Disable ruff hover in favor of basedpyright
    if client.name == "ruff" then
      client.server_capabilities.hoverProvider = false
    end
    -- Disable csharp_ls completion (use custom snippets instead)
    if client.name == "csharp_ls" then
      client.server_capabilities.completionProvider = nil
    end
  end,
})
----------------------------------------------------------------------
-- fzf-lua
----------------------------------------------------------------------
local fd_excludes = {
    -- OS generated files
    ".DS_Store", "Thumbs.db", "desktop.ini", ".directory",
    "__MACOSX", "._*", ".fseventsd", ".Spotlight-V100",
    ".Trashes", ".TemporaryItems", ".DocumentRevisions-V100",
    ".VolumeIcon.icns", ".com.apple.timemachine.donotpresent",
    ".AppleDB", ".AppleDesktop", ".apdisk", ".fuse_hidden*",
    ".nfs*", "nohup.out",
    -- Version control
    ".git", ".svn", ".hg", ".bzr", "_darcs", ".fossil", "CVS",
    -- IDE and editor artifacts
    ".idea", ".vs", ".vscode", "*.swp", "*.swo", "*~",
    ".netrwhist", "tags", "Session.vim", ".history",
    -- JavaScript / TypeScript / Node.js
    "node_modules", ".next", ".nuxt", ".svelte-kit", ".output",
    ".vitepress", ".docusaurus", "dist", ".turbo", ".vercel",
    ".netlify", ".serverless", ".cache", ".parcel-cache",
    ".eslintcache", ".stylelintcache", ".yarn", ".pnpm-store",
    ".npm", "*.tsbuildinfo", ".vite", ".firebase", ".dynamodb",
    ".fusebox",
    -- Python
    "__pycache__", ".venv", "venv", "env", ".env", ".mypy_cache",
    ".pytest_cache", ".ruff_cache", ".tox", ".nox", ".hypothesis",
    ".eggs", "*.egg-info", "*.pyc", "*.pyo", ".coverage",
    "htmlcov", ".ipynb_checkpoints", ".pytype", ".pyre",
    ".dmypy.json", ".pixi", "*.egg", ".Python",
    -- C / C++
    "build", "Build", "cmake-build-*", "CMakeFiles",
    "CMakeCache.txt", "*.o", "*.obj", "*.so", "*.dylib", "*.dll",
    "*.a", "*.lib", "*.exe", "*.out", "*.dSYM", "*.pdb",
    "_deps", "vcpkg_installed", "compile_commands.json",
    -- C# / .NET
    "bin", "obj", "*.suo", "*.user", "Debug", "Release",
    "packages", "artifacts", "*.nupkg", "*.snupkg", "TestResults",
    -- Neovim
    "nvim-pack-lock.json", ".luarc.json", "lazy-lock.json",
    -- Testing / CI
    "coverage", ".nyc_output", "playwright-report", "test-results",
    "storybook-static", "jest-report",
}
local fd_opts = ""
for _, pattern in ipairs(fd_excludes) do
    fd_opts = fd_opts .. " --exclude " .. vim.fn.shellescape(pattern)
end
require("fzf-lua").setup({
    files = { fd_opts = fd_opts },
})
require("oil").setup({
    default_file_explorer = true,
    view_options = {
        show_hidden = true,
    },
})
vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>")
vim.keymap.set("n", "<leader>f", function() require("fzf-lua").files() end)
vim.keymap.set("n", "<leader>g", function() require("fzf-lua").live_grep() end)
