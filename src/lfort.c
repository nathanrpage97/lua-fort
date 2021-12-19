#include "fort.h"

#include <lua.h>
#include <lauxlib.h>

#define CHECK_ARG_COUNT(L, arg_count)                                   \
    do                                                                  \
    {                                                                   \
        if (lua_gettop(L) != arg_count)                                 \
        {                                                               \
            return luaL_error(L, "Expected %d argument(s)", arg_count); \
        }                                                               \
    } while (0);

#define CHECK_ARG_IS(L, checker, arg_num, checker_str)                                 \
    do                                                                                 \
    {                                                                                  \
        if (!checker(L, arg_num))                                                      \
        {                                                                              \
            return luaL_error(L, "Expected %s for argument %d", checker_str, arg_num); \
        }                                                                              \
    } while (0);

#define CHECK_ARG_IS_NUMBER(L, arg_num)                                       \
    do                                                                        \
    {                                                                         \
        if (!lua_isnumber(L, arg_num))                                        \
        {                                                                     \
            return luaL_error(L, "Expected number for argument %d", arg_num); \
        }                                                                     \
    } while (0);

#define CHECK_ARG_IS_FTABLE(L, arg_num)                                       \
    do                                                                        \
    {                                                                         \
        if (!lua_isuserdata(L, arg_num))                                      \
        {                                                                     \
            return luaL_error(L, "Expected ftable for argument %d", arg_num); \
        }                                                                     \
    } while (0);

#define ERR_CHECK(func)                                    \
    do                                                     \
    {                                                      \
        int error_code = func;                             \
        if (error_code != 0)                               \
        {                                                  \
            return luaL_error(L, ft_strerror(error_code)); \
        }                                                  \
    } while (0);

static ft_table_t **get_fort_table(lua_State *L, int arg_num)
{
    if (!lua_isuserdata(L, arg_num))
    {
        return NULL;
    }
    return (ft_table_t **)lua_touserdata(L, arg_num);
}

static int lft_destroy_table(lua_State *L)
{
    ft_table_t **table = lua_touserdata(L, 1);
    if (table != NULL)
    {
        ft_destroy_table(*table);
    }
    return 0;
}

static void register_lua_table(lua_State *L, ft_table_t *table)
{
    ft_table_t **data = lua_newuserdata(L, sizeof(ft_table_t *));
    *data = table;

    // create gc method to cleanup table struct
    lua_newtable(L);
    lua_pushcfunction(L, lft_destroy_table);
    lua_setfield(L, -2, "__gc");
    lua_setmetatable(L, -2);
}

static int lft_create_table(lua_State *L)
{
    ft_table_t *table = ft_create_table();
    if (table == NULL)
    {
        return luaL_error(L, "Unable to create table");
    }
    register_lua_table(L, table);
    return 1;
}

static int lft_copy_table(lua_State *L)
{
    CHECK_ARG_COUNT(L, 1);
    CHECK_ARG_IS_FTABLE(L, 1);

    ft_table_t **table = lua_touserdata(L, 1);
    ft_table_t *new_table = ft_copy_table(*table);

    register_lua_table(L, new_table);
    return 1;
}

static int lft_ln(lua_State *L)
{
    CHECK_ARG_COUNT(L, 1);
    CHECK_ARG_IS_FTABLE(L, 1);
    ft_table_t **table = lua_touserdata(L, 1);
    ERR_CHECK(ft_ln(*table));
    return 0;
}

static int lft_cur_row(lua_State *L)
{
    CHECK_ARG_COUNT(L, 1);
    CHECK_ARG_IS_FTABLE(L, 1);
    ft_table_t **table = lua_touserdata(L, 1);

    int cur_row = ft_cur_row(*table);
    lua_pushnumber(L, cur_row);
    return 1;
}

static int lft_cur_col(lua_State *L)
{
    CHECK_ARG_COUNT(L, 1);
    CHECK_ARG_IS_FTABLE(L, 1);
    ft_table_t **table = lua_touserdata(L, 1);
    int cur_col = ft_cur_col(*table);
    lua_pushnumber(L, cur_col);
    return 1;
}

