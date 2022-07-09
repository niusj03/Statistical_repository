* Problem5(a);
DATA DATA1;
INPUT Convict $ Victim $ Death $ Number;
DATALINES;
White White Yes 19
White White No 132
White Black Yes 0
White Black No 9
Black White Yes 11
Black White No 52
Black Black Yes 6
Black Black No 97
;
RUN;

* Problem5(b);
PROC FREQ DATA=DATA1;
	TABLES Death / Binomial(Level=2 Wald Exact);
	EXACT Binomial;
	WEIGHT Number;
RUN;
* Problem5(c);
PROC FREQ DATA=DATA1;
	TABLE Death / Binomial(Level=2 P=0.09 Wald Wilson Exact) Alpha=0.1;
	WEIGHT Number;
	EXACT Binomial;
RUN;

* Problem5(d);
* Barnard exact test;
PROC FREQ DATA=DATA1;
	TABLES Convict*Death / CHISQ;
	EXACT BARNARD;
	WEIGHT Number;
RUN;

* Pearson’s chi-squared test;
PROC FREQ DATA=DATA1;
	TABLES Convict * Death / RISKDIFF(EQUAL VAR = NULL CL = Wald NORISKS);	
	WEIGHT Number;
RUN;

* Problem5(e);

PROC FREQ DATA=DATA1;
	TABLES Victim*Death / CHISQ;
	EXACT BARNARD;
	WEIGHT Number;
RUN;