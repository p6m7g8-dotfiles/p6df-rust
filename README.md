# P6's POSIX.2: p6df-rust

## Table of Contents

- [Badges](#badges)
- [Summary](#summary)
- [Contributing](#contributing)
- [Code of Conduct](#code-of-conduct)
- [Usage](#usage)
  - [Aliases](#aliases)
  - [Functions](#functions)
- [Hierarchy](#hierarchy)
- [Author](#author)

## Badges

[![License](https://img.shields.io/badge/License-Apache%202.0-yellowgreen.svg)](https://opensource.org/licenses/Apache-2.0)

## Summary

TODO: Add a short summary of this module.

## Contributing

- [How to Contribute](<https://github.com/p6m7g8-dotfiles/.github/blob/main/CONTRIBUTING.md>)

## Code of Conduct

- [Code of Conduct](<https://github.com/p6m7g8-dotfiles/.github/blob/main/CODE_OF_CONDUCT.md>)

## Usage

### Aliases

- `ca` -> `cargo`

### Functions

#### p6df-rust

##### p6df-rust/init.zsh

- `p6df::modules::rust::aliases::init(_module, _dir)`
  - Args:
    - _module
    - _dir
- `p6df::modules::rust::deps()`
- `p6df::modules::rust::env::init(_module, _dir)`
  - Args:
    - _module
    - _dir
- `p6df::modules::rust::external::brews()`
- `p6df::modules::rust::langmgr::init()`
- `p6df::modules::rust::langs()`
- `p6df::modules::rust::vscodes()`
- `p6df::modules::rust::vscodes::config()`
- `str str = p6df::modules::rust::prompt::lang()`
- `words rust = p6df::modules::rust::prompt::env()`

#### p6df-rust/lib

##### p6df-rust/lib/rustup.sh

- `p6df::modules::rust::rustup::inline()`

## Hierarchy

```text
.
├── init.zsh
├── lib
│   └── rustup.sh
└── README.md

2 directories, 3 files
```

## Author

Philip M. Gollucci <pgollucci@p6m7g8.com>
