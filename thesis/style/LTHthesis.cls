\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{LTHthesis}%
  [2022/04/02 A class for theses at LTH, based on memoir]

\DeclareOption{paper}{%
  \PassOptionsToClass{article}{memoir}%
  \AtEndOfClass{\renewcommand\thesection{\arabic{section}}
    \setsecnumdepth{subsection}
    \renewcommand\sectiondot{.}
    \renewcommand\thesubsection{\thesection.\arabic{subsection}}
    \let\paper\@paper
  }
}%

\newif\ifno@biblatex
\DeclareOption{biblatex=none}{%
  \no@biblatextrue
  % Vi behöver definiera ett par tomma kommandon som annars definieras
  % av biblatex
  \let\newrefsection=\relax
  \let\endrefsection=\relax
}
\newif\if@biblatex@numeric
\newcommand\biblatex@style{style=authoryear}
\DeclareOption{biblatex=numeric}{
  \@biblatex@numerictrue
  \renewcommand\biblatex@style{style=numeric}
}
\newcommand\bibtex@backend{biber}
\DeclareOption{biblatex=bibtex}{%
  \renewcommand\bibtex@backend{bibtex}
}

\DeclareOption{biblatex=biber}{%
 \renewcommand\bibtex@backend{biber}
}

\let\possiblyShow@trims\relax
\DeclareOption{showtrims}{%
  \def\possiblyShow@trims{\stockaiv}%
  \PassOptionsToClass{\CurrentOption}{memoir}%
}%

\newif\if@lth@babel
\DeclareOption{english}{\@lth@babeltrue
  \PassOptionsToPackage{\CurrentOption}{babel}}
\DeclareOption{swedish}{\@lth@babeltrue
  \PassOptionsToPackage{\CurrentOption}{babel}}
\DeclareOption{russian}{\@lth@babeltrue
  \PassOptionsToPackage{\CurrentOption}{babel}}
\let\thesis@lang=\relax
\DeclareOption{svenska}{\@lth@babeltrue
  \PassOptionsToPackage{swedish}{babel}
  \newcommand*\thesis@lang{swedish}
}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{memoir}}%

\ProcessOptions
\LoadClass{memoir}
\PassOptionsToPackage{tbtags}{amsmath}
\RequirePackage{amsmath,amsfonts,amssymb}
\AtBeginDocument{\RequirePackage{graphicx}}
\if@lth@babel \RequirePackage{babel}\fi

%%%%%%%%%%% Paper and typeblock size %%%%%%%%%%%%%%%%
\settrimmedsize{220mm}{155mm}{*}
\setstocksize{220mm}{155mm}
\possiblyShow@trims
\setlength{\trimtop}{30mm}
\setlength{\trimtop}{\stockheight}
\addtolength{\trimtop}{-\paperheight}
\setlength{\trimtop}{0.5\trimtop}
\setlength{\trimedge}{\stockwidth}
\addtolength{\trimedge}{-\paperwidth}
\setlength{\trimedge}{0.5\trimedge}
\trimFrame

\textheight=178mm\textwidth=117mm
\setlrmargins{*}{*}{1.0}
\setulmargins{14mm}{*}{*}
\headheight=12pt\headsep=12pt
\checkandfixthelayout

%%%%%%%%% Headers and footers %%%%%%%%%%%%%%%%%%%%
\makepagestyle{thesis}
\makeevenhead{thesis}{\normalfont\itshape\leftmark}{}{}
\makeoddhead{thesis}{}{}{\normalfont\itshape\rightmark}
\makeoddfoot{thesis}{}{}{\normalfont\thepage}
\makeevenfoot{thesis}{\normalfont\thepage}{}{}
\copypagestyle{chapter}{thesis}
\makeevenhead{chapter}{}{}{}
\makeoddhead{chapter}{}{}{}
\pagestyle{thesis}

\parskip=0pt plus 0.1pt\relax
%%%%%%%%%%%%%% Part style%%%%%%%%%%%%%%%%%%%%%%%%%%%
% We want the part page to always be recto, so some extra work is
% necessary.
\let \origPart=\part
\renewcommand*{\part}{\@openrighttrue\origPart}
\let\origPartpageend=\partpageend
\renewcommand*{\partpageend}{{\origPartpageend\@openrightfalse}}
\renewcommand*{\cftpartname}{Part~}
\aliaspagestyle{part}{empty}

