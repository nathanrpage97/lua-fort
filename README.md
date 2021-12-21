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
- UTF-8 support\*
  - Handles all utf8 characters as 1-width for simplicity

The `fort` module directly maps the API from c to lua with the `FT_*`/`ft_*`
prefixes.

## Differences from libfort

- No UTF-8 support (on the roadmap)
- No wchar support (Not needed for lua)
- `ft_printf`/`ft_printf_ln` aren't used directly.
  - lua's string.format method is used to do formatting
  - String splitting on column separator is done in lua

## Roadmap

There are a few things that I would like to add with lua fort. This list is in
chronological order.

- [x] lua ≥ 5.1 support
- [x] CI testing across versions
- [x] Documentation site
- [x] UTF-8 support
- [x] Unit testing
- [x] Detailed Examples (from libfort)
- [ ] First release on luarocks
- [ ] More detailed usage documentation
- [ ] Add custom border style
