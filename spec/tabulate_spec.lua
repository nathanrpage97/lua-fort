local tabulate = require "tabulate"

describe("data types", function()
    it("list list", function()
        local value = tabulate({
            {"cool", "testing"}, {"more", "third", "fourth"}
        })
        assert.equals(tostring(value), [[
+------+---------+--------+
| 1    | 2       | 3      |
+------+---------+--------+
| cool | testing |        |
| more | third   | fourth |
+------+---------+--------+
]])
    end)
    it("dict list", function()
        -- column has to be set to be deterministic
        local value = tabulate({
            {a = "cool", b = "running"}, {a = "534", b = "sdfsdf"},
            {a = "534", b = "sdfsdf", c = "testing"}
        }, {column = {"a", "b", 'c'}})
        assert.equals(tostring(value), [[
+------+---------+---------+
| a    | b       | c       |
+------+---------+---------+
| cool | running |         |
| 534  | sdfsdf  |         |
| 534  | sdfsdf  | testing |
+------+---------+---------+
]])
    end)
    it("list dict", function()
        -- column has to be set to be deterministic
        local value = tabulate({
            a = {1, 2, 3, 4, 5, 6, 8, "csdfs", "23"},
            c = {"wow this is a longer text", 2, 4, "sdf", ""},
            d = {"this is a good test", 2, 3434}
        }, {column = {"a", "d", "c"}})
        assert.equals(tostring(value), [[
+-------+---------------------+---------------------------+
| a     | d                   | c                         |
+-------+---------------------+---------------------------+
| 1     | this is a good test | wow this is a longer text |
| 2     | 2                   | 2                         |
| 3     | 3434                | 4                         |
| 4     |                     | sdf                       |
| 5     |                     |                           |
| 6     |                     |                           |
| 8     |                     |                           |
| csdfs |                     |                           |
| 23    |                     |                           |
+-------+---------------------+---------------------------+
]])
    end)
end)

describe("frame", function()

    local data = {cool = {1, 2, 3, 4}, testing = {"text", "2", 5, 5.2}}
    it("basic", function()
        local value = tabulate(data,
                               {column = {"cool", "testing"}, frame = "basic"})
        assert.equals(tostring(value), [[
+------+---------+
| cool | testing |
+------+---------+
| 1    | text    |
| 2    | 2       |
| 3    | 5       |
| 4    | 5.2     |
+------+---------+
]])
    end)

    it("bold", function()
        local value = tabulate(data,
                               {column = {"cool", "testing"}, frame = "bold"})
        assert.equals(tostring(value), [[
┏━━━━━━┳━━━━━━━━━┓
┃ cool ┃ testing ┃
┣━━━━━━╋━━━━━━━━━┫
┃ 1    ┃ text    ┃
┃ 2    ┃ 2       ┃
┃ 3    ┃ 5       ┃
┃ 4    ┃ 5.2     ┃
┗━━━━━━┻━━━━━━━━━┛
]])
    end)
    it("solid_round", function()
        local value = tabulate(data, {
            column = {"cool", "testing"},
            frame = "solid_round"
        })
        assert.equals(tostring(value), [[
╭──────┬─────────╮
│ cool │ testing │
├──────┼─────────┤
│ 1    │ text    │
│ 2    │ 2       │
│ 3    │ 5       │
│ 4    │ 5.2     │
╰──────┴─────────╯
]])
    end)
end)

describe("header", function()

    local data_ll = {{"2", "4", "5"}, {"2", 343, 234.32}}
    local data_dl = {{a = "2", b = "4", "5"}, {a = "2", b = 343, 234.32}}
    local data_ld = {a = {"2", "2"}, b = {"4", 343}, c = {"5", 234.32}}
    it("list-list", function()
        local value = tabulate(data_ll, {
            column = {1, 2, 3},
            header = {[1] = "first", [2] = "second", [3] = "third"}
        })
        assert.equals(tostring(value), [[
+-------+--------+--------+
| first | second | third  |
+-------+--------+--------+
| 2     | 4      | 5      |
| 2     | 343    | 234.32 |
+-------+--------+--------+
]])
    end)
    it("dict-list", function()
        local value = tabulate(data_dl, {
            column = {"a", "b", 1},
            header = {a = "first", b = "second", [1] = "third"}
        })
        assert.equals(tostring(value), [[
+-------+--------+--------+
| first | second | third  |
+-------+--------+--------+
| 2     | 4      | 5      |
| 2     | 343    | 234.32 |
+-------+--------+--------+
]])
    end)
    it("list-dict", function()
        local value = tabulate(data_ld, {
            column = {"a", "b", "c"},
            header = {a = "first", b = "second", c = "third"}
        })
        assert.equals(tostring(value), [[
+-------+--------+--------+
| first | second | third  |
+-------+--------+--------+
| 2     | 4      | 5      |
| 2     | 343    | 234.32 |
+-------+--------+--------+
]])
    end)
end)

describe("align", function()

    local data_dl = {
        {a = "2", b = "4", c = "5"}, {a = "2", b = 343, c = 234.32}
    }
    it("left", function()
        local value = tabulate(data_dl, {
            column = {"a", "b", "c"},
            header = {a = "first", b = "second", c = "third"},
            align = {a = "left", b = "left"}
        })
        assert.equals(tostring(value), [[
+-------+--------+--------+
| first | second | third  |
+-------+--------+--------+
| 2     | 4      | 5      |
| 2     | 343    | 234.32 |
+-------+--------+--------+
]])
    end)
    it("center", function()
        local value = tabulate(data_dl, {
            column = {"a", "b", "c"},
            header = {a = "first", b = "second", c = "third"},
            align = {a = "center", b = "center"}
        })
        assert.equals(tostring(value), [[
+-------+--------+--------+
| first | second | third  |
+-------+--------+--------+
|   2   |   4    | 5      |
|   2   |  343   | 234.32 |
+-------+--------+--------+
]])
    end)
    it("right", function()
        local value = tabulate(data_dl, {
            column = {"a", "b", "c"},
            header = {a = "first", b = "second", c = "third"},
            align = {a = "right", b = "right"}
        })
        assert.equals(tostring(value), [[
+-------+--------+--------+
| first | second | third  |
+-------+--------+--------+
|     2 |      4 | 5      |
|     2 |    343 | 234.32 |
+-------+--------+--------+
]])
    end)
end)
