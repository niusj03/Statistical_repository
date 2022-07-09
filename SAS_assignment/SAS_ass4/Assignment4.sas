/* Problem 3 */

* load data;

DATA DATA3;
INPUT X1 X2 Y @@;
DATALINES;
40 65 24.0 40 65 23.8 40 65 23.6 50 65 25.6 50 65 25.4 60 65 29.2 60 65 29.4 60 65 29.0 70 65 28.4 70 65 27.6
40 70 25.0 40 70 26.0 50 70 28.8 50 70 28.8 50 70 28.4 60 70 31.6 60 70 32.0 60 70 32.2 70 70 30.2 70 70 30.0
40 75 25.6 40 75 25.0 50 75 27.6 50 75 28.0 50 75 27.8 60 75 29.8 60 75 28.6 70 75 28.0 70 75 27.0 70 75 27.4
40 80 24.0 40 80 24.2 40 80 24.6 50 80 27.6 50 80 26.2 60 80 27.6 60 80 28.6 70 80 26.0 70 80 24.4
;
RUN;

/* Problem 3(1) */
PROC GLM DATA = DATA3;
CLASS X1;
MODEL Y = X1;
RUN;

/* Problem 3(2) */
PROC GLM DATA = DATA3;
CLASS X2;
MODEL Y = X2;
RUN;

/* Problem 3(3) */
PROC GLM DATA = DATA3;
	CLASS X2;
	MODEL Y = X2;
	MEANS X2 /TUKEY ;
RUN;

/* Problem 3 (4) */
PROC GLM DATA = DATA3;
	CLASS X1 X2;
	MODEL Y = X1 X2 X1*X2;
	OUTPUT OUT = DataRegOut RESIDUAL = resid;
RUN;

/* Problem 3 (5) */
PROC UNIVARIATE DATA = DataRegOut NORMAL;
	VAR resid;
RUN;

/* Problem 3 (6) */
proc glm data=DATA3;
   model Y=X1 X1*X1*X1 X2 X1*X1 X2*X2 X2*X2*X2 / p clm;
run;

/* Problem 3 (7) */

/* Problem 4 (1) */
DATA Sim1;
	CALL Streaminit(12345);
	ARRAY X(*) Ind Y;
	ARRAY G(*)$ Group;
	DO i=1 TO 21000;
		X(1) = ceil(i/21);
		X(2) = RAND("Normal",1,1);
		if 0 < i - 21 * floor(i/21) <= 7
		Then G(1) = "A";
		Else if 7 < i - 21 * floor(i/21) <= 14
		Then G(1) = "B";
		ELSE if 14 < i - 21 * floor(i/21) <= 21
		Then G(1) = "C";
		OUTPUT;
	END;
	DROP i;
RUN;

PROC GLM  data=Sim1 noprint outstat=sim2;
	CLASS Group;
	MODEL Y = Group;
	By Ind;
RUn;

PROC SQL;
	create table new_data1 AS
	select _TYPE_, PROB
	from sim2
	where _TYPE_ = "SS1";
quit;
PROC SQL;
	create table P_1 AS
	select PROB
	from new_data1
	where PROB < 0.05;
quit;

proc univariate data=new_data1;
	histogram PROB;
run;

/* Problem 4 (2) */
DATA Sim3(DROP=j);
	CALL Streaminit(12345);
	
	DO Ind=1 TO 1000;
		Do j=1 TO 7;
			Group='A';
			Y=RAND("Normal",1,0.5);
			OUTPUT;
		END;
		Do j=8 TO 14;
			Group='B';
			Y=RAND("Normal",1,1);
			OUTPUT;
		END;
		Do j=15 TO 21;
			Group='C';
			Y=RAND("Normal",1,2);
			OUTPUT;
		END;
	END;
RUN;

PROC GLM  data=Sim3 noprint outstat=sim4;
	CLASS Group;
	MODEL Y = Group;
	By Ind;
RUn;

PROC SQL;
	create table new_data2 AS
	select _TYPE_, PROB
	from sim4
	where _TYPE_ = "SS1";
quit;
proc univariate data=new_data2;
	histogram PROB;
run;
PROC SQL;
	create table P_2 AS
	select PROB
	from new_data2
	where PROB < 0.05;
quit;