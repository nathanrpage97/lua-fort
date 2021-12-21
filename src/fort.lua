--- Fort Module
-- @classmod fort
-- @pragma nostrip
local fort = require "cfort"

local fortc = {}

local function split(inputstr, sep)
    if sep == nil then sep = "%s" end
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end

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
---@function fort:add_separator
---@within Methods

---Completely Copy a table
---@function fort:copy_table
---@within Methods
---@treturn ftable copied table

---Create a new formatted table
---@function fort.create_table
---@treturn ftable new formatted table

---Get the current column
---@function fort:cur_col
---@within Methods
---@treturn number

---Get the current row
---@function fort:cur_row
---@within Methods
---@treturn number

---Erase a rectangular range of data from the ftable
---@function fort:erase_range
---@within Methods
---@number top_left_row
---@number top_left_col
---@number bottom_right_row
---@number bottom_right_col

---Check if ftable is empty
---@function fort:is_empty
---@within Methods
---@treturn boolean

---Go to the next line (row)
---@function fort:ln
---@within Methods

---Get the number of rows in the ftable
---@function fort:row_count
---@within Methods
---@treturn number

fortc.row_write = fort.row_write

---Write a row of data.
---@tparam {string} row row of strings to write
---@within Methods
function fort:row_write(row)
    local stringified_row = {}
    for i, v in ipairs(row) do stringified_row[i] = tostring(v) end
    fortc.row_write(self, stringified_row)
end

fortc.row_write_ln = fort.row_write_ln
---Write a row of data and go to the next line.
---@tparam {string} row row of strings to write
---@within Methods
function fort:row_write_ln(row)
    local stringified_row = {}
    for i, v in ipairs(row) do stringified_row[i] = tostring(v) end
    fortc.row_write_ln(self, stringified_row)
end

---Write a row
---@param ... string strings to write in the row
---@within Methods
function fort:write(...) fortc.row_write(self, {...}) end
---Write a row and go to the next line
---@param ... string strings to write in the row
---@within Methods
function fort:write_ln(...) fort.row_write_ln(self, {...}) end

---Set the border style of the ftable.
---@function fort:set_border_style
---@within Methods
---@userdata style from available styles @{BASIC_STYLE}

---Set the cell property of the ftable.
---@function fort:set_cell_prop
---@within Methods
---@number row the row to set, can also use @{ANY_ROW}/@{CUR_ROW}
---@number col the column to set, can also use @{ANY_COLUMN}/@{CUR_COLUMN}
---@number property the property to set
---@number value value to set

---Set a cell's horizontal span in the ftable.
---@function fort:set_cell_span
---@within Methods
---@number row the row to set. DO NOT USE @{ANY_ROW}/@{CUR_ROW}
---@number col the column to set. DO NOT USE @{ANY_COLUMN}/@{CUR_COLUMN}
---@number span how many columns the cell should span

---Set the current cell position.
---@function fort:set_cur_cell
---@within Methods
---@number row the row to set. DO NOT USE @{ANY_ROW}/@{CUR_ROW}
---@number col the column to set. DO NOT USE @{ANY_COLUMN}/@{CUR_COLUMN}

---Set the default border style for new tables.
---@function fort.set_default_border_style
---@userdata style from available styles @{BASIC_STYLE}

---Set a default cell property for new tables.
---@function fort.set_default_cell_prop
---@number property the property to set
---@number value value to set

---Set a default table property for new tables.
---@number property the property to set
---@number value value to set
---@function fort.set_default_tbl_prop

---Set a table property.
---@function fort:set_tbl_prop
---@within Methods
---@number property the property to set
---@number value value to set

---Generate the string version of the ftable.
---@function fort:to_string
---@within Methods
---@treturn string formatted table string

---Cell Text Align.
-- Indicate the text alignment inside a cell.
--
-- Can be used with @{set_cell_prop}/@{set_default_cell_prop}
-- @section cell-text-align

--- align text center
fort.ALIGNED_CENTER = fort.ALIGNED_CENTER
--- align text left
fort.ALIGNED_LEFT = fort.ALIGNED_LEFT
--- align text right
fort.ALIGNED_RIGHT = fort.ALIGNED_RIGHT

---Cell Selectors.
-- Special flags that select a cell
--
-- Can be used with @{set_cell_prop}
-- @section cell-selector

--- Select all columns
fort.ANY_COLUMN = fort.ANY_COLUMN
--- Select all rows
fort.ANY_ROW = fort.ANY_ROW
--- Select the current column
fort.CUR_COLUMN = fort.CUR_COLUMN
--- Select the current row
fort.CUR_ROW = fort.CUR_ROW

