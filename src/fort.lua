--- Fort Module
-- @classmod fort
-- @pragma nostrip
local cfort = require "cfort"

local fort = {}
setmetatable(cfort, {__index = fort})

local function split(inputstr, sep)
    if sep == nil then sep = "%s" end
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end

---Create a new formatted table
---@function fort.create_table
---@treturn ftable new formatted table
function fort.create_table() return cfort.create_table() end

---Alias of @{fort.create_table}
---@function fort.new
fort.new = fort.create_table

---Alias of @{fort.create_table}
---@function fort.create
fort.create = fort.create_table

---Alias of @{fort.create_table}
---@within Metamethods
fort.__call = fort.new
setmetatable(fort, fort)

---Control the default separator for @{printf} and @{printf_ln} functions.
---(Defaults to '|')
fort.default_separator = "|"

---Use a formatted string to write a row.
---
---Splits cells on fort.default_separator. Uses lua @{string.format} to
---format the text.
---@string row_format row to write with formatting
---@param ... any format arguments
---@within Methods
function fort:printf(row_format, ...)
    local formatted_text = string.format(row_format, ...)
    local row = split(formatted_text, fort.default_separator)
    fort.row_write(self, row)
end

---Use a formatted string to write a row and go to the next line.
---
---Splits cells on fort.default_separator. Uses lua @{string.format} to
---format the text.
---@string row_format row to write with formatting
---@param ... any format arguments
---@within Methods
function fort:printf_ln(row_format, ...)
    local formatted_text = string.format(row_format, ...)
    local row = split(formatted_text, fort.default_separator)
    fort.row_write_ln(self, row)
end

---Write a row.
---Use a single string to write a row. Allows using a custom cell separator
---without modifying the global separator.
---@string row_text
---@string[opt=fort.default_separator] sep cell separator
---@within Methods
function fort:print(row_text, sep)
    sep = sep or fort.default_separator
    local row = split(row_text, sep)
    fort.row_write(self, row)
end

---Write a row and go to the next line.
---Use a single string to write a row. Allows using a custom cell separator
---without modifying the global separator.
---@string row_text
---@string[opt=fort.default_separator] sep cell separator
---@within Methods
function fort:print_ln(row_text, sep)
    sep = sep or fort.default_separator
    local row = split(row_text, sep)
    fort.row_write_ln(self, row)
end

---Write a 2d array of strings to the ftable.
---@tparam {{string}} data_table 2d array of strings to write, can be jagged.
---@bool[opt=false] colalign align to the @{cur_col} at the start
---@within Methods
function fort:table_write(data_table, colalign)
    colalign = colalign or false
    local rows = #data_table
    local cur_col = fort.cur_col(self)
    for row_index, data_row in ipairs(data_table) do
        fort.row_write(self, data_row)
        if row_index ~= rows then
            fort.ln(self)
            if colalign then
                local cur_row = fort.cur_row(self)
                fort.set_cur_cell(self, cur_row, cur_col)
            end
        end
    end
end

---Write a 2d array of strings to the ftable and go to next line.
---@tparam {{string}} data_table 2d array of strings to write, can be jagged.
---@bool[opt=false] colalign align to the @{cur_col} at the start
---@within Methods
function fort:table_write_ln(data_table, colalign)
    local cur_col = fort.cur_col(self)
    colalign = colalign or false
    fort.table_write(self, data_table, colalign)
    fort.ln(self)
    if colalign then
        local cur_row = fort.cur_row(self)
        fort.set_cur_cell(self, cur_row, cur_col)
    end
end

---Add a dividing separtor line at the current row.
---@within Methods
function fort:add_separator() cfort.add_separator(self) end

---Completely Copy a table
---@within Methods
---@treturn ftable copied table
function fort:copy_table() return cfort.copy_table(self) end

---Alias of @{fort.copy_table}
---@function fort:copy
---@within Methods
---@treturn ftable copied table
fort.copy = fort.copy_table

