/* Problem 3(1) */
DATA personality;
INPUT EI $ SN $ TF $ JP $ drink $ count @@;
DATALINES;
E S T P Yes 8
E S T P No 34
E S T J Yes 10
E S T J No 67
E S F P Yes 7
E S F P No 72
E S F J Yes 5
E S F J No 101
E N T P Yes 2
E N T P No 16
E N T J Yes 3
E N T J No 20
E N F P Yes 15
E N F P No 65
E N F J Yes 4
E N F J No 27
I S T P Yes 3
I S T P No 49
I S T J Yes 17
I S T J No 123
I S F P Yes 4
I S F P No 102
I S F J Yes 6
I S F J No 132
I N T P Yes 5
I N T P No 30
I N T J Yes 1
I N T J No 12
I N F P Yes 6
I N F P No 73
I N F J Yes 1
I N F J No 30
;
RUN;

/* Problem 3(2) */
PROC LOGISTIC DATA = personality
	PLOTS(ONLY) = (EFFECT(CLBAND YRANGE = (0,0.3) X = EI*SN*TF*JP)
	ODDSRATIO);
	FREQ count;
	CLASS EI(REF = first) SN(REF = first) TF(REF = first) JP(REF = first)/ PARAM = REF;
	MODEL drink(EVENT = last) = EI SN TF JP;
RUN;

/* Problem 3(3) */
PROC LOGISTIC DATA = personality
	PLOTS(ONLY) = (EFFECT(CLBAND YRANGE = (0,0.3) X = EI*SN*TF)
	ODDSRATIO);
	FREQ count;
	CLASS EI(REF = first) SN(REF = first) TF(REF = first) / PARAM = REF;
	MODEL drink(EVENT = last) = EI SN TF SN*TF;
	EFFECTPLOT INTERACTION (X = SN) / AT(EI = all TF = all) LINK NOOBS;
	ODDSRATIO SN;
RUN;

/* Problem 4(1) */
PROC IMPORT
DATAFILE = "~/my_shared_file_links/u44964922/Assignments/HRdata.csv"
OUT = hr
DBMS = csv;
RUN;

PROC SGPLOT DATA = hr;
VBOX satisfaction_level / GROUP = left;


PROC GCHART data=hr;
pie left / type=percent;

PROC SGPLOT DATA = hr ;
	VBAR number_project / GROUP = left FILL GROUPDISPLAY=CLUSTER ;
RUN;

PROC SGPLOT DATA = hr ;
	VBAR left / GROUP = salary FILL GROUPDISPLAY=CLUSTER ;
RUN;

PROC SGPLOT DATA = hr;
VBAR time_spent_company / GROUP = left  GROUPDISPLAY=CLUSTER ;

/* Problem 4(2) */
PROC LOGISTIC DATA = hr DESC PLOTS(ONLY) = ROC PLOTS(MAXPOINTS = NONE);
CLASS work_accident(REF = first) promotion_last_5years(REF = first)
 salary(REF = "low") salary(REF = "high") ;
MODEL left = satisfaction_level last_evaluation number_project
 average_monthly_hours time_spent_company
 work_accident promotion_last_5years salary / CTABLE;
RUN;

/* Problem 4(3) */
DATA hr1;
SET hr;
IF satisfaction_level <= 0.5 THEN satisfaction_level1 = "no";
ELSE satisfaction_level1 = "yes";
IF 3 <= number_project <= 4 THEN number_project1 = "medium";
ELSE IF number_project = 2 THEN number_project1 = "low";
ELSE number_project1 = "high";
IF last_evaluation <=0.6 THEN last_evaluation1 = "low";
ELSE IF last_evaluation <=0.8 THEN last_evaluation1 = "medium";
ELSE last_evaluation1 = "high";
IF average_monthly_hours <= 165 THEN average_monthly_hours1 = "low";
ELSE IF average_monthly_hours <= 215 THEN average_monthly_hours1 = "medium";
ELSE IF average_monthly_hours <= 275 THEN average_monthly_hours1 = "high";
ELSE average_monthly_hours1 = "very high";
IF time_spent_company = 2 THEN time_spent_company1 = "short";
ELSE IF 3<=time_spent_company <= 6 THEN time_spent_company1 = "medium";
ELSE time_spent_company1 = "high";
RUN;
PROC LOGISTIC DATA = hr1 DESC PLOTS(ONLY) = ROC PLOTS(MAXPOINTS = NONE);
CLASS work_accident(REF = first) promotion_last_5years(REF = first)
 salary(REF = "low") salary(REF = "high") satisfaction_level1(REF = first)
 last_evaluation1(REF = first) average_monthly_hours1(REF = first) number_project1 / PARAM=ref;
MODEL left = satisfaction_level1 last_evaluation1 number_project1
 average_monthly_hours1 time_spent_company
 work_accident promotion_last_5years salary;
RUN;

/*Problem 5(1) */
DATA Indian;
INPUT Duration $ Education $ place $ y n ;
ln = LOG(n);
DATALINES;
0-4 None Suva 4 8
0-4 None Urban 14 12
0-4 None Rural 60 62
0-4 LP Suva 24 21
0-4 LP Urban 23 27
0-4 LP Rural 98 102
0-4 UP Suva 38 42
0-4 UP Urban 41 39
0-4 UP Rural 104 107
0-4 SH Suva 37 51
0-4 SH Urban 35 51
0-4 SH Rural 35 47
5-9 None Suva 31 10
5-9 None Urban 59 13
5-9 None Rural 171 70
5-9 LP Suva 80 30
5-9 LP Urban 98 37
5-9 LP Rural 317 117
5-9 UP Suva 49 24
5-9 UP Urban 118 44
5-9 UP Rural 200 81
5-9 SH Suva 38 22
5-9 SH Urban 48 21
5-9 SH Rural 47 21
10-14 None Suva 49 12
10-14 None Urban 75 18
10-14 None Rural 364 88
10-14 LP Suva 99 27
10-14 LP Urban 143 43
10-14 LP Rural 546 132
10-14 UP Suva 58 20
10-14 UP Urban 105 29
10-14 UP Rural 197 50
10-14 SH Suva 24 12
10-14 SH Urban 50 15
10-14 SH Rural 30 9
15-19 None Suva 59 14
15-19 None Urban 108 23
15-19 None Rural 577 114
15-19 LP Suva 153 31
15-19 LP Urban 225 42
15-19 LP Rural 481 86
15-19 UP Suva 41 13
15-19 UP Urban 92 20
15-19 UP Rural 135 30
15-19 SH Suva 11 4
15-19 SH Urban 19 5
15-19 SH Rural 2 1
20-24 None Suva 118 21
20-24 None Urban 118 22
20-24 None Rural 756 117
20-24 LP Suva 91 18
20-24 LP Urban 147 25
20-24 LP Rural 431 68
20-24 UP Suva 47 12
20-24 UP Urban 65 13
20-24 UP Rural 132 23
20-24 SH Suva 13 5
20-24 SH Urban 16 3
20-24 SH Rural 5 2
;
RUN;

/* Problem 5(2) */
PROC GENMOD DATA = Indian;
CLASS Duration (REF = "0-4") Education (REF ="None") place (REF = "Suva") / PARAM = ref;
MODEL y = Duration Education place / DIST = POISSON LINK = LOG TYPE1 TYPE3 OFFSET = ln;
RUN;

/* Problem 5(3) */
PROC GENMOD DATA = Indian;
CLASS Duration (REF = "0-4") Education (REF ="None") place (REF = "Suva") / PARAM = ref;
MODEL y = Duration Education place / DIST = NEGBIN TYPE3 OFFSET = ln;
RUN;