# lua-fort

A lua wrapper around the [libfort](https://github.com/seleznevae/libfort)
library.

## Features

- No external libraries required
- Tiny implementation
  - Easy to integrate into an embedded lua environment
- Resizes cells to content of tables
- Cusomization of Appearance
  - Text colors
  - Border style
  - Background style
- Different Methods of filling in the formatted table
- UTF-8 support
  ([More details](https://github.com/nathanrpage97/lua-fort/blob/72b888f6dd3a05d61d99686c71b6f26984d7c58c/src/fort.h#L1047-L1054))

The `fort` module directly maps the API from c to lua with the `FT_*`/`ft_*`
prefixes.

## Differences from libfort

- No wchar support (Not needed for lua)
- `ft_printf`/`ft_printf_ln` aren't used directly.
  - lua's string.format method is used to do formatting
  - String splitting on column separator is done in lua
- all functions are UTF-8 compatible

## Roadmap

There are a few things that I would like to add with lua fort. This list is in
chronological order.

- [x] lua ≥ 5.1 support
- [x] CI testing across versions
- [x] Documentation site
- [x] UTF-8 support
- [x] Unit testing
- [x] Examples (from libfort)
- [x] First release on luarocks
- [ ] Detailed usage documentation
- [ ] Stronger unit testing
