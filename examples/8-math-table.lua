local ft = require "fort"

table = ft.create_table();
ft.set_border_style(table, ft.DOUBLE2_STYLE);

-- 2 last columns are aligned right
ft.set_cell_prop(table, ft.ANY_ROW, 2, ft.CPROP_TEXT_ALIGN, ft.ALIGNED_RIGHT);
ft.set_cell_prop(table, ft.ANY_ROW, 3, ft.CPROP_TEXT_ALIGN, ft.ALIGNED_RIGHT);

-- Setup header
ft.set_cell_prop(table, 0, ft.ANY_COLUMN, ft.CPROP_ROW_TYPE, ft.ROW_HEADER);
ft.write_ln(table, "Figure", "Formula", "Volume, cm³", "Accuracy");

ft.write_ln(table, "Sphere ○", "4πR³/3", "3.145", "±0.3");
ft.write_ln(table, "Cone ◸", "πR²h/3", "4.95", "±0.25");
ft.write_ln(table, "Random", "∫ρdv", "12.95", "±0.75");

print(ft.to_string(table));
