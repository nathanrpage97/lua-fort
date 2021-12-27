local ft = require "fort"

local ftable = ft.create_table()

-- setup header
ftable.set_cell_prop(ftable, 1, ft.ANY_COLUMN, ft.CPROP_ROW_TYPE, ft.ROW_HEADER)
ft.write_ln(ftable, "N", "Driver", "Time", "Avg Speed")
ft.write_ln(ftable, "1", "Ricciardo", "1:25.945", "222.128")
ft.write_ln(ftable, "2", "Hamilton", "1:26.373", "221.027")
ft.write_ln(ftable, "3", "Verstappen", "1:26.469", "220.782")

print(ftable)
