local ft = require "fort"

local ftable = ft.create_table()

-- Change border style
ft.set_border_style(ftable, ft.DOUBLE2_STYLE)

-- Setup header
ft.set_cell_prop(ftable, 0, ft.ANY_COLUMN, ft.CPROP_ROW_TYPE, ft.ROW_HEADER)
ft.write_ln(ftable, "Sed", "Aenean", "Text")

-- Fill table
ft.write_ln(ftable, "Duis", "Aliquam",
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n" ..
                "In accumsan felis eros, nec malesuada sapien bibendum eget.")
ft.write_ln(ftable, "Mauris", "Curabitur",
            "Proin condimentum eros viverra nunc ultricies, at fringilla \n" ..
                "quam pellentesque.")
ft.write_ln(ftable, "Summary", "", "Sed tempor est eget odio varius dignissim.")

-- Setup alignments and cell span
ft.set_cell_prop(ftable, 0, 2, ft.CPROP_TEXT_ALIGN, ft.ALIGNED_CENTER)
ft.set_cell_prop(ftable, 3, 0, ft.CPROP_TEXT_ALIGN, ft.ALIGNED_CENTER)
ft.set_cell_span(ftable, 3, 0, 2)

print(ft.to_string(ftable))