%%%%%%%%%%% Chapter style %%%%%%%%%%%%%%%%
\makechapterstyle{LTHthesis}{
  \setlength{\beforechapskip}{0pt}
  \setlength{\afterchapskip}{20mm plus 3mm minus 1mm}
  \renewcommand\printchaptername{}
  \renewcommand\afterchapternum{\par\nobreak\vskip\midchapskip}
  \renewcommand\chapnumfont{\fontsize{36}{42pt}\usefont{T1}{pbk}{l}{n}}
  \renewcommand\chaptitlefont{\fontsize{24}{30pt}\usefont{T1}{pbk}{l}{n}}
  \renewcommand\printchapternum{\hrule height0pt\relax
              \chapnumfont\leftline{\thechapter}}
  \renewcommand\printchapternonum{
    \setbox0=\hbox{\chapnumfont 3}\hrule height 0pt
    \leftline{\vrule height \ht0 width 0pt}\vskip\midchapskip}%
  \def\@chap@mark##1{\ifnum \c@secnumdepth >\m@ne
    \if@mainmatter \@chapapp \ \thechapter . \ \fi \fi ##1}
  \def\chaptermark##1{\markboth{\@chap@mark{##1}}{\@chap@mark{##1}}}
}
\chapterstyle{LTHthesis}
\openright % Will be reset by the \tableofcontents command.

%%%%%%%%%%%%%%%% section style %%%%%%%%%%%%%%%%%%%
\setbeforesecskip{-20pt plus -6 pt minus -3pt}
\setsecheadstyle{\sffamily\bfseries\Large\raggedright}
\setaftersecskip{9pt}
\def\sectionmark#1{\markright{\ifnum \c@secnumdepth > \z@
    \thesection \quad\fi #1}}

%%%%%%%%%%%%%% subsection style %%%%%%%%%%%%%%%%%%%%
\setbeforesubsecskip{-10pt plus -5pt minus -2pt}
\setsubsecheadstyle{\sffamily\bfseries\large\raggedright}
\setaftersubsecskip{3pt}

