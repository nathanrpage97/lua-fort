package = "lua-fort"
version = "0.1.0-1"

source = {
    url = "git+https://github.com/openresty/lua-cjson",
    tag = "2.1.0.10",
}

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
    homepage = "http://www.kyne.com.au/~mark/software/lua-cjson.php",
    license = "MIT"
}

dependencies = {
    "lua >= 5.3"
}

build = {
    type = "builtin",
    modules = {
        cfort = {
            sources = { "src/lfort.c", "src/fort.c" },
            defines = {
                "FT_CONGIG_DISABLE_WCHAR",
                "FT_CONGIG_DISABLE_UTF8",
            }
        }
    },
    install = {
        lua={
            fort = "src/fort.lua"
        }
    },
    -- Override default build options (per platform)
    platforms = {
    },
}