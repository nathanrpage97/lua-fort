local ft = require "fort"

local ftable = ft.create_table()

-- setup header
ftable:set_cell_prop(0, ft.ANY_COLUMN, ft.CPROP_ROW_TYPE, ft.ROW_HEADER)
ftable:write_ln("N", "Driver", "Time", "Avg Speed")
ftable:write_ln("1", "Ricciardo", "1:25.945", "222.128")
ftable:write_ln("2", "Hamilton", "1:26.373", "221.027")
ftable:write_ln("3", "Verstappen", "1:26.469", "220.782")

print(ftable:to_string())