---Get the current column
---@within Methods
---@treturn number
function fort:cur_col() return cfort.cur_col(self) end

---Get the current row
---@within Methods
---@treturn number
function fort:cur_row() return cfort.cur_row(self) end

---Erase a rectangular range of data from the ftable
---@within Methods
---@number top_left_row
---@number top_left_col
---@number bottom_right_row
---@number bottom_right_col
function fort:erase_range(top_left_row, top_left_col, bottom_right_row,
                          bottom_right_col)
    return cfort.erase_range(self, top_left_row, top_left_col, bottom_right_row,
                             bottom_right_col)
end

---Check if ftable is empty
---@within Methods
---@treturn boolean
function fort:is_empty() return cfort.is_empty(self) end

---Go to the next line (row)
---@within Methods
function fort:ln() return cfort.ln(self) end

---Get the number of rows in the ftable
---@within Methods
---@treturn number
function fort:row_count() return cfort.row_count(self) end

---Get the number of columns in the ftable
---@function fort:col_count
---@within Methods
---@treturn number
function fort:col_count() return cfort.col_count(self) end

---Write a row of data.
---@tparam {string} row row of strings to write
---@within Methods
function fort:row_write(row)
    assert(type(row) == "table", "Expected table for arg 1")
    local stringified_row = {}
    for i, v in ipairs(row) do stringified_row[i] = tostring(v) end
    cfort.row_write(self, stringified_row)
end

---Write a row of data and go to the next line.
---@tparam {string} row row of strings to write
---@within Methods
function fort:row_write_ln(row)
    assert(type(row) == "table", "Expected table for arg 1")
    local stringified_row = {}
    for i, v in ipairs(row) do stringified_row[i] = tostring(v) end
    cfort.row_write_ln(self, stringified_row)
end

---Write a row
---@param ... string strings to write in the row
---@within Methods
function fort:write(...) fort.row_write(self, {...}) end
---Write a row and go to the next line
---@param ... string strings to write in the row
---@within Methods
function fort:write_ln(...) fort.row_write_ln(self, {...}) end

---Set the border style of the ftable.
---@function fort:set_border_style
---@within Methods
---@userdata style from available styles @{BASIC_STYLE}
function fort:set_border_style(style) cfort.set_border_style(self, style) end

---Set the cell property of the ftable.
---@function fort:set_cell_prop
---@within Methods
---@number row the row to set, can also use @{ANY_ROW}/@{CUR_ROW}
---@number col the column to set, can also use @{ANY_COLUMN}/@{CUR_COLUMN}
---@number property the property to set
---@number value value to set
function fort:set_cell_prop(row, col, property, value)
    cfort.set_cell_prop(self, row, col, property, value)
end

---Set a cell's horizontal span in the ftable.
---@function fort:set_cell_span
---@within Methods
---@number row the row to set. DO NOT USE @{ANY_ROW}/@{CUR_ROW}
---@number col the column to set. DO NOT USE @{ANY_COLUMN}/@{CUR_COLUMN}
---@number span how many columns the cell should span
function fort:set_cell_span(row, col, span)
    cfort.set_cell_span(self, row, col, span)
end

---Set the current cell position.
---@within Methods
---@number row the row to set. DO NOT USE @{ANY_ROW}/@{CUR_ROW}
---@number col the column to set. DO NOT USE @{ANY_COLUMN}/@{CUR_COLUMN}
function fort:set_cur_cell(row, col) cfort.set_cur_cell(self, row, col) end

---Set the default border style for new tables.
---@userdata style from available styles @{BASIC_STYLE}
function fort.set_default_border_style(style)
    cfort.set_default_border_style(style)
end

---Set a default cell property for new tables.
---@number property the property to set
---@number value value to set
function fort.set_default_cell_prop(property, value)
    cfort.set_default_cell_prop(property, value)
end

---Set a default table property for new tables.
---@number property the property to set
---@number value value to set
function fort.set_default_tbl_prop(property, value)
    cfort.set_default_tbl_prop(property, value)
end

