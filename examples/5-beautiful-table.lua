local ft = require "fort"

local table = ft.create_table()
ft.set_border_style(table, ft.NICE_STYLE)
ft.set_cell_prop(table, 0, ft.ANY_COLUMN, ft.CPROP_ROW_TYPE, ft.ROW_HEADER)

-- Filling table with data
ft.write_ln(table, "Тест", "Итерации", "ms/op", "Тики",
            "Результат")
ft.write_ln(table, "n-body", "1000", "1.6", "1,500,000", "✔")
ft.add_separator(table)
ft.write_ln(table, "regex-redux", "1000", "0.8", "8,000,000")
ft.write_ln(table, "", "2500", "3.9", "27,000,000", "✖")
ft.write_ln(table, "", "10000", "12.5", "96,800,000")
ft.add_separator(table)
ft.write_ln(table, "mandelbrot", "1000", "8.1", "89,000,000")
ft.write_ln(table, "", "2500", "19.8", "320,000,000", "✔")
ft.write_ln(table, "", "10000", "60.7", "987,000,000")
ft.add_separator(table)
ft.set_cell_span(table, 8, 0, 4)
ft.write_ln(table, "Итог", "", "", "", "✖")

-- Setting text styles
ft.set_cell_prop(table, 0, ft.ANY_COLUMN, ft.CPROP_CONT_TEXT_STYLE,
                 ft.TSTYLE_BOLD)
ft.set_cell_prop(table, 8, ft.ANY_COLUMN, ft.CPROP_CONT_TEXT_STYLE,
                 ft.TSTYLE_BOLD)
ft.set_cell_prop(table, ft.ANY_ROW, 0, ft.CPROP_CONT_TEXT_STYLE, ft.TSTYLE_BOLD)
ft.set_cell_prop(table, ft.ANY_ROW, 4, ft.CPROP_CONT_TEXT_STYLE, ft.TSTYLE_BOLD)
ft.set_cell_prop(table, ft.ANY_ROW, ft.ANY_COLUMN, ft.CPROP_CONT_TEXT_STYLE,
                 ft.TSTYLE_ITALIC)

-- Set alignment
ft.set_cell_prop(table, ft.ANY_ROW, 1, ft.CPROP_TEXT_ALIGN, ft.ALIGNED_RIGHT)
ft.set_cell_prop(table, ft.ANY_ROW, 2, ft.CPROP_TEXT_ALIGN, ft.ALIGNED_RIGHT)
ft.set_cell_prop(table, ft.ANY_ROW, 3, ft.CPROP_TEXT_ALIGN, ft.ALIGNED_RIGHT)
ft.set_cell_prop(table, ft.ANY_ROW, 4, ft.CPROP_TEXT_ALIGN, ft.ALIGNED_CENTER)
ft.set_cell_prop(table, 8, 0, ft.CPROP_TEXT_ALIGN, ft.ALIGNED_CENTER)

-- Set colors
ft.set_cell_prop(table, 1, 4, ft.CPROP_CONT_FG_COLOR, ft.COLOR_GREEN)
ft.set_cell_prop(table, 3, 4, ft.CPROP_CONT_FG_COLOR, ft.COLOR_RED)
ft.set_cell_prop(table, 6, 4, ft.CPROP_CONT_FG_COLOR, ft.COLOR_GREEN)
ft.set_cell_prop(table, 8, 4, ft.CPROP_CONT_FG_COLOR, ft.COLOR_RED)
ft.set_cell_prop(table, 3, 2, ft.CPROP_CONT_FG_COLOR, ft.COLOR_RED)
ft.set_cell_prop(table, 4, 3, ft.CPROP_CONT_BG_COLOR, ft.COLOR_LIGHT_RED)
ft.set_cell_prop(table, 0, ft.ANY_COLUMN, ft.CPROP_CONT_FG_COLOR,
                 ft.COLOR_LIGHT_BLUE)

-- Move table to the center of the screen
ft.set_tbl_prop(table, ft.TPROP_TOP_MARGIN, 1)
ft.set_tbl_prop(table, ft.TPROP_LEFT_MARGIN, 10)

print("Table:\n", ft.to_string(table))