---Table Border Style.
-- Border styling of the table.
--
-- Refer to refer to
-- [this page](https://github.com/seleznevae/libfort/wiki/Border-styles-%28C-API%29#built-in-border-styles)
-- to see how each border style looks.
-- @section table-border-style

---Border style
fort.BASIC_STYLE = fort.BASIC_STYLE
---Border style
fort.BASIC2_STYLE = fort.BASIC2_STYLE
---Border style
fort.BOLD_STYLE = fort.BOLD_STYLE
---Border style
fort.BOLD2_STYLE = fort.BOLD2_STYLE
---Border style
fort.DOT_STYLE = fort.DOT_STYLE
---Border style
fort.DOUBLE_STYLE = fort.DOUBLE_STYLE
---Border style
fort.DOUBLE2_STYLE = fort.DOUBLE2_STYLE
---Border style
fort.EMPTY_STYLE = fort.EMPTY_STYLE
---Border style
fort.EMPTY2_STYLE = fort.EMPTY2_STYLE
---Border style
fort.FRAME_STYLE = fort.FRAME_STYLE
---Border style
fort.NICE_STYLE = fort.NICE_STYLE
---Border style
fort.PLAIN_STYLE = fort.PLAIN_STYLE
---Border style
fort.SIMPLE_STYLE = fort.SIMPLE_STYLE
---Border style
fort.SOLID_ROUND_STYLE = fort.SOLID_ROUND_STYLE
---Border style
fort.SOLID_STYLE = fort.SOLID_STYLE

---Cell Color.
-- Color used for cell/content properties.
-- @section cell-color

---Color
fort.COLOR_BLACK = fort.COLOR_BLACK
---Color
fort.COLOR_BLUE = fort.COLOR_BLUE
---Color
fort.COLOR_CYAN = fort.COLOR_CYAN
---Color
fort.COLOR_DARK_GRAY = fort.COLOR_DARK_GRAY
---Color
fort.COLOR_DEFAULT = fort.COLOR_DEFAULT
---Color
fort.COLOR_GREEN = fort.COLOR_GREEN
---Color
fort.COLOR_LIGHT_BLUE = fort.COLOR_LIGHT_BLUE
---Color
fort.COLOR_LIGHT_CYAN = fort.COLOR_LIGHT_CYAN
---Color
fort.COLOR_LIGHT_GRAY = fort.COLOR_LIGHT_GRAY
---Color
fort.COLOR_LIGHT_GREEN = fort.COLOR_LIGHT_GREEN
---Color
fort.COLOR_LIGHT_MAGENTA = fort.COLOR_LIGHT_MAGENTA
---Color
fort.COLOR_LIGHT_RED = fort.COLOR_LIGHT_RED
---Color
fort.COLOR_LIGHT_WHITE = fort.COLOR_LIGHT_WHYTE
---Color
fort.COLOR_LIGHT_YELLOW = fort.COLOR_LIGHT_YELLOW
---Color
fort.COLOR_MAGENTA = fort.COLOR_MAGENTA
---Color
fort.COLOR_RED = fort.COLOR_RED
---Color
fort.COLOR_YELLOW = fort.COLOR_YELLOW

---Cell Property.
-- @section cell-property

---Cell Property
fort.CPROP_CELL_BG_COLOR = fort.CPROP_CELL_BG_COLOR
---Cell Property
fort.CPROP_CELL_TEXT_STYLE = fort.CPROP_CELL_TEXT_STYLE
---Cell Property
fort.CPROP_CONT_BG_COLOR = fort.CPROP_CONT_BG_COLOR
---Cell Property
fort.CPROP_CONT_FG_COLOR = fort.CPROP_CONT_FG_COLOR
---Cell Property
fort.CPROP_CONT_TEXT_STYLE = fort.CPROP_CONT_TEXT_STYLE
---Cell Property
fort.CPROP_EMPTY_STR_HEIGHT = fort.CPROP_EMPTY_STR_HEIGHT
---Cell Property
fort.CPROP_MIN_WIDTH = fort.CPROP_MIN_WIDTH
---Cell Property
fort.CPROP_ROW_TYPE = fort.CPROP_ROW_TYPE
---Cell Property
fort.CPROP_TEXT_ALIGN = fort.CPROP_TEXT_ALIGN
---Cell Property
fort.CPROP_TOP_PADDING = fort.CPROP_TOP_PADDING
---Cell Property
fort.CPROP_LEFT_PADDING = fort.CPROP_LEFT_PADDING
---Cell Property
fort.CPROP_BOTTOM_PADDING = fort.CPROP_BOTTOM_PADDING
---Cell Property
fort.CPROP_RIGHT_PADDING = fort.CPROP_RIGHT_PADDING

---Row Type.
-- @section row-type

---Row Type
fort.ROW_COMMON = fort.ROW_COMMON
---Row Type
fort.ROW_HEADER = fort.ROW_HEADER

---Table Adding Strategy.
-- @section table-adding-strategy

---Insert new cells
fort.STRATEGY_INSERT = fort.STRATEGY_INSERT
---Replace current cells
fort.STRATEGY_REPLACE = fort.STRATEGY_REPLACE

---Table Property.
-- @section table-property

---Table Property
fort.TPROP_ADDING_STRATEGY = fort.TPROP_ADDING_STRATEGY
---Table Property
fort.TPROP_BOTTOM_MARGIN = fort.TPROP_BOTTOM_MARGIN
---Table Property
fort.TPROP_LEFT_MARGIN = fort.TPROP_LEFT_MARGIN
---Table Property
fort.TPROP_RIGHT_MARGIN = fort.TPROP_RIGHT_MARGIN
---Table Property
fort.TPROP_TOP_MARGIN = fort.TPROP_TOP_MARGIN

---Cell Text Style.
-- @section cell-text-style

---Text Style
fort.TSTYLE_BLINK = fort.TSTYLE_BLINK
---Text Style
fort.TSTYLE_BOLD = fort.TSTYLE_BOLD
---Text Style
fort.TSTYLE_DEFAULT = fort.TSTYLE_DEFAULT
---Text Style
fort.TSTYLE_DIM = fort.TSTYLE_DIM
---Text Style
fort.TSTYLE_HIDDEN = fort.TSTYLE_HIDDEN
---Text Style
fort.TSTYLE_INVERTED = fort.TSTYLE_INVERTED
---Text Style
fort.TSTYLE_ITALIC = fort.TSTYLE_ITALIC
---Text Style
fort.TSTYLE_UNDERLINED = fort.TSTYLE_UNDERLINED

return fort
