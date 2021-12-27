local ft = require "fort"

local ftable = ft.create_table()
ftable:set_border_style(ft.NICE_STYLE)
ftable:set_cell_prop(1, ft.ANY_COLUMN, ft.CPROP_ROW_TYPE, ft.ROW_HEADER)

-- Filling ftable with data
ftable:write_ln("Тest", "Iterations", "ms/op", "Ticks", "Passed")
ftable:write_ln("n-body", "1000", "1.6", "1,500,000", "✔")
ftable:add_separator()
ftable:write_ln("regex-redux", "1000", "0.8", "8,000,000")
ftable:write_ln("", "2500", "3.9", "27,000,000", "✖")
ftable:write_ln("", "10000", "12.5", "96,800,000")
ftable:add_separator()
ftable:write_ln("mandelbrot", "1000", "8.1", "89,000,000")
ftable:write_ln("", "2500", "19.8", "320,000,000", "✔")
ftable:write_ln("", "10000", "60.7", "987,000,000")
ftable:add_separator()
ftable:set_cell_span(9, 1, 4)
ftable:write_ln("Total Result", "", "", "", "✖")

-- Setting text styles
ftable:set_cell_prop(1, ft.ANY_COLUMN, ft.CPROP_CONT_TEXT_STYLE, ft.TSTYLE_BOLD)
ftable:set_cell_prop(9, ft.ANY_COLUMN, ft.CPROP_CONT_TEXT_STYLE, ft.TSTYLE_BOLD)
ftable:set_cell_prop(ft.ANY_ROW, 1, ft.CPROP_CONT_TEXT_STYLE, ft.TSTYLE_BOLD)
ftable:set_cell_prop(ft.ANY_ROW, 5, ft.CPROP_CONT_TEXT_STYLE, ft.TSTYLE_BOLD)
ftable:set_cell_prop(ft.ANY_ROW, ft.ANY_COLUMN, ft.CPROP_CONT_TEXT_STYLE,
                     ft.TSTYLE_ITALIC)

-- Set alignment
ftable:set_cell_prop(ft.ANY_ROW, 2, ft.CPROP_TEXT_ALIGN, ft.ALIGNED_RIGHT)
ftable:set_cell_prop(ft.ANY_ROW, 3, ft.CPROP_TEXT_ALIGN, ft.ALIGNED_RIGHT)
ftable:set_cell_prop(ft.ANY_ROW, 4, ft.CPROP_TEXT_ALIGN, ft.ALIGNED_RIGHT)
ftable:set_cell_prop(ft.ANY_ROW, 5, ft.CPROP_TEXT_ALIGN, ft.ALIGNED_CENTER)
ftable:set_cell_prop(9, 1, ft.CPROP_TEXT_ALIGN, ft.ALIGNED_CENTER)

-- Set colors
ftable:set_cell_prop(2, 5, ft.CPROP_CONT_FG_COLOR, ft.COLOR_GREEN)
ftable:set_cell_prop(4, 5, ft.CPROP_CONT_FG_COLOR, ft.COLOR_RED)
ftable:set_cell_prop(7, 5, ft.CPROP_CONT_FG_COLOR, ft.COLOR_GREEN)
ftable:set_cell_prop(9, 5, ft.CPROP_CONT_FG_COLOR, ft.COLOR_RED)
ftable:set_cell_prop(4, 3, ft.CPROP_CONT_FG_COLOR, ft.COLOR_RED)
ftable:set_cell_prop(5, 4, ft.CPROP_CONT_BG_COLOR, ft.COLOR_LIGHT_RED)
ftable:set_cell_prop(1, ft.ANY_COLUMN, ft.CPROP_CONT_FG_COLOR,
                     ft.COLOR_LIGHT_BLUE)

-- Move ftable to the center of the screen
ftable:set_tbl_prop(ft.TPROP_TOP_MARGIN, 1)
ftable:set_tbl_prop(ft.TPROP_LEFT_MARGIN, 10)

print("ftable:\n" .. tostring(ftable))
