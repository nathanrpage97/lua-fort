local ft = require "fort"

local function use_printf()
    local ftable = ft.create_table()

    ftable:set_cell_prop(1, ft.ANY_COLUMN, ft.CPROP_ROW_TYPE, ft.ROW_HEADER)
    ftable:printf_ln("N|Planet|Speed, km/s")

    ftable:printf_ln("%d|%s|%5.2f", 1, "Mercury", 47.362)
    ftable:printf_ln("%d|%s|%5.2f", 2, "Venus", 35.02)
    ftable:printf_ln("%d|%s|%5.2f", 3, "Earth", 29.78)

    print(ftable)
end

local function use_print()
    local ftable = ft.create_table()

    ftable:set_cell_prop(1, ft.ANY_COLUMN, ft.CPROP_ROW_TYPE, ft.ROW_HEADER)
    ftable:print_ln("N|Planet|Speed, km/s")

    ftable:print_ln("1|Mercury|47.362")
    ftable:print_ln("2|Venus|35.02")
    ftable:print_ln("3|Earth|29.78")

    print(ftable)
end

local function use_write()
    local ftable = ft.create_table()

    ftable:set_cell_prop(1, ft.ANY_COLUMN, ft.CPROP_ROW_TYPE, ft.ROW_HEADER)
    ftable:write_ln("N", "Planet", "Speed, km/s")

    ftable:write_ln("1", "Mercury", "47.362")
    ftable:write_ln("2", "Venus", "35.02")
    ftable:write_ln("3", "Earth", "29.78")

    print(ftable)
end

local function use_row_write()
    local ftable = ft.create_table()

    ftable:set_cell_prop(1, ft.ANY_COLUMN, ft.CPROP_ROW_TYPE, ft.ROW_HEADER)
    ftable:row_write_ln({"N", "Planet", "Speed, km/s"})

    ftable:row_write_ln({"1", "Mercury", "47.362"})
    ftable:row_write_ln({"2", "Venus", "35.02"})
    ftable:row_write_ln({"3", "Earth", "29.78"})

    print(ftable)
end

local function use_table_write()
    local ftable = ft.create_table()

    ftable:set_cell_prop(1, ft.ANY_COLUMN, ft.CPROP_ROW_TYPE, ft.ROW_HEADER)
    ftable:table_write_ln({
        {"N", "Planet", "Speed, km/s"}, {"1", "Mercury", "47.362"},
        {"2", "Venus", "35.02"}, {"3", "Earth", "29.78"}
    })

    print(ftable)

end

use_printf()
use_print()
use_row_write()
use_write()
use_table_write()
