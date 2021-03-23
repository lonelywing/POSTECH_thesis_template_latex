%% TeX: UTF-8 
%%
%% POSTECH Thesis Template for LaTeX
%%
%% @version      0.6
%% @releasedate  Mar. 2021
%%
%% @author       Junshin Park 박준신
%%               mailto:lonelywing@postech.ac.kr
%%
%% @requirements
%%    current distribution of TeXLive
%%      + ko.TeX
%%
%% 본 템플릿은 학사관리팀의 지원으로 진행되었습니다.
%% 또한, 본 템플릿은 kaist latex Thesis template을 기반으로 작성되었음을 밝힙니다.
%% Sae Hee Ryu의 지원이 한 스푼 들어갔습니다.
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{postech-ucs}%
%       [2020/7/9 v0.6 Standard POSTECH Thesis document class, ko.TeX version]

%% 옵션 설정을 위한 boolean 변수선언
\newif\if@isDoctor
\newif\if@isKorean
\newif\if@isFinal
\newif\if@PDFdoc\@PDFdocfalse
\newif\if@dvips\@dvipsfalse

%% 새 옵션 모음 - doctor|master, korean|english, final|draft
\DeclareOption{doctor} {\@isDoctortrue}
\DeclareOption{master} {\@isDoctorfalse}
\DeclareOption{korean} {\@isKoreantrue}
\DeclareOption{english}{\@isKoreanfalse}
\DeclareOption{final}  {\@isFinaltrue}
\DeclareOption{draft}  {\@isFinalfalse}
\DeclareOption{pdfdoc} {\@PDFdoctrue}
\DeclareOption{dvips}  {\@dvipstrue}

%% leqno,fleqn,openbib 옵션은 그대로 report 클래스에 전달
\DeclareOption{leqno}  {\PassOptionsToClass{leqno}  {report}}
\DeclareOption{fleqn}  {\PassOptionsToClass{fleqn}  {report}}
\DeclareOption{openbib}{\PassOptionsToClass{openbib}{report}}

\ExecuteOptions{doctor,korean,final}         % doctor,korean,final이 기본값
\ProcessOptions

%% 11pt,onecolumn,oneside 옵션으로 report 클래스 불러오기
\LoadClass[11pt,onecolumn,oneside]{report} % ver0.3 : 본문 글자 크기 11pt


%%들여쓰기
\usepackage{indentfirst}
\setlength\parindent{2.0em}

%폰트 Times Roman으로 변경 (Times New Roman은 기본 패키지에 탑재되어 있지 않음.) ver0.5
\renewcommand{\rmdefault}{ptm}

%%zref package is used for page referencing.
\usepackage{refcount}
\usepackage[savepos,totpages,titleref,dotfill,counter,user]{zref}
%\usepackage{zref-thepage}

%\usepackage{tocloft}
%\renewcommand{\cftchapfont}{\rmdefault}

\RequirePackage{ifthen}       % 추가 패키지 설정

%%%% Hangul-ucs preamble.......
\RequirePackage[nonfrench]{dhucs}
%\RequirePackage[default]{dhucs-interword}
\RequirePackage{ifpdf}
\ifpdf
  \def\@drivername{pdftex}
\else
  \def\@drivername{dvipdfmx}
\fi
\if@dvips
  \def\@drivername{dvips}
\fi

%\ifpdf
%  \input glyphtounicode\pdfgentounicode=1
%\fi

\RequirePackage[\@drivername]{graphicx,xcolor}

\if@PDFdoc
  \RequirePackage[unicode,%
      \@drivername=true,%
      bookmarks=true,%
     colorlinks=true,%
   ]{hyperref}
\else
  \RequirePackage[unicode,%
      \@drivername=true,%
      bookmarks=false,%
     colorlinks=false,%
   ]{hyperref}
\fi

%% for compatability to HLaTeX
\let\gt\sffamily
\DeclareTextFontCommand{\textgt}{\gt}
%%%% end of Hangul-ucs preamble

\AtBeginDocument{%                           % \begin{document}와 함께 실행
    \checkparameters                        % 문서 변수가 올바른지 점검
    \if@isFinal                             % final 옵션이 지정되어 있으면
        \makefrontcover \maketitle         % 앞표지, 속표지 생성
        \makeapproval                      % 제출승인서, 심사완료검인 생성
    \else \fi }
\AtEndDocument{}                             % \end{document}와 함께 실행

%% 편집용지 설정 ver0.5
\usepackage[paperheight=257mm,paperwidth=182mm,
			left=25mm,right=25mm,top=35mm,bottom=30mm]{geometry}
%상단여백 20
%하단여백 15
%머리말 15
%꼬리말 15
%왼쪽 25
%오른쪽 25
%top=상단여백+머리말 bottom=하단여백+꼬리말
%용지 사이즈 JIS B5 257X182 (국내 4X6 배판)

%% ver0.2 : blank page 정의
\usepackage{afterpage}
\newcommand\blankpage{%
    \null
    \thispagestyle{empty}%
    \addtocounter{page}{-1}%
    \newpage}

%% 줄간격 설정
%\renewcommand{\baselinestretch}{1.3}
\linespread{1.4}			% ver0.2 : 줄간격 170 이상

%% 본문이 영어로 되어있는지 한글로 되어있는지 설정
\newcommand{\@korean}{korean}
\newcommand{\@english}{english}
\newcommand{\@textlang}{}                    % 텍스트 기본언어 변수선언
\if@isKorean                                 % korean 옵션이 지정되어 있으면
    \let\@textlang\@korean                  % 텍스트 기본언어는 한글
\else                                        % english 옵션이 지정되어 있으면
    \let\@textlang\@english                 % 텍스트 기본언어는 영문
\fi

%% POSTECH 공식 영문명칭
\newcommand{\@postech}{Pohang University of Science and Technology}

%% pagestyle
\def\ps@postech{\let\@mkboth\@gobbletwo
     \let\@oddhead\@empty
     \def\@oddfoot{\reset@font\hfil--\ \thepage\ --
     \hfil}%
     \let\@evenhead\@empty\let\@evenfoot\@oddfoot
}

\pagestyle{postech}

%%
%% 문서 정보 변수 정의
%%