---Set a table property.
---@within Methods
---@number property the property to set
---@number value value to set
function fort:set_tbl_prop(property, value)
    cfort.set_tbl_prop(self, property, value)
end

---Generate the string version of the ftable.
---@within Methods
---@treturn string formatted table string
function fort:to_string() return cfort.to_string(self) end

---Cell Text Align.
-- Indicate the text alignment inside a cell.
--
-- Can be used with @{set_cell_prop}/@{set_default_cell_prop}
-- @section cell-text-align

--- align text center
fort.ALIGNED_CENTER = cfort.ALIGNED_CENTER
--- align text left
fort.ALIGNED_LEFT = cfort.ALIGNED_LEFT
--- align text right
fort.ALIGNED_RIGHT = cfort.ALIGNED_RIGHT

---Cell Selectors.
-- Special flags that select a cell
--
-- Can be used with @{set_cell_prop}
-- @section cell-selector

--- Select all columns
fort.ANY_COLUMN = cfort.ANY_COLUMN
--- Select all rows
fort.ANY_ROW = cfort.ANY_ROW
--- Select the current column
fort.CUR_COLUMN = cfort.CUR_COLUMN
--- Select the current row
fort.CUR_ROW = cfort.CUR_ROW

---Table Border Style.
-- Border styling of the table.
--
-- Refer to refer to
-- [this page](https://github.com/seleznevae/libfort/wiki/Border-styles-%28C-API%29#built-in-border-styles)
-- to see how each border style looks.
-- @section table-border-style

---Border style
fort.BASIC_STYLE = cfort.BASIC_STYLE
---Border style
fort.BASIC2_STYLE = cfort.BASIC2_STYLE
---Border style
fort.BOLD_STYLE = cfort.BOLD_STYLE
---Border style
fort.BOLD2_STYLE = cfort.BOLD2_STYLE
---Border style
fort.DOT_STYLE = cfort.DOT_STYLE
---Border style
fort.DOUBLE_STYLE = cfort.DOUBLE_STYLE
---Border style
fort.DOUBLE2_STYLE = cfort.DOUBLE2_STYLE
---Border style
fort.EMPTY_STYLE = cfort.EMPTY_STYLE
---Border style
fort.EMPTY2_STYLE = cfort.EMPTY2_STYLE
---Border style
fort.FRAME_STYLE = cfort.FRAME_STYLE
---Border style
fort.NICE_STYLE = cfort.NICE_STYLE
---Border style
fort.PLAIN_STYLE = cfort.PLAIN_STYLE
---Border style
fort.SIMPLE_STYLE = cfort.SIMPLE_STYLE
---Border style
fort.SOLID_ROUND_STYLE = cfort.SOLID_ROUND_STYLE
---Border style
fort.SOLID_STYLE = cfort.SOLID_STYLE

---Cell Color.
-- Color used for cell/content properties.
-- @section cell-color

---Color
fort.COLOR_BLACK = cfort.COLOR_BLACK
---Color
fort.COLOR_BLUE = cfort.COLOR_BLUE
---Color
fort.COLOR_CYAN = cfort.COLOR_CYAN
---Color
fort.COLOR_DARK_GRAY = cfort.COLOR_DARK_GRAY
---Color
fort.COLOR_DEFAULT = cfort.COLOR_DEFAULT
---Color
fort.COLOR_GREEN = cfort.COLOR_GREEN
---Color
fort.COLOR_LIGHT_BLUE = cfort.COLOR_LIGHT_BLUE
---Color
fort.COLOR_LIGHT_CYAN = cfort.COLOR_LIGHT_CYAN
---Color
fort.COLOR_LIGHT_GRAY = cfort.COLOR_LIGHT_GRAY
---Color
fort.COLOR_LIGHT_GREEN = cfort.COLOR_LIGHT_GREEN
---Color
fort.COLOR_LIGHT_MAGENTA = cfort.COLOR_LIGHT_MAGENTA
---Color
fort.COLOR_LIGHT_RED = cfort.COLOR_LIGHT_RED
---Color
fort.COLOR_LIGHT_WHITE = cfort.COLOR_LIGHT_WHYTE
---Color
fort.COLOR_LIGHT_YELLOW = cfort.COLOR_LIGHT_YELLOW
---Color
fort.COLOR_MAGENTA = cfort.COLOR_MAGENTA
---Color
fort.COLOR_RED = cfort.COLOR_RED
---Color
fort.COLOR_YELLOW = cfort.COLOR_YELLOW

---Cell Property.
-- @section cell-property

---Cell Property
fort.CPROP_CELL_BG_COLOR = cfort.CPROP_CELL_BG_COLOR
---Cell Property
fort.CPROP_CELL_TEXT_STYLE = cfort.CPROP_CELL_TEXT_STYLE
---Cell Property
fort.CPROP_CONT_BG_COLOR = cfort.CPROP_CONT_BG_COLOR
---Cell Property
fort.CPROP_CONT_FG_COLOR = cfort.CPROP_CONT_FG_COLOR
---Cell Property
fort.CPROP_CONT_TEXT_STYLE = cfort.CPROP_CONT_TEXT_STYLE
---Cell Property
fort.CPROP_EMPTY_STR_HEIGHT = cfort.CPROP_EMPTY_STR_HEIGHT
---Cell Property
fort.CPROP_MIN_WIDTH = cfort.CPROP_MIN_WIDTH
---Cell Property
fort.CPROP_ROW_TYPE = cfort.CPROP_ROW_TYPE
---Cell Property
fort.CPROP_TEXT_ALIGN = cfort.CPROP_TEXT_ALIGN
---Cell Property
fort.CPROP_TOP_PADDING = cfort.CPROP_TOP_PADDING
---Cell Property
fort.CPROP_LEFT_PADDING = cfort.CPROP_LEFT_PADDING
---Cell Property
fort.CPROP_BOTTOM_PADDING = cfort.CPROP_BOTTOM_PADDING
---Cell Property
fort.CPROP_RIGHT_PADDING = cfort.CPROP_RIGHT_PADDING

---Row Type.
-- @section row-type

---Row Type
fort.ROW_COMMON = cfort.ROW_COMMON
---Row Type
fort.ROW_HEADER = cfort.ROW_HEADER

---Table Adding Strategy.
-- @section table-adding-strategy

---Insert new cells
fort.STRATEGY_INSERT = cfort.STRATEGY_INSERT
---Replace current cells
fort.STRATEGY_REPLACE = cfort.STRATEGY_REPLACE

---Table Property.
-- @section table-property

---Table Property
fort.TPROP_ADDING_STRATEGY = cfort.TPROP_ADDING_STRATEGY
---Table Property
fort.TPROP_BOTTOM_MARGIN = cfort.TPROP_BOTTOM_MARGIN
---Table Property
fort.TPROP_LEFT_MARGIN = cfort.TPROP_LEFT_MARGIN
---Table Property
fort.TPROP_RIGHT_MARGIN = cfort.TPROP_RIGHT_MARGIN
---Table Property
fort.TPROP_TOP_MARGIN = cfort.TPROP_TOP_MARGIN

---Cell Text Style.
-- @section cell-text-style

---Text Style
fort.TSTYLE_BLINK = cfort.TSTYLE_BLINK
---Text Style
fort.TSTYLE_BOLD = cfort.TSTYLE_BOLD
---Text Style
fort.TSTYLE_DEFAULT = cfort.TSTYLE_DEFAULT
---Text Style
fort.TSTYLE_DIM = cfort.TSTYLE_DIM
---Text Style
fort.TSTYLE_HIDDEN = cfort.TSTYLE_HIDDEN
---Text Style
fort.TSTYLE_INVERTED = cfort.TSTYLE_INVERTED
---Text Style
fort.TSTYLE_ITALIC = cfort.TSTYLE_ITALIC
---Text Style
fort.TSTYLE_UNDERLINED = cfort.TSTYLE_UNDERLINED

return fort
