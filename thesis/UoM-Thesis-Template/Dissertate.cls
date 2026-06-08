% -------------------------------------------------------------------
%  @LaTeX-class-file{
%     filename        = "Dissertate.cls",
%     version         = "1.0",
%     date            = "24 January 2014",
%     codetable       = "ISO/ASCII",
%     keywords        = "LaTeX, Dissertate",
%     docstring       = "Class for a dissertation."
% --------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{Dissertate}[2014/01/24 v1.0 Dissertate Class]
% If you need to change font size etc. 
\LoadClass[12pt, oneside, a4paper]{book}

% some definitions
\def\degreeyear#1{\gdef\@degreeyear{#1}}
\def\degreemonth#1{\gdef\@degreemonth{#1}}
\def\degree#1{\gdef\@degree{#1}}
\def\advisor#1{\gdef\@advisor{#1}}
\def\department#1{\gdef\@department{#1}}
\def\field#1{\gdef\@field{#1}}
\def\university#1{\gdef\@university{#1}}
\def\universitycity#1{\gdef\@universitycity{#1}}
\def\universitystate#1{\gdef\@universitystate{#1}}
\def\programname#1{\gdef\@programname{#1}}
\def\pdOneName#1{\gdef\@pdOneName{#1}}
\def\pdOneSchool#1{\gdef\@pdOneSchool{#1}}
\def\pdOneYear#1{\gdef\@pdOneYear{#1}}
\def\pdTwoName#1{\gdef\@pdTwoName{#1}}
\def\pdTwoSchool#1{\gdef\@pdTwoSchool{#1}}
\def\pdTwoYear#1{\gdef\@pdTwoYear{#1}}


% for links in references
\usepackage{hyperref}

% ---- Chapter/section formatting
\setlength{\headheight}{15pt}
\pagestyle{plain}
\RequirePackage{titling}
\RequirePackage{titlesec, blindtext, color}
\newcommand{\hsp}{\hspace{10pt}}

% Chapter format -- using fncychap
\usepackage[Sonny]{fncychap}

%  Section and subsections -- using titlesec
\titleformat{\section}[hang]{\Large\scshape}{\thesection.}{1em}{}
\titleformat{\subsection}[hang]{\large\itshape}{\thesection.}{1em}{}
\titleformat{\subsubsection}[hang]{\normalfont\itshape}{\thesection.}{1em}{}


% ----- From original template -- it's a mystery

\RequirePackage{kvoptions}
\DeclareStringOption{School}[]
\ProcessKeyvalOptions*
\RequirePackage{packages/\Dissertate@School/style}

\RequirePackage{graphicx}
\RequirePackage{amssymb}
\RequirePackage{lettrine}
% \RequirePackage[natbib=true, maxbibnames=3,doi=false,isbn=false,url=false]{biblatex}
%\renewcommand{\bibnumfmt}[1]{[#1]}

\makeatother
%\RequirePackage[width=5.75in, letterpaper]{geometry}
%\RequirePackage{fancyhdr}

\RequirePackage{geometry}
 \geometry{
    a4paper,
    right=30mm,
    left=30mm,
    top=30mm,
    bottom=30mm
 }



\usepackage[titletoc]{appendix}
\renewcommand{\setthesection}{\arabic{chapter}.A\arabic{section}}

\RequirePackage{setspace}
\RequirePackage{booktabs}
\RequirePackage{verbatim}
% \setcounter{tocdepth}{1}

\RequirePackage{url}
\usepackage[titles]{tocloft}
\renewcommand{\cftsecleader}{\cftdotfill{\cftdotsep}}
\renewcommand{\cftchapfont}{\normalsize \scshape}
\renewcommand{\cftsecfont}{\normalsize \scshape}
% \usepackage{fixltx2e}
%\usepackage{ragged2e}

\renewcommand\bibname{References}
\renewcommand\listfigurename{List of figures}
%\RaggedRight

\parindent 12pt

\RequirePackage{color}
\usepackage{epigraph}
\usepackage{hyperref}
\usepackage{xcolor}
\RequirePackage{url}
\RequirePackage{amssymb}
\RequirePackage{amsmath}
\RequirePackage{siunitx}
\RequirePackage{physics}
%\sisetup{per-mode=symbol}
\DeclareSIUnit\year{yr}
\RequirePackage{cleveref}
\usepackage[T1]{fontenc}
\usepackage{kpfonts}%  for math    
\usepackage[mono=false]{libertine}%  serif and sans serif
\sisetup{range-phrase = \text{--}}
\sisetup{separate-uncertainty = true}
\sisetup{math-micro=\text{µ},text-micro=µ}
\DeclareSIUnit\gauss{G}
\DeclareMathOperator*{\argmax}{arg\,max} 
\providecommand\condprob[2]{P\left(#1\,\middle\vert\,#2\right)}
\newcommand{\overbar}[1]{\mkern 1.5mu\overline{\mkern-1.5mu#1\mkern-1.5mu}\mkern 1.5mu}

\renewcommand{\thefootnote}{\fnsymbol{footnote}}

% an environment for paragraph-style section
\providecommand\newthought[1]{%
   \addvspace{1.0\baselineskip plus 0.5ex minus 0.2ex}%
   \noindent#1%
}


%%%%%%%%%%%%ROMAN LETTERS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\Scal}[2][4]{\scalebox{#1}{$#2$}}
\newcommand{\io}{\dot{\imath}}
\newcommand{\Io}{\mathcal{I}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%\newcommand{\G}{\mathcal{G}}
%\newcommand{\V}{\mathcal{V}}
%\newcommand{\Ed}{\mathcal{E}}
%\newcommand{\Rho}{\mbox{\boldmath $\rho$}}
%\newcommand{\Iota}{\mbox{\boldmath $\iota$}}
%\newcommand{\A}{\mathcal{A}}
%\newcommand{\p}{\mathcal{P}}
% please place your own definitions here and don't use \def but \newcommand{}{}
\newcommand{\dr}{{d}^{\hspace{.3mm}\raisebox{1pt}{$\scriptscriptstyle \!\star$}}}
\newcommand{\da}{{d}^{\hspace{.3mm}\raisebox{1pt}{$\scriptscriptstyle \scalebox{.4}{G}\star$}}}
\newcommand{\dat}{{\tilde{d}}^{\hspace{.3mm}\raisebox{1pt}{$\scriptscriptstyle \scalebox{.4}{G}\star$}}}
\newcommand{\db}{{d}^{\hspace{.3mm}\raisebox{1pt}{$\scriptscriptstyle \scalebox{.4}{G}$}}}
\newcommand{\deltar}{{\delta}^{\hspace{.3mm}\raisebox{1pt}{$\scriptscriptstyle \!\star$}}}
\newcommand{\deltaa}{{\delta}^{\hspace{.3mm}\raisebox{1pt}{$\scriptscriptstyle \scalebox{.4}{G}\star$}}}
\newcommand{\deltaat}{{\tilde{\delta}}^{\hspace{.3mm}\raisebox{1pt}{$\scriptscriptstyle \scalebox{.4}{G}\star$}}}
\newcommand{\deltab}{{\delta}^{\hspace{.3mm}\raisebox{1pt}{$\scriptscriptstyle \scalebox{.4}{G}$}}}
%-----------------------------------------------
\newcommand{\muIF}{\mu_{\scriptscriptstyle IF}}
\newcommand{\muGF}{\mu_{\scriptscriptstyle GF}}
%
\newcommand{\dIF}{d_{,\scriptscriptstyle IF}}
\newcommand{\dGF}{d_{,\scriptscriptstyle GF}}
%
\newcommand{\muWL}{\mu_{\scriptscriptstyle WL}}
\newcommand{\muNL}{\mu_{\scriptscriptstyle NL}}
%
\newcommand{\rIF}{_{r, \scriptscriptstyle IF}}
\newcommand{\rGF}{_{r, \scriptscriptstyle GF}}
\newcommand{\rGB}{_{r, \scriptscriptstyle GB}}
\newcommand{\aGF}{_{1, \scriptscriptstyle GF}}
\newcommand{\aIF}{_{1, \scriptscriptstyle IF}}
\newcommand{\aGB}{_{1, \scriptscriptstyle GB}}
\newcommand{\GB}{_{\scriptscriptstyle GB}}
\newcommand{\GF}{_{\scriptscriptstyle GF}}
\newcommand{\jGF}{_{j, \scriptscriptstyle GF}}
\newcommand{\uGF}{^{\scriptscriptstyle GF}}
\newcommand{\uGFinv}{^{\scriptscriptstyle GF-1}}
\newcommand{\uGB}{^{\scriptscriptstyle GB}}
%-----------------------------------------------
\newcommand{\GBphi}{_{\phi, \scriptscriptstyle GB}}
\newcommand{\GBp}{_{p, \scriptscriptstyle GB}}
\newcommand{\GFphi}{_{\phi, \scriptscriptstyle GF}}
\newcommand{\GFp}{_{p, \scriptscriptstyle GF}}
\newcommand{\GFiphi}{_{\phi, \scriptscriptstyle GFi}}
\newcommand{\GFip}{_{p, \scriptscriptstyle GFi}}
%-----------------------------------------------
%
\newcommand{\be}{\begin{equation}}
\newcommand{\ee}{\end{equation}}
\newcommand{\ba}{\begin{array}}
\newcommand{\ea}{\end{array}}
\newcommand{\E}{\mathsf{E}}
\newcommand{\N}{\mathsf{N}}
\def\C{\mathsf{C}}
\newcommand{\yh}{\hat{y}}
\newcommand{\yu}{\underline{y}}
\newcommand{\yhu}{\underline{\hat{y}}}
\newcommand{\ycu}{\underline{\check{y}}}
\newcommand{\zh}{\hat{z}}
\newcommand{\zu}{\underline{z}}
\newcommand{\zhu}{\underline{\hat{z}}}
\newcommand{\zcu}{\underline{\check{z}}}
\newcommand{\zc}{\check{z}}
\newcommand{\xh}{\hat{x}}
\newcommand{\xu}{\underline{x}}
\newcommand{\xhu}{\underline{\hat{x}}}
\newcommand{\xc}{\check{x}}
\newcommand{\xcu}{\underline{\check{x}}}
\newcommand{\eh}{\hat{e}}
\newcommand{\eu}{\underline{e}}
\newcommand{\ehu}{\underline{\hat{e}}}
\newcommand{\ecu}{\underline{\check{e}}}
\newcommand{\tu}{\underline{t}}
\newcommand{\pu}{\underline{p}}
%\newcommand{\Pu}{\underline{P}}
\newcommand{\Pu}{\underline{\rho}}
\newcommand{\phiu}{\underline{\phi}}
\newcommand{\Phiu}{\underline{\Phi}}
\newcommand{\mtb}{\textit{Mycobacterium tuberculosis }}
\newcommand{\ppe}{\textit{pe/ppe} }
\newcommand{\etal}{\textit{et al.}}
%%%%%%
%%%%%%%%Theorems with different numbers%%%%%%%%
% \spnewtheorem*{theoremlika}{Theorem 2 (a)}{\bf}{\it}
% \spnewtheorem*{theoremlikb}{Theorem 2 (b)}{\bf}{\it}
% \spnewtheorem*{definitiona}{Definition}{\bf}{\it}
% \spnewtheorem*{example*}{Example}{\it}{\normalfont}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\blockcomment}[1]{}

\usepackage{enumitem}
%%%%%%%%%%

%%%for color citation%%%%%%%%%%%%%%%%%%%
\usepackage{xcolor}
\usepackage{color}
\usepackage{colortbl}
\usepackage{textcomp}
% \usepackage{subcaption}
\usepackage{float}
\usepackage{stfloats}
\usepackage{wrapfig}
\usepackage{multicol}
\usepackage{multirow}
\usepackage{longtable}
\usepackage{bm}
    \setcounter{MaxMatrixCols}{30} % maximum columns in a matrix

\usepackage{tabularx} % better tables
    \setlength{\extrarowheight}{3pt} % increase table row height
\newcommand{\tableheadline}[1]{\multicolumn{1}{l}{\spacedlowsmallcaps{#1}}}
\newcommand{\myfloatalign}{\centering} % to be used with each float for alignment
\newcolumntype{Y}{>{\centering\arraybackslash}X}

\usepackage{lineno}
% \usepackage{epstopdf}
\usepackage{csquotes}
% For paragraphing
\usepackage{setspace}
\onehalfspacing
% Set the indentation size (typically 1.5em to 2em, or about 0.5 inches)
\setlength{\parindent}{1.5em}

% Ensure there is zero extra space added between paragraphs
\setlength{\parskip}{0pt}

\usepackage[style=vancouver,backend=biber,natbib=true, sortcites=true]{biblatex}
%\usepackage[UTF8]{ctex} % Chinese
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%FLOWCHART%%%%%%%%%%%%%%%%
\usepackage{tikz}
\usetikzlibrary{shapes,arrows}
\usetikzlibrary{positioning,shadows,arrows}
\usetikzlibrary{calc}
\definecolor{mycolor}{rgb}{0.2,0.2,0.2}
\definecolor{mygreen}{rgb}{0,0.85,0}
\tikzstyle{input} = [ellipse,draw=black!15, fill=black!15,text width=2em,scale= 0.8, rotate=90, opacity=.4 ,text centered, rounded corners=1mm, minimum height=3.3em,minimum size=1em]
\tikzstyle{input2} = [ellipse,draw=green, fill=black!15,text width=2em,scale= 0.85, rotate=90, opacity=.4 ,text centered, rounded corners=1mm, minimum height=3.4em,minimum size=1.2em]
\tikzstyle{input5} = [ellipse,draw=green, fill=black!15,text width=2em,scale= 0.87, rotate=90, opacity=.4 ,text centered, rounded corners=1mm, minimum height=3.4em,minimum size=1.2em]
\tikzstyle{input4} = [ellipse,draw=green, fill=black!15,text width=2em,scale= 0.87, rotate=90, opacity=.4 ,text centered, rounded corners=1mm, minimum height=3.4em,minimum size=2.4em]
\tikzstyle{input3} = [draw,draw=black!30, fill=white,text width=16.4em,scale= 0.9, text centered, rounded corners=1mm, minimum height=.3em,minimum size=1.1em]
\tikzstyle{input6} = [draw,draw=black, densely dashed,fill=white,text width=17em,scale= 1, opacity=.2, rounded corners=1mm, text centered, minimum height=3em,minimum size=1.1em]
\tikzstyle{line1} = [draw,  color=green, -latex']
\tikzstyle{line2} = [draw,  color=black, -latex']
\tikzstyle{tri} = [draw=black!10, shape border rotate=30, regular polygon, regular polygon sides=3, fill=black!10, scale = .422,node distance=2.5cm, minimum height=2em]
\tikzstyle{tri1} = [draw=black!10, shape border rotate=30, regular polygon, regular polygon sides=3, fill=black!10, scale = .49,node distance=2.5cm, minimum height=2em]
\tikzstyle{trm} = [rectangle,draw=white, fill=white,text width=.3em, scale=.5, text centered, minimum height=1em]
\tikzstyle{crc} = [circle,draw=black!30, fill=white,text width=.3em, scale=.4, text centered, minimum height=1em]
\tikzstyle{trm1} = [rectangle,thin,draw=black!20, fill=white,text width=2.5em, scale=.5, text centered, minimum height=1em]
\tikzstyle{trm2} = [ellipse,draw=green!60, fill=black!10,text width=3.3em, scale=.45 ,text centered, rounded corners=1mm, minimum height=1em]
\tikzstyle{trm3} = [ellipse,draw=green!60, fill=black!10,text width=4em, scale=.45 ,text centered, rounded corners=1mm, minimum height=1em]
\tikzstyle{trm4} = [ellipse,draw=green!60, fill=black!10,text width=5.5em, scale=.41 ,text centered, rounded corners=1mm, minimum height=1em]
\tikzstyle{tra} = [rectangle,draw=white, fill=white,text width=6.1em, scale=.5, text centered, minimum height=1em]
\tikzstyle{tras} = [rectangle,draw=white, fill=white,text width=3em, scale=.5, text centered, minimum height=1em]
\tikzstyle{trat} = [rectangle,draw=white, fill=white,text width=5em, scale=.5,rotate = 90, minimum height=1em]

\tikzstyle{boxisb} = [draw,draw=red!60, fill=white,text width=6em,scale= 0.9, text centered, minimum height=.3em,minimum size=1.1em]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\iffalse

% Align reference numbers so that they do not cause an indent
\newlength\mybibindent
\setlength\mybibindent{0pt}
\makeatletter
\renewenvironment{thebibliography}[1]
    {\chapter*{\bibname}%
     \@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}%
     \list{\@biblabel{\@arabic\c@enumiv}}
          {\settowidth\labelwidth{\@biblabel{999}}
           \leftmargin\labelwidth
            \advance\leftmargin\dimexpr\labelsep+\mybibindent\relax\itemindent-\mybibindent
           \@openbib@code
           \usecounter{enumiv}
           \let\p@enumiv\@empty
           \renewcommand\theenumiv{\@arabic\c@enumiv}}
     \sloppy
     \clubpenalty4000
     \@clubpenalty \clubpenalty
     \widowpenalty4000%
     \sfcode`\.\@m}
    {\def\@noitemerr
      {\@latex@warning{Empty `thebibliography' environment}}
     \endlist}
\makeatother
\fi
