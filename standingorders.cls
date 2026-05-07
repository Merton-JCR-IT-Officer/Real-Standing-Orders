\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{standingorders}[2022/06/04 Class for typesetting Standing Orders]

\newif\if@printeddoc\@printeddocfalse
\DeclareOption{print}{\@printeddoctrue}

\newif\if@constitution\@constitutionfalse
\DeclareOption{constitution}{\@constitutiontrue}

\ProcessOptions\relax

\if@printeddoc
\PassOptionsToClass{twoside}{memoir}
\else
\PassOptionsToClass{oneside}{memoir}
\fi

\LoadClass[11pt,a4paper]{memoir}


\RequirePackage{letltxmacro}
\RequirePackage{alphalph}
\RequirePackage[utf8]{inputenc}

\setsecnumdepth{subparagraph}
\setcounter{tocdepth}{1}

\RequirePackage{enumitem}
\setlist[enumerate]{topsep=3pt, parsep=0pt}
\setlist[enumerate,1]{label=\roman*.,align=left,ref=(\roman*)}

\chapterstyle{hangnum}
\renewcommand*{\chaptitlefont}{\huge\bfseries}
\settowidth{\chapindent}{\normalfont\normalsize 9.9.9.9.9}
\addtolength{\chapindent}{6pt}
\newlength\titleindent
\setlength\titleindent{\chapindent}
\setlength{\afterchapskip}{\baselineskip}
\setlength{\beforechapskip}{-\baselineskip}

