# Thesis
the repository of my PhD thesis, using the LTH thesis template

## File Structure

### File Tree

```
root/
├── papers/
│   ├── not-thesis/
│   │   ├── cdc19.pdf
│   │   ├── ifac22-wip.pdf
│   │   ├── ifac23.pdf
│   │   ├── iotfog19.pdf
│   │   ├── iotfog20.pdf
│   │   └── lites21.pdf
│   └── thesis/
│       ├── ecrts21.pdf
│       ├── lcss22.pdf
│       ├── rtas22a.pdf
│       ├── rtas22b.pdf
│       └── emsoft23.pdf
├── README.md
└── thesis/
    ├── kappa/
    │   ├── figs/
    │   ├── kappa.bib
    │   ├── kappa.tex
    │   └── sec/
    │       ├── background.tex
    │       ├── contribution.tex
    │       └── introduction.tex
    ├── Makefile
    ├── papers/
    │   ├── ecrts21/
    │   │   ├── ecrts21.bib
    │   │   ├── ecrts21.tex
    │   │   ├── figs/
    │   │   ├── og/
    │   │   ├── preamble/
    │   │   └── sec/
    │   ├── lcss22/
    │   │   ├── lcss22.bib
    │   │   ├── lcss22.tex
    │   │   ├── figs/
    │   │   ├── og/
    │   │   ├── preamble/
    │   │   └── sec/
    │   ├── rtas22a/
    │   │   ├── rtas22a.bib
    │   │   ├── rtas22a.tex
    │   │   ├── figs/
    │   │   ├── og/
    │   │   ├── preamble/
    │   │   └── sec/
    │   ├── rtas22b/
    │   │   ├── rtas22b.bib
    │   │   ├── rtas22b.tex
    │   │   ├── figs/
    │   │   ├── og/
    │   │   ├── preamble/
    │   │   └── sec/
    │   └── emsoft23/
    │       ├── emsoft23.bib
    │       ├── emsoft23.tex
    │       ├── figs/
    │       ├── og/
    │       ├── preamble/
    │       └── sec/
    ├── preface/
    │   ├── abstract.tex
    │   ├── acknoledgement.tex
    │   ├── cmds.tex
    │   ├── nomenclature.tex
    │   ├── pkgs.tex
    │   ├── preface.tex
    │   ├── thmfmt.tex
    │   ├── tikzfmt.tex
    │   └── titlepages.tex
    ├── style/
    │   ├── LTHthesis.cls
    │   ├── LUBWen.pdf
    │   ├── LUCsv.eps
    │   └── LUCsv.pdf
    └── thesis.tex
```

### File Description
* `root/papers/`: The papers written by the author.
    - `not-thesis/`: Not included in thesis
    - `thesis/`: Included in thesis
* `root/thesis/preface/`: All the material relevant for latex setup and everything before Chapter 1.
    - `abstract.tex`: The thesis' abstract 
    - `acknowledgement.tex`: The thesis' acknowledgements 
    - `cmds.tex`: All commands, declarations, and similar that are common throughout thesis
    - `nomenclature.tex`: Nomenclature chapter
    - `pkgs.tex`: All packages necessary to compile thesis (including packages necessary to compile papers)
    - `preface.tex`: Setup file for preface
    - `thmfmt.tex`: Declare therorem formatting
    - `tikzfmt.tex`: Declare tikz commands, packages, and other formatting
    - `titlepages.tex`: Information relevant to title pages (first two pages)
* `root/thesis/kappa/`: The introductory chapters to the thesis
    - `figs/`: Figures in kappa
    - `kappa.bib`: Bibliography file
    - `kappa.tex`: Setup file for kappa
    - `sec/introduction.tex`: Kappas first chapter
    - `sec/background.tex`: Kappas second chapter
    - `sec/contribution.tex`: Kappas third chapter
* `root/thesis/papers/`: The major contribution of the thesis (namely the papers)
    - `paperX/paperX.bib`: Bibliography file
    - `paperX/paperX.tex`: Setup file for paperX
    - `paperX/figs/`: Figures in paperX
    - `paperX/og/`: Setup and packages files from originally published paperX
    - `paperX/preamble/`: The preamble files specifically for paperX (mostly paper specific commands)
    - `paperX/sec/`: Section setup for paperX
* `root/thesis/style/`: The style files to compile this thesis.
* `root/thesis/thesis.tex`: The main thesis file to compile.


## Useful Links

* [LTHthesis](https://wiki.control.lth.se/Computer/Latex/LTHthesis): instructions about template, titlepage, references, sections...
* [LargeDocuments](https://wiki.control.lth.se/Computer/Latex/LargeDocuments): Leif's structure for large latex docs
* [Tikzexternalize_Hyperref](https://wiki.control.lth.se/Computer/Latex/Tikzexternalize_Hyperref): for tikz externalize issues with large files

## To Do
* ~~Insert all papers~~
* ~~Unify notation~~
* ~~Kappa: Write Chapter 1~~
* Kappa: Write Chapter 2
* ~~Kappa: Write Chapter 3~~
* Kappa: Write nomenclature
* Unify sequences throughout thesis (langle and rangle)
