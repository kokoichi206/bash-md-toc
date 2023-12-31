% MD-TOC(1)
% Takahiro Tominaga
% December 2023

# NAME

md-toc – make table of contents (TOC) for a markdown file.

# SYNOPSIS

**md-toc** [OPTIONS] MARKDOWN_FILE_PATH

# DESCRIPTION

**md-toc** is a CLI command that generates a table of contents (TOC) for a Markdown file.<br>
It reads a specified Markdown file and extracts headings to create a TOC, with options to adjust<br>
indentation size and sprcify minimum and maximum heading levels.

**-h**, **--help**
:   show help message.

**-s**, **--indent-size SIZE**
:   change indent size (indent using spaces).

**-min LEVEL**, **--minimum LEVEL**
:  set the minimum heading level to include in the table of contents.

**-max LEVEL**, **--maximum LEVEL**
:  set the maximum heading level to include in the table of contents.

## Examples

**Generate a table of contents (TOC) for a Markdown file.**

    $ bash md-toc.sh <file_name>
      * [h1-title](#h1-title)
        * [h2-title-1](#h2-title-1)
          * [What is a space?](#what-is-a-space?)
    $ bash md-toc.sh --min 2 <file_name>
      * [h2-title-1](#h2-title-1)
        * [What is a space?](#what-is-a-space?)

## Exit status:

**0**
:   if OK,

**1**
:   if minor problems (e.g., parse error or no file was passed),

# BUGS

See GitHub Issues: https://github.com/kokoichi206/md-toc-bash/issues

# LICENSE

md-toc is licensed under the terms of the MIT license.