%\hangsecnum
\setsechook{\setsecnumformat{\llap{\makebox[\titleindent][l]{\csname the##1\endcsname}}}}
\setsubsechook{\setsecnumformat{\llap{\makebox[\titleindent][l]{\csname the##1\endcsname}}}}
\setbeforesecskip{-2ex plus -0.5ex minus -0.2ex}
\setaftersecskip{1.5ex plus 0.2ex}
\setbeforesubsecskip{-1.7ex plus -0.5ex minus -0.2ex}
\setaftersubsecskip{0.9ex plus 0.2ex}
\setsecheadstyle{\Large\bfseries}
\setsubsecheadstyle{\normalsize\bfseries}

\setparaheadstyle{}
\setbeforeparaskip{1.7ex plus 0.5ex minus 0.2ex}
\setafterparaskip{0pt}
\setparahook{\setsecnumformat{\llap{\makebox[\titleindent][l]{\csname the##1\endcsname}}}}


\newcounter{minchapdepth}
\newcounter{maxchapdepth}
\newcounter{minsecdepth}
\newcounter{maxsecdepth}
\newcounter{minssecdepth}
\newcounter{maxssecdepth}



\newcounter{secdepth}
\newcommand{\setsecdepth}[2]{%
	\ifnum\value{#1}=0
		\setcounter{secdepth}{#2}
	\else
		\ifnum\value{#1}=1
			\ifnum\value{#2}>=\value{minchapdepth}
				\ifnum\value{#2}<=\value{maxchapdepth}
					\setcounter{secdepth}{#2}
				\fi
			\fi
		\else
			\ifnum\value{#1}=2
				\ifnum\value{#2}>=\value{minsecdepth}
					\ifnum\value{#2}<=\value{maxsecdepth}
						\setcounter{secdepth}{#2}
					\fi
				\fi
			\else
				\ifnum\value{#1}=3
			
}
\newcommand{\parnumber}{%
	\ifnum\value{secdepth}=0
	\arabic{chapter}.\arabic{section}%
	\else
		\ifnum\value{secdepth}=1
		\arabic{chapter}.\arabic{section}.\arabic{subsection}%
		\else
			\ifnum\value{secdepth}=2
			\arabic{chapter}.\arabic{section}.\arabic{subsection}.\arabic{subsubsection}%
			\else
				\ifnum\value{secdepth}=3
				\arabic{chapter}.\arabic{section}.\arabic{subsection}.\arabic{subsubsection}.\arabic{paragraph}%
				\else
					\ifnum\value{secdepth}=4
					\arabic{chapter}.\arabic{section}.\arabic{subsection}.\arabic{subsubsection}.\arabic{paragraph}.\arabic{subparagraph}%
					\else
						X
					\fi
				\fi
			\fi
		\fi
	\fi%
}

\newcommand{\appparnumber}{%
	\ifnum\value{secdepth}=0
	\Alph{chapter}.\arabic{section}%
	\else
		\ifnum\value{secdepth}=1
		\Alph{chapter}.\arabic{section}.\arabic{subsection}%
		\else
			\ifnum\value{secdepth}=2
			\Alph{chapter}.\arabic{section}.\arabic{subsection}.\arabic{subsubsection}%
			\else
				\ifnum\value{secdepth}=3
				\Alph{chapter}.\arabic{section}.\arabic{subsection}.\arabic{subsubsection}.\arabic{paragraph}%
				\else
					\ifnum\value{secdepth}=4
					\Alph{chapter}.\arabic{section}.\arabic{subsection}.\arabic{subsubsection}.\arabic{paragraph}.\arabic{subparagraph}%
					\else
						X
					\fi
				\fi
			\fi
		\fi
	\fi%
}

\renewcommand{\theparagraph}{\parnumber}
\newcommand{\minzc}[2]{%
	\ifnum#1<\value{#2}
		#1
	\else
		\value{#2}
	\fi%
}

\newcommand{\maxzc}[2]{%
	\ifnum#1>\value{#2}
		#1
	\else
		\value{#2}
	\fi%
}

\LetLtxMacro{\oldchap}{\chapter}
\renewcommand{\chapter}{\setcounter{minchapdepth}{0}\setcounter{maxchapdepth}{4}\setcounter{secdepth}{0}\oldchap}
\LetLtxMacro{\oldsec}{\section}
\renewcommand{\section}{\setcounter{minsecdepth}{\minzc{1}{minchapdepth}}\setcounter{maxsecdepth}{\maxzc{4}{maxchapdepth}}\setcounter{secdepth}{1}\oldsec}
\LetLtxMacro{\oldssec}{\subsection}
\renewcommand{\subsection}{\setcounter{minssecdepth}{\minzc{2}{minsecdepth}}\setcounter{maxssecdepth}{\maxzc{4}{maxsecdepth}}\setcounter{secdepth}{2}\oldssec}

\newcommand{\iteratecount}[1]{%
	\ifnum\value{#1}=0
		\stepcounter{section}
	\else
		\ifnum\value{#1}=1
			\stepcounter{subsection}
		\else
			\ifnum\value{#1}=2
				\stepcounter{subsubsection}
			\else
				\ifnum\value{#1}=3
					\stepcounter{paragraph}
				\else
					\ifnum\value{#1}=4
						\stepcounter{subparagraph}
					\else
						ITERATION ERROR
					\fi
				\fi
			\fi
		\fi
	\fi%	
}

\newcommand{\appiteratecount}[1]{%

	\ifnum\value{#1}=0
		\stepcounter{chapter}
	\else
		\ifnum\value{#1}=1
			\stepcounter{section}
		\else
			\ifnum\value{#1}=2
				\stepcounter{subsection}
			\else
				\ifnum\value{#1}=3
					\stepcounter{subsubsection}
				\else
					\ifnum\value{#1}=4
						\stepcounter{paragraph}
					\else
					    \ifnum\value{#1}=5
						    \stepcounter{subparagraph}
					    \else
						    ITERATION ERROR
						\fi
					\fi
				\fi
			\fi
		\fi
	\fi%	
}



\newcommand{\npara}[1][]{\iteratecount{secdepth}\paragraph{#1}\addtocounter{paragraph}{-1}}

\newcounter{secdepth2}
\setcounter{secdepth2}{\value{secdepth}}
\addtocounter{secdepth2}{0}
%\value{secdepth2} = \value{secdepth}

\newcommand{\appnpara}[1][]{\renewcommand{\theparagraph}{\appparnumber}\iteratecount{secdepth}\paragraph{#1}\addtocounter{paragraph}{-1}}


\renewcommand{\printtoctitle}[1]{\normalfont\Large\textsc {#1}}

\if@printeddoc
\setbinding{20mm}
\fi

\setlrmargins{*}{*}{1}
\setulmarginsandblock{25mm}{30mm}{*}
\checkandfixthelayout

\if@printeddoc
\pagestyle{ruled}
\else
\pagestyle{plain}
\fi