static int lft_set_cur_cell(lua_State *L)
{
    CHECK_ARG_COUNT(L, 3);
    CHECK_ARG_IS_FTABLE(L, 1);
    CHECK_ARG_IS_NUMBER(L, 2);
    CHECK_ARG_IS_NUMBER(L, 3);

    ft_table_t **table = lua_touserdata(L, 1);
    size_t row = luaL_checknumber(L, 2);
    size_t col = luaL_checknumber(L, 3);

    ft_set_cur_cell(*table, row, col);

    return 0;
}

static int lft_is_empty(lua_State *L)
{
    CHECK_ARG_COUNT(L, 1);
    CHECK_ARG_IS_FTABLE(L, 1);

    ft_table_t **table = lua_touserdata(L, 1);

    int is_empty = ft_is_empty(*table);
    lua_pushboolean(L, is_empty);
    return 1;
}

static int lft_row_count(lua_State *L)
{
    CHECK_ARG_COUNT(L, 1);
    CHECK_ARG_IS_FTABLE(L, 1);

    ft_table_t **table = lua_touserdata(L, 1);
    size_t row_count = ft_row_count(*table);

    lua_pushnumber(L, row_count);
    return 1;
}

static int lft_erase_range(lua_State *L)
{
    CHECK_ARG_COUNT(L, 5);
    CHECK_ARG_IS_FTABLE(L, 1);
    CHECK_ARG_IS_NUMBER(L, 2);
    CHECK_ARG_IS_NUMBER(L, 3);
    CHECK_ARG_IS_NUMBER(L, 4);
    CHECK_ARG_IS_NUMBER(L, 5);

    ft_table_t **table = lua_touserdata(L, 1);
    size_t top_left_row = luaL_checknumber(L, 2);
    size_t top_left_col = luaL_checknumber(L, 3);
    size_t bottom_right_row = luaL_checknumber(L, 4);
    size_t bottom_right_col = luaL_checknumber(L, 5);

    ERR_CHECK(ft_erase_range(*table, top_left_row, top_left_col, bottom_right_row, bottom_right_col));

    return 0;
}

static const char **generate_row_cells(lua_State *L, int arg_num)
{

    size_t cols = lua_rawlen(L, 2);
    const char **row_cells = malloc(cols * sizeof(char *));
    if (row_cells == NULL)
    {
        return NULL;
    }
    size_t cols_populated = 0;

    lua_pushnil(L);
    while (lua_next(L, arg_num) != 0)
    {
        // ensure we dont go over bounds
        if (cols_populated >= cols)
        {
            lua_pop(L, 1);
            break;
        }
        row_cells[cols_populated] = lua_tostring(L, -1);
        cols_populated += 1;
        lua_pop(L, 1);
    }
    return row_cells;
}

static int lft_row_write(lua_State *L)
{
    CHECK_ARG_COUNT(L, 2);
    CHECK_ARG_IS_FTABLE(L, 1);

    if (!lua_istable(L, 2))
    {
        return luaL_error(L, "Expected string[] for argument 2");
    }

    ft_table_t **table = lua_touserdata(L, 1);

    size_t cols = lua_rawlen(L, 2);
    const char **row_cells = generate_row_cells(L, 2);
    if (row_cells == NULL)
    {
        return luaL_error(L, "Unable to create row cells");
    }

    int error_code = ft_row_write(*table, cols, row_cells);
    free(row_cells);
    ERR_CHECK(error_code);
    return 0;
}

static int lft_row_write_ln(lua_State *L)
{
    CHECK_ARG_COUNT(L, 2);
    CHECK_ARG_IS_FTABLE(L, 1);

    if (!lua_istable(L, 2))
    {
        return luaL_error(L, "Expected string[] for argument 2");
    }

    ft_table_t **table = lua_touserdata(L, 1);

    size_t cols = lua_rawlen(L, 2);
    const char **row_cells = generate_row_cells(L, 2);
    if (row_cells == NULL)
    {
        return luaL_error(L, "Unable to create row cells");
    }

    int error_code = ft_row_write_ln(*table, cols, row_cells);
    free(row_cells);
    ERR_CHECK(error_code);
    return 0;
}

