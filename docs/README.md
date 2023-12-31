convert markdown file to roff format using [pandoc](https://pandoc.org/).

``` sh
pandoc md-toc.1.md -s -t man > md-toc.1
```

archive (gzip format) and move it to the man directory

``` sh
gzip -f md-toc.1
# mv md-toc.1.gz man
mv md-toc.1.gz /usr/share/man/man1
```

check the path of the man page

``` sh
cat /etc/manpath.config
# MANDATORY_MANPATH ...
```

place the man pages in the path

``` sh
# man page (default)
pandoc md-toc.1.md -s -t man > md-toc.1
gzip -f md-toc.1
mv md-toc.1.gz man

# man page for ja
pandoc md-toc.1.ja.md -s -t man > md-toc.1
gzip -f md-toc.1
mv md-toc.1.gz man/ja
```

``` sh
LANG=ja_JP.utf8 man md-toc
```
