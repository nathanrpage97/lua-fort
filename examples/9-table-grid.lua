local ft = require "fort"

local ftable = ft.create_table()

-- setup header
ftable:set_cell_prop(1, ft.ANY_COLUMN, ft.CPROP_ROW_TYPE, ft.ROW_HEADER)
ftable:write_ln("N", "Driver", "Time", "Avg Speed")
ftable:write_ln("1", "Ricciardo", "1:25.945", "222.128")
ftable:write_ln("2", "Hamilton", "1:26.373", "221.027")
ftable:write_ln("3", "Verstappen", "1:26.469", "220.782")

--- create a table grid
local fgrid = ft.create_table()
fgrid:set_border_style(ft.EMPTY_STYLE)

local ftable2 = ftable:copy()
ftable2:write_ln("4", "?", "?", "?")

fgrid:table_write({{ftable, ftable2, ftable}, {ftable, "", ftable}})

print(fgrid)
