# Changelog

## v0.2.0 (2021.12.21)

- [Added] `fort.new` and `fort.__call` aliases of `fort.create_table`
- [Added] `fort.copy` alias of `fort.copy_table`
- [Fixed] `fort.ftable` and `fort.border_style` udata types to ensure the user
  passes the correct type
- [Added] `fort` is now a class module which means the function can be accessed
  from ftable.

  Example `fort.printf(ftable, "test1|test2")` → `ftable:printf("test1|test2")`

        local fort = require "fort"
        local simple_table = fort()
        simple_table:print("test1|test2")
        print(simple_table:to_string())

- [Fixed] error code now properly checked in `fort.write_ln`/`fort.write`
