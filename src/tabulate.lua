local fort = require "fort"

local tabulate = {}

---@alias tabulate.Frame
--- | 'basic'
--- |'basic2'
--- |'bold'
--- |'bold2'
--- |'dot'
--- |'double'
--- |'double2'
--- |'empty'
--- | 'empty2'
--- |'frame'
--- |'nice'
--- |'plain'
--- |'simple'
--- |'solid_round'
--- |'solid'

---@alias tabulate.Align 'left'|'center'|'right'

---@alias tabulate.Formatter  fun(row: integer, col_name: string, value: any):string
---@alias tabulate.Wrapper fun (row: integer, col_name: string, value: string): string[]

---@class tabulate.Padding
---@field top? integer
---@field bottom? integer
---@field left? integer
---@field right? integer

---@alias tabulate.Margin tabulate.Padding

---@class tabulate.Options
---@field column string[]
---@field header? table<string, string>
---@field align? table<string, tabulate.Align>
---@field row_separator? integer[]|integer
---@field cell_span? table<integer, table<string, integer>>
---@field frame? tabulate.Frame
---@field margin? tabulate.Margin
---@field col_padding? table<string, tabulate.Padding>
---@field padding? tabulate.Padding
---@field show_header? boolean  defaults to true
---@field format? tabulate.Formatter
---@field wrap? tabulate.Wrapper
---@field footer? table<string, any>
---@field footer_column? string[]
---@field footer_span? table<string, integer>
---@field footer_separator? boolean  defaults to true when valid footer
---@field footer_align? table<string, tabulate.Align>

---@type table<tabulate.Frame, fort.BorderStyle>
local border_style_mapping = {
    basic = fort.BASIC_STYLE,
    basic2 = fort.BASIC2_STYLE,
    bold = fort.BOLD_STYLE,
    bold2 = fort.BOLD2_STYLE,
    dot = fort.DOT_STYLE,
    double = fort.DOUBLE_STYLE,
    double2 = fort.DOUBLE2_STYLE,
    empty = fort.EMPTY_STYLE,
    empty2 = fort.EMPTY2_STYLE,
    frame = fort.FRAME_STYLE,
    nice = fort.NICE_STYLE,
    plain = fort.PLAIN_STYLE,
    simple = fort.SIMPLE_STYLE,
    solid_round = fort.SOLID_ROUND_STYLE,
    solid = fort.SOLID_STYLE
}

---@type table<tabulate.Align, integer>
local text_align_mapping = {
    left = fort.ALIGNED_LEFT,
    center = fort.ALIGNED_CENTER,
    right = fort.ALIGNED_RIGHT
}

---@generic IT
---@param data IT[]
---@return table<IT, integer>
local function indexify(data)
    local res = {}
    for i, val in ipairs(data) do res[val] = i end
    return res
end

---@generic HT
---@param data HT[]
---@return table<HT, true>
local function hashmapify(data)
    local res = {}
    for _, val in ipairs(data) do res[val] = true end
    return res
end

