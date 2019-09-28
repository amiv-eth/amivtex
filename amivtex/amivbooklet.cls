\ProvidesClass{amivbooklet}[2017/05/02 AMIV Booklet Class]

\LoadClass[9pt]{extarticle}


%% LANGUAGE (polyglossia instead of babel since we are using xetex)

\RequirePackage{polyglossia}
\setmainlanguage[variant=swiss]{german}
\setotherlanguage{english}

% Improve line breaking in the rather narrow columns,
% without being as agressive as \sloppy
\setlength\emergencystretch{3em}\hbadness=10000


%% FOR PRITING

% Define margin that can be cutoff
\newlength\printmargin
\setlength\printmargin{2mm}


%% FONT AND COLORS

\RequirePackage{xcolor}
\definecolor{copperred}{rgb}{0.910, 0.275, 0.169}
\definecolor{petrolblue}{rgb}{0.122, 0.176, 0.329}

\RequirePackage{fontspec}
\setmainfont{DINPro}
\setsansfont{DINPro}


% No Paragraph Indentation in Booklet
\setlength{\parindent}{0pt}


%% PAGELAYOUT

\newlength{\innermargin}
\setlength{\innermargin}{9mm}
\newlength{\outermargin}
\setlength{\outermargin}{18mm}

\RequirePackage[%
% General setup
xetex, a5paper, twoside,%
% Top and Bottom Margin
top=40mm, bottom=20mm, footskip=10mm,%
% Side Margins
inner=\innermargin, outer=\outermargin,%
marginparsep=0mm, marginparwidth=\outermargin%
]{geometry}

% Detect odd/even pages
\RequirePackage{changepage}


%% GRAPHICS AND IMAGES

% Including print margins
\RequirePackage{graphicx}
\usepackage{tikz}


% Check if odd or even page to find correct left and right margins
\newcommand{\leftimagemargin}{%
    \ifoddpage\innermargin\else\outermargin\fi
}
\newcommand{\rightimagemargin}{%
    \ifoddpage\outermargin\else\innermargin\fi    
}

