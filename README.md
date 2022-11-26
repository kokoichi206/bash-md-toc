# md-toc-bash

Generate toc (table of contents) using bash.

## Usage

Just run [`md-toc.sh` script](./md-toc.sh).

```sh
$ bash md-toc.sh <file_name>
* [h1-title](#h1-title)
  * [h2-title-1](#h2-title-1)
    * [What is a space?](#what-is-a-space?)

# You can change the indent size.
$ bash md-toc.sh -s 4 <file_name>
* [h1-title](#h1-title)
    * [h2-title-1](#h2-title-1)
        * [What is a space?](#what-is-a-space?)
# This also works.
$ bash md-toc.sh <file_name> -s 4

# You can set min(max) headline # of outputs.
$ bash md-toc.sh -min 2 <file_name>
* [h2-title-1](#h2-title-1)
  * [What is a space?](#what-is-a-space?)

# Detailed usage.
$ bash md-toc.sh -h
```

## License

This repository is under [MIT license](./LICENSE).