---@param data table<string, any>[]
---@param options tabulate.Options
---@return string
function tabulate.tabulate(data, options)
    local ftable = fort.create()

    local base_row_separator = options.row_separator or {}
    local row_separator
    if type(base_row_separator) == "number" then
        row_separator = base_row_separator
    else
        ---@diagnostic disable-next-line: param-type-mismatch
        row_separator = hashmapify(base_row_separator)
    end

    local header_row_offset = 0
    local footer_row_offset = 0
    local show_header = options.show_header == nil or options.show_header
    -- add
    if options.footer then footer_row_offset = -1 end
    if show_header then header_row_offset = 1 end
    local column_index_map = indexify(options.column)
    local footer_index_map = indexify(options.footer_column or options.column)

    local header = options.header or {}

    if show_header then
        for _, col_name in ipairs(options.column) do
            local name = header[col_name] or col_name
            ftable:row_write({name})
        end
        ftable:ln()
        ftable:set_cell_prop(1, fort.ANY_COLUMN, fort.CPROP_ROW_TYPE,
                             fort.ROW_HEADER)
    end

    -- add data to table
    for row_index, row in ipairs(data) do
        for _, col_name in ipairs(options.column) do
            local value = row[col_name]
            if options.format then
                value = options.format(row_index, col_name, value)
            end
            if options.wrap then
                -- allow for penlight text wrap or other func
                value = table.concat(options.wrap(row_index, col_name, value),
                                     "\n")
            end
            value = value or "" -- show empty for nil (user can use format to change this)
            ftable:row_write({value})
        end
        ftable:ln()
        if type(row_separator) == "number" then
            if row_index % row_separator == 0 then
                ftable:add_separator()
            end
        elseif row_separator[row_index] then
            ftable:add_separator()
        end

    end

    if options.footer then
        if options.footer_separator == nil or options.footer_separator then
            ftable:add_separator()
        end
        local footer_column = options.footer_column or options.column
        for _, col_name in ipairs(footer_column) do
            local value = options.footer[col_name]
            if options.format then
                -- pass -1 for footer as special index
                value = options.format(-1, col_name, value)
            end
            if options.wrap then
                -- allow for penlight text wrap or other func
                value = table.concat(options.wrap(-1, col_name, value), "\n")
            end
            value = value or "" -- show empty for nil (user can use format to change this)
            ftable:row_write({value})
        end
        ftable:ln()
    end

    -- add table margins
    if options.margin then
        if options.margin.top then
            ftable:set_tbl_prop(fort.TPROP_TOP_MARGIN, options.margin.top)
        end
        if options.margin.left then
            ftable:set_tbl_prop(fort.TPROP_LEFT_MARGIN, options.margin.left)
        end
        if options.margin.bottom then
            ftable:set_tbl_prop(fort.TPROP_BOTTOM_MARGIN, options.margin.bottom)
        end
        if options.margin.right then
            ftable:set_tbl_prop(fort.TPROP_RIGHT_MARGIN, options.margin.right)
        end
    end

    --- set text alignment
    if options.align then
        for col_name, text_align in pairs(options.align) do
            assert(text_align_mapping[text_align],
                   "tabulate: invalid text align:" .. tostring(text_align))
            ftable:set_cell_prop(fort.ANY_ROW, column_index_map[col_name],
                                 fort.CPROP_TEXT_ALIGN,
                                 text_align_mapping[text_align])
        end
    end

    --- set footer alignment
    if options.footer_align then
        for col_name, text_align in pairs(options.footer_align) do
            assert(text_align_mapping[text_align],
                   "tabulate: invalid footer align:" .. tostring(text_align))
            ftable:set_cell_prop(-1, footer_index_map[col_name],
                                 fort.CPROP_TEXT_ALIGN,
                                 text_align_mapping[text_align])
        end
    end

    -- set generic padding
    local tbl_padding = options.padding or {}
    if tbl_padding.top ~= nil then
        ftable:set_cell_prop(fort.ANY_ROW, fort.ANY_COLUMN,
                             fort.CPROP_TOP_PADDING, tbl_padding.top)
    end
    if tbl_padding.left ~= nil then
        ftable:set_cell_prop(fort.ANY_ROW, fort.ANY_COLUMN,
                             fort.CPROP_LEFT_PADDING, tbl_padding.left)
    end
    if tbl_padding.bottom ~= nil then
        ftable:set_cell_prop(fort.ANY_ROW, fort.ANY_COLUMN,
                             fort.CPROP_BOTTOM_PADDING, tbl_padding.bottom)
    end
    if tbl_padding.right ~= nil then
        ftable:set_cell_prop(fort.ANY_ROW, fort.ANY_COLUMN,
                             fort.CPROP_RIGHT_PADDING, tbl_padding.right)
    end

    --- set column padding, after generic padding to override
    if options.col_padding then
        for col_name, padding in pairs(options.col_padding) do
            if padding.top ~= nil then
                ftable:set_cell_prop(fort.ANY_ROW, column_index_map[col_name],
                                     fort.CPROP_TOP_PADDING, padding.top)
            end
            if padding.left ~= nil then
                ftable:set_cell_prop(fort.ANY_ROW, column_index_map[col_name],
                                     fort.CPROP_LEFT_PADDING, padding.left)
            end
            if padding.bottom ~= nil then
                ftable:set_cell_prop(fort.ANY_ROW, column_index_map[col_name],
                                     fort.CPROP_BOTTOM_PADDING, padding.bottom)
            end
            if padding.right ~= nil then
                ftable:set_cell_prop(fort.ANY_ROW, column_index_map[col_name],
                                     fort.CPROP_RIGHT_PADDING, padding.right)
            end
        end
    end

    -- add cell spanning
    if options.cell_span then
        for row_index, cell_span in pairs(options.cell_span) do
            for col_name, span in pairs(cell_span) do
                -- only add header offset when positive indices
                if row_index > 0 then
                    row_index = row_index + header_row_offset
                else
                    row_index = row_index + footer_row_offset
                end
                ftable:set_cell_span(row_index, column_index_map[col_name], span)
            end
        end
    end

    --- add footer spanning
    if options.footer and options.footer_span then
        for col_name, span in pairs(options.footer_span) do
            -- will be the last index
            ftable:set_cell_span(-1, footer_index_map[col_name], span)
        end
    end

    if options.frame ~= nil then
        assert(border_style_mapping[options.frame],
               "tabulate: invalid border style")
        ftable:set_border_style(border_style_mapping[options.frame])
    end

    return tostring(ftable)
end

---convenience call to tabulate.tabulate
---@param data table<string, any>[]
---@param options tabulate.Options
---@return string
function tabulate:__call(data, options) return self.tabulate(data, options) end

setmetatable(tabulate, tabulate)

return tabulate
