local ft = require "fort"

local ftable = ft.create_table()

-- Setup header
ftable:set_cell_prop(1, ft.ANY_COLUMN, ft.CPROP_ROW_TYPE, ft.ROW_HEADER)
ftable:write_ln("Rank", "Title", "Year", "Rating")

-- Fill table
ftable:write_ln("1", "The Shawshank Redemption", "1994", "9.5")
ftable:write_ln("2", "12 Angry Men", "1957", "8.8")
ftable:write_ln("3", "It's a Wonderful Life", "1946", "8.6")
ftable:add_separator()
ftable:write_ln("4", "2001: A Space Odyssey", "1968", "8.5")
ftable:write_ln("5", "Blade Runner", "1982", "8.1")

-- Set alignment for columns
ftable:set_cell_prop(ft.ANY_ROW, 1, ft.CPROP_TEXT_ALIGN, ft.ALIGNED_CENTER)
ftable:set_cell_prop(ft.ANY_ROW, 2, ft.CPROP_TEXT_ALIGN, ft.ALIGNED_LEFT)
ftable:set_cell_prop(ft.ANY_ROW, 4, ft.CPROP_TEXT_ALIGN, ft.ALIGNED_CENTER)

print(ftable)
