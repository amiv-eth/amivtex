\ProvidesClass{amivletter}[2017/05/02 AMIV Letter Class]

% Base is the KOMA-script class scrartcl and the scrletter package
\LoadClass{scrartcl}
\RequirePackage{scrletter}
\KOMAoptions{%
	foldmarks=false,  % No folding marks
	refline=nodate,  % Date is in location field
	backaddress=plain,  % Don't underline back address
	fontsize=10pt
}
% Load (customized) swiss letter format
\LoadLetterOption{SNcustom}

%% TITLES
\RequirePackage{titlesec}

%% LANGUAGE (polyglossia instead of babel since we are using xetex)
\RequirePackage{polyglossia}
\setmainlanguage[variant=swiss]{german}

% LOGO
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
\newcommand{\amivrepresentativeemail}{\amivemail}
\newcommand{\amivsignature}{Pablo}
\newcommand{\amivsubject}{AMIV Letter}

% Provide commands to change variables
\newcommand{\representative}[1]{\renewcommand{\amivrepresentative}{#1}}
\newcommand{\email}[1]{\renewcommand{\amivrepresentativeemail}{#1}}
\newcommand{\signature}[1]{\renewcommand{\amivsignature}{#1}}
\renewcommand{\subject}[1]{\renewcommand{\amivsubject}{#1}}  % Is it bad to overwrite \subject?

% Let KOMA use the previously defined commands for each letter
\setkomavar{backaddress}{%
	\amivname\ \amivaddress\ \amivpostal\ \amivcity%
}
\setkomavar{signature}{\amivsignature}
\setkomavar{subject}{\amivsubject}

\newcommand{\locationitem}[2] {% Helper to create formatted and colored items
	{\color{copperred} #1}\quad #2
}
\newcommand{\locationcontent}{%
	\locationitem{Ihre Ansprechperson}{\\ \amivrepresentative}
	\bigbreak\noindent
	\locationitem{T}{\amivphone}\\
	\locationitem{E}{\amivrepresentativeemail}
	\bigbreak\noindent
	\locationitem{D}{\usekomavar{date}}\\
}
\setkomavar{location}{\locationcontent}

% Signature left handed and with some extra space
\renewcommand*{\raggedsignature}{\raggedright}
\@setplength{sigbeforevskip}{1.5cm}

% Rename of "Anlagen" field
\setkomavar*{enclseparator}{Anlagen}

% Helper: Create colored bar
% First arg color, second content
\newcommand{\colorbar}[2] {%
	\colorbox{#1}{\parbox{\paperwidth}{#2}}
}

% Blue bar with logo in head
\setkomavar{firsthead}{%
	\colorbar{petrolblue}{%
		\vspace{0.5cm}
		\hspace{1cm}
		\includegraphics[height=2cm]{\amivlogo}%
		\vspace{0.5cm}%
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
	\vspace{1.36cm}\\  % TODO: This is bad. Should be better
	\hspace*{-\oddsidemargin}\hspace{-1in}%
	\colorbar{copperred}{\centering
		\vspace{0.41cm}
		\footnotesize{%
			\amivname \quad \amivaddress \quad \amivpostal\ \amivcity \quad \amivphone \quad \amivemail
		}
		\vspace{1cm} % bigger than necessary, just to definetly fill the page
	}%
}

%% OPTIONS
\DeclareOption{kontakt}{%
	\input{kontakt.sty}
}
\ProcessOptions\relax
