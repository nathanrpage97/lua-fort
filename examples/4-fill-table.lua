local ft = require "fort"

local function use_printf()
    local table = ft.create_table()

    ft.set_cell_prop(table, 0, ft.ANY_COLUMN, ft.CPROP_ROW_TYPE, ft.ROW_HEADER)
    ft.printf_ln(table, "N|Planet|Speed, km/s")

    ft.printf_ln(table, "%d|%s|%5.2f", 1, "Mercury", 47.362)
    ft.printf_ln(table, "%d|%s|%5.2f", 2, "Venus", 35.02)
    ft.printf_ln(table, "%d|%s|%5.2f", 3, "Earth", 29.78)

    print(ft.to_string(table))
end

local function use_print()
    local table = ft.create_table()

    ft.set_cell_prop(table, 0, ft.ANY_COLUMN, ft.CPROP_ROW_TYPE, ft.ROW_HEADER)
    ft.print_ln(table, "N|Planet|Speed, km/s")

    ft.print_ln(table, "1|Mercury|47.362")
    ft.print_ln(table, "2|Venus|35.02")
    ft.print_ln(table, "3|Earth|29.78")

    print(ft.to_string(table))
end

local function use_write()
    local table = ft.create_table()

    ft.set_cell_prop(table, 0, ft.ANY_COLUMN, ft.CPROP_ROW_TYPE, ft.ROW_HEADER)
    ft.write_ln(table, "N", "Planet", "Speed, km/s")

    ft.write_ln(table, "1", "Mercury", "47.362")
    ft.write_ln(table, "2", "Venus", "35.02")
    ft.write_ln(table, "3", "Earth", "29.78")

    print(ft.to_string(table))
end

local function use_row_write()
    local table = ft.create_table()

    ft.set_cell_prop(table, 0, ft.ANY_COLUMN, ft.CPROP_ROW_TYPE, ft.ROW_HEADER)
    ft.row_write_ln(table, {"N", "Planet", "Speed, km/s"})

    ft.row_write_ln(table, {"1", "Mercury", "47.362"})
    ft.row_write_ln(table, {"2", "Venus", "35.02"})
    ft.row_write_ln(table, {"3", "Earth", "29.78"})

    print(ft.to_string(table))
end

local function use_table_write()
    local table = ft.create_table()

    ft.set_cell_prop(table, 0, ft.ANY_COLUMN, ft.CPROP_ROW_TYPE, ft.ROW_HEADER)
    ft.table_write_ln(table, {
        {"N", "Planet", "Speed, km/s"}, {"1", "Mercury", "47.362"},
        {"2", "Venus", "35.02"}, {"3", "Earth", "29.78"}
    })

    print(ft.to_string(table))

end

use_printf()
use_print()
use_row_write()
use_write()
use_table_write()
