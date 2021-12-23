local ft = require "fort"

local ftable = ft.create_table();
ft.set_border_style(ftable, ft.DOUBLE2_STYLE);

-- 2 last columns are aligned right
ft.set_cell_prop(ftable, ft.ANY_ROW, 3, ft.CPROP_TEXT_ALIGN, ft.ALIGNED_RIGHT);
ft.set_cell_prop(ftable, ft.ANY_ROW, 4, ft.CPROP_TEXT_ALIGN, ft.ALIGNED_RIGHT);

-- Setup header
ft.set_cell_prop(ftable, 1, ft.ANY_COLUMN, ft.CPROP_ROW_TYPE, ft.ROW_HEADER);
ft.write_ln(ftable, "Figure", "Formula", "Volume, cm³", "Accuracy");

ft.write_ln(ftable, "Sphere ○", "4πR³/3", "3.145", "±0.3");
ft.write_ln(ftable, "Cone ◸", "πR²h/3", "4.95", "±0.25");
ft.write_ln(ftable, "Random", "∫ρdv", "12.95", "±0.75");

print(ftable);
