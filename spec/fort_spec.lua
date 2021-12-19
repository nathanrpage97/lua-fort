local fort = require "fort"

describe("test simple table", function()

    it("should create the table", function()
        local simple_table = fort.create_table()
        fort.printf(simple_table, "hello|test")
        print(fort.to_string(simple_table))
    end)

end)
