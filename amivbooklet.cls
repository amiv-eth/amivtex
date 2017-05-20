\ProvidesClass{amivbooklet}[2017/05/02 AMIV Booklet Class]

\LoadClass[9pt]{extarticle}

%% LANGUAGE (polyglossia instead of babel since we are using xetex)
\RequirePackage{polyglossia}
\setmainlanguage[variant=swiss]{german}

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

\newlength{\innermargin}
\setlength{\innermargin}{9mm}
\newlength{\outermargin}
\setlength{\outermargin}{18mm}

%% LAYOUT
\RequirePackage[%
% General setup
xetex, a5paper, twocolumn, twoside,%
% Top and Bottom Margins including Footer and Header
top=20mm, headheight=20mm, headsep=10mm, bottom=20mm, footskip=10mm,%
% Side Margins
%inner=7.5mm, outer=15mm, marginparsep=0mm, marginparwidth=15mm]{geometry}
inner=\innermargin,% 
outer=\outermargin, marginparsep=0mm, marginparwidth=\outermargin]{geometry}


%% HEADER AND FOOTER
% Helper command to create colored Boxes of fixed Size
\newcommand{\colorpage}[5][black]{% Textcolor (optional), Boxcolor, Width, Height, Content
	\colorbox{#2}{%
		\begin{minipage}[c][#4]{#3}
			\makebox[\textwidth]{\textcolor{#1}{#5}}
		\end{minipage}%
	}%
}
\RequirePackage{fancyhdr}
% Add layout to fancy header
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\newcommand{\headerbox}{\colorpage{petrolblue}{\paperwidth}{10mm}{}}
\fancyhead[OC]{\hspace*{-1\innermargin}\headerbox}
\fancyhead[EC]{\hspace*{-1\outermargin}\headerbox}
\fancyfoot[EL, OR]{\textcolor{copperred}{\thepage}}


%% KONTAKT
% Detect odd/even pages
\RequirePackage{changepage}
\newcommand{\rot}{\ifoddpage 90\else -90\fi}

%Use marginnotes to create boxes at the border
\RequirePackage{marginnote}
\newcommand{\sidebox}[4][black]{%  text color (black), box color, height, text 
	\checkoddpage  % required for \rot to have correct value
	\ifoddpage\hfill\fi% Odd page need filler first
	\colorpage[#1]{#2}{6mm}{#3}{\rotatebox{\rot}{#4}}%
	\ifoddpage\else\hfill\ \fi% Even page after box
}
% Booth
\newlength{\sideboxheight}
\setlength{\sideboxheight}{16mm}
\newcommand{\boothbox}[1]{\marginnote{\sidebox{copperred}{\sideboxheight}{%
\textbf{{\large #1}}
}}[0cm]}

% Interested in (ITET, MAVT, MTEC)
\newcommand{\interestbox}[1]{\sidebox[white]{petrolblue}{\sideboxheight}{%
\textbf{{\large #1}}
}}
\newcommand{\itet}{\marginnote{\interestbox{ITET}}[\dimexpr 1\sideboxheight + 2em]}
\newcommand{\mavt}{\marginnote{\interestbox{MAVT}}[\dimexpr 2\sideboxheight + 3em]}
\newcommand{\mtec}{\marginnote{\interestbox{MTEC}}[\dimexpr 3\sideboxheight + 4em]}

% Offers (fulltime, entry, thesis)
\newlength{\offerboxheight}
\newlength{\offerboxoffset}
\setlength{\offerboxheight}{30mm}
\setlength{\offerboxoffset}{\dimexpr 4\sideboxheight + 6em}

\newcommand{\offerbox}[1]{\sidebox{petrolblue!33}{\offerboxheight}{%
% Use a tabular environment to allow newlines inside box
\begin{tabular}{c}
	#1
\end{tabular}
}}

\newcommand{\fulltimeoffer}[1]{\marginnote{\offerbox{#1}}[\dimexpr 1\offerboxoffset]}
\newcommand{\entryoffer}[1]{\marginnote{\offerbox{#1}}[\dimexpr 1\offerboxoffset + \offerboxheight + 1em]}
\newcommand{\thesisoffer}[1]{\marginnote{\offerbox{#1}}[\dimexpr 1\offerboxoffset + 2\offerboxheight + 2em]}


% Internal Variables
\newcommand{\companyname}{}
\newcommand{\companywebsite}{}
\newcommand{\companybooth}{}
\newcommand{\companylogo}{}
\newcommand{\companyboxes}{}
\newcommand{\companycontact}{}
\newcommand{\companyemployees}{}
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
\newcommand{\about}[1]{\renewcommand{\companyabout}{#1}}
\newcommand{\focus}[1]{\renewcommand{\companyfocus}{#1}}

% Create a companypage
\newcommand{\companypage}{%
	% start on new page and switch to onecolumn mode
	\clearpage
	\onecolumn
	\begin{minipage}[t][\textheight]{\textwidth}  % Keep content on one page
		% Sidebar
		\boothbox{\companybooth}
		\companyboxes
		% Company name and website
		\textbf{\Large \textcolor{copperred}{\companyname}}\\
		\companywebsite\\
		% Company Info
		\begin{minipage}[t]{0.5\textwidth}
			\smallbreak
			{\small \companyemployees}
			\bigbreak
			\textbf{Kontakt für Studierende}\\
			\companycontact
			\bigbreak\medbreak
		\end{minipage}%
		% Logo
		% This minipage has a height to get a minimum height if the comapny info
		% is short
		\begin{minipage}[t][0.2\textheight]{0.5\textwidth}
			%\vspace{0pt}
			\vspace*{-8pt}  % This is needed to align the logo to the top of the minipage. Why?
			\centering
			\includegraphics[width=0.9\textwidth, height=0.2\textheight, keepaspectratio]{\companylogo}
		\end{minipage}
		
		\textbf{\large \textcolor{copperred}{Über uns}}
		\smallbreak
		\companyabout
		\bigbreak\medbreak
		\textbf{\large \textcolor{copperred}{Schwerpunkte}}
		\smallbreak
		\companyfocus	
	\end{minipage}
	\twocolumn

}


%% FULL PAGE ADVERTISEMENTS
% newgeometry is used to remove margins. Both newgeometry and restoregeometry will add a clearpage
% We need to put everything into a minipage, because if the image is too
% large, TeX will sometimes include a uncesseary white page otherwise
\newcommand{\fullpagead}[1]{% image
	\newgeometry{top=0pt, bottom=0pt, left=0pt, right=0pt}
	\begin{minipage}{\paperwidth}
	\includegraphics[width=\paperwidth, height=\paperheight, keepaspectratio]{#1}
	\end{minipage}
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
