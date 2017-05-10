\ProvidesClass{amivbooklet}[2017/05/02 AMIV Booklet Class]

\LoadClass[9pt]{extarticle}


%% FONT AND COLORS
\RequirePackage{fontspec}
\setmainfont{DINPro}
\setsansfont{DINPro}

\RequirePackage{xcolor}    
\definecolor{copperred}{rgb}{0.910, 0.274, 0.169}
\definecolor{petrolblue}{rgb}{0.122, 0.176, 0.329}


% No Paragraph Indentation in Booklet
\setlength{\parindent}{0pt}


%% LOGOS AND TITLE
\RequirePackage{graphicx}


%% LAYOUT
\RequirePackage[%
% General setup
xetex, a5paper, twocolumn, twoside,%
% Top and Bottom Margins including Footer and Header
top=20mm, headheight=20mm, headsep=10mm, bottom=15mm, footskip=7.5mm,%
% Side Margins
inner=7.5mm, outer=15mm, marginparsep=0mm, marginparwidth=15mm]{geometry}


%% HEADER AND FOOTER
% Helper command to create colored Boxes of fixed Size
\newcommand{\colorpage}[5][black]{% Textcolor (optional), Boxcolor, Width, Height, Content
	\colorbox{#2}{%
		\begin{minipage}[c][#4]{#3}
			\makebox[\textwidth]{\large \color{#1}\textbf{#5}}
		\end{minipage}%
	}%
}
\RequirePackage{fancyhdr}
% Add layout to fancy header
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\newcommand{\headerbox}{\colorpage{petrolblue}{\paperwidth}{10mm}{}}
\fancyhead[OC]{\hspace*{-7.5mm}\headerbox}
\fancyhead[EC]{\hspace*{-15mm}\headerbox}
\fancyfoot[EL, OR]{\textcolor{copperred}{\thepage}}


%% KONTAKT
% Detect odd/even pages
\RequirePackage{changepage}
\newcommand{\rot}{\ifoddpage 90\else -90\fi}

%Use marginnotes to create boxes at the border
\RequirePackage{marginnote}
\newlength{\sideboxheight}
\setlength{\sideboxheight}{2cm}
\newcommand{\sidebox}[3][black]{%  text color (black), box color, text 
	\checkoddpage  % required for \rot to have correct value
	\ifoddpage\hfill\fi% Odd page need filler first
	\colorpage[#1]{#2}{5mm}{\sideboxheight}{\rotatebox{\rot}{#3}}%
	\ifoddpage\else\hfill\ \fi% Even page after box
}
\newcommand{\boothbox}[1]{\marginnote{\sidebox{copperred}{#1}}[0cm]}
\newcommand{\itet}{\marginnote{\sidebox[white]{petrolblue}{ITET}}[\dimexpr 1\sideboxheight + 3em]}
\newcommand{\mavt}{\marginnote{\sidebox[white]{petrolblue}{MAVT}}[\dimexpr 2\sideboxheight + 4em]}
\newcommand{\mtec}{\marginnote{\sidebox[white]{petrolblue}{MTEC}}[\dimexpr 3\sideboxheight + 5em]}

% Internal Variables
\newcommand{\companyname}{}
\newcommand{\companywebsite}{}
\newcommand{\companybooth}{}
\newcommand{\companylogo}{}
\newcommand{\companyboxes}{}
\newcommand{\companycontact}{}
\newcommand{\companyemployees}{}
\newcommand{\companyoffers}{}
\newcommand{\companyabout}{}
\newcommand{\companyfocus}{}

% Provide commands to set company info easily
\newcommand{\name}[1]{\renewcommand{\companyname}{#1}}
\newcommand{\website}[1]{\renewcommand{\companywebsite}{#1}}
\newcommand{\booth}[1]{\renewcommand{\companybooth}{#1}}
\newcommand{\logo}[1]{\renewcommand{\companylogo}{#1}}
\newcommand{\boxes}[1]{\renewcommand{\companyboxes}{#1}}
\newcommand{\contact}[1]{\renewcommand{\companycontact}{#1}}
\newcommand{\employees}[1]{\renewcommand{\companyemployees}{#1}}
\newcommand{\offers}[1]{\renewcommand{\companyoffers}{#1}}
\newcommand{\about}[1]{\renewcommand{\companyabout}{#1}}
\newcommand{\focus}[1]{\renewcommand{\companyfocus}{#1}}

% Create a companypage
\newcommand{\companypage}{%
	% start on new page and switch to onecolumn mode
	\clearpage
	\onecolumn
	% Sidebar
	\boothbox{\companybooth}
	\companyboxes
	% Company Info
	\begin{minipage}[t][0.4\textheight]{0.5\textwidth}
		\textbf{\Large \textcolor{copperred}{\companyname}}\\
		\companywebsite
		\bigbreak
		\textbf{KONTAKT FÜR STUDIERENDE}\\
		\companycontact
		\medbreak
		\textbf{MITARBEITENDE}\\
		\companyemployees
		\medbreak
		\textbf{ANGEBOTE}\\
		\companyoffers
	\end{minipage}%
	% Logo
	\begin{minipage}[t][0.4\textheight]{0.5\textwidth}
		\vspace*{-8pt}  % This is needed to align the logo to the top of the minipage. Why?
		\centering
		\includegraphics[width=\textwidth, height=0.4\textheight, keepaspectratio]{\companylogo}
	\end{minipage}
	
	% Text, use minipage to keep it on one page
	\begin{minipage}[t][0.55\textheight]{\textwidth}
		\textbf{\large \textcolor{copperred}{Über uns}}
		\smallbreak
		\companyabout
		\bigbreak
		\textbf{\large \textcolor{copperred}{Schwerpunkte}}
		\smallbreak
		\companyfocus
	\end{minipage}
	\twocolumn
}


%% FULL PAGE ADVERTISEMENTS
% newgeometry is used to remove margins. Both newgeometry and restoregeometry will add a clearpage
\newcommand{\fullpagead}[1]{% image
	\newgeometry{top=0pt, bottom=0pt, left=0pt, right=0pt}
	\includegraphics[width=\paperwidth, height=\paperheight, keepaspectratio]{#1}
	\restoregeometry
}

% Companies with advertisements, make sure they are on the same double page
% Helper to ensure even page
\def\clearevenpage{\clearpage \ifodd\c@page
	\hbox{}\newpage\hbox{}\newpage\fi}

\newcommand{\companywithadleft}[1]{%
	\clearevenpage
	\fullpagead{#1}
	\companypage
}
\newcommand{\companywithadright}[1]{%
	\clearevenpage
	\companypage
	\fullpagead{#1}
}