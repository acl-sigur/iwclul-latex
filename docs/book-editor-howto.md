# HOWTO: use ACLPUB with easy chair for external SIG workshop

This is a practical HOWTO for the **Editor(s)** who will send the **book** to
ACL for publication. If you are an author of an article, please see the
[Call for
Papers](https://github.com/acl-sigur/iwclul-latex/blob/master/README.md)
instead.

ACLPUB is a perl+make thing for making ACL publications, it is integrated with
START softconf which SIGUR doesn't use. And the information on how to use is
quite hard to find from the net (2016–2021). Here's a list of references I used:

* https://github.com/acl-org/ACLPUB
* https://github.com/acl-org/acl-pub
  * https://github.com/naacl-org/aclpub
* http://naacl.org/naacl-pubs/aclpub-howto-2010.html
* http://wwwusers.di.uniroma1.it/~faralli/acl2013/publication/howto/aclpub/ACLPUB-0.htm
* https://github.com/acl-org/acl-pub/blob/gh-pages/002.book.md

## How to ACLPUB IWCLULs

This is kind of a check-list based on IWCLULs 2017 and 2018 and 2019.

1. ask your co-organisers to start writing pre-face, earlier is better.
1. before CfP, notify ACL publication person (see the footer of
   http://aclanthology.info)
1. Send a message to ACL treasurer to ask for ISBN (this is important for some
   university funders)
1. clone ACLPUB, iwclul-latex, and download paper pdfs (in easychair you can
   fetch one zip file)
   1. when you download camera-readies once, they should be final; late changes
   are not that easy to re-integrate
   1. the file names must be `pdf/IWCLUL_paper_XXX.pdf` sometimes works with
   easychairs and other times not...
1. `export ACLPUB=` wherever its cloned (2021 it is in `ACLPUB/` but it seems to
   change every f year)
   1. also edit the Makefile to contain this `ACLPUB=fgrfrgae`
1. now in proceedings, `make perl-modules` (i.e. follow ACLPUB-0 instructions
   starting from "Get Software" onwards).
    1. Text-PDF may not be in your distro, when manually installing, see:
      https://www.nntp.perl.org/group/perl.perl5.porters/2012/12/msg196450.html.
1. Convert easychair to ACLPUB is here: https://github.com/acl-org/easy2acl
  1. Because the official easy2acl does not do much (2021), use the older
    version as well, otherwise you are missing db, and all the tex files and
    lots of stuff: https://github.com/nblomqvist/easy2acl
    1. Install PyPDF2 and python module `unicode_tex`. May need pip
  1. Note that for ACL's easy2acl you need dummy files `pdf/IWCLUL-2021.pdf`
    and `pdf/IWCLUL-2021_frontmatter.pdf` for the other easy2acl you must remove
    them
1. When following easy2acl, there are some potential copy-paste errors
    1. I did `s/\. /\t/` here and `awk '{print $1, $3, $2, $4;}'` (pre-2020)
1. Check that latex codes for characters are correct. This is in files like `db`
1. `make draft` and see `book.pdf`.
    1. Check stuff and fix (names, alignments, margins, focus...)
    1. Don't mind that at this point in time, the order, the schedule and all the first few title pages are wrong
1. `make get-order` and `vim order`
    1. This is just a lot of manual work, self-explanatory
1. `make draft` and see `book.pdf` and check again
1. `make shipout` and check `book.pdf`, there is a number of things wrong that
   are related to ACLPUB is setup for conference-workshops
    1. just `vim *.tex`, chances are all of them could use some changes. Ensure
    years, workshop names, dates and places, everything that changes every
    workshop. This is in the ACLPUB howtos too
    1. `preface.tex` can be filled with preface that is already ready!
1. `make shipout` and check `book.pdf`, and  verify everything!
1. `vim meta` to edit some metadata.
    1. We need the WXX-YY%02d code here
1. `make cdrom`
    1. this is actually acl anthology site in HTML format, check it out using a
       WWW browser software (click all the links)
1. `make advertisement`, this is a schedule, for conference website.
1. if someone sends in late camera-ready, replace it in pdf/ **and** final/, if
   number of pages are different, you have to change page numbers everywhere
   (e.g. `db` file... that maybe regenerates `toc.tex`, `programme.tex`, not to
   mention `cdrom`).
1. Try printing the whole lot in grayscale or bw
1. `make all` and you get a `proceedings.tgz`, upload it to internet and send
   link to ACL publication person
   1. For `make all` you must have a ../proceedings as a directory not as a
      symlink, switch that around for the ACL SIGUR github later
1. There is a final back-and-forth of finalising the public version here in
   cooperation with ACL Anthology maintainer, so triple check everything before
   sending to minimise the work
1. After the publication is live, `rm proceedings-2018 && mv proceedings
   proceedings-2018`, then selectively git add things, e.g. `git add db
   accepted programme *.tex cdrom/*.html`?

Note, the Makefile of ACLPUB has a macro that prevents remaking when timestamps
don't match, this is helpful:

```bash
function aclremakediff() {
    mv $1{,~}
    make $1
    diff $1{~,}
}
```


