-- Tell lua_ls about neovim runtime
return {
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            format = {
                defaultConfig = {
                    indent_size = '4',
                },
            },
            workspace = {
                library = { vim.env.VIMRUNTIME },
                checkThirdParty = false,
            },
        },
    },
}
