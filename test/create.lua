local fort = require "fort"
local inspect = require "inspect"
local a = fort.create_table()

print(inspect(a))
print(inspect(getmetatable(a)))

print(fort.is_empty(a))
fort.ln(a)
fort.ln(a)

print(fort.cur_row(a))

fort.set_cur_cell(a, 3, 3)
print(fort.cur_row(a))
print(fort.cur_col(a))

print(fort.is_empty(a))

fort.row_write(a, {"test", "test2"})

print(fort.row_count(a))

local b = fort.create_table()
fort.row_write(b, {"hello", "test1"})
fort.row_write(b, {"hello", "test2"})
fort.row_write_ln(b, {"hello", "test3"})
fort.add_separator(b)
fort.row_write_ln(b, {"hello", "test4", "test4", "test4", "test4"})

fort.set_cell_span(b, 1, 1, 3)
print(fort.to_string(b))

fort.printf(b, "test %d|test %d", 2, 232)
fort.printf_ln(b, "ln test %d|test %d", 1234, 891)

fort.set_border_style(b, fort.PLAIN_STYLE)
print(fort.to_string(b))
