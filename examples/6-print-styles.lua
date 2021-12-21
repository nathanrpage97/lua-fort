local ft = require "fort"
local function print_table_with_styles(style, name)
    -- Just create a table with some content
    table = ft.create_table()
    ft.set_cell_prop(table, ft.ANY_ROW, 0, ft.CPROP_TEXT_ALIGN,
                     ft.ALIGNED_CENTER)
    ft.set_cell_prop(table, ft.ANY_ROW, 1, ft.CPROP_TEXT_ALIGN, ft.ALIGNED_LEFT)

    ft.set_cell_prop(table, 0, ft.ANY_COLUMN, ft.CPROP_ROW_TYPE, ft.ROW_HEADER)
    ft.write_ln(table, "Rank", "Title", "Year", "Rating")

    ft.write_ln(table, "1", "The Shawshank Redemption", "1994", "9.5")
    ft.write_ln(table, "2", "12 Angry Men", "1957", "8.8")
    ft.write_ln(table, "3", "It's a Wonderful Life", "1946", "8.6")
    ft.add_separator(table)
    ft.write_ln(table, "4", "2001: A Space Odyssey", "1968", "8.5")
    ft.write_ln(table, "5", "Blade Runner", "1982", "8.1")

    -- Setup border style
    ft.set_border_style(table, style)
    -- Print table
    print(string.format("%s style:\n\n%s\n\n", name, ft.to_string(table)))
end

local function print_table_with_different_styles()
    local function print_style(name) print_table_with_styles(ft[name], name) end
    print_style("BASIC_STYLE")
    print_style("BASIC2_STYLE")
    print_style("SIMPLE_STYLE")
    print_style("PLAIN_STYLE")
    print_style("DOT_STYLE")
    print_style("EMPTY_STYLE")
    print_style("EMPTY2_STYLE")
    print_style("SOLID_STYLE")
    print_style("SOLID_ROUND_STYLE")
    print_style("NICE_STYLE")
    print_style("DOUBLE_STYLE")
    print_style("DOUBLE2_STYLE")
    print_style("BOLD_STYLE")
    print_style("BOLD2_STYLE")
    print_style("FRAME_STYLE")
end

print_table_with_different_styles()
