local ft = require "fort"
local function print_table_with_styles(style, name)
    -- Just create a table with some content
    local ftable = ft.create_table()
    ft.set_cell_prop(ftable, ft.ANY_ROW, 1, ft.CPROP_TEXT_ALIGN,
                     ft.ALIGNED_CENTER)
    ft.set_cell_prop(ftable, ft.ANY_ROW, 2, ft.CPROP_TEXT_ALIGN, ft.ALIGNED_LEFT)

    ft.set_cell_prop(ftable, 1, ft.ANY_COLUMN, ft.CPROP_ROW_TYPE, ft.ROW_HEADER)
    ft.write_ln(ftable, "Rank", "Title", "Year", "Rating")

    ft.write_ln(ftable, "1", "The Shawshank Redemption", "1994", "9.5")
    ft.write_ln(ftable, "2", "12 Angry Men", "1957", "8.8")
    ft.write_ln(ftable, "3", "It's a Wonderful Life", "1946", "8.6")
    ft.add_separator(ftable)
    ft.write_ln(ftable, "4", "2001: A Space Odyssey", "1968", "8.5")
    ft.write_ln(ftable, "5", "Blade Runner", "1982", "8.1")

    -- Setup border style
    ft.set_border_style(ftable, style)
    -- Print ftable
    print(string.format("%s style:\n\n%s\n\n", name, ftable))
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