% @command title 논문 제목
% @options [default: (none)]
% - korean: 한글제목 | english: 영문제목
\renewcommand{\title}[2][korean] {%
    \ifthenelse{\equal{#1}{korean}}%
        {\newcommand{\@titleKor}{#2}}{}%
    \ifthenelse{\equal{#1}{english}}%
        {\newcommand{\@titleEng}{#2}}{}%
}
\@onlypreamble{\title}

% @command author 저자 이름
% @param family_name, given_name 성, 이름을 구분해서 입력
% @options [default: (none)]
% - korean: 한글이름 english: 영문이름
\renewcommand{\author}[3][korean] {%
    \ifthenelse{\equal{#1}{korean}}
        {\newcommand{\@authorKorFN}{#2}
         \newcommand{\@authorKorGN}{#3}
         \newcommand{\@authorKor}{#2\ #3}}{}%
    \ifthenelse{\equal{#1}{english}}
        {\newcommand{\@authorEngFN}{#2}
         \newcommand{\@authorEngGN}{#3}
         \newcommand{\@authorEng}{#3 #2}}{}%
}
\@onlypreamble{\author}

% @command advisor 지도교수 이름 (복수가능)
% @options [default: major]
% - major: 주 지도교수  | coopr: 부 지도교수 (공동지도교수 경우)
\newcommand{\advisor}[4][major]{%
    \ifthenelse{\equal{#1}{major}} {%       % 주 지도교수이면
        \newcommand{\@advisorMajorKor}{#2} % 한글이름 저장
        \newcommand{\@advisorMajorEng}{#3} % 영문이름 저장
        % nosign을 명시하지 않으면 주 지도교수가 서명한 것으로 간주
        \ifthenelse{\equal{#4}{nosign}}{}{%
            \newcommand{\@advisorSigned}{\@advisorMajorEng}} }{}%
    \ifthenelse{\equal{#1}{coopr}} {%       % 부 지도교수이면
        \newcommand{\@advisorCooprKor}{#2} % 한글이름 저장
        \newcommand{\@advisorCooprEng}{#3} % 영문이름 저장
        % signed를 명시해야 부 지도교수가 서명한 것으로 간주
        \ifthenelse{\equal{#4}{signed}}{%
            \newcommand{\@advisorSigned}{\@advisorCooprEng}}{} }{}%
}
\@onlypreamble{\advisor}

% @command department
%
\newcommand{\@degreeCode}{}          % 학위 영문코드
\newcommand{\@degreeName}{}          % 학위명
\newcommand{\@parentDeptNameKor}{}      % 학과/전공 첫째줄
\newcommand{\@childDeptNameKor}{}       % 학과/전공 둘째줄
\newcommand{\@parentDeptNameEng}{}      % 학과/전공 첫째줄
\newcommand{\@childDeptNameEng}{}       % 학과/전공 둘째줄
\newcommand{\@programDeptNameEng}{}		%학위명
\newcommand{\@affFullNameKor}{}      % 학과/전공 한글이름
\newcommand{\@affFullNameEng}{}      % 학과/전공 영문이름
\newcommand{\@affFullNameEngCover}{} % 학과/전공 영문이름(표지용)
\newcommand{\@degreeField}{}
\newcommand{\@degreePrefix}{\ifthenelse{\boolean{@isDoctor}}{D}{M}}
\newcommand{\department}[2] {%
    \ifthenelse{\equal{#1}{MA}}
	    {\renewcommand{\@degreeCode}{\@degreePrefix #1}
    	\renewcommand{\@childDeptNameKor}{수학과}
    	\renewcommand{\@childDeptNameEng}{Department of Mathematics}
		\renewcommand{\@programDeptNameEng}{Mathematics}
    	\renewcommand{\@degreeField}{#2}} {}
    \ifthenelse{\equal{#1}{PH}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{물리학과}
         \renewcommand{\@childDeptNameEng}{Department of Physics}
   	    \renewcommand{\@programDeptNameEng}{Physics}
         \renewcommand{\@degreeField}{#2}} {}
    \ifthenelse{\equal{#1}{CH}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{화학과}
         \renewcommand{\@childDeptNameEng}{Department of Chemistry}
         \renewcommand{\@programDeptNameEng}{Chemistry}
         \renewcommand{\@degreeField}{#2}} {}
    \ifthenelse{\equal{#1}{LS}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{생명과학과}
         \renewcommand{\@childDeptNameEng}{Department of Life Sciences}
         \renewcommand{\@programDeptNameEng}{Life Science}
         \renewcommand{\@degreeField}{#2}} {}    	 	
    \ifthenelse{\equal{#1}{MS}}
	    {\renewcommand{\@degreeCode}{\@degreePrefix #1}
    	\renewcommand{\@childDeptNameKor}{신소재공학과}
    	\renewcommand{\@childDeptNameEng}{Department of Material Science and Engineering}
        \renewcommand{\@programDeptNameEng}{Material Science and Engineering}
    	\renewcommand{\@degreeField}{#2}} {}      	
    \ifthenelse{\equal{#1}{ME}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{기계공학과}
         \renewcommand{\@childDeptNameEng}{Department of Mechanical Engineering}
         \renewcommand{\@programDeptNameEng}{Mechanical Engineering}
         \renewcommand{\@degreeField}{#2}} {}      	
    \ifthenelse{\equal{#1}{EE}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{전자전기공학과}
         \renewcommand{\@childDeptNameEng}{Department of Electrical Engineering}
         \renewcommand{\@programDeptNameEng}{Electrical Engineering}
         \renewcommand{\@degreeField}{#2}} {}
    \ifthenelse{\equal{#1}{IME}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{산업경영공학과}
         \renewcommand{\@childDeptNameEng}{Department of Industrial and Management Engineering}
         \renewcommand{\@programDeptNameEng}{Industrial and Management Engineering}
         \renewcommand{\@degreeField}{#2}} {}
     \ifthenelse{\equal{#1}{CSE}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{컴퓨터공학과}
         \renewcommand{\@childDeptNameEng}{Department of Computer Science and Engineering}
         \renewcommand{\@programDeptNameEng}{Computer Science and Engineering}
         \renewcommand{\@degreeField}{#2}} {}
     \ifthenelse{\equal{#1}{CE}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{화학공학과}
         \renewcommand{\@childDeptNameEng}{Department of Chemical Engineering}
         \renewcommand{\@programDeptNameEng}{Chemical Engineering}
         \renewcommand{\@degreeField}{#2}} {}
     \ifthenelse{\equal{#1}{CITE}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{창의IT융합공학과}
         \renewcommand{\@childDeptNameEng}{Department of Creative IT Excellence Engineering}
         \renewcommand{\@programDeptNameEng}{Creative IT Excellence Engineering}
         \renewcommand{\@degreeField}{#2}} {}
     \ifthenelse{\equal{#1}{AMS}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{첨단재료과학부}
         \renewcommand{\@childDeptNameEng}{Division of Advanced Material Science}
         \renewcommand{\@programDeptNameEng}{Advanced Material Science}
         \renewcommand{\@degreeField}{#2}} {}
     \ifthenelse{\equal{#1}{IBB}}
	    {\renewcommand{\@degreeCode}{\@degreePrefix #1}
    	\renewcommand{\@childDeptNameKor}{시스템생명공학과}
    	\renewcommand{\@childDeptNameEng}{Division of Integrative Bioscience and Engineering}
        \renewcommand{\@programDeptNameEng}{Integrative Bioscience and Engineering}
    	\renewcommand{\@degreeField}{#2}} {}
     \ifthenelse{\equal{#1}{IBT}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{융합생명공학과}
         \renewcommand{\@childDeptNameEng}{School of Interdisciplinary Bioscience and Bioengineering}
         \renewcommand{\@programDeptNameEng}{Interdisciplinary Bioscience and Bioengineering}
         \renewcommand{\@degreeField}{#2}} {}
     \ifthenelse{\equal{#1}{ITCE}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{정보전자융합공학과}
         \renewcommand{\@childDeptNameEng}{Division of IT Convergence Engineering}
         \renewcommand{\@programDeptNameEng}{IT Convergence Engineering}
         \renewcommand{\@degreeField}{#2}} {}
    \ifthenelse{\equal{#1}{ANE}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{첨단원자력공학과}
         \renewcommand{\@childDeptNameEng}{Division of Advanced Nuclear Science}
         \renewcommand{\@programDeptNameEng}{Advanced Nuclear Science}
         \renewcommand{\@degreeField}{#2}} {}
     \ifthenelse{\equal{#1}{EV}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{환경공학과}
         \renewcommand{\@childDeptNameEng}{School of Environmental Science and Engineering}
         \renewcommand{\@programDeptNameEng}{Environmental Science and Engineering}
         \renewcommand{\@degreeField}{#2}} {}
    \ifthenelse{\equal{#1}{TIM}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{기술경영공학과}
         \renewcommand{\@childDeptNameEng}{Graduate Program for Technology and Innovation Managment}
         \renewcommand{\@programDeptNameEng}{Technology and Innovation Managment}
         \renewcommand{\@degreeField}{#2}} {}
    \ifthenelse{\equal{#1}{WE}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{풍력특성화과정}
         \renewcommand{\@childDeptNameEng}{Graduate School of Wind Energy}
         \renewcommand{\@programDeptNameEng}{Wind Energy}
         \renewcommand{\@degreeField}{#2}} {}
    \ifthenelse{\equal{#1}{GIFT}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{철강대학원}
         \renewcommand{\@childDeptNameEng}{Graduate Institute of Ferrous Technology}
         \renewcommand{\@programDeptNameEng}{Ferrous Technology}
         \renewcommand{\@degreeField}{#2}} {}
    \ifthenelse{\equal{#1}{GEM}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{엔지니어링특성화대학원}
         \renewcommand{\@childDeptNameEng}{Graduate School of Engineering Mastership}
         \renewcommand{\@programDeptNameEng}{Engineering Mastership}
         \renewcommand{\@degreeField}{#2}} {}
    \ifthenelse{\equal{#1}{OSTI}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{해양대학원}
         \renewcommand{\@childDeptNameEng}{Ocean Science and Technology Institute}
         \renewcommand{\@programDeptNameEng}{Ocean Science and Technology}
         \renewcommand{\@degreeField}{#2}} {}


    \renewcommand{\@affFullNameKor}{%               % 학과/전공 한글이름
    	\ifthenelse{\equal{\@parentDeptNameKor}{}}
    		{\@childDeptNameKor}
    		{\@parentDeptNameKor, \@childDeptNameKor}
    }
    \renewcommand{\@affFullNameEng}{%               % 학과/전공 영문이름
        	\ifthenelse{\equal{\@parentDeptNameEng}{}}
    		{\@childDeptNameEng}
    		{\@parentDeptNameEng, \@childDeptNameEng}
    }

    \renewcommand{\@affFullNameEngCover}{%          % 학과/전공 영문이름
        	\ifthenelse{\equal{\@parentDeptNameEng}{}}
    		{\@childDeptNameEng}
    		{\@parentDeptNameEng \\ \@childDeptNameEng}
    }
    \renewcommand{\@degreeName}{%                       % 학위 영문이름
        \ifthenelse{\boolean{@isDoctor}}
            {Doctor of Philosophy} {%                 % 박사는 모두 Ph.D.
            \ifthenelse{\equal{\@degreeField}{science}}
                {Master of Science}{}%               % 이학석사는 M.S.
            \ifthenelse{\equal{\@degreeField}{engineering}}
                {Master of Science}{}%           % 공학석사는 M.E.
%            \ifthenelse{\equal{\@degreeField}{business}}
%                {Master of Business Administration}{}% 경영학석사는 M.B.A.
        }
    }
}
\@onlypreamble{\department}

% @command studentid 학번
\newcommand{\studentid}[1]{\newcommand{\@studentID}{#1}}
\@onlypreamble{\studentid}

% @command referee 심사위원 (석사과정 3인, 박사과정 5인)
\newcommand{\referee}[2][1] {%
    \ifthenelse{\equal{#1}{1}}{\newcommand{\@refereeChief} {#2}} {}%
    \ifthenelse{\equal{#1}{2}}{\newcommand{\@refereeSecond}{#2}} {}%
    \ifthenelse{\equal{#1}{3}}{\newcommand{\@refereeThird} {#2}} {}%
    \ifthenelse{\equal{#1}{4}}{\newcommand{\@refereeFourth}{#2}} {}%
    \ifthenelse{\equal{#1}{5}}{\newcommand{\@refereeFifth} {#2}} {}%
}
\@onlypreamble{\referee}

% @command approvaldate 지도교수논문승인일
% @param year,month,day 연,월,일 순으로 입력
\newcommand{\approvaldate}[3] {%
    \newcommand{\@approvalYear}{#1}
    \newcommand{\@approvalMonth}{#2}
    \newcommand{\@approvalDay}{#3}
}
\@onlypreamble{\approvaldate}

% @command refereedate 심사위원논문심사일
% @param year,month,day 연,월,일 순으로 입력
\newcommand{\refereedate}[3] {%
    \newcommand{\@refereeYear}{#1}
    \newcommand{\@refereeMonth}{#2}
    \newcommand{\@refereeDay}{#3}
}
\@onlypreamble{\refereedate}

% @command gradyear 졸업년도
\newcommand{\gradyear}[1]{\newcommand{\@gradYear}{#1}}
\@onlypreamble{\gradyear}

%%
%% 필요한 정보 중에 누락된 것이 없는지 점검 --> 제작중. 아직 불완전.
%%
\newcommand{\checkparameters}{%
    \@ifundefined{@titleKor}{%
        \ClassError{postech}{The korean title is not found}{}}{}
    \@ifundefined{@titleEng}{%
        \ClassError{postech}{The english title is not found}{}}{}
    \@ifundefined{@authorKor}{%
        \ClassError{postech}{The korean name of the author is not found}{}}{}
    \@ifundefined{@authorEng}{%
        \ClassError{postech}{The english name of the author is not found}{}}{}
    \@ifundefined{@advisorMajorKor}{%
        \ClassError{postech}{The korean name of the major advisor is not found}{}}{}
    \@ifundefined{@advisorMajorEng}{%
        \ClassError{postech}{The english name of the major advisor is not found}{}}{}
}

%%
%% 앞표지 생성
%%
\newcommand{\makefrontcover}{%
    \renewcommand{\baselinestretch}{1.3}%
   \thispagestyle{empty} \noindent%
    \begin{minipage}[t][][t]{\textwidth}
   		\vspace{2mm}
        \begin{center}
            \huge
            \if@isDoctor
                \fontsize{16pt}{16pt}\selectfont Doctoral Dissertation \\
            \else
                \fontsize{16pt}{16pt}\selectfont Master's Thesis \\
            \fi
			\vspace{23mm}
            \fontsize{21pt}{21pt}\selectfont \@titleEng
        \end{center}
    \end{minipage}\vfill%\\[30mm]
\thispagestyle{empty} \noindent%
    \begin{minipage}[b][][b]{\textwidth}
        \begin{flushleft}
        	\hspace{54.2pt}\@ifundefined{@authorKor}{
	        	\fontsize{16pt}{9mm}\selectfont \@authorEng\\}
		        {\fontsize{16pt}{9mm}\selectfont \@authorEng\ (\@authorKor)\\}
            \hspace{54.2pt}\@affFullNameEngCover \\
			\hspace{54.2pt}\@postech \\
			\hspace{54.2pt}\@gradYear
        \end{flushleft}
    \end{minipage}
%    \afterpage{\null\thispagestyle{empty}\newpage}           % ver0.2 : 첫 장 백색별지 추가 (지침사항은 아님)
    \newpage   
}

%%
%% 속표지 생성
%%
\renewcommand{\maketitle}{%
    \renewcommand{\baselinestretch}{1.3}%
    \thispagestyle{empty} \noindent
	%\\[0mm]
    \begin{minipage}[t][][t]{\textwidth}
	    \vspace{9mm}
        \begin{center}
            \fontsize{21pt}{21pt}\selectfont  \@titleKor \\
            \vspace{21pt}       % ver0.2 : 제목 줄간격
            \@titleEng
        \end{center}
    \end{minipage}
    \newpage
}

%%
%% 학위논문 제출승인서 및 심사완료 검인서 생성
%%
\newcommand{\makeapproval}{%
    % 학위논문 제출승인서
    \renewcommand{\baselinestretch}{1.3}
%    \hyphenation{institute department division program} % word division 방지
    \thispagestyle{empty} \noindent
   	\vspace{10mm}
    \begin{minipage}[t][][t]{\textwidth}
        \begin{center}
            \fontsize{21pt}{21pt}\selectfont \@titleEng \\
         \end{center}
    \end{minipage}
\vfill
    \thispagestyle{empty} \noindent
    \begin{minipage}[b][][b]{\textwidth}
        \begin{center}
	\Large by \\ \vspace{\baselineskip}
            \@authorEngGN \ \@authorEngFN \\  % 저자 영문이름
            \@affFullNameEngCover \\         % 학과/전공명 (표지용)
            \@postech                          % 학교명 POSTECH
\\ \vspace{\baselineskip}
    		\Large
    		\if@isDoctor
				A dissertation submitted to the faculty of the \@postech\ in partial fulfillment of the requirements for the degree of Doctor of Philosophy in the \@programDeptNameEng
            \else
				A thesis submitted to the faculty of the \@postech\ in partial fulfillment of the requirements for the degree of \@degreeName in the \@programDeptNameEng
            \fi
\\ \vspace{3\baselineskip}
            \Large
			Pohang, Korea \\
	        \@approvalMonth. \@approvalDay. \@approvalYear  \\ % 제출승인일자
	        Approved by \\
			 % 학위논문 지도교수 영문이름, 단독지도교수일 경우만 가정.
             \@advisorMajorEng \ (Signature) \\
%            \@advisorMajorEng \ \textcolor{white}{(Signature)} \\ % ver0.2 : 서명란 글씨 흰색 (인쇄용)
			Academic advisor
        \end{center}
    \end{minipage}

      % 학위논문 심사완료 검인서
    \newpage 
    \thispagestyle{empty} \noindent
    \begin{minipage}[t][][t]{\textwidth}
        \begin{center}
		\fontsize{21pt}{21pt}\selectfont \@titleEng \\          % 학위논문 한글제목
        \end{center}
    \end{minipage}
\vfill
\noindent
    \begin{minipage}[b][][b]{\textwidth}
        \begin{center}
		\LARGE \@authorEng \\ \vspace{\baselineskip}
        	\Large The undersigned have examined this \ifthenelse{\boolean{@isDoctor}}{dissertation}{thesis} and hereby certify that it is worthy of acceptance for a \ifthenelse{\boolean{@isDoctor}}{doctoral}{master's} degree from POSTECH \vspace{2\baselineskip}
        \end{center}

        \begin{flushright}
		\Large
		\@refereeMonth. \@refereeDay. \@refereeYear \\ \vspace{2\baselineskip}
	\begin{tabular}{r c r}   % 심사위원명단
                \@ifundefined{@refereeChief}{}
                    {\\[4pt] Committee Chair & \ \makebox[\width]{\@refereeChief}  & \ (Seal)}
                \@ifundefined{@refereeSecond}{}
                    {\\[4pt] Member   & \ \makebox[\width]{\@refereeSecond} & \ (Seal)}
                \@ifundefined{@refereeThird}{}
                    {\\[4pt] Member   & \ \makebox[\width]{\@refereeThird}  & \ (Seal)}
                \@ifundefined{@refereeFourth}{}
                    {\\[4pt] Member   & \ \makebox[\width]{\@refereeFourth} & \ (Seal)}
                \@ifundefined{@refereeFifth}{}
                    {\\[4pt] Member   & \ \makebox[\width]{\@refereeFifth} & \ (Seal)}
            \end{tabular}
        \end{flushright}
    \end{minipage}
    \hfill \newpage
}

%%
%% 초록(abstract)페이지 생성
%%
\newcounter{pagemarker}                           % 페이지 번호 임시 저장용
\newcommand{\@lastPage}{\pageref{paperlastpagelabel}} % 총 페이지 수 계산용
\renewenvironment{abstract}{%
    %\thispagestyle{plain}
    \thispagestyle{postech}
    \pagenumbering{Roman}                        % 로마자 페이지 시작
    \newcommand{\@tempbreak}{}                   % \linebreak 명령 보관용
    \let\@tempbreak\linebreak
    \renewcommand{\linebreak}{\ }                % \linebreak -> 공백 대체
    \newlength{\@thesisinfowidth}
    \setlength{\@thesisinfowidth}{\textwidth}    % 논문정보박스 사이즈는
    \addtolength{\@thesisinfowidth}{-30mm}       % 텍스트 폭보다 30mm 작게
    \noindent
%    \\[10mm]
    \parbox[t]{30mm}{\large \@degreeCode \\ \@studentID}% 왼쪽박스
    %\raisebox{3pt}
    {\begin{minipage}[t]{\@thesisinfowidth}
        %\normalsize \sffamily
	    \large
        \ifthenelse{\equal{\@authorKorFN}{}}
        {}
        {\@authorKorFN\ \@authorKorGN}           % 저자 한글이름
        \@authorEngGN\ \@authorEngFN \\           % 저자 영문이름
        \@titleEng.  \\
	    \@titleKor.  \\                 % 학위논문 영문 및 한글제목
        \@affFullNameEng, \@gradYear,           % 학과/전공명, 졸업년도
        \@lastPage p\\                            % 총 페이지 수 -> 참고문헌 끝
        \@ifundefined{@advisorCooprEng}         % 공동지도교수 유무판정
            {Advisor : ~\@advisorMajorEng.} % 단독지도교수 영문이름
            {Advisor : ~\@advisorCooprEng.}
%%            {Advisors : ~\@advisorMajorEng, % 공동 주 지도교수 영문이름
%%             Prof.~\@advisorCooprEng.}         % 공동 부 지도교수 영문이름
        \ifthenelse{\boolean{@isKorean}}
            {}{\\Text in English.}               % 본문이 영어인 경우 명시
    \end{minipage}}\\[17mm]
    \begin{center} \Large \textbf{ABSTRACT} \end{center}      % 초록명 -> Abstract
    \vspace{8mm}
    \hspace*{5mm}
%  \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{content}{\abstractname}% 초록을 목차(TOC)에 삽입
    \fontsize{11pt}{19pt}\selectfont
}
{
%	  \label{pg:abstractLastPage}  
	  \newpage
  	  \setcounter{pagemarker}{\value{page}}
	  
     %\pagenumbering{Roman}
%\pagenumbering{arabic}              % 페이지 아라비아 숫자 포맷
\let\linebreak\@tempbreak                    % \linebreak 명령 복원
%    \afterpage{\blankpage}                      % % ver0.2 : 초록 이후 백색별지
}

%%
%% 목차 일괄 생성
%%
\newcommand{\makecontents}{%            % TOC, LOT, LOF 생성
    \tableofcontents
    \listoftables
    \listoffigures
}

%%%% 부록 section을 위한...
\renewenvironment{appendix}{
	\setcounter{chapter}{0}
	\renewcommand{\thechapter}{\Alph{chapter}}
	\renewcommand{\thesection}{\Alph{chapter}.\arabic{section}} %ex) A.1
	\renewcommand{\thefigure}{\Alph{chapter}.\arabic{figure}} %ex) A.1
	\renewcommand{\thetable}{\Alph{chapter}.\arabic{table}} %ex) A.1
	\renewcommand{\theequation}{\Alph{chapter}.\arabic{equation}} %ex) A.1
}
%%%%


%%
%% 한글요약문 생성 - 영문논문의 경우만 해당
%%
\newenvironment{summary}{%              % 요약문 생성 환경
    \thispagestyle{postech}               % ver0.2 : 국문 요약문 쪽번호 유지
    \newcommand{\@tempbreak}{}
    \let\@tempbreak\linebreak
    \renewcommand{\linebreak}{\ }      % \linebreak 명령 바꿔치기
    \if@isKorean
    \else
        \chapter*{Summary}
        \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{chapter}{\rmfamily{Summary (in Korean)}}
        \begin{quote}
            \begin{center}
                \noindent \textsf{\Large \@titleEng} \\[6mm]
            \end{center}
        \end{quote}% \setlength{\parindent}{0pt}
    \fi
}{  \let\linebreak\@tempbreak          % \linebreak 명령 되돌리기
}

\newcommand{\summarykorean}{%           % ver 0.1 요약문 생성 명령
    \renewcommand{\linebreak}{\ }      % 차후 버젼에서 삭제 예정
   	\setlength{\parindent}{10pt}
    \ifx\@textlang\@english
        \chapter*{요 약 문}
        \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{chapter}{\rmfamily{Summary (in Korean)}}
        \fontsize{11pt}{19pt} \selectfont
%        \begin{center}
%            \noindent\textsf{\Large \@titleKor} \\[6mm]
%        \end{center}% \setlength{\parindent}{0\p@}
    \fi
}

%%
%% 감사의 글 및 이력서 생성
%%
\newcommand{\acknowledgement}[1][default]{%     % 이력서
   % \thispagestyle{empty} \noindent             % ver0.2 : 쪽 번호없음
	\setlength{\parindent}{10pt}
    \newcommand{\@acklang}{#1}
    \ifthenelse{\equal{#1}{default}}            % 아무 옵션을 설정하지 않으면
        {\let\@acklang\@textlang}{}           % 논문 언어대로 이력서 언어설정
%    \ifthenelse{\equal{\@acklang}{\@korean}}
%        {\chapter*{감 사 의 글}}                 % korean  옵션일 경우
        {\chapter*{Acknowledgements}}         % english 옵션일 경우
}

\newcommand{\curriculumvitae}[1][default]{%     % 이력서
    \thispagestyle{empty} \noindent             % ver0.2 : 쪽 번호없음
%    \newcommand{\@ccvlang}{#1}
%    \ifthenelse{\equal{#1}{default}}            % 아무 옵션을 설정하지 않으면
%        {\let\@ccvlang\@textlang}{}           % 논문 언어대로 이력서 언어설정
%    \ifthenelse{\equal{\@ccvlang}{\@korean}}
%        {\chapter*{이 력 서}}                 % korean  옵션일 경우
        {\chapter*{Curriculum Vitae}}         % english 옵션일 경우
}

%%
%% 이력서 내부 요소 생성
%%
    \newenvironment{personaldata}{%            % 개인정보
        \thispagestyle{empty}               % ver0.2 : 쪽 번호없음
        \begin{list}{}{%
            \setlength{\labelwidth}{70pt}
            \setlength{\leftmargin}{\labelwidth}
            \addtolength{\leftmargin}{\labelsep}
            \setlength{\parsep}{0pt}
            \renewcommand{\makelabel}[1]{\textgt{##1\ \ :\ }}}
        \newcommand{\name}[1]{%               % 이름
            \ifx\@ccvlang\@korean
                \def\@arg{[이\hfill름]}
            \else
                \def\@arg{[Name\hfill]}
            \fi
            \expandafter\item\@arg ##1}
        \newcommand{\dateofbirth}[3]{%        % 생년월일
            \ifx\@ccvlang\@korean
                \def\@arg{[생\hfill년\hfill월\hfill일]}
                \expandafter\item\@arg ##1년 ##2월 ##3일
            \else
                \def\@arg{[Date of Birth\hfill]}
                \expandafter\item\@arg \@dateUSenglish{##1}{##2}{##3}
            \fi }
        \newcommand{\birthplace}[1]{%         % 출생지
            \ifx\@ccvlang\@korean
                \def\@arg{[출\hfill생\hfill지]}
            \else
               \def\@arg{[Birthplace\hfill]}
           \fi
           \expandafter\item\@arg ##1}
        \newcommand{\domicile}[1]{%           % 본적지
            \ifx\@ccvlang\@korean
                \def\@arg{[본\hfill적\hfill지]}
            \else
                \def\@arg{[Domicile\hfill]}
            \fi
            \expandafter\item\@arg ##1}
        \newcommand{\address}[1]{%            % 주소지
            \ifx\@ccvlang\@korean
                \def\@arg{[주\hfill소]}
            \else
                \def\@arg{[Address\hfill]}
            \fi
            \expandafter\item\@arg ##1}
        \newcommand{\email}[1]{%              % E-mail
            \ifx\@ccvlang\@korean
                \def\@arg{[E-mail\hfill주\hfill소]}
            \else
                \def\@arg{[E-mail\hfill]}
            \fi
          \expandafter\item\@arg ##1}
        %이력서에 집어넣을 추가 필드가 필요하면 위를 참고하여 만들어 쓸 것.
        %\newcommand{(필드명령)}[1]{%
        %   \ifx\@ccvlang\@korean
        %       \def\@arg{[(한글필드명)]}
        %   \else
        %       \def\@arg{[(영문필드명)]}
        %   \fi
        %   \expandafter\item\@arg ##1}
    }{\end{list}}

    \newenvironment{education}{%               % 학력
        \thispagestyle{empty}   
        \vspace*{10mm} \noindent
%        \ifx\@ccvlang\@korean
%            \begin{center}
%                \makebox[2cm][s]{\textbf{\large 학 력}}
%            \end{center}
%        \else \textbf{\large Educations} \fi
		\begin{center}\large\textbf{Education}\end{center}
		\vspace{3mm}
        \begin{list}{}{%
            \setlength{\labelwidth}{95pt}
            \setlength{\leftmargin}{\labelwidth}
            \addtolength{\leftmargin}{\labelsep}
            \setlength{\parsep}{0pt}
            \renewcommand{\makelabel}[1]{\textgt{##1\hfill\ }}}
    }{\end{list}}

    \newenvironment{experience}{%                  % 경력
        \thispagestyle{empty}              % ver0.2 : 쪽 번호없음
        \vspace*{10mm} \noindent           % ver0.2 : 줄 간격 조정
%        \ifx\@ccvlang\@korean
%            \begin{center}
%                \makebox[2cm][s]{\textbf{\large 경 력}}
%            \end{center}
%        \else \textbf{\large Career} \fi
		\begin{center}\large\textbf{Experience}\end{center}
		\vspace{3mm}
        \begin{list}{}{%
            \setlength{\labelwidth}{95pt}
            \setlength{\leftmargin}{\labelwidth}
            \addtolength{\leftmargin}{\labelsep}
            \setlength{\parsep}{\z@}
            \renewcommand{\makelabel}[1]{\textgt{##1\hfill\ }}}
    }{\end{list}}

    \newcounter{itemnum1}
    \newenvironment{affiliation}{%                % 학회활동
        \thispagestyle{empty}               	% ver0.2 : 쪽 번호없음
        \vspace*{10mm} \noindent		% ver0.2 : 줄 간격 조정            
%        \ifx\@ccvlang\@korean
%            \begin{center}
%                \makebox[2cm][s]{\textbf{\large 학 회 활 동}}
%            \end{center}
%        \else \textbf{\large Academic Activities} \fi
		\begin{center}\large\textbf{Affiliation}\end{center}
		\vspace{3mm}
        \begin{list}{}{%
            \usecounter{itemnum1+1}
            \setlength{\labelwidth}{95pt}
            \setlength{\leftmargin}{\labelwidth}
            \addtolength{\leftmargin}{\labelsep}
            \setlength{\parsep}{\z@}
%            \renewcommand{\makelabel}{\textgt{\arabic{itemnum1}.\ }}}
            \renewcommand{\makelabel}[1]{\textgt{##1\hfill\ }}}
    }{\end{list}}

%    \newcounter{itemnum2}
%    \newenvironment{publication}{%             % 연구업적
%        \vspace*{5mm} \noindent
%        \ifx\@ccvlang\@korean
%            \begin{center}
%                \makebox[2cm][s]{\textbf{\large 연 구 업 적}}
%            \end{center}
%        \else \textbf{\large Publications} \fi
%        \begin{list}{}{%
%            \usecounter{itemnum2}
%            \setlength{\labelwidth}{1.5em}
%            \setlength{\leftmargin}{\labelwidth}
%            \addtolength{\leftmargin}{\labelsep}
%            \setlength{\parsep}{\z@}
%            \renewcommand{\makelabel}{\textgt{\arabic{itemnum2}.\ }}}
%    }{\end{list}}

%%
%% 헤딩 재설정
%%
\renewcommand{\contentsname}{%
    \if@isKorean 목 차       \else Contents        \fi}
\renewcommand{\listfigurename}{%
    \if@isKorean 그 림 목 차 \else List of Figures \fi}
\renewcommand{\listtablename}{%
    \if@isKorean 표 목 차    \else List of Tables  \fi}
\renewcommand{\bibname}{%
    \if@isKorean 참 고 문 헌 \else References      \fi}

%%%
%%% \part 재정의 - 아예 쓰지 못하게 막아버림. 이 명령을 호출하면 에러 발생.
%%%
\renewcommand\part{%
    \secdef\@part\@spart}
\def\@part[#1]#2{%
    \ClassError{postech}{The use of \protect\part\space is prohibited.
        \MessageBreak Consider the use of \protect\chapter\space instead}{}
}
\def\@spart#1{%
    \ClassError{postech}{The use of \protect\part\space is prohibited.
        \MessageBreak Consider the use of \protect\chapter\space instead}{}
}

%%
%% \chapter 재정의 - report 클래스로부터 복사하여 일부 수정
%%

\renewcommand{\thechapter}{\Roman{chapter}} %Enumerate chapter as Roman number
%\renewcommand{\thechapter}{\Roman{part}} %Enumerate chapter as Roman number
%\renewcommand{\thechapter}{\arabic{chapter}} %Enumerate chapter as Roman number
\renewcommand{\thesection}{\arabic{chapter}.\arabic{section}} %Enumerate section as arabic number
\renewcommand{\thefigure}{\arabic{chapter}.\arabic{figure}} 	% ver0.2 : figure 번호를 아라비아 숫자로 표기
\renewcommand{\thetable}{\arabic{chapter}.\arabic{table}}	% ver0.2 : table 번호를 아라비아 숫자로 표기	
\renewcommand{\theequation}{\arabic{chapter}.\arabic{equation}}

\renewcommand\chapter{%
    \if@openright\cleardoublepage\else\clearpage\fi
%   \thispagestyle{plain}%
    \global\@topnum\z@
    \@afterindentfalse
%   \if@isKorean \parindent\z@ \else \fi % <-- 추가할지 여부 고민중
    \secdef\@chapter\@schapter}

\def\@chapter[#1]#2{%
    \ifnum \c@secnumdepth >\m@ne
        \refstepcounter{chapter}%
        \typeout{\@chapapp\space\thechapter.}%
        \addcontentsline{toc}{chapter}{%
        \protect \rmfamily{\numberline{\thechapter.}}#1
        }% <-- 목차에 나타나는 형식 - 변경사항
    \else
       \addcontentsline{toc}{chapter}{#1}%
%       \addcontentsline{toc}{}{#1}%
    \fi
    \chaptermark{#1}%
    \addtocontents{lof}{\protect\addvspace{10\p@}}%
    \addtocontents{lot}{\protect\addvspace{10\p@}}%
    
    \if@twocolumn
        \@topnewpage[\@makechapterhead{#2}]%
    \else
        \@makechapterhead{#2}%
        \@afterheading%
    \fi
}
\def\@makechapterhead#1{% <-- 전체 변경
    \vspace*{10\p@}
    {\centering \parindent\z@ \LARGE\bfseries
    %{\centering \parindent\z@ \LARGE\bfseries
%    \ifthenelse{\equal{\@textlang}{korean}}
%        {제\hspace{1.4ex}\thechapter\hspace{1.4ex}장\hspace{2ex}}
%        {Chapter\hspace{1.4ex}\thechapter.\hspace{1ex}}
%        {\thechapter.\hspace{1ex}}
    \thechapter.\hspace{1ex}
	#1\par}
    \vspace*{20\p@}
}
\def\@schapter#1{%
    \if@twocolumn
        \@topnewpage[\@makeschapterhead{#1}]%
    \else
        \@makeschapterhead{#1}%
        \@afterheading
    \fi}
\def\@makeschapterhead#1{% <-- 전체 변경
    \vspace*{10\p@}
    {\centering \parindent\z@ \LARGE\bfseries #1\par}
    \vspace*{20\p@}
}

%%
%% \tableofcontents 재정의 - report 클래스로부터 복사하여 일부 수정
%%
\renewcommand\tableofcontents{%
	%\thispagestyle{plain}
	\thispagestyle{postech}
    \pagenumbering{Roman}                        % 로마자 페이지 시작
    \if@twocolumn
        \@restonecoltrue\onecolumn
    \else
        \@restonecolfalse
    \fi
	\chapter*{\contentsname
        \@mkboth{\MakeUppercase\contentsname}{\MakeUppercase\contentsname}}%
%   \pagenumbering{arabic}                         % Roman 페이지번호로 복원

%    \addtocounter{pagemarker}{1}
% 	\setcounterpageref{page}{pg:abstractLastPage}
%	\addtocounter{pagemarker}{1}
    \setcounter{page}{\value{pagemarker}}         % pagemarker에 저장된 값으로
%    \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{content}{\contentsname} % 목차(TOC)에 추가
    \@starttoc{toc}%
    \if@restonecol\twocolumn\fi
    \newpage \setcounter{pagemarker}{\value{page}}% pagemarker에 다시 저장
    \pagenumbering{arabic}                        % arabic 페이지번호로 재시작
}

%%
%% \listoftables 재정의 - report 클래스로부터 복사하여 일부 수정
%%
\renewcommand\listoftables{%
	%\thispagestyle{plain}
	\thispagestyle{postech}
    \pagenumbering{Roman}                        % 로마자 페이지 시작
    \if@twocolumn
        \@restonecoltrue\onecolumn
    \else
        \@restonecolfalse
    \fi
    \chapter*{\listtablename}%
    \@mkboth{\MakeUppercase\listtablename}{\MakeUppercase\listtablename}%
%    \pagenumbering{arabic}                         % roman 페이지번호로 복원
    \setcounter{page}{\value{pagemarker}}         % pagemarker에 저장된 값으로
%    \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{content}{\listtablename}% 목차(TOC)에 추가
%    \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{chapter}{\listtablename}% 목차(TOC)에 추가
    \@starttoc{lot}%
    \if@restonecol\twocolumn\fi
    \newpage \setcounter{pagemarker}{\value{page}}% pagemarker에 다시 저장
%    \pagenumbering{arabic}                        % arabic 페이지번호로 재시작
}

%%
%% \listoffigures 재정의 - report 클래스로부터 복사하여 일부 수정
%%
\renewcommand\listoffigures{%
	%\thispagestyle{plain}
	\thispagestyle{postech}
    \pagenumbering{Roman}                        % 로마자 페이지 시작
    \if@twocolumn
        \@restonecoltrue\onecolumn
    \else
        \@restonecolfalse
    \fi
    \chapter*{\listfigurename}%
    \@mkboth{\MakeUppercase\listfigurename}{\MakeUppercase\listfigurename}%
%    \pagenumbering{arabic}                         % roman 페이지번호로 복원
    \setcounter{page}{\value{pagemarker}}         % pagemarker에 저장된 값으로
%    \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{content}{\listfigurename}% 목차(TOC)에 추가
%    \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{chapter}{\listfigurename}% 목차(TOC)에 추가
    \@starttoc{lof}%
    \if@restonecol\twocolumn\fi
    \newpage \setcounter{pagemarker}{\value{page}}% pagemarker에 다시 저장
    \pagenumbering{arabic}                        % arabic 페이지번호로 재시작
}

%%
%% 목차에 나오는 형식 - report 클래스로부터 복사하여 일부 수정
%%
%\newcommand{\l@content}{\normalsize\bf\@dottedtocline{1}{0em}{0em}}
\newcommand{\l@content}{\normalfont\normalsize\@dottedtocline{1}{0em}{0em}}

\renewcommand*\l@chapter[2]{%
   % \thispagestyle{plain}           % ver0.2 : 목차 쪽번호 유지
    \thispagestyle{postech}           % ver0.2 : 목차 쪽번호 유지
    \ifnum \c@tocdepth >\m@ne
        \addpenalty{-\@highpenalty}%
        \vskip 1.3em \@plus\p@      % ver0.2 : 줄간격 조정 
        \if@isKorean                     % <-- 변경 부분
            \setlength\@tempdima{5.0em} % korean  옵션일 때는 5.0em
        \else
            \setlength\@tempdima{2.0em} % english 옵션일 때는 2.0em
        \fi
        \begingroup
            \parindent \z@\rightskip \@pnumwidth
            \parfillskip -\@pnumwidth
            \leavevmode \normalsize \sffamily \bfseries
            \advance\leftskip\@tempdima
            \hskip -\leftskip
            #1\nobreak \hfil \nobreak\hb@xt@\@pnumwidth{\hss\rmfamily #2}\par
            \penalty\@highpenalty
        \endgroup
    \fi}


\if@isKorean % 한글이면 각종 치수를 변경
    \renewcommand*\l@section{\@dottedtocline{1}{2.7em}{2.3em}}
    \renewcommand*\l@subsection{\@dottedtocline{2}{5.0em}{3.2em}}
    \renewcommand*\l@subsubsection{\@dottedtocline{3}{8.2em}{4.1em}}
    \renewcommand*\l@paragraph{\@dottedtocline{4}{11.2em}{5em}}
    \renewcommand*\l@subparagraph{\@dottedtocline{5}{13.2em}{6em}}
\else \fi     % 영문이면 가만히 내버려둠

%%
%% thebibliography 환경 재정의 - report 클래스로부터 복사하여 일부 수정
%%
\renewenvironment{thebibliography}[1]{%
    \chapter*{\rmfamily{\bibname}}%
    \@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}%
    \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{chapter}{\rmfamily{\bibname}}%
    \list{\@biblabel{\@arabic\c@enumiv}}%
        {\settowidth\labelwidth{\@biblabel{#1}}%
         \leftmargin\labelwidth
         \advance\leftmargin\labelsep
         \@openbib@code
         \usecounter{enumiv}%
         \let\p@enumiv\@empty
         \renewcommand\theenumiv{\@arabic\c@enumiv}}%
    \sloppy
    \clubpenalty4000
    \@clubpenalty \clubpenalty
    \widowpenalty4000%
    \sfcode`\.\@m%
}{  \label{paperlastpagelabel}     % <-- 추가 부분: 마지막 페이지 위치 지정
    \def\@noitemerr{\@latex@warning{Empty `thebibliography' environment}}%
    \endlist
}

%%
%% 한국식 날짜 표기 -> 영문식 날짜 표기
%%
\newcommand{\@dateUSenglish}[3]{%  % 미국식 날짜 표기
    \newcommand{\@year}{#1}%
    \newcommand{\@month}{#2}%
    \newcommand{\@day}{#3}%
    \ifcase\@month \or
        January \or February \or March \or April \or May \or June \or
        July \or August \or September \or October \or November \or December \fi
    \@day, \@year
}
\newcommand{\@dateBRenglish}[3]{%  % 영국식 날짜 표기
    \newcommand{\@year}{#1}%
    \newcommand{\@month}{#2}%
    \newcommand{\@day}{#3}%
    \@day\ifcase\@day \or
        st\or nd\or rd\or th\or th\or th\or th\or th\or th\or th\or
        st\or nd\or rd\or th\or th\or th\or th\or th\or th\or th\or
        st\or nd\or rd\or th\or th\or th\or th\or th\or th\or th\or th\fi
    \space\ifcase\@month \or
        January\or February\or March\or April\or May\or June\or
        July\or August\or September\or October\or November\or December\fi,
    \@year
}
