local ft = require "fort"

local ftable = ft.create_table()

-- setup header
ft.set_cell_prop(ftable, 1, ft.ANY_COLUMN, ft.CPROP_ROW_TYPE, ft.ROW_HEADER)
ft.write_ln(ftable, "N", "Driver", "Time", "Avg Speed")
ft.write_ln(ftable, "1", "Ricciardo", "1:25.945", "222.128")
ft.write_ln(ftable, "2", "Hamilton", "1:26.373", "221.027")
ft.write_ln(ftable, "3", "Verstappen", "1:26.469", "220.782")

--- create a table grid
local fgrid = ft.create_table()
ft.set_border_style(fgrid, ft.EMPTY_STYLE)

local ftable2 = ft.copy(ftable)

ft.write_ln(ftable2, "4", "?", "?", "?")

local ftable_str = ft.to_string(ftable)
local ftable2_str = ft.to_string(ftable2)

ft.table_write(fgrid, {
    {ftable_str, ftable2_str, ftable_str}, {ftable_str, "", ftable_str}
})

print(ft.to_string(fgrid))