\newcommand*{\fullwidthimage}[1]{%
\end{multicols}
% Pack everything into a box and shift it s.t. it reaches the page border
\checkoddpage\hspace{-\leftimagemargin}%
% Print Margin: Shift needed on even pages
\ifoddpage\else\hspace{-\printmargin}\fi%
\makebox[\dimexpr\paperwidth+\printmargin]{
    \includegraphics[width=\dimexpr\paperwidth+\printmargin]{#1}
}
\vspace{-5mm}  % Adjust whitespace below picture
\iftwocolumn\begin{multicols}{2}\fi
}

\newcommand{\image}[2][]{% [Caption]{Image}
% The image is placed inline, not as a float -- therefore we have to use \par
% to end the current paragraph and again to start a new one after the image.
% Otherwise we get inconsistent newlines and unwanted spacing
\par\vspace{0.5\columnsep}
\checkoddpage
\docolaction{%
    % Left col
    \hspace{\dimexpr-\leftimagemargin-\printmargin}%
    \includegraphics[width=\dimexpr\linewidth+\leftimagemargin+\printmargin]{#2}%
}{%
    % Middle col (not possible in layout, but for completeness)
    \includegraphics[width=\linewidth]{#2}%
}{%
    % Right col    
    \includegraphics[width=\dimexpr\linewidth+\rightimagemargin+\printmargin]{#2}%
}%
% Caption
\ifx#1\empty\else
\vspace{0.25\columnsep}\par
#1
\fi
\vspace{0.5\columnsep}\par
}


%% TITLE PAGE

% Lengths for the title layout
\newlength{\titletopbar}\setlength{\titletopbar}{42mm}
\newlength{\titlebottombar}\setlength{\titlebottombar}{20mm}

% In addition to \title and \date, allow to specify \titleimage and \location
\newcommand{\@titleimage}{example-image}
\newcommand{\titleimage}[1]{\renewcommand{\@titleimage}{#1}}
\newcommand{\@location}{}
\newcommand{\location}[1]{\renewcommand{\@location}{#1}}

% Create the titlepage with tikz
\renewcommand{\maketitle}{%
\begin{titlepage}
\begin{tikzpicture}[remember picture, overlay]
% Featured Image
\node [inner sep=0pt, anchor=south] at ([yshift=\titlebottombar]current page.south)
    {\includegraphics[height=\dimexpr \paperheight-\titletopbar-\titlebottombar]
     {\@titleimage}};
% Blue bar on top, including print margins
\fill [petrolblue] 
    ([xshift=-\printmargin, yshift=\printmargin]current page.north west)
    rectangle ([xshift=\printmargin, yshift=-\titletopbar]current page.north east);
% Top and Bottom Text
\node [anchor=east, align=right, text=white, font=\fontsize{21}{28}\selectfont,
       text width=0.5\paperwidth]
    at ([xshift=-5mm, yshift=-0.5\titletopbar]current page.north east)
    {\addfontfeature{LetterSpace=2.0} \textbf{\@title}};
\node [anchor=east, align=right, text=copperred, font=\huge,
       text width=0.75\paperwidth]
    at ([xshift=-5mm, yshift=0.5\titlebottombar]current page.south east)
    {\@location\\\@date};
% Logos
\node [inner sep=0pt, anchor=north west]
    at ([xshift=-27.5mm, yshift=28mm]current page.north west)
    {\includegraphics[width=90mm]{logo_no_text.pdf}};
\node [inner sep=0pt, anchor=south west]
    at ([xshift=5mm, yshift=5mm]current page.south west)
    {\includegraphics[height=\dimexpr \titlebottombar - 10mm]{logo_text_only.pdf}};
    \end{tikzpicture}
\end{titlepage}
}


%% HEADER AND FOOTER

\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\fancyhead[C]{\begin{tikzpicture}[remember picture, overlay]
    % Blue bar with print margin
    \fill [petrolblue] ([xshift=-\printmargin, yshift=\printmargin]current page.north west)
        rectangle ([xshift=\printmargin, yshift=-10mm]current page.north east);
    \end{tikzpicture}
}
\fancyfoot[EL, OR]{\textcolor{copperred}{\thepage}}


%% MULTICOLUMN LAYOUT

% We need multicol instead of the default twocolumn layout since
% we can't implement layout elements like the fullwidthimage.
% We want to make it invisble TODO
% As a downside, we need special commands to clear pages.
\RequirePackage[colaction]{multicol}

% Twocolumn mode switch
\newif\iftwocolumn

% Helper to close multicol if open https://tex.stackexchange.com/q/39713
\def\closeopenmulticols{%
% test if current env is "multicols" if so close it
    \def\@tempa{multicols}%
    \ifx\@tempa\@currenvir
      \end{multicols}%
    \fi 
}

\renewcommand*{\onecolumn}{\iftwocolumn%
    \closeopenmulticols\twocolumnfalse%
\fi}
\renewcommand*{\twocolumn}{\iftwocolumn\else%
    \twocolumntrue\begin{multicols}{2}
\fi}

% Start twocolumn mode at start of document
\RequirePackage{etoolbox}
\AfterEndPreamble{\twocolumn}

% Close last open multicols at end of document
\AtEndDocument{\closeopenmulticols}

% Start new pages with breaking twocolumn mode properly
% Otherwise multicol can't balance columns right
\newcommand{\nextpage}{%
    \iftwocolumn\closeopenmulticols\clearpage\begin{multicols}{2}
    \else\clearpage\fi
}

% Jump to the next even page
\newcommand*{\filler}{\null}
\newcommand*{\nextevenpage}{%
    \nextpage
    \ifodd\c@page \filler\nextpage\fi
}


%% SECTIONS

% Adjust spacing for subsubsections
% TODO: Not quite working yet, all space above is removed regardless of setting
\RequirePackage{titlesec}  % Important: Load this before section re-definitions
\titlespacing*{\subsubsection}{0pt}{10pt}{0pt}


% Remove all numbering
\setcounter{secnumdepth}{-2}
% Redefine sections to start a new page and place section name as special title
\newcommand*{\@sectionname}{}
\renewcommand*{\section}{%
    % Check for starred version (dont add to TOC)
    \@ifstar{\starsection}{\@dblarg\nostarsection}%
}
\def\nostarsection[#1]#2{% dblarg doesnt work with \newcommand
    \addcontentsline{toc}{section}{#1}%
    \starsection{#2}%
}
\newcommand*{\starsection}[1]{%
    % For each section, interrupt multicol, otherwise it can't balance cols
    \closeopenmulticols
    \clearpage%
    \renewcommand*{\@sectionname}{#1}%
    %\null% Don't skip the page without content
    \thispagestyle{newsection}%
    \iftwocolumn\begin{multicols}{2}\fi
}
% Title is in a header to not influence text body
\newcommand{\sectiontitleheader}[1]{%
\begin{tikzpicture}[remember picture, overlay]
\node [inner sep=0pt, align=left, anchor=west, font=\Large\bfseries]
    at ([xshift=#1, yshift=-25mm]current page.north west)
    {\@sectionname};
\end{tikzpicture}%
}
\fancypagestyle{newsection}{%
    \fancyhead[EL]{\sectiontitleheader{\outermargin}}
    \fancyhead[OL]{\sectiontitleheader{\innermargin}}
}


%% ADDITIONAL PACKAGES

% email
\RequirePackage{hyperref}


%% OPTIONS

\DeclareOption{kontakt}{%
    \input{kontaktbooklet.sty}
}
\DeclareOption{preview}{%
    % Preview footer
    \fancyfoot[EC]{\framebox{VORSCHAU GERADE SEITE -- EVEN PAGE PREVIEW}}
    \fancyfoot[OC]{\framebox{VORSCHAU UNGERADE SEITE -- ODD PAGE PREVIEW}}
}
\ProcessOptions\relax
