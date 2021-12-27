--- Fort Module
-- @classmod fort
-- @pragma nostrip
local cfort = require "cfort"

local fort = {}

---Create a new formatted table
---@function fort.create_table
---@treturn ftable new formatted table

---Alias of @{fort.create_table}
---@function fort.new
---@treturn ftable new formatted table

---Alias of @{fort.create_table}
---@function fort.create
---@treturn ftable new formatted table

---Alias of @{fort.create_table}
---@within Metamethods
---@function fort.__call
---@treturn ftable new formatted table

---Control the default separator for @{printf} and @{printf_ln} functions.
---(Defaults to '|')
fort.default_separator = "|"

---Use a formatted string to write a row.
---
---Splits cells on fort.default_separator. Uses lua @{string.format} to
---format the text.
---@function fort:printf
---@string row_format row to write with formatting
---@param ... any format arguments
---@within Methods: Data Entry

---Use a formatted string to write a row and go to the next line.
---
---Splits cells on fort.default_separator. Uses lua @{string.format} to
---format the text.
---@function fort:printf_ln
---@string row_format row to write with formatting
---@param ... any format arguments
---@within Methods: Data Entry

---Write a row.
---Use a single string to write a row. Allows using a custom cell separator
---without modifying the global separator.
---@function fort:print
---@string row_text
---@string[opt=fort.default_separator] sep cell separator
---@within Methods: Data Entry

---Write a row and go to the next line.
---Use a single string to write a row. Allows using a custom cell separator
---without modifying the global separator.
---@function fort:print_ln
---@string row_text
---@string[opt=fort.default_separator] sep cell separator
---@within  Methods: Data Entry

---Write a 2d array of strings to the ftable.
---@function fort:table_write
---@tparam {{string}} data_table 2d array of strings to write, can be jagged.
---@bool[opt=false] colalign align to the @{cur_col} at the start
---@within  Methods: Data Entry

---Write a 2d array of strings to the ftable and go to next line.
---@function fort:table_write_ln
---@tparam {{string}} data_table 2d array of strings to write, can be jagged.
---@bool[opt=false] colalign align to the @{cur_col} at the start
---@within  Methods: Data Entry

---Add a dividing separtor line at the current row.
---@function fort:add_separator
---@within Methods: Table Appearance

---Completely Copy a table
---@function fort:copy_table
---@within Methods: Table State
---@treturn ftable copied table

---Alias of @{fort:copy_table}
---@function fort:copy
---@within Methods: Table State
---@treturn ftable copied table

---Get the current column
---@function fort:cur_col
---@within Methods: Table State
---@treturn number

---Get the current row
---@function fort:cur_row
---@within Methods: Table State
---@treturn number

---Erase a rectangular range of data from the ftable
---@function fort:erase_range
---@within Methods: Data Entry
---@number top_left_row
---@number top_left_col
---@number bottom_right_row
---@number bottom_right_col

---Check if ftable is empty
---@function fort:is_empty
---@within Methods: Table State
---@treturn boolean

---Go to the next line (row)
---@function fort:ln
---@within Methods: Data Entry

---Get the number of rows in the ftable
---@function fort:row_count
---@within Methods: Table State
---@treturn number

---Get the number of columns in the ftable
---@function fort:col_count
---@within Methods: Table State
---@treturn number

---Write a row of data.
---@function fort:row_write
---@tparam {string} row row of strings to write
---@within Methods: Data Entry

---Write a row of data and go to the next line.
---@function fort:row_write_ln
---@tparam {string} row row of strings to write
---@within Methods: Data Entry

---Write a row
---@function fort:write
---@param ... string strings to write in the row
---@within Methods: Data Entry

---Write a row and go to the next line
---@function fort:write_ln
---@param ... string strings to write in the row
---@within Methods: Data Entry

---Set the border style of the ftable.
---@function fort:set_border_style
---@within Methods: Table Appearance
---@userdata style from available styles @{BASIC_STYLE}

---Set the cell property of the ftable.
---@function fort:set_cell_prop
---@within Methods: Table Appearance
---@number row the row to set, can also use @{ANY_ROW}/@{CUR_ROW}
---@number col the column to set, can also use @{ANY_COLUMN}/@{CUR_COLUMN}
---@number property the property to set
---@number value value to set

---Set a cell's horizontal span in the ftable.
---@function fort:set_cell_span
---@within Methods: Table Appearance
---@number row the row to set. DO NOT USE @{ANY_ROW}/@{CUR_ROW}
---@number col the column to set. DO NOT USE @{ANY_COLUMN}/@{CUR_COLUMN}
---@number span how many columns the cell should span

---Set the current cell position.
---@within Methods: Data Entry
---@function fort:set_cur_cell
---@number row the row to set. DO NOT USE @{ANY_ROW}/@{CUR_ROW}
---@number col the column to set. DO NOT USE @{ANY_COLUMN}/@{CUR_COLUMN}

---Set the default border style for new tables.
---@userdata style from available styles @{BASIC_STYLE}
---@function fort.set_default_border_style

---Set a default cell property for new tables.
---@number property the property to set
---@number value value to set
---@function fort.set_default_cell_prop

---Set a default table property for new tables.
---@number property the property to set
---@number value value to set
---@function fort.set_default_tbl_prop

---Set a table property.
---@within Methods: Table Appearance
---@number property the property to set
---@number value value to set
---@function fort:set_tbl_prop

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
