local fort = require "fort"
local inspect = require "inspect"

local a = fort.create_table()

fort.table_write(a, {{[3] = "2", [5] = "3", test = "4"}, {"a", "b", "c", "d"}})

print(fort.to_string(a))
