package = "lua-fort"
version = "0.1.0-1"

source = {url = "todo"}

description = {
    summary = "A wrapper around the fort ascii table library",
    detailed = [[
        The lua-fort module provides ASCII table support for Lua. It wraps the fort library
        https://github.com/seleznevae/libfort.

        Features:
        - Appearance customization
            - border styles
            - row/column/cell alignment, indentation, and padding
        - Numerous table filling methods
        - No dependencies on other libraries
    ]],
    license = "MIT"
}

-- TODO: make this lua >= 5.1
dependencies = {"lua >= 5.1"}

build = {
    type = "builtin",
    modules = {
        cfort = {
            sources = {"src/lfort.c", "src/fort.c"},
            -- disable wchar and utf8 for now
            defines = {"FT_CONGIG_DISABLE_WCHAR", "FT_CONGIG_DISABLE_UTF8"}
        }
    },
    install = {lua = {fort = "src/fort.lua"}},
    -- Override default build options (per platform)
    platforms = {}
}
