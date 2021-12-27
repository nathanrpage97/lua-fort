local ft = require "fort"

local ftable = ft.create_table();
ftable:set_border_style(ft.DOUBLE2_STYLE);

-- 2 last columns are aligned right
ftable:set_cell_prop(ft.ANY_ROW, 3, ft.CPROP_TEXT_ALIGN, ft.ALIGNED_RIGHT);
ftable:set_cell_prop(ft.ANY_ROW, 4, ft.CPROP_TEXT_ALIGN, ft.ALIGNED_RIGHT);

-- Setup header
ftable:set_cell_prop(1, ft.ANY_COLUMN, ft.CPROP_ROW_TYPE, ft.ROW_HEADER);
ftable:write_ln("Figure", "Formula", "Volume, cm³", "Accuracy");

ftable:write_ln("Sphere ○", "4πR³/3", "3.145", "±0.3");
ftable:write_ln("Cone ◸", "πR²h/3", "4.95", "±0.25");
ftable:write_ln("Random", "∫ρdv", "12.95", "±0.75");

print(ftable);
