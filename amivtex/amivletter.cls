\ProvidesClass{amivletter}[2017/05/02 AMIV Letter Class]

% Base is the KOMA-script class scrartcl and the scrletter package
\LoadClass{scrartcl}
\RequirePackage{scrletter}
\RequirePackage{scrdate}
\RequirePackage{scrlayer}  % For footer
\KOMAoptions{%
    foldmarks=false,  % No folding marks
    refline=nodate,  % Date is in location field
    backaddress=plain,  % Don't underline back address
    fontsize=10pt,
}
% Load (customized) swiss letter format
\LoadLetterOption{SNcustom}


% For Kontakt contract titles
\RequirePackage{titlesec}

%% LANGUAGE (polyglossia instead of babel since we are using xetex)

\RequirePackage{polyglossia}
\setmainlanguage[variant=swiss]{german}
\setotherlanguage{english}

% Allow commands to react to current language
\RequirePackage{iflang}
\newcommand{\ifgerman}[2]{\IfLanguageName{german}{#1}{#2}}

%% LOGO

\RequirePackage{graphicx}


%% FONT & COLORS

\RequirePackage{fontspec}
\setmainfont{DINPro}
\setsansfont{DINPro}

\RequirePackage{xcolor}
\definecolor{copperred}{rgb}{0.910, 0.274, 0.169}
\definecolor{petrolblue}{rgb}{0.122, 0.176, 0.329}


%% GENERAL AMIV INFORMATION

\newcommand*{\amivname}{AMIV an der ETH}
\newcommand*{\amivaddress}{Universitätsstrasse 6, CAB E 37}
\newcommand*{\amivpostal}{8092}
\newcommand*{\amivcity}{Zürich}
\newcommand*{\amivphone}{+41 44 632 42 45}
\newcommand*{\amivemail}{info@amiv.ethz.ch}
\newcommand*{\amivlogo}{logo.pdf}

% Provide commands to certain variables (no need to expose koma vars)
\newcommand*{\representative}[1]{\renewcommand*{\@representative}{#1}}
\newcommand*{\email}[1]{\renewcommand*{\@representativeemail}{#1}}
\newcommand*{\signature}[1]{\renewcommand*{\@signature}{#1}}
\renewcommand*{\subject}[1]{\renewcommand*{\@subject}{#1}}

% Defaults for the internal variables
\newcommand*{\@representative}{Pablo}
\newcommand*{\@representativeemail}{\amivemail}
\newcommand*{\@signature}{Pablo}
\renewcommand*{\@subject}{AMIV Letter}


%% INFO BLOCK (the info on the top right of letter)

% Completely custom
\newcommand*{\infoblock}[1]{\renewcommand{\@locationcontent}{#1}}

% AMIV info including representative
\newcommand*{\amivinfoblock}{\renewcommand{\@locationcontent}{%
    \locationitem{\ifgerman{Ihre Ansprechperson}{Your representative}}{\\ \@representative}%
    \bigbreak\noindent
    \locationitem{T}{\amivphone}\\
    \locationitem{E}{\@representativeemail}
    \bigbreak\noindent
    \locationitem{D}{\usekomavar{date}}\\
}}

% AMIV info without representative
\newcommand*{\genericamivinfoblock}{\renewcommand{\@locationcontent}{%
    \vphantom{Ihre Ansprechperson\\Someone}\\
    \bigbreak\noindent
    \locationitem{T}{\amivphone}\\
    \locationitem{E}{\amivemail}
    \bigbreak\noindent
    \locationitem{D}{\usekomavar{date}}\\
}}

% Defaults
\newcommand*{\@locationcontent}{}
\amivinfoblock

% Helper to create formatted and colored items
\newcommand*{\locationitem}[2] {%
    {\color{copperred} #1}\quad #2
}


%% KOMA LETTER CONFIG (using the amiv vars)

\setkomavar{backaddress}{%
    \amivname\ \amivaddress\ \amivpostal\ \amivcity%
}
\setkomavar{signature}{\@signature}
\setkomavar{subject}{\@subject}
\setkomavar{location}{\@locationcontent}

% Signature left handed and with some extra space
\renewcommand*{\raggedsignature}{\raggedright}
\@setplength{sigbeforevskip}{1.5cm}

% Rename of "Anlagen" field depending on language
\let\oldencl\encl  % save original command for patching
\renewcommand{\encl}[1]{
\ifgerman{%
\setkomavar*{enclseparator}{Anlagen}
}{%
\setkomavar*{enclseparator}{Attachments}
}
\oldencl{#1}
}


%% HEADER AND FOOTER

% Helper command to create colored Boxes of fixed Size
\newcommand*{\colorpage}[3]{% Boxcolor, Height, Content
    \colorbox{#1}{%
        \begin{minipage}[c][#2]{\paperwidth}
            #3
        \end{minipage}%
    }%
}

\setkomavar{firsthead}{%
    \colorpage{petrolblue}{3cm}{%
        \hspace{1cm}\includegraphics[height=2cm]{\amivlogo}%
    }
}

\setkomavar{firstfoot}{%
    \colorpage{copperred}{2cm}{\makebox[\paperwidth]{%
        \footnotesize{%
            \amivname \quad \amivaddress
            \quad
            \amivpostal\ \amivcity
            \quad
            \amivphone
            \quad
            \amivemail
        }}
    }
}

% Footer placement on subsequent sides is not so straightforward,
% see https://tex.stackexchange.com/questions/196360/scrlttr2-make-second-page-footer-match-first-page-footer
\DeclareNewLayer[
  align=tl,
  hoffset=\dimexpr.5\paperwidth-.5\useplength{firstfootwidth}\relax,
  voffset=\useplength{firstfootvpos},
  width=\useplength{firstfootwidth},
  height=\dimexpr\paperheight-\useplength{firstfootvpos},
  foreground,
  contents={\parbox{\layerwidth}{\usekomavar{firstfoot}}}
]{myfoot.fg}
\DeclarePageStyleByLayers{amivfoot}{myfoot.fg}
\AtBeginLetter{\pagestyle{amivfoot}}


%% OPTIONS

\DeclareOption{kontakt}{\input{kontakt.sty}}
\DeclareOption{contract}{\input{contract.sty}}
\ProcessOptions\relax
