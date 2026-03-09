-- Tell lua_ls about neovim runtime
return {
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            workspace = {
                library = { vim.env.VIMRUNTIME },
                checkThirdParty = false,
            },
        },
    },
}
