* Problem 1;

*Generate a random sample of size n=20;
%LET SampleSize = 10000;
DATA Data1;
	CALL STREAMINIT(12321);
	DO i = 1 TO &SampleSize;
		ARRAY x(*) x1-x20;
		DO j = 1 TO 20;	
			x(j) = RAND("NORMAL");
		END;
		* Compute t statistic value;
		Mean = MEAN(OF x(*));Std= stderr(Of x(*));
		t=SQRT(20)*Mean/Std;p = 2 - 2 * CDF("T",abs(t),19);
		OUTPUT;
	END;
	DROP i j;
RUN;
* Draw the histogram;
PROC SGPLOT data=Data1;
	histogram p;
run;

* Problem 2(1);
%LET SampleSize = 10000;
DATA Sim1;
	CALL STREAMINIT(12321);
	ARRAY Disease(*) ar as CHD db liv lun;
	ARRAY Factor(*) leo tm Kb pur hair fn ID sum;
	DO i=1 TO &SampleSize;
		DO j= 1 TO 6;
			Disease(j) = RAND("Bernoulli", 0.1);
		END;
		DO j= 1 TO 8;
			Factor(j) = RAND("Bernoulli", 0.05);
		END;
		OUTPUT;
	END;
	DROP i j;
RUN;
* Problem 2(3);
%MACRO Test(Disease=,);
	PROC FREQ DATA=Sim1;
	TABLE &Disease*leo / CHISQ;
	TABLE &Disease*tm / CHISQ;
	TABLE &Disease*Kb / CHISQ;
	TABLE &Disease*pur / CHISQ;
	TABLE &Disease*hair / CHISQ;
	TABLE &Disease*fn / CHISQ;
	TABLE &Disease*ID / chisq;
	TABLE &Disease*sum / chisq;
RUN;
%MEND;
%TEST(Disease=ar)
%TEST(Disease=as)
%TEST(Disease=CHD)
%TEST(Disease=db)
%TEST(Disease=liv)
%TEST(Disease=lun);




* Problem 4(1);
LIBNAME file1 "~/my_shared_file_links/u44964922/Assignments";
PROC means DATA=file1.exercise mean std;
	output mean=mean std=std;
run;
*Hence we know mean of effort is 29.6592189,std is 5.1427635;
PROC SQL;
	create table copy AS
	select loss, hours, effort
	from file1.exercise;
quit;
DATA sim2;
	set copy;
	if 24.5164554<= effort <= 34.8019824 
	then effort_cat = "median";
	else if effort > 34.8019824
	then effort_cat = "high";
	else effort_cat = "low";
run;

* Interaction Plot;
PROC SGPLOT DATA=sim2;
	STYLEATTRS DATACONTRASTCOLORS=(LightSkyBlue bio bib)
			   WALLCOLOR=WhiteSmoke;
	REG X=hours Y=loss / GROUP=effort_cat MARKERATTRS=(Symbol=CircleFilled) 
							CLM CLMTRANSPARENCY=0.5;
	TITLE 'Interaction Plot';
RUN;

* Problem 4(2);
PROC GLM DATA=sim2;
MODEL loss = effort hours;
RUN;

* Problem 4(3);

*The homoscedasticity assumption;
*fitted vs. residual plot & Q-Q plot;
PROC GLM DATA=sim2 PLOTS=DIAGNOSTICS(UNPACK);
MODEL loss = hours effort;
RUN;
*White test;
PROC MODEL DATA=sim2;
	PARMS b0 b1 b2;
	loss = b0 + b1*effort + b2*hours;
	FIT loss / WHITE PAGAN=(1 effort hours);
RUN;

*The normality assumption;
* Q-Q plot has shown in above;
* S-W test;
PROC GLM DATA=sim2;
	MODEL loss = effort hours;
	OUTPUT OUT = sim2_fitted (Keep=loss effort hours resid) Residual=resid;
RUN;
PROC UNIVARIATE DATA=sim2_fitted NORMAL;
	VAR resid;
RUN;
PROC MODEL DATA = sim2_fitted;
	PARMS b0;
	resid = b0;
	FIT resid / NORMAL;
RUN;

* Problem 5(1);
PROC IMPORT 
	DATAFILE = "~/my_shared_file_links/u44964922/Assignments/cancer_reg.csv" 
	OUT = Data5 DBMS = CSV REPLACE;
RUN;

PROC CORR DATA=Data5 NOPROB RANK NOSIMPLE;
	VAR X1 X2 X3 X4 X5 X6 X7 X8 X9 X10 X11 X12 X13 X14;
RUN;


* Problem 5(2);
PROC GLM DATA=Data5;
	MODEL deathRate = X1 X2 X3 X4 X5 X6 X7 X8 X9 X10 X11 X12 X13 X14 / tolerance;
RUN;

PROC REG DATA=Data5;
	MODEL deathRate = X1 X2 X3 X4 X5 X6 X7 X8 X9 X10 X11 X12 X13 X14 / TOL VIF;
RUN;


* Problem 5(3);
PROC STANDARD DATA=Data5
MEAN = 0
STD = 1
OUT = cancerstd;
VAR deathRate X1 X2 X3 X4 X5 X6 X7 X8 X9 X10 X11 X12 X13 X14;
RUN;
PROC REG DATA=cancerstd OUTEST=outVIF
	RIDGE=0 to 1 by 0.05
	PLOTS(only)=ridge(unpack);
	MODEL deathRate = X1 X2 X3 X4 X5 X6 X7 X8 X9 X10 X11 X12 X13 X14;
RUN;
PROC SGPLOT DATA=outVIF;
	SERIES x=_RIDGE_ y=X1 / LINEATTRS=(Thickness=2 Color=Grey);
	SERIES x=_RIDGE_ y=X3 / LINEATTRS=(Thickness=2 Color=Green) ;
	SERIES x=_RIDGE_ y=X4 / LINEATTRS=(Thickness=2 Color=Yellow);
	SERIES x=_RIDGE_ y=X5 / LINEATTRS=(Thickness=2 Color=Red);
	SERIES x=_RIDGE_ y=X6 / LINEATTRS=(Thickness=2 Color=Pink);
	SERIES x=_RIDGE_ y=X8 / LINEATTRS=(Thickness=2 Color=DodgerBlue);
	SERIES x=_RIDGE_ y=X14 / LINEATTRS=(Thickness=2 Color=Blue);
	YAXIS LABEL = "Coefficients";
RUN;
* Problem 5(4);
PROC GLMSELECT DATA=Data5 PLOTS=CriterionPanel;
	MODEL deathRate = X1 X2 X3 X4 X5 X6 X7 X8 X9 X10 X11 X12 X13 X14 
		/ SELECTION=STEPWISE(SELECT=SBC)
		STATS=(ADJRSQ CP AIC SBC);
RUN;

* Problem 5(5);
PROC GLM DATA = Data5;
   MODEL deathRate = X1 X3 X8 X14;
   OUTPUT OUT = sim3(Keep=Region deathRate X1 X3 X8 X14 r) Rstudent=r;
RUN;

PROC PRINT DATA=sim3;
	WHERE ABS(r) > 3;
RUN;

PROC SQL;
	create table sim4 AS
	select Region,deathRate,X1,X3,X8,X14,r
	from sim3
	WHERE ABS(r) > 3;
quit;
proc sort data=sim4  out=bb;
	by X1;
	
RUN;
PROC PRINT DATA=bb;