%%%%%%%%%%%%% subsubsection style %%%%%%%%%%%%%%%%%%%%%%%%
\setbeforesubsubsecskip{6pt plus 2pt minus 1pt}
\setaftersubsubsecskip{-1em}
\setsubsubsecheadstyle{\normalsize\bfseries\itshape}
% The following tries to add a period after the title (Anton?). But, since the
% style macro receives an already formatted title it adds the period after the
% negative space which forces the actual title to after the first paragraph.
% \newcommand{\subsubsecdot}[1]{\normalsize\bfseries\itshape #1.}
% \setsubsubsecheadstyle{\subsubsecdot}


%%%%%%%%%%%%%%%%%%% Style for all section numbering %%%%%%%%%55555
\setsecnumformat{\csname the#1\endcsname\csname #1dot\endcsname\quad}
\newcommand\sectiondot{}
\newcommand\subsectiondot{}
\newcommand\subsubsectiondot{}
\newcommand\captiondot{}

%%%%%%%%%%%%%%%%% Table of contents %%%%%%%%%%%%%%%%%%%
\let\origTOC=\tableofcontents
\renewcommand\tableofcontents{\clearforchapter
  \currentpdfbookmark{\contentsname}{toc}\origTOC*\cleartorecto\openany}
\renewcommand\cftchapteraftersnum{.}
\setlength{\cftchapternumwidth}{20pt}
\setlength{\cftsectionindent}{\cftchapternumwidth}
%\renewcommand\cftchapterpresnum{\hfill}
\setlength{\cftbeforechapterskip}{\smallskipamount}
\renewcommand\cftsectionaftersnum{\sectiondot}
\renewcommand\@pnumwidth{2em}

%%%%%%%%%%%%%% Captions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\captiondelim{\captiondot\quad}
\captionnamefont{\small\bfseries}
\captiontitlefont{\small}
\captionstyle[\centering]{}
\AtBeginDocument{%
  \dimen0=\textwidth\advance\dimen0 -2\parindent
  \captionwidth{\dimen0}\changecaptionwidth
}
% The command \@minipagerestore is called at the start
% of every minipage. It is intended to set any necessary
% internal parameters. In this case we need to reset the
% captionwidth. See 'texdoc source2e', section ltboxes.
\renewcommand\@minipagerestore{\normalcaptionwidth}

\setlength{\textfloatsep}{12pt plus 4pt minus 3pt}

%%%%%%%%%%%%% Footnotes  %%%%%%%%%%%%%%%%%%%%%%%%%
\footmarkwidth=1.2em\footmarksep=0pt
\footmarkstyle{\textsuperscript{#1}\hskip1pt\relax}

%%%%%%%%%%%%%%%%% Papers %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcounter{paper}
\def\thepaper{\Roman{paper}}

\newlength{\afterpaperskip}
\setlength{\afterpaperskip}{10mm}
\newcommand\paperheadname{Paper}
\newcommand\papernumfont{\fontsize{20}{24pt}\usefont{T1}{pbk}{l}{n}}
\newcommand\papertitlefont{\huge\bfseries}
\renewcommand\abstracttextfont{\normalfont\small\noindent\ignorespaces}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\paper@{%
  \@ifnextchar[%
  {\paper@i}
  {\paper@i[]}
}
\def\paper@i[#1]{%
  \@ifnextchar[%
  {\paper@ii{#1}}
  {\paper@ii{#1}[]}%
}
\def\paper@ii#1[#2]#3{%
  \def\p@title{#3}%
  \def\p@head{#2}%
  \def\p@toc{#1}%
  \ifx\p@toc\@empty
    \let\p@toc=\p@title
  \fi
  \ifx\p@head\@empty %no optional arg
    \let\p@head=\p@toc
  \fi
  \par
  \clearforchapter
  \thispagestyle{chapter}
  \refstepcounter{paper}
  \addcontentsline{toc}{paper}{\protect\papernumberline{\thepaper}\p@toc}%
  \markboth{\paperheadname\ \thepaper.\quad\p@head}{}
  \begingroup
    \offinterlineskip
    \hrule height 0pt
    \papernumfont
    \leftline{\paperheadname\ \thepaper}\par
  \endgroup
    \afterchapternum
  \begingroup
      \centering
      \papertitlefont \p@title\par
  \endgroup
    \vskip\afterpaperskip
    \newrefsection
    \renewcommand\thesection{\@arabic\c@section}\anappendixfalse
 }

\def\@authorcr{\unskip\egroup\@centercr\mbox\bgroup\ignorespaces}
\def\@authors#1{%
  \begin{center}\large\bfseries\addtolength{\baselineskip}{2mm}%
    \def\and{\egroup\unskip\quad\mbox\bgroup}%
    \let\\=\@authorcr
    \mbox\bgroup#1\egroup\par
  \end{center}
  \vspace{10mm}%
}

\def\setP@perCounters{%
  \let\save@elt\@elt
  \let\@elt\setChapter@elt
  \cl@chapter
  \let\@elt\save@elt
}
\def\setChapter@elt#1{\expandafter\def\csname
  the#1\endcsname{\arabic{#1}}}



\newcommand*\l@paper[2]{%
  %\message{paper|#1|#2|}
\begingroup
  \cftchapterbreak
  \vskip \cftbeforechapterskip
  \rightskip 2.5em plus 20mm
  \parfillskip -\rightskip
  \parindent0pt\relax
  \@afterindenttrue
  \interlinepenalty\@M
  \leavevmode
  \hyphenpenalty\@M
  \exhyphenpenalty\@M
  % Egentligen skall man beräkna exakt bredd, men vi fuskar
  % och använder 'Paper VII.' som standard
  \settowidth{\leftskip}{\cftchapterfont Paper\enskip VII.\enskip}\null
  \nobreak\hskip -\leftskip
  \cftchapterfont #1\cftchapterfillnum{#2}%
\endgroup
}


% \newcommand*\papernumberline[1]{\texorpdfstring{%
%     \makebox[\leftskip]{\cftchapterfont Paper\enskip #1.\enskip}\ignorespaces
% }{Paper #1. }}
\newcommand*\papernumberline[1]{\texorpdfstring{%
    {\cftchapterfont Paper\enskip #1.\enskip}\ignorespaces
}{Paper #1. }}

% If hyperref is used it will define \texorpdfstring
% and \currentpdfbookmark, otherwise define them here.
\AtBeginDocument{%
  \providecommand{\texorpdfstring}[2]{#1}%
  \providecommand{\currentpdfbookmark}[2]{}%
  \providecommand{\theHsection}[1]{}%
  \providecommand{\theHfigure}[1]{}%
  \providecommand{\theHtable}[1]{}%
}


 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This section is to handle labels and references in papers.
% We want them all to be local inside papers, so a lot of
% extra work is required.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%  This is for comma separated lists inside when using cleveref.
\def\paper@cref@#1#2{%
  \toks@{}%
  \@for\@ll:=#2\do{%
    \ifx\@ll\@empty\else\edef\@ll{@p\thepaper @\@ll}\fi%
    \edef\@tmp{\the\toks@}%
    \ifx\@tmp\@empty
      \toks@=\expandafter{\@ll}%
    \else
      \edef\@tmp{\the\toks@,\@ll}%
      \toks@=\expandafter{\@tmp}%
    \fi}%
  \@nameuse{@memoir@#1}{\the\toks@}%
}

\protected\def\paper@label#1{\@memoir@label{@p\thepaper @#1}}
\protected\def\paper@ref#1{\@memoir@ref{@p\thepaper @#1}}
\protected\def\paper@thref#1{\@memoir@thref{@p\thepaper @#1}}
\protected\def\paper@pageref#1{\@memoir@pageref{@p\thepaper @#1}}
\protected\def\paper@label@in@display#1{\@memoir@label@in@display{@p\thepaper @#1}}
\protected\def\paper@crefrange#1#2{\@memoir@crefrange{@p\thepaper @#1}{@p\thepaper @#2}}
\protected\def\paper@Crefrange#1#2{\@memoir@Crefrange{@p\thepaper @#1}{@p\thepaper @#2}}
\protected\def\paper@cref#1{\paper@cref@{cref}{#1}}
\protected\def\paper@Cref#1{\paper@cref@{Cref}{#1}}
\protected\def\paper@labelcref#1{\paper@cref@{labelcref}{#1}}

%% This is a copy of sf@memsub@label taken from the deep inside of
%% memoir.cls, and also from cleveref.sty. I don't like it, but it is necessary to handle
%% \label inside \subcaption and still make the label local to a paper.
\AtBeginDocument{%
  \@ifpackageloaded{cleveref}{%
    \def\paper@sf@memsub@label(#1)#2{%
      \protected@edef\mem@currentlabelname{@p\thepaper @#1}%
      %\protected@edef\mem@currentlabelname{#1}%
      \sf@@memsub@label{@p\thepaper @#2}
      \protected@write\@auxout{}%
      {\string\newlabel{@p\thepaper @#2@cref}{{\cref@currentlabel}{\thepage}}}%
    }
%
%  To handle equation numbers for cleveref and multline in papers.
%
   \def\paper@multline{%
    \def\label@in@mmeasure@noarg##1{%
       \begingroup%
       \measuring@false%
       \cref@old@label@in@display{{@p\thepaper @##1}}%
       \endgroup}%
     }%
   }{%
    \def\paper@sf@memsub@label(#1)#2{%
      % \protected@edef\mem@currentlabelname{@p\thepaper @#1}%
      \protected@edef\mem@currentlabelname{#1}%
      \sf@@memsub@label{@p\thepaper @#2}
    }
    \def\paper@multline{}%
  }
}
\newcommand*{\paper@ssc@ref}[1]{\@memoir@ref{sub@@p\thepaper @#1}}
\newcommand*{\paper@sc@ref}[1]{{\@subcaplabelfont
                          \@memoir@ref{sub@@p\thepaper @#1}}}




\newenvironment{papers}{%
  % \setP@perCounters
%  \counterwithout{section}{chapter}
  \renewcommand\cftsectionaftersnum{.}
  \counterwithin{section}{paper}
  \counterwithin{figure}{paper}
  \counterwithin{table}{paper}
  \counterwithin{equation}{paper}
  \providecommand*{\toclevel@paper}{0}
  \renewcommand{\sectiondot}{.}
  \renewcommand{\captiondot}{.}
  \def\thesubsection{\thesection.\arabic{subsection}}
  \renewcommand\thefigure{\arabic{figure}}
  \renewcommand\thesection{\arabic{section}}
  \renewcommand\thetable{\arabic{table}}
  \renewcommand\theequation{\arabic{equation}}
  \renewcommand\theHsection{\thepaper.\thesection}
  \renewcommand\theHfigure{\thepaper.\thefigure}
  \renewcommand\theHtable{\thepaper.\thetable}

  \setsecnumdepth{subsection}
  \let\cl@paper\cl@chapter
  \let\paper=\paper@
  \let\@memoir@label\label
  \let\label\paper@label
  \let\globalLabel\@memoir@label
  \let\@memoir@label@in@display\label@in@display
  \let\label@in@display\paper@label@in@display
  \let\authors\@authors

  \let\sf@memsub@label\paper@sf@memsub@label
  \let\ssc@ref\paper@ssc@ref
  \let\sc@ref\paper@sc@ref
  \paper@multline
  \renewcommand\appendix{\par
     \setcounter{section}{0}%
     \renewcommand\thesection{\@Alph\c@section}%
     \anappendixtrue}

  \let\@memoir@ref\ref
  \let\ref\paper@ref
  \let\@memoir@thref\thref
  \let\thref\paper@thref
  \let\@memoir@pageref\pageref
  \let\pageref\paper@pageref
  \let\@memoir@cref\cref
  \let\cref\paper@cref
  \let\@memoir@Cref\Cref
  \let\Cref\paper@Cref
  \let\@memoir@crefrange\crefrange
  \let\crefrange\paper@crefrange
  \let\@memoir@Crefrange\Crefrange
  \let\Crefrange\paper@Crefrange
  \let\@memoir@labelcref\labelcref
  \let\labelcref\paper@labelcref
  \openright
}{\par\endrefsection\openany}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%% ntheorem %%%%%%%%%%%%%%%%%%%%%%
\namerefoff
\PassOptionsToPackage{amsmath,thmmarks,framed}{ntheorem}
%\PassOptionsToPackage{thref}{ntheorem} % Gave trouble with numbering
\RequirePackage{latexsym}
%\RequirePackage{framed}
\newcommand{\theoremhack}{\NoEndMark\hrule height 0pt\kern-\belowdisplayskip
  \strut\hfill \csname\InTheoType Symbol\endcsname}
\RequirePackage{ntheorem}

%%%%%% Nedanstående var för att få en \noindent efter \end{<theoremname>},
%%%%%% men jag hade missuppfattat avsikten med \theorempostwork.
%%%%%% Vi får se om jag kan hitta en annan lösning.
%\newdimen\save@indent\newtoks\saved@everypar
% \theorempostwork{
%   \save@indent=\parindent \saved@everypar=\everypar
%   \parindent=\z@
%   \everypar={\parindent=\saved@indent\everypar=\saved@everypar}
% }

\newtheoremstyle{proof}%
    {\item[\theorem@headerfont\hskip\labelsep ##1\theorem@separator]}%
    {\item[\theorem@headerfont\hskip\labelsep ##3\theorem@separator]}
    % {\item[\theorem@headerfont\hskip \labelsep ##1\ ##3\theorem@separator]}
\theoremstyle{proof}
\theoremseparator{.}
\theoremheaderfont{\bfseries\itshape}
\theorembodyfont{\normalfont}
\theoremsymbol{\ensuremath{\Box}}
\newtheorem{proof}{Proof}

\newtheoremstyle{regler}%
    {\item[\rlap{\vbox{\hbox{\hskip\labelsep \theorem@headerfont
            ##1\ ##2\theorem@separator}\hbox{\strut}}}]}%
    {\item[\strut]{\theorem@headerfont##1\ ##2---##3}\newline}
\theoremstyle{regler}
\theoremseparator{}
% \theoremsymbol{\ensuremath{\Box}}
\theoremsymbol{}
% \theorembodyfont{\normalfont}
% \theorembodyfont{\slshape}
\theorembodyfont{\itshape}
\theoremheaderfont{\scshape}

%%%%%%%%%%%%% Title Pages %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  \AtBeginDocument{\RequirePackage{textcomp}} % Gives a better result for the copyright symbol

  \newcommand*\tp@title@{An Important Contribution}
  \newcommand*\tp@author@{John Student}
  \newcommand*\tp@month@{}
  \newcommand*\tp@year@{2099}
  \newcommand*\tp@printer@{}
  \newcommand*\tp@dedication@{}
  \newcommand*\tp@ISBN@print{}
  \newcommand*\tp@ISBN@web{}
  \newcommand*\tp@series@{ TFRT-}
  \newcommand*\tp@number@{9999}
  \newcommand*\tp@ISSN@{0280--5316}
  \newcommand*\tp@subtitle@{}
  \newcommand*\tp@extrainfo@{}
  \newcommand*\tp@copyright@{\copyright{} \tp@year@{} by \tp@author@.
    All rights reserved.\\}
  \@ifundefined{thesis@lang}%
    {\newcommand*\LUlogo{LUBWen}%
      \newcommand*\tp@department@{Department of Automatic Control}
      \newcommand*\tp@type@{MSc Thesis}%
      \newcommand*\title@page{Title Page}
    }{%
      \newcommand*\LUlogo{LUBWsv}%
      \newcommand*\tp@department@{Institutionen f\"or Reglerteknik}
      \newcommand*\tp@type@{Examensarbete}%
      \newcommand*\title@page{Titelsida}
    }%

\newenvironment{titlepages}{
  \renewcommand\month[1]{\renewcommand\tp@month@{##1}}
  \renewcommand*\year[1]{\renewcommand\tp@year@{##1}}
  \renewcommand*\title[1]{\renewcommand\tp@title@{##1}}
  \newcommand*\subtitle[1]{\renewcommand\tp@subtitle@{##1}}
  \renewcommand*\author[1]{\renewcommand\tp@author@{##1}}
  \newcommand*\type[1]{\renewcommand*\tp@type@{##1}}
  \newcommand*\ISBNprint[1]{\renewcommand*\tp@ISBN@print{##1}}
  \newcommand*\ISBNweb[1]{\renewcommand*\tp@ISBN@web{##1}}
  \newcommand*\dedication[1]{\renewcommand*\tp@dedication@{##1}}
  \newcommand*\printer[1]{\renewcommand\tp@printer@{ by ##1}}
  \newcommand*\series[1]{\renewcommand*\tp@series@{##1}}
  \newcommand*\reportnumber[1]{\renewcommand*\tp@number@{##1}}
  \newcommand*\ISSN[1]{\renewcommand*\tp@ISSN@{##1}}
  \newcommand*\department[1]{\renewcommand*\tp@department@{##1}}
  \newcommand*\extrainfo[1]{\renewcommand*\tp@extrainfo@{%
      \noindent ##1\par\vspace{10mm}}}
  \newcommand*\copyrightnotice[1]{\renewcommand*\tp@copyright@{##1}}
  \let\TFRT\reportnumber
  \let\thesisnumber\reportnumber
}{
  % \show\tp@copyright@
  \currentpdfbookmark{\title@page}{titlepage}
  \thispagestyle{empty}
  \vspace*{0pt plus 0.15fill}
  \begin{center}\sffamily
    \huge \tp@title@\\[0pt plus 0.3fill]
    \ifx\tp@subtitle@\empty\else
      \vspace*{-35mm}%
      \normalsize \tp@subtitle@\\[0pt plus 0.1fill]
    \fi
    \LARGE \tp@author@\\[0pt plus 0.55fill]
    \normalsize
    \includegraphics[width=25mm]{\LUlogo}\\[\medskipamount]
    \tp@department@
  \end{center}
  \newpage
  \thispagestyle{empty}
  \vspace*{0pt plus 0.6fill}%
  \tp@extrainfo@
  \begin{flushleft}
   \tp@type@{} \tp@series@\tp@number@ \\
   \ifx\tp@ISBN@print\empty\else ISBN \tp@ISBN@print\ (print)\\\fi
   \ifx\tp@ISBN@web\empty\else ISBN \tp@ISBN@web\ (web)\\\fi
   ISSN \tp@ISSN@

   \vspace{10mm}%
   \@ifundefined{thesis@lang}{%
     \tp@department@ \\
     Lund University\\
     Box 118\\
     SE-221 00 LUND\\
     Sweden
   }{%
     \tp@department@\\
     Lunds universitet\\
     Box 118\\
     221 00 Lund%
   }\\
   \vspace{10mm}
   \tp@copyright@
   Printed in Sweden\tp@printer@.\\
   Lund \tp@year@
 \end{flushleft}
 \cleartorecto
 \ifx\tp@dedication@\empty
 \else
   \thispagestyle{empty}
   \vspace*{0pt plus 0.4fill}
   \begin{center}
     \itshape \tp@dedication@
   \end{center}%
   \vspace*{0pt plus 0.6fill}
   \cleartorecto
 \fi
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\frenchspacing\tolerance=1000\emergencystretch=1em
\setlength{\@fptop}{5pt}

%%%%%%%%%%%%% biblatex %%%%%%%%%%%%%%%%%%
\ifno@biblatex \endinput \fi
\renewcommand\memUChead[1]{#1}

\PassOptionsToPackage{\biblatex@style}{biblatex}
\PassOptionsToPackage{backend=\bibtex@backend}{biblatex}
\RequirePackage{biblatex}

\ExecuteBibliographyOptions{maxcitenames=2,maxbibnames=99}
\if@biblatex@numeric\relax\else
  \ExecuteBibliographyOptions{dashed=false}
\fi
\ExecuteBibliographyOptions{giveninits=true,uniquename=false,uniquelist=false}
\@ifpackagelater{biblatex}{2017/11/21}{%
   \ExecuteBibliographyOptions{urldate=iso,seconds=true}
} {%
   \ExecuteBibliographyOptions{urldate=edtf,seconds=true}
 }
\AtEveryBibitem{\clearfield{month}}

\let\cite=\parencite
\newcommand\mkciteparens[1]{{[#1]}}

\DeclareCiteCommand{\parencite}[\mkciteparens]%
  {\usebibmacro{prenote}}
  {\usebibmacro{citeindex}%
    \printtext[bibhyperref]{\usebibmacro{cite}}}
  {\multicitedelim}
  {\usebibmacro{postnote}}

\DeclareCiteCommand*{\parencite}[\mkciteparens]
{\usebibmacro{prenote}}
{\usebibmacro{citeindex}%
    \printtext[bibhyperref]{\usebibmacro{citeyear}}}
{\multicitedelim}
{\usebibmacro{postnote}}

  \renewcommand*{\nameyeardelim}{\addcomma\addspace}

\renewcommand*{\bibsetup}{%
  \interlinepenalty=5000\relax
  \widowpenalty=10000\relax
  \clubpenalty=10000\relax
  \raggedbottom
  \frenchspacing
  \tolerance=2000
  \emergencystretch=2em
  \setlength{\bibitemsep}{\smallskipamount}
  \biburlsetup}

% \renewbibmacro*{name:andothers}{%
%   \ifboolexpr{
%     test {\ifnumequal{\value{listcount}}{\value{liststop}}}
%     and
%     test \ifmorenames
%   }
%     {\ifnumgreater{\value{liststop}}{1}
%        {\finalandcomma}
%        {}%
%      \andothersdelim\bibstring[\mkbibemph]{andothers}}
%     {}}



% We want to remove an 'in:' from the article entries. Unfortunately
% this requires a complete copy of the Driver.
\DeclareBibliographyDriver{article}{%
  \usebibmacro{bibindex}%
  \usebibmacro{begentry}%
  \usebibmacro{author/translator+others}%
  \setunit{\labelnamepunct}\newblock
  \usebibmacro{title}%
  \newunit
  \printlist{language}%
  \newunit\newblock
  \usebibmacro{byauthor}%
  \newunit\newblock
  \usebibmacro{bytranslator+others}%
  \newunit\newblock
  \printfield{version}%
  \newunit\newblock
  %\usebibmacro{in:}%
  \usebibmacro{journal+issuetitle}%
  \newunit
  \usebibmacro{byeditor+others}%
  \newunit
  \usebibmacro{note+pages}%
  \newunit\newblock
  \iftoggle{bbx:isbn}
    {\printfield{issn}}
    {}%
  \newunit\newblock
  \usebibmacro{doi+eprint+url}%
  \newunit\newblock
  \usebibmacro{addendum+pubstate}%
  \setunit{\bibpagerefpunct}\newblock
  \usebibmacro{pageref}%
  \newunit\newblock
  \usebibmacro{related}%
  \usebibmacro{finentry}}

% We want to include a number for the theses. Unfortunately this
% requires a complete copy of the driver.
\DeclareBibliographyDriver{thesis}{%
  \usebibmacro{bibindex}%
  \usebibmacro{begentry}%
  \usebibmacro{author}%
  \setunit{\labelnamepunct}\newblock
  \usebibmacro{title}%
  \newunit
  \printlist{language}%
  \newunit\newblock
  \usebibmacro{byauthor}%
  \newunit\newblock
  \printfield{note}%
  \newunit\newblock
  \printfield{type}%
  \setunit*{\addspace}%
  \printfield{number}% Added locally
  \newunit
  \usebibmacro{institution+location+date}%
  \newunit\newblock
  \usebibmacro{chapter+pages}%
  \newunit
  \printfield{pagetotal}%
  \newunit\newblock
  \iftoggle{bbx:isbn}
    {\printfield{isbn}}
    {}%
  \newunit\newblock
  \usebibmacro{doi+eprint+url}%
  \newunit\newblock
  \usebibmacro{addendum+pubstate}%
  \setunit{\bibpagerefpunct}\newblock
  \usebibmacro{pageref}%
  \newunit\newblock
  \usebibmacro{related}%
  \usebibmacro{finentry}}

% Make theses look like book titles
\DeclareFieldFormat[thesis]{title}{\mkbibemph{#1}}

% The original version has the form vol.num.
% we want <bold>vol</bold>:num
\renewbibmacro*{volume+number+eid}{%
  \printfield[bold]{volume}%
  \setunit*{\addcolon}%
  \printfield{number}%
  \setunit{\addcomma\space}%
  \printfield{eid}}

% The original version had the form address: publisher.
% We want publisher, address.
\renewbibmacro*{publisher+location+date}{%
  \printlist{publisher}%
  \setunit*{\addcomma\space}%
  \printlist{location}%
  \setunit*{\addcomma\space}%
  \usebibmacro{date}%
  \newunit}

% The original version had the form address: institution.
% We want institution, address.
\renewbibmacro*{institution+location+date}{%
  \printlist{institution}
  \setunit*{\addcomma\space}%
  \printlist{location}%
  \setunit*{\addcomma\space}%
  \usebibmacro{date}%
  \newunit}

% Make the titles of articles and conference contributions 'sentence case',
% but don't touch any other titles.
% http://tex.stackexchange.com/questions/22980/sentence-case-for-titles-in-biblatex
\DeclareFieldFormat{titlecase}{\MakeTitleCase{#1}}
\newrobustcmd{\MakeTitleCase}[1]{%
  \ifthenelse{\ifcurrentfield{booktitle}\OR\ifcurrentfield{booksubtitle}%
    \OR\ifcurrentfield{maintitle}\OR\ifcurrentfield{mainsubtitle}%
    \OR\ifcurrentfield{journaltitle}\OR\ifcurrentfield{journalsubtitle}%
    \OR\ifcurrentfield{issuetitle}\OR\ifcurrentfield{issuesubtitle}%
    \OR\ifentrytype{book}\OR\ifentrytype{mvbook}\OR\ifentrytype{bookinbook}%
    \OR\ifentrytype{booklet}\OR\ifentrytype{suppbook}%
    \OR\ifentrytype{collection}\OR\ifentrytype{mvcollection}%
    \OR\ifentrytype{suppcollection}\OR\ifentrytype{manual}%
    \OR\ifentrytype{periodical}\OR\ifentrytype{suppperiodical}%
    \OR\ifentrytype{proceedings}\OR\ifentrytype{mvproceedings}%
    \OR\ifentrytype{reference}\OR\ifentrytype{mvreference}%
    \OR\ifentrytype{report}\OR\ifentrytype{thesis}}
    {#1}
    {\MakeSentenceCase{#1}}}

% We want incollection and inbook entries to have editor specifications like:
% In: Editor E. (Ed.). Booktitle. Publisher. Address
%
\newbibmacro*{ineditor+others}{%
  \ifboolexpr{ test \ifuseeditor and not test {\ifnameundef{editor}} }
    {\defcounter{maxnames}{1}% Only show one editor, use et al. if more.
      \printnames{editor}%
     \setunit{\addspace}%
     \usebibmacro{editor+othersstrg}%
     \clearname{editor}}
    {}}

% Print editors before "in" title
\renewbibmacro{in:}{%
  \ifentrytype{article}{}{\printtext{\bibstring{in}\intitlepunct}}%
  \usebibmacro{ineditor+others}%
  \newunit
  \clearname{editor}}

\DeclareFieldFormat{editortype}{\mkbibparens{#1}}

\DefineBibliographyStrings{english}{% various adjustments to
                                    % common bib entry strings
  editor = {Ed.},
  editors = {Eds.},
}

