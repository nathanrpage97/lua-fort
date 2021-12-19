# lua-fort

A lua wrapper around the [libfort](https://github.com/seleznevae/libfort) library.

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

The `fort` module directly maps the API from c to lua with the `FT_*`/`ft_*` prefixes.

## Differences from libfort

- No UTF-8 support (on the roadmap)
- No wchar support (Not needed for lua)
- `ft_printf`/`ft_printf_ln` aren't used directly.
  - lua's string.format method is used to do formatting
  - String splitting on column separator is done in lua

## Roadmap

There are a few things that I would like to add with lua fort. This list is in chronological order.

- [x] lua ≥ 5.1 support
- [x] CI testing across versions
- [ ] Unit testing
- [ ] More detailed usage documentation
  - Detailed Examples
  - References to the libfort wiki
- [ ] Documentation site
- [ ] First release on luarocks
- [ ] UTF-8 support
- [ ] Complimentary `ftable` class module. The API will differ from the `fort` module to make it nicer to use from lua.
