*Problem 4;
DATA Problem4;
INFILE "/home/u60917423/Assignments/Assignment1/NationalPark.txt";
INPUT @1 ParkName $ 12.
	@ 15 State $ 8.
	+2 EstablishDate mmddyy10.
	+2 Acreage comma9.;
RUN;


*Problem 5(a);
LIBNAME ass "/home/u60917423/my_shared_file_links/u44964922/Assignments";
PROC CONTENTS DATA = ass.sff POSITION;
RUN;
DATA problem5;
	SET ASS.SFF;
PROC FREQ DATA=PROBLEM5;
	TABLES Continent/NOPERCENT NOCUM;
RUN;

*Problem 5(b);
* Note that the number for 05-01-2009 is 18018
	and the number for 04-01-2009 is 17988;
PROC SQL;
	create table data1 AS
	SELECT FirstCase, Continent
	from PROBLEM5
	where 17988 <= FirstCase <18018;
quit;

PROC FREQ DATA=data1;
	TABLES Continent/NOPERCENT NOCUM;
	TITLE "# of countries per continent that had at least one case during April";
RUN;

PROC SQL;
	create table data2 AS
	SELECT FirstCase, Continent
	from PROBLEM5
	where FirstCase >= 18018;
quit;

PROC FREQ DATA=data2;
	TABLES Continent/NOPERCENT NOCUM;
	TITLE "# of countries per continent that had at least no case during April";
RUN;

PROC SQL;
	create table data3 AS
	SELECT FirstCase, Continent
	from PROBLEM5
	where FirstCase <17988;
quit;

PROC FREQ DATA=data3;
	TABLES Continent/NOPERCENT NOCUM;
	TITLE "# of countries per continent that we cannot tell whether there were cases during April";
RUN;


*Problem 5(c);
PROC SQL;
	creat table answer AS
	select Continent, Country, FirstCase, Aug, FirstDeath
	from ASS.SFF
	where FirstCase<17988;
quit;

PROC SQL;
	creat table answer2 AS
	select Continent, Country, FirstCase, Aug, input(put(FirstDeath,yymmddn8.),8.) as date
	from answer;
quit;

PROC PRINT DATA=answer2;
TITLE "Potential errors"
quit;

*Problem 6(a);
LIBNAME problem6 "~/my_shared_file_links/u44964922/Assignments";
proc sort data=problem6.visits  nouniquekey out=bb;
by id;
proc print;
run;
proc sort data=problem6.txgroup  nouniquekey out=bb;
by id;
run;

*Problem 6(b);
PROC SQL;
	create table Visits AS
	select ID, visitdt, gender, visit, B_cholesterol
	from problem6.visits;
quit;
proc sort data=Visits;
	by id;
run;
PROC SQL;
	create table TX AS
	select ID, TX
	from problem6.txgroup;
quit;
proc sort data=TX  NODUPKEY;
	by id;
run;

DATA temp;
	MERGE Visits TX;
	BY ID;
PROC SQL;
	create table combine AS
	select ID, TX, visit, visitdt, B_cholesterol
	from temp
	where TX = 1;
RUN;

*Problem 6(c);
proc sql; 
create table median as
select median(B_cholesterol) as Median from combine ; 
quit;

PROC SQL;
	CREATE TABLE Dummy AS
	SELECT ID, TX, visitdt,visit,B_Cholesterol,Median
	FROM combine median;
QUIT;
Data Dummy;
	SET Dummy;
	Length Abovemedian $ 2.;
	IF B_Cholesterol>Median Then Abovemedian=1;
	ELSE Abovemedian=0;
RUN;
PROC PRINT data=Dummy;
RUN;

*Problem 7(a);
DATA ANSWER;
	set SASHELP.Heart;
	IF DeathCause = 'Other' THEN DELETE;
	IF DeathCause = 'Unknown' THEN DELETE;
run;

PROC TABULATE DATA=ANSWER;
	CLASS DeathCause Smoking_Status Sex;
	VAR AgeAtDeath;
	TABLE DeathCause*Smoking_Status, (Sex ALL)*AgeAtDeath*(N MEAN MEDIAN);
RUN;

*Problem 7(b);
DATA heart1;
	set SASHELP.HEART;
	IF Sex ~= 'Female' Then Delete;
	IF Chol_Status ~= 'High' Then Delete;
run;
DATA heart2;
	set SASHELP.HEART;
	IF Sex ~= 'Female' Then Delete;
	IF Chol_Status ~= 'Desirable' Then Delete;
run;
DATA h1;
	set heart1;
	CHDhigh = AgeCHDdiag;
run;
DATA h2;
	set heart2;
	CHDdesir = AgeCHDdiag;
run;
DATA heart3;
	merge h1 h2;
run;
title 'Age at CHD Diagnosed By Cholesterol Status for Female';
PROC SGPLOT DATA=heart3;
	histogram CHDhigh/fillattrs=graphdata1 name='s' legendlabel='High'
	transparency=0.5 binwidth=5;
	density CHDhigh/type=kernel legendlabel='Kernel' lineattrs=(pattern=solid);

	histogram CHDdesir/fillattrs=graphdata1 name='d' legendlabel='Desirable'
	transparency=0.5 binwidth=5;
	density CHDdesir/type=kernel legendlabel='Kernel' lineattrs=(pattern=solid);
	xaxis display=(nolabel);
Run;


*Problem 7(c);
* create a macro named %DrawPlot; 
%MACRO DrawPlot(cate=);
	%IF &SYSDAY = Monday %THEN %DO;
		PROC SGPLOT DATA = SASHELP.Heart;
			histogram AgeAtDeath/group=&cate;
		RUN;
	%END;
	%ELSE %IF &SYSDAY = Wednesday %THEN %DO;
		PROC SGPLOT DATA = SASHELP.Heart;
			histogram AgeAtDeath/group=&cate;
		RUN;
	%END;
	%ELSE %IF &SYSDAY = Tuesday %THEN %DO;
		PROC SGPLOT DATA = SASHELP.Heart;
			VBAR AgeAtDeath/group=&cate;
		RUN;
	%END;
	%ELSE %IF &SYSDAY = Friday %THEN %DO;
		PROC SGPLOT DATA = SASHELP.Heart;
			VBAR AgeAtDeath/group=&cate;
		RUN;
	%END;
%MEND;

%DrawPlot(cate=Sex) 










