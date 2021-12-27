local fort = require "fort"

describe("basic table data injection", function()

    it("row_write", function()
        local simple_table = fort.new()
        fort.row_write(simple_table, {"hello", "test"})
        fort.row_write(simple_table, {"hello", "test"})

        print(simple_table)
        assert.equals(fort.cur_row(simple_table), 1)
        assert.equals(fort.cur_col(simple_table), 5)
    end)

    it("row_write with ln", function()
        local simple_table = fort.new()
        fort.row_write(simple_table, {"hello", "test"})
        fort.ln(simple_table)
        fort.row_write(simple_table, {"hello", "test"})
        fort.ln(simple_table)

        print(simple_table)
        assert.equals(fort.cur_row(simple_table), 3)
        assert.equals(fort.cur_col(simple_table), 1)
    end)

    it("row_write_ln", function()
        local simple_table = fort.new()
        fort.row_write_ln(simple_table, {"hello", "test"})
        fort.row_write_ln(simple_table, {"hello", "test"})

        print(simple_table)
        assert.equals(fort.cur_row(simple_table), 3)
        assert.equals(fort.cur_col(simple_table), 1)
    end)

    it("printf", function()
        local simple_table = fort.new()
        fort.printf(simple_table, "hello|test")
        fort.printf(simple_table, "hello|test")

        print(simple_table)
        assert.equals(fort.cur_row(simple_table), 1)
        assert.equals(fort.cur_col(simple_table), 5)
    end)

    it("printf_ln", function()
        local simple_table = fort.new()
        fort.printf_ln(simple_table, "hello|test")
        fort.printf_ln(simple_table, "hello|test")

        print(simple_table)
        assert.equals(fort.cur_row(simple_table), 3)
        assert.equals(fort.cur_col(simple_table), 1)
    end)

    it("printf with formatting", function()
        local simple_table = fort.new()
        fort.printf(simple_table, "hello %d|test %d", 0, 1)
        fort.printf(simple_table, "hello %d|test %d", 2, 3)

        print(simple_table)
        assert.equals(fort.cur_row(simple_table), 1)
        assert.equals(fort.cur_col(simple_table), 5)
    end)

    it("print", function()
        local simple_table = fort.new()
        fort.print(simple_table, "hello|test")
        fort.print(simple_table, "hello|test")

        print(simple_table)
        assert.equals(fort.cur_row(simple_table), 1)
        assert.equals(fort.cur_col(simple_table), 5)

    end)

    it("print_ln", function()
        local simple_table = fort.new()
        fort.print_ln(simple_table, "hello|test")
        fort.print_ln(simple_table, "hello|test")

        print(simple_table)
        assert.equals(fort.cur_row(simple_table), 3)
        assert.equals(fort.cur_col(simple_table), 1)
    end)

    it("table_write", function()
        local simple_table = fort.new()
        fort.table_write(simple_table, {{"hello", "test"}, {"hello", "test"}})

        print(simple_table)
        assert.equals(fort.cur_row(simple_table), 2)
        assert.equals(fort.cur_col(simple_table), 3)
    end)

    it("table_write_ln", function()
        local simple_table = fort.new()
        fort.table_write_ln(simple_table, {{"hello", "test"}, {"hello", "test"}})

        print(simple_table)
        assert.equals(fort.cur_row(simple_table), 3)
        assert.equals(fort.cur_col(simple_table), 1)
    end)

    it("print with # separator", function()
        local simple_table = fort.new()
        fort.print(simple_table, "hello#test", "#")
        fort.print(simple_table, "hello#test", "#")

        print(simple_table)
        assert.equals(fort.cur_row(simple_table), 1)
        assert.equals(fort.cur_col(simple_table), 5)
    end)

    it("print_ln with # separator", function()
        local simple_table = fort.new()
        fort.print_ln(simple_table, "hello#test", "#")
        fort.print_ln(simple_table, "hello#test", "#")

        print(simple_table)
        assert.equals(fort.cur_row(simple_table), 3)
        assert.equals(fort.cur_col(simple_table), 1)
    end)

    it("print with @@ separator", function()
        local simple_table = fort.new()
        fort.print(simple_table, "hello@@test", "@@")
        fort.print(simple_table, "hello@@test", "@@")

        print(simple_table)
        assert.equals(fort.cur_row(simple_table), 1)
        assert.equals(fort.cur_col(simple_table), 5)
    end)

    it("print_ln with @@ separator", function()
        local simple_table = fort.new()
        fort.print_ln(simple_table, "hello@@test", "@@")
        fort.print_ln(simple_table, "hello@@test", "@@")

        print(simple_table)
        assert.equals(fort.cur_row(simple_table), 3)
        assert.equals(fort.cur_col(simple_table), 1)
    end)
end)

describe("advanced table data injection", function()
    it("unaligned column table write", function()
        local adv_table = fort.new()
        fort.print_ln(adv_table, "0|1")
        fort.print(adv_table, "2|3")
        fort.table_write(adv_table, {{"4", "5"}, {"6", "7"}})
        assert.equals(fort.cur_row(adv_table), 3)
        assert.equals(fort.cur_col(adv_table), 3)
        assert.equals(tostring(adv_table), [[
+---+---+---+---+
| 0 | 1 |   |   |
| 2 | 3 | 4 | 5 |
| 6 | 7 |   |   |
+---+---+---+---+
]])
    end)
    it("unaligned column table write with align", function()
        local adv_table = fort.new()
        fort.print_ln(adv_table, "0|1")
        fort.print(adv_table, "2|3")
        fort.table_write(adv_table, {{"4", "5"}, {"6", "7"}}, true)
        assert.equals(tostring(adv_table), [[
+---+---+---+---+
| 0 | 1 |   |   |
| 2 | 3 | 4 | 5 |
|   |   | 6 | 7 |
+---+---+---+---+
]])
        assert.equals(fort.cur_row(adv_table), 3)
        assert.equals(fort.cur_col(adv_table), 5)
    end)
end)

describe("table erasing", function()
    it("erase_range cell", function()
        local simple_table = fort.new()
        fort.row_write_ln(simple_table, {"hello", "test"})
        fort.row_write_ln(simple_table, {"hello", "test"})
        fort.erase_range(simple_table, 1, 1, 1, 1)
        print(simple_table)
        assert.equals(fort.row_count(simple_table), 2)
    end)

    it("erase_range row", function()
        local simple_table = fort.new()
        fort.row_write_ln(simple_table, {"hello", "test"})
        fort.row_write_ln(simple_table, {"hello", "test"})
        fort.erase_range(simple_table, 1, 1, 1, 2)
        print(simple_table)
        assert.equals(fort.row_count(simple_table), 1)
    end)

    it("erase_range all", function()
        local simple_table = fort.new()
        fort.row_write_ln(simple_table, {"hello", "test"})
        fort.row_write_ln(simple_table, {"hello", "test"})
        fort.erase_range(simple_table, 1, 1, 2, 2)
        print(simple_table)
        assert.equals(fort.row_count(simple_table), 0)
        assert.is_true(fort.is_empty(simple_table))
    end)
end)

