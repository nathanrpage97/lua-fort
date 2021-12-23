local ft = require "fort"

local ftable = ft.create_table()
ft.set_border_style(ftable, ft.NICE_STYLE)
ft.set_cell_prop(ftable, 1, ft.ANY_COLUMN, ft.CPROP_ROW_TYPE, ft.ROW_HEADER)

-- Filling ftable with data
ft.write_ln(ftable, "Тest", "Iterations", "ms/op", "Ticks", "Passed")
ft.write_ln(ftable, "n-body", "1000", "1.6", "1,500,000", "✔")
ft.add_separator(ftable)
ft.write_ln(ftable, "regex-redux", "1000", "0.8", "8,000,000")
ft.write_ln(ftable, "", "2500", "3.9", "27,000,000", "✖")
ft.write_ln(ftable, "", "10000", "12.5", "96,800,000")
ft.add_separator(ftable)
ft.write_ln(ftable, "mandelbrot", "1000", "8.1", "89,000,000")
ft.write_ln(ftable, "", "2500", "19.8", "320,000,000", "✔")
ft.write_ln(ftable, "", "10000", "60.7", "987,000,000")
ft.add_separator(ftable)
ft.set_cell_span(ftable, 9, 1, 4)
ft.write_ln(ftable, "Total Result", "", "", "", "✖")

-- Setting text styles
ft.set_cell_prop(ftable, 1, ft.ANY_COLUMN, ft.CPROP_CONT_TEXT_STYLE,
                 ft.TSTYLE_BOLD)
ft.set_cell_prop(ftable, 9, ft.ANY_COLUMN, ft.CPROP_CONT_TEXT_STYLE,
                 ft.TSTYLE_BOLD)
ft.set_cell_prop(ftable, ft.ANY_ROW, 1, ft.CPROP_CONT_TEXT_STYLE, ft.TSTYLE_BOLD)
ft.set_cell_prop(ftable, ft.ANY_ROW, 5, ft.CPROP_CONT_TEXT_STYLE, ft.TSTYLE_BOLD)
ft.set_cell_prop(ftable, ft.ANY_ROW, ft.ANY_COLUMN, ft.CPROP_CONT_TEXT_STYLE,
                 ft.TSTYLE_ITALIC)

-- Set alignment
ft.set_cell_prop(ftable, ft.ANY_ROW, 2, ft.CPROP_TEXT_ALIGN, ft.ALIGNED_RIGHT)
ft.set_cell_prop(ftable, ft.ANY_ROW, 3, ft.CPROP_TEXT_ALIGN, ft.ALIGNED_RIGHT)
ft.set_cell_prop(ftable, ft.ANY_ROW, 4, ft.CPROP_TEXT_ALIGN, ft.ALIGNED_RIGHT)
ft.set_cell_prop(ftable, ft.ANY_ROW, 5, ft.CPROP_TEXT_ALIGN, ft.ALIGNED_CENTER)
ft.set_cell_prop(ftable, 9, 1, ft.CPROP_TEXT_ALIGN, ft.ALIGNED_CENTER)

-- Set colors
ft.set_cell_prop(ftable, 2, 5, ft.CPROP_CONT_FG_COLOR, ft.COLOR_GREEN)
ft.set_cell_prop(ftable, 4, 5, ft.CPROP_CONT_FG_COLOR, ft.COLOR_RED)
ft.set_cell_prop(ftable, 7, 5, ft.CPROP_CONT_FG_COLOR, ft.COLOR_GREEN)
ft.set_cell_prop(ftable, 9, 5, ft.CPROP_CONT_FG_COLOR, ft.COLOR_RED)
ft.set_cell_prop(ftable, 4, 3, ft.CPROP_CONT_FG_COLOR, ft.COLOR_RED)
ft.set_cell_prop(ftable, 5, 4, ft.CPROP_CONT_BG_COLOR, ft.COLOR_LIGHT_RED)
ft.set_cell_prop(ftable, 1, ft.ANY_COLUMN, ft.CPROP_CONT_FG_COLOR,
                 ft.COLOR_LIGHT_BLUE)

-- Move ftable to the center of the screen
ft.set_tbl_prop(ftable, ft.TPROP_TOP_MARGIN, 1)
ft.set_tbl_prop(ftable, ft.TPROP_LEFT_MARGIN, 10)

print("ftable:\n" .. tostring(ftable))