static int lft_add_separator(lua_State *L)
{
    CHECK_ARG_COUNT(L, 1);
    CHECK_ARG_IS_FTABLE(L, 1);

    ft_table_t **table = lua_touserdata(L, 1);

    ERR_CHECK(ft_add_separator(*table));
    return 0;
}

static int lft_to_string(lua_State *L)
{
    CHECK_ARG_COUNT(L, 1);
    CHECK_ARG_IS_FTABLE(L, 1);

    ft_table_t **table = lua_touserdata(L, 1);

    const char *table_string = ft_to_string(*table);
    lua_pushstring(L, table_string);
    return 1;
}

static int lft_set_default_border_style(lua_State *L)
{
    CHECK_ARG_COUNT(L, 1);
    CHECK_ARG_IS(L, lua_islightuserdata, 1, "border-style");

    const struct ft_border_style *style = lua_touserdata(L, 1);

    ERR_CHECK(ft_set_default_border_style(style));
    return 0;
}
static int lft_set_border_style(lua_State *L)
{
    CHECK_ARG_COUNT(L, 2);
    CHECK_ARG_IS_FTABLE(L, 1);
    CHECK_ARG_IS(L, lua_islightuserdata, 2, "border-style");

    ft_table_t **table = lua_touserdata(L, 1);
    const struct ft_border_style *style = lua_touserdata(L, 2);

    ERR_CHECK(ft_set_border_style(*table, style));
    return 0;
}

static int lft_set_default_cell_prop(lua_State *L)
{
    CHECK_ARG_COUNT(L, 2);
    CHECK_ARG_IS_NUMBER(L, 1);
    CHECK_ARG_IS_NUMBER(L, 2);

    uint32_t property = lua_tonumber(L, 1);
    int value = lua_tonumber(L, 2);

    ERR_CHECK(ft_set_default_cell_prop(property, value));
    return 0;
}
static int lft_set_cell_prop(lua_State *L)
{
    CHECK_ARG_COUNT(L, 5);
    CHECK_ARG_IS_FTABLE(L, 1);
    CHECK_ARG_IS_NUMBER(L, 2);
    CHECK_ARG_IS_NUMBER(L, 3);
    CHECK_ARG_IS_NUMBER(L, 4);
    CHECK_ARG_IS_NUMBER(L, 5);

    ft_table_t **table = lua_touserdata(L, 1);
    size_t row = lua_tonumber(L, 2);
    size_t col = lua_tonumber(L, 3);
    uint32_t property = lua_tonumber(L, 4);
    int value = lua_tonumber(L, 5);

    ERR_CHECK(ft_set_cell_prop(*table, row, col, property, value));
    return 0;
}

static int lft_set_default_tbl_prop(lua_State *L)
{
    CHECK_ARG_COUNT(L, 2);
    CHECK_ARG_IS_NUMBER(L, 1);
    CHECK_ARG_IS_NUMBER(L, 2);

    uint32_t property = lua_tonumber(L, 1);
    int value = lua_tonumber(L, 2);

    ERR_CHECK(ft_set_default_tbl_prop(property, value));
    return 0;
}
static int lft_set_tbl_prop(lua_State *L)
{
    CHECK_ARG_COUNT(L, 3);
    CHECK_ARG_IS_FTABLE(L, 1);
    CHECK_ARG_IS_NUMBER(L, 2);
    CHECK_ARG_IS_NUMBER(L, 3);

    ft_table_t **table = lua_touserdata(L, 1);
    uint32_t property = lua_tonumber(L, 2);
    int value = lua_tonumber(L, 3);

    ERR_CHECK(ft_set_tbl_prop(*table, property, value));
    return 0;
}
static int lft_set_cell_span(lua_State *L)
{
    CHECK_ARG_COUNT(L, 4);
    CHECK_ARG_IS_FTABLE(L, 1);
    CHECK_ARG_IS_NUMBER(L, 2);
    CHECK_ARG_IS_NUMBER(L, 3);
    CHECK_ARG_IS_NUMBER(L, 4);

    ft_table_t **table = lua_touserdata(L, 1);
    size_t row = lua_tonumber(L, 2);
    size_t col = lua_tonumber(L, 3);
    size_t hor_span = lua_tonumber(L, 4);

    ERR_CHECK(ft_set_cell_span(*table, row, col, hor_span));
    return 0;
}

