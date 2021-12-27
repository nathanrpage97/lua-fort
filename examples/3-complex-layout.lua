local ft = require "fort"

local ftable = ft.create_table()

-- Change border style
ftable:set_border_style(ft.DOUBLE2_STYLE)

-- Setup header
ftable:set_cell_prop(1, ft.ANY_COLUMN, ft.CPROP_ROW_TYPE, ft.ROW_HEADER)
ftable:write_ln("Sed", "Aenean", "Text")

-- Fill table
ftable:write_ln("Duis", "Aliquam",
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n" ..
                    "In accumsan felis eros, nec malesuada sapien bibendum eget.")
ftable:write_ln("Mauris", "Curabitur",
                "Proin condimentum eros viverra nunc ultricies, at fringilla \n" ..
                    "quam pellentesque.")
ftable:write_ln("Summary", "", "Sed tempor est eget odio varius dignissim.")

-- Setup alignments and cell span
ftable:set_cell_prop(1, 3, ft.CPROP_TEXT_ALIGN, ft.ALIGNED_CENTER)
ftable:set_cell_prop(4, 1, ft.CPROP_TEXT_ALIGN, ft.ALIGNED_CENTER)
ftable:set_cell_span(4, 1, 2)

print(ftable)
