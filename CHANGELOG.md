# Changelog

## v1.1.0 (2023.12.24)

- [Added] Many fort commands now return the fort object. This allows for
  chaining operations.

## v1.0.0 (2022.1.8)

- [Fix] ftable metatable now links to fort instead of cfort module.
- [Added] negative indices for rows and columns
  - `fort.set_cur_cell`
  - `fort.erase_range`
  - `fort.set_cell_prop`
  - `fort.set_cell_span`
- [Fix] splitting of rows follows libfort methodology
  - "" -> {""}
  - "|" -> {"",""}

## v0.3.0 (2021.12.26)

This should be the last minor release before v1 stable is released.

- [BREAKING] `row` and `col` arguments are now 1 indexed to follow lua
  convention. The following functions are affected:
  - `fort.cur_row`
  - `fort.cur_col`
  - `fort.set_cur_cell`
  - `fort.erase_range`
  - `fort.set_cell_prop`
  - `fort.set_cell_span`
- [Updated] libfort updated 0.4.2 → 0.5.0
- [Added] `fort.col_count` (new in libfort 0.5.0)
- [Changed] in lua ≥ 5.3 returns integer values instead of floats. Input still
  accepting of floats
- [Added] `ftable` implements the `__tostring()` metamethod to return formatted
  table string. `print(ftable:to_string())` → `print(ftable)`
- [Fixed] `fort.copy_table` now works correctly with utf8 tables
- [Added] `fort.__call` alias of `fort.create_table`

## v0.2.0 (2021.12.21)

- [Added] `fort.new` and `fort.__call` aliases of `fort.create_table`
- [Added] `fort.copy` alias of `fort.copy_table`
- [Fixed] `fort.ftable` and `fort.border_style` udata types to ensure the user
  passes the correct type
- [Added] `fort` is now a class module which means the function can be accessed
  from ftable

  Example `fort.printf(ftable, "test1|test2") == ftable:printf("test1|test2")`

        local fort = require "fort"
        local simple_table = fort()
        simple_table:print("test1|test2")
        print(simple_table:to_string())

- [Fixed] error code now properly checked in `fort.write_ln`/`fort.write`
