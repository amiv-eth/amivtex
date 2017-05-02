\ProvidesClass{amivletter}[2017/05/02 AMIV Letter Class]

% Base is the KOMA-script class scrartcl and the scrletter package
\LoadClass{scrartcl}
\RequirePackage{scrletter}


% Default packages needed for german hyphenation
\RequirePackage[ngerman, nswissgerman]{babel}

% Required for logo
\RequirePackage{graphicx}

%% FONT & COLORS
\RequirePackage{fontspec}
\setmainfont{DINPro}
\setsansfont{DINPro}

\RequirePackage{xcolor}    
\definecolor{copperred}{rgb}{0.910, 0.274, 0.169}
\definecolor{petrolblue}{rgb}{0.122, 0.176, 0.329}


%% GENERAL AMIV INFORMATION
\newcommand{\amivname}{AMIV an der ETH}
\newcommand{\amivaddress}{Universitätsstrasse 6, CAB E 37}
\newcommand{\amivpostal}{8092}
\newcommand{\amivcity}{Zürich}
\newcommand{\amivphone}{+41 44 632 42 45}
\newcommand{\amivemail}{info@amiv.ethz.ch}
\newcommand{\amivlogo}{logo.png}

% Letter specific defaults (to avoid manipulation koma vars and normal commands mixed)
\newcommand{\amivrepresentative}{Pablo}
\newcommand{\amivsignature}{Pablo}
\newcommand{\amivsubject}{AMIV Letter}

% Provide commands to change variables
\newcommand{\representative}[1]{\renewcommand{\amivrepresentative}{#1}}
\newcommand{\signature}[1]{\renewcommand{\amivsignature}{#1}}
\renewcommand{\subject}[1]{\renewcommand{\amivsubject}{#1}}  % Is it bad to overwrite \subject?

%% OPTIONS
\DeclareOption{kontakt}{%
	\renewcommand{\amivemail}{kontakt@amiv.ethz.ch}
	\renewcommand{\amivlogo}{kontakt_dark_background.eps}
}
\ProcessOptions\relax

%% KOMA-SCRIPT CONFIG
% Set general options
\KOMAoptions{%
	foldmarks=false,  % No folding marks
	backaddress=plain,  % No underlined backaddress
	refline=nodate,  % Date is in location field
	fontsize=10pt,
}

% Set positions
% Header
\@setplength{firstheadvpos}{1.5cm}
\@setplength{firstheadhpos}{0pt}
\@setplength{firstheadwidth}{\paperwidth}

% First und next Footer
\@setplength{firstfoothpos}{0pt}
\@setplength{firstfootvpos}{26.5cm}
\@setplength{firstfootwidth}{\paperwidth}

% Adress field
\@setplength{toaddrhpos}{2.5cm}
\@setplength{toaddrvpos}{5.5cm}

% Location Field
\@setplength{locvpos}{\useplength{toaddrvpos}}
\@setplength{lochpos}{2cm}
\@addtoplength[0.5]{locvpos}{\useplength{backaddrheight}}
\@setplength{locwidth}{6.5cm}

% Start of text
\@setplength{refvpos}{10cm}
\@setplength{subjectaftervskip}{1.1cm}

% Signature left handed
\renewcommand*{\raggedsignature}{\raggedright}

% Header and footer
% Helper: Create colored bar
% First arg color, second content
\newcommand{\colorbar}[2] {%
	\colorbox{#1}{\parbox{\paperwidth}{#2}}
}

% Blue bar with logo in head
\setkomavar{firsthead}{%
	\colorbar{petrolblue}{%
		\vspace{0.25cm}
		\hspace{20pt}
		\includegraphics[height=2.5cm]{\amivlogo}%
		\vspace{0.25cm}%
	}
}

% Orange bar with general amiv info in foot
\setkomavar{firstfoot}{%
	\vspace{1.8cm}\\
	\colorbar{copperred}{\centering
		\vspace{0.4cm}
		\footnotesize{%
			\amivname \quad \amivaddress \quad \amivpostal\ \amivcity \quad \amivphone \quad \amivemail
		}
		\vspace{1cm} % bigger than necessary, just to definitely fill the page
	}%
}

% Copy content for other footers
\AtBeginLetter{\pagestyle{headings}}
\setkomavar{nextfoot}{%
	\vspace{2.76cm}\\  % TODO: This is bad. Should be better
	\hspace*{-\oddsidemargin}\hspace{-1in}%
	\colorbar{copperred}{\centering
		\vspace{0.4cm}
		\footnotesize{%
			\amivname \quad \amivaddress \quad \amivpostal\ \amivcity \quad \amivphone \quad \amivemail
		}
		\vspace{1cm} % bigger than necessary, just to definetly fill the page
	}%
}

% Location field (to the right of address field)
% Helper to create nicely formatted and colored items
\newcommand{\locationitem}[2] {%
	{\color{copperred} #1}\quad #2
}

% Content of location field
% Create command to make it reusable
\newcommand{\locationcontent}{%
	\locationitem{Ihre Ansprechperson}{\\ \amivrepresentative}
	\bigbreak\noindent
	\locationitem{T}{\usekomavar{fromphone}}\\
	\locationitem{E}{\usekomavar{fromemail}}
	\bigbreak\noindent
	\locationitem{D}{\usekomavar{date}}\\    
}
% Set actual field
\setkomavar{location}{\locationcontent}

% Set Name of "Anlagen" field
\setkomavar*{enclseparator}{Anlagen}


% Set default fields
\setkomavar{fromname}{\amivname}
\setkomavar{fromaddress}{%
	\amivaddress\\
	\amivpostal\ \amivcity%
}
\setkomavar{fromphone}{\amivphone}
\setkomavar{fromemail}{\amivemail}
\setkomavar{signature}{\amivsignature}
\setkomavar{subject}{\amivsubject}

