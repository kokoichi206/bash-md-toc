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
