local ft = require "fort"

local ftable = ft.create_table()

-- Setup header
ft.set_cell_prop(ftable, 0, ft.ANY_COLUMN, ft.CPROP_ROW_TYPE, ft.ROW_HEADER)
ft.write_ln(ftable, "Rank", "Title", "Year", "Rating")

-- Fill table
ft.write_ln(ftable, "1", "The Shawshank Redemption", "1994", "9.5")
ft.write_ln(ftable, "2", "12 Angry Men", "1957", "8.8")
ft.write_ln(ftable, "3", "It's a Wonderful Life", "1946", "8.6")
ft.add_separator(ftable)
ft.write_ln(ftable, "4", "2001: A Space Odyssey", "1968", "8.5")
ft.write_ln(ftable, "5", "Blade Runner", "1982", "8.1")

-- Set alignment for columns
ft.set_cell_prop(ftable, ft.ANY_ROW, 0, ft.CPROP_TEXT_ALIGN, ft.ALIGNED_CENTER)
ft.set_cell_prop(ftable, ft.ANY_ROW, 1, ft.CPROP_TEXT_ALIGN, ft.ALIGNED_LEFT)
ft.set_cell_prop(ftable, ft.ANY_ROW, 3, ft.CPROP_TEXT_ALIGN, ft.ALIGNED_CENTER)

print(ft.to_string(ftable))