static const struct luaL_Reg fort_functions[] = {
    {"create_table", lft_create_table},
    {"copy_table", lft_copy_table},
    {"ln", lft_ln},
    {"cur_row", lft_cur_row},
    {"cur_col", lft_cur_col},
    {"set_cur_cell", lft_set_cur_cell},
    {"is_empty", lft_is_empty},
    {"row_count", lft_row_count},
    {"erase_range", lft_erase_range},
    {"row_write", lft_row_write},
    {"row_write_ln", lft_row_write_ln},
    {"add_separator", lft_add_separator},
    {"to_string", lft_to_string},
    {"set_default_border_style", lft_set_default_border_style},
    {"set_border_style", lft_set_border_style},
    {"set_default_cell_prop", lft_set_default_cell_prop},
    {"set_cell_prop", lft_set_cell_prop},
    {"set_default_tbl_prop", lft_set_default_tbl_prop},
    {"set_tbl_prop", lft_set_tbl_prop},
    {"set_cell_span", lft_set_cell_span},
    {NULL, NULL},
};

int luaopen_cfort(lua_State *L)
{
    luaL_newlib(L, fort_functions);

    // styles
    lua_pushlightuserdata(L, (void *)FT_BASIC_STYLE);
    lua_setfield(L, -2, "BASIC_STYLE");
    lua_pushlightuserdata(L, (void *)FT_BASIC2_STYLE);
    lua_setfield(L, -2, "BASIC2_STYLE");
    lua_pushlightuserdata(L, (void *)FT_SIMPLE_STYLE);
    lua_setfield(L, -2, "SIMPLE_STYLE");
    lua_pushlightuserdata(L, (void *)FT_PLAIN_STYLE);
    lua_setfield(L, -2, "PLAIN_STYLE");
    lua_pushlightuserdata(L, (void *)FT_DOT_STYLE);
    lua_setfield(L, -2, "DOT_STYLE");
    lua_pushlightuserdata(L, (void *)FT_EMPTY_STYLE);
    lua_setfield(L, -2, "EMPTY_STYLE");
    lua_pushlightuserdata(L, (void *)FT_EMPTY2_STYLE);
    lua_setfield(L, -2, "EMPTY2_STYLE");
    lua_pushlightuserdata(L, (void *)FT_SOLID_STYLE);
    lua_setfield(L, -2, "SOLID_STYLE");
    lua_pushlightuserdata(L, (void *)FT_SOLID_ROUND_STYLE);
    lua_setfield(L, -2, "SOLID_ROUND_STYLE");
    lua_pushlightuserdata(L, (void *)FT_NICE_STYLE);
    lua_setfield(L, -2, "NICE_STYLE");
    lua_pushlightuserdata(L, (void *)FT_DOUBLE_STYLE);
    lua_setfield(L, -2, "DOUBLE_STYLE");
    lua_pushlightuserdata(L, (void *)FT_DOUBLE2_STYLE);
    lua_setfield(L, -2, "DOUBLE2_STYLE");
    lua_pushlightuserdata(L, (void *)FT_BOLD_STYLE);
    lua_setfield(L, -2, "BOLD_STYLE");
    lua_pushlightuserdata(L, (void *)FT_BOLD2_STYLE);
    lua_setfield(L, -2, "BOLD2_STYLE");
    lua_pushlightuserdata(L, (void *)FT_FRAME_STYLE);
    lua_setfield(L, -2, "FRAME_STYLE");

    // special macros
    lua_pushnumber(L, FT_ANY_COLUMN);
    lua_setfield(L, -2, "ANY_COLUMN");
    lua_pushnumber(L, FT_CUR_COLUMN);
    lua_setfield(L, -2, "CUR_COLUMN");
    lua_pushnumber(L, FT_ANY_ROW);
    lua_setfield(L, -2, "ANY_ROW");
    lua_pushnumber(L, FT_CUR_ROW);
    lua_setfield(L, -2, "CUR_ROW");

    // cell properties
    lua_pushnumber(L, FT_CPROP_MIN_WIDTH);
    lua_setfield(L, -2, "CPROP_MIN_WIDTH");
    lua_pushnumber(L, FT_CPROP_TEXT_ALIGN);
    lua_setfield(L, -2, "CPROP_TEXT_ALIGN");
    lua_pushnumber(L, FT_CPROP_TOP_PADDING);
    lua_setfield(L, -2, "CPROP_TOP_PADDING");
    lua_pushnumber(L, FT_CPROP_BOTTOM_PADDING);
    lua_setfield(L, -2, "CPROP_BOTTOM_PADDING");
    lua_pushnumber(L, FT_CPROP_LEFT_PADDING);
    lua_setfield(L, -2, "CPROP_LEFT_PADDING");
    lua_pushnumber(L, FT_CPROP_RIGHT_PADDING);
    lua_setfield(L, -2, "CPROP_RIGHT_PADDING");
    lua_pushnumber(L, FT_CPROP_EMPTY_STR_HEIGHT);
    lua_setfield(L, -2, "CPROP_EMPTY_STR_HEIGHT");
    lua_pushnumber(L, FT_CPROP_ROW_TYPE);
    lua_setfield(L, -2, "CPROP_ROW_TYPE");
    lua_pushnumber(L, FT_CPROP_CONT_FG_COLOR);
    lua_setfield(L, -2, "CPROP_CONT_FG_COLOR");
    lua_pushnumber(L, FT_CPROP_CELL_BG_COLOR);
    lua_setfield(L, -2, "CPROP_CELL_BG_COLOR");
    lua_pushnumber(L, FT_CPROP_CONT_BG_COLOR);
    lua_setfield(L, -2, "CPROP_CONT_BG_COLOR");
    lua_pushnumber(L, FT_CPROP_CELL_TEXT_STYLE);
    lua_setfield(L, -2, "CPROP_CELL_TEXT_STYLE");
    lua_pushnumber(L, FT_CPROP_CONT_TEXT_STYLE);
    lua_setfield(L, -2, "CPROP_CONT_TEXT_STYLE");

    // colors
    lua_pushnumber(L, FT_COLOR_DEFAULT);
    lua_setfield(L, -2, "COLOR_DEFAULT");
    lua_pushnumber(L, FT_COLOR_BLACK);
    lua_setfield(L, -2, "COLOR_BLACK");
    lua_pushnumber(L, FT_COLOR_RED);
    lua_setfield(L, -2, "COLOR_RED");
    lua_pushnumber(L, FT_COLOR_GREEN);
    lua_setfield(L, -2, "COLOR_GREEN");
    lua_pushnumber(L, FT_COLOR_YELLOW);
    lua_setfield(L, -2, "COLOR_YELLOW");
    lua_pushnumber(L, FT_COLOR_BLUE);
    lua_setfield(L, -2, "COLOR_BLUE");
    lua_pushnumber(L, FT_COLOR_MAGENTA);
    lua_setfield(L, -2, "COLOR_MAGENTA");
    lua_pushnumber(L, FT_COLOR_CYAN);
    lua_setfield(L, -2, "COLOR_CYAN");
    lua_pushnumber(L, FT_COLOR_LIGHT_GRAY);
    lua_setfield(L, -2, "COLOR_LIGHT_GRAY");
    lua_pushnumber(L, FT_COLOR_DARK_GRAY);
    lua_setfield(L, -2, "COLOR_DARK_GRAY");
    lua_pushnumber(L, FT_COLOR_LIGHT_RED);
    lua_setfield(L, -2, "COLOR_LIGHT_RED");
    lua_pushnumber(L, FT_COLOR_LIGHT_GREEN);
    lua_setfield(L, -2, "COLOR_LIGHT_GREEN");
    lua_pushnumber(L, FT_COLOR_LIGHT_YELLOW);
    lua_setfield(L, -2, "COLOR_LIGHT_YELLOW");
    lua_pushnumber(L, FT_COLOR_LIGHT_BLUE);
    lua_setfield(L, -2, "COLOR_LIGHT_BLUE");
    lua_pushnumber(L, FT_COLOR_LIGHT_MAGENTA);
    lua_setfield(L, -2, "COLOR_LIGHT_MAGENTA");
    lua_pushnumber(L, FT_COLOR_LIGHT_CYAN);
    lua_setfield(L, -2, "COLOR_LIGHT_CYAN");
    lua_pushnumber(L, FT_COLOR_LIGHT_WHYTE);
    lua_setfield(L, -2, "COLOR_LIGHT_WHYTE");

    // text style
    lua_pushnumber(L, FT_TSTYLE_DEFAULT);
    lua_setfield(L, -2, "TSTYLE_DEFAULT");
    lua_pushnumber(L, FT_TSTYLE_BOLD);
    lua_setfield(L, -2, "TSTYLE_BOLD");
    lua_pushnumber(L, FT_TSTYLE_DIM);
    lua_setfield(L, -2, "TSTYLE_DIM");
    lua_pushnumber(L, FT_TSTYLE_ITALIC);
    lua_setfield(L, -2, "TSTYLE_ITALIC");
    lua_pushnumber(L, FT_TSTYLE_UNDERLINED);
    lua_setfield(L, -2, "TSTYLE_UNDERLINED");
    lua_pushnumber(L, FT_TSTYLE_BLINK);
    lua_setfield(L, -2, "TSTYLE_BLINK");
    lua_pushnumber(L, FT_TSTYLE_INVERTED);
    lua_setfield(L, -2, "TSTYLE_INVERTED");
    lua_pushnumber(L, FT_TSTYLE_HIDDEN);
    lua_setfield(L, -2, "TSTYLE_HIDDEN");

    // text alignment
    lua_pushnumber(L, FT_ALIGNED_LEFT);
    lua_setfield(L, -2, "ALIGNED_LEFT");
    lua_pushnumber(L, FT_ALIGNED_CENTER);
    lua_setfield(L, -2, "ALIGNED_CENTER");
    lua_pushnumber(L, FT_ALIGNED_RIGHT);
    lua_setfield(L, -2, "ALIGNED_RIGHT");

    // row type
    lua_pushnumber(L, FT_ROW_COMMON);
    lua_setfield(L, -2, "ROW_COMMON");
    lua_pushnumber(L, FT_ROW_HEADER);
    lua_setfield(L, -2, "ROW_HEADER");

    // text prop
    lua_pushnumber(L, FT_TPROP_LEFT_MARGIN);
    lua_setfield(L, -2, "TPROP_LEFT_MARGIN");
    lua_pushnumber(L, FT_TPROP_TOP_MARGIN);
    lua_setfield(L, -2, "TPROP_TOP_MARGIN");
    lua_pushnumber(L, FT_TPROP_RIGHT_MARGIN);
    lua_setfield(L, -2, "TPROP_RIGHT_MARGIN");
    lua_pushnumber(L, FT_TPROP_BOTTOM_MARGIN);
    lua_setfield(L, -2, "TPROP_BOTTOM_MARGIN");
    lua_pushnumber(L, FT_TPROP_ADDING_STRATEGY);
    lua_setfield(L, -2, "TPROP_ADDING_STRATEGY");

    // adding strategy
    lua_pushnumber(L, FT_STRATEGY_REPLACE);
    lua_setfield(L, -2, "STRATEGY_REPLACE");
    lua_pushnumber(L, FT_STRATEGY_INSERT);
    lua_setfield(L, -2, "STRATEGY_INSERT");

    return 1;
}