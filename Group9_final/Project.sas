/* 分析calender数据集 */
PROC IMPORT 
	DATAFILE = "~/my_shared_file_links/u44964922/FinalProject/calendar-Shanghai.csv" 
	OUT = calender DBMS = CSV REPLACE;
RUN;

/* 分析review数据集 */
PROC IMPORT 
	DATAFILE = "~/my_shared_file_links/u44964922/FinalProject/reviews-Shanghai.csv" 
	OUT = reviews DBMS = CSV REPLACE;
RUN;

/* 分析listing数据集 */
PROC IMPORT 
	DATAFILE = "~/sasuser.v94/Project/result7.csv" 
	OUT = listings DBMS = CSV REPLACE;
RUN;

/* EDA for listing dataset of our project*/
PROC SQL;
	create table study1 AS
	select host_response_time, price,host_identity_verified,neighbourhood,host_is_superhost,property_type,room_type,accommodates,description,neiover
	from listings
	where price<3527.2;
quit;

/* histogram */
/*proc univariate data=listings;
	histogram price;
run;*/

PROC SGPLOT DATA = study1 ;
	
	histogram price/ dataskin=gloss;
	*density price;
	*density price/type=kernel;
RUN;


/* box plot */
%MACRO VBar(var = , dat = );
	PROC SGPLOT DATA = &dat;
		vbox price / category= &var ;
	RUN;
%MEND;

%VBar(var = host_response_time, dat = study1);
%VBar(var = host_identity_verified, dat = study1);
%VBar(var = neighbourhood, dat = study1);
%VBar(var = host_is_superhost, dat = study1);
%VBar(var = accommodates, dat = study1);

/* price的对数变换 */
DATA study2;
 SET study1;
 logprice = LOG(price);
RUN;

PROC SGPLOT DATA = study2 ;
	
	histogram logprice/ dataskin=gloss;
	*density price;
	*density price/type=kernel;
RUN;

/* missing data 处理*/
DATA study2;
 SET study2;
 IF host_response_time = ' ' THEN host_response_time = 'U';
 IF host_identity_verified = ' ' THEN host_identity_verified = 'U';
 IF neighbourhood = ' ' THEN neighbourhood = 'U';
 IF host_is_superhost = ' ' THEN host_is_superhost = 'U';
 IF property_type = ' ' THEN property_type = 'U';
 IF accommodates = ' ' THEN accommodates = 'U';
RUN;


%MACRO VBar1(var = , dat = );
	PROC SGPLOT DATA = &dat;
		vbox logprice / category= &var ;
	RUN;
%MEND;

%VBar1(var = host_response_time, dat = study2);
%VBar1(var = host_identity_verified, dat = study2);
%VBar1(var = neighbourhood, dat = study2);
%VBar1(var = host_is_superhost, dat = study2);
%VBar1(var = property_type, dat = study2);
%VBar1(var = accommodates, dat = study2);

/* 分析评分 */
PROC SQL;
	create table study3 AS
	select host_response_time, review_scores_rating,host_identity_verified,neighbourhood,host_is_superhost,property_type,room_type,accommodates
	from listings;
quit;

PROC SGPLOT DATA = study3 ;
	
	histogram review_scores_rating/ dataskin=gloss;
	*density price;
	*density price/type=kernel;
RUN;

%MACRO VBar2(var = , dat = );
	PROC SGPLOT DATA = &dat;
		vbox review_scores_rating / category= &var ;
	RUN;
%MEND;

%VBar2(var = host_response_time, dat = study3);
%VBar2(var = host_identity_verified, dat = study3);
%VBar2(var = neighbourhood, dat = study3);
%VBar2(var = host_is_superhost, dat = study3);
%VBar2(var = accommodates, dat = study3);

/* ANOVA for scores */
PROC GLMSELECT DATA = listings PLOTS = (CriterionPanel CoefficientPanel);
	CLASS Extra_pillows_and_blankets Iron Smoke_alarm Oven Heating Bed_linens Hangers Kitchen	Coffee_maker	TV	Carbon_monoxide_alarm	Wifi	Stove	Hot_water	Microwave	Shampoo	Dishes_and_silverware	Washer	Cooking_basics	Essentials	Free_parking_on_premises	Dedicated_workspace	Refrigerator	Air_conditioning	Paid_parking_off_premises	Patio_or_balcony	High_chair	Luggage_dropoff_allowed	Childrens_books_and_toys	Building_staff	Hair_dryer	Room_darkening_shades	Long_term_stays_allowed	Smart_lock	Elevator	Paid_parking_on_premises	Fire_extinguisher	TV_with_standard_cable	Cable_TV	Keypad	Ethernet_connection	Dryer	Private_entrance	Shower_gel	Host_greets_you	Lock_on_bedroom_door	Hot_tub	First_aid_kit	Pool	Backyard	Hot_water_kettle	Lockbox	Rice_maker	Conditioner	Cleaning_before_checkout	Body_soap	EV_charger	Clothing_storage	Dining_table	Cleaning_products	Waterfront	Window_guards	Gym	Breakfast	Free_street_parking	Bathtub	Dishwasher	Childrens_dinnerware	Drying_rack_for_clothing	Baking_sheet	BBQ_grill	Indoor_fireplace	Security_cameras_on_property	Board_games	Barbecue_utensils
;
	MODEL review_scores_rating = Extra_pillows_and_blankets	Iron	Smoke_alarm	Oven	Heating	Bed_linens	Hangers	Kitchen	Coffee_maker	TV	Carbon_monoxide_alarm	Wifi	Stove	Hot_water	Microwave	Shampoo	Dishes_and_silverware	Washer	Cooking_basics	Essentials	Free_parking_on_premises	Dedicated_workspace	Refrigerator	Air_conditioning	Paid_parking_off_premises	Patio_or_balcony	High_chair	Luggage_dropoff_allowed	Childrens_books_and_toys	Building_staff	Hair_dryer	Room_darkening_shades	Long_term_stays_allowed	Smart_lock	Elevator	Paid_parking_on_premises	Fire_extinguisher	TV_with_standard_cable	Cable_TV	Keypad	Ethernet_connection	Dryer	Private_entrance	Shower_gel	Host_greets_you	Lock_on_bedroom_door	Hot_tub	First_aid_kit	Pool	Backyard	Hot_water_kettle	Lockbox	Rice_maker	Conditioner	Cleaning_before_checkout	Body_soap	EV_charger	Clothing_storage	Dining_table	Cleaning_products	Waterfront	Window_guards	Gym	Breakfast	Free_street_parking	Bathtub	Dishwasher	Childrens_dinnerware	Drying_rack_for_clothing	Baking_sheet	BBQ_grill	Indoor_fireplace	Security_cameras_on_property	Board_games	Barbecue_utensils 
		   / SELECTION=STEPWISE(SELECT=SL) 
		  STATS=(ADJRSQ CP AIC SBC SL);
RUN;

PROC GLMSELECT DATA = listings PLOTS = (CriterionPanel CoefficientPanel);
	CLASS Extra_pillows_and_blankets Iron Smoke_alarm Oven Heating Bed_linens Hangers Kitchen	Coffee_maker	TV	Carbon_monoxide_alarm	Wifi	Stove	Hot_water	Microwave	Shampoo	Dishes_and_silverware	Washer	Cooking_basics	Essentials	Free_parking_on_premises	Dedicated_workspace	Refrigerator	Air_conditioning	Paid_parking_off_premises	Patio_or_balcony	High_chair	Luggage_dropoff_allowed	Childrens_books_and_toys	Building_staff	Hair_dryer	Room_darkening_shades	Long_term_stays_allowed	Smart_lock	Elevator	Paid_parking_on_premises	Fire_extinguisher	TV_with_standard_cable	Cable_TV	Keypad	Ethernet_connection	Dryer	Private_entrance	Shower_gel	Host_greets_you	Lock_on_bedroom_door	Hot_tub	First_aid_kit	Pool	Backyard	Hot_water_kettle	Lockbox	Rice_maker	Conditioner	Cleaning_before_checkout	Body_soap	EV_charger	Clothing_storage	Dining_table	Cleaning_products	Waterfront	Window_guards	Gym	Breakfast	Free_street_parking	Bathtub	Dishwasher	Childrens_dinnerware	Drying_rack_for_clothing	Baking_sheet	BBQ_grill	Indoor_fireplace	Security_cameras_on_property	Board_games	Barbecue_utensils
;
	MODEL review_scores_accuracy = Extra_pillows_and_blankets	Iron	Smoke_alarm	Oven	Heating	Bed_linens	Hangers	Kitchen	Coffee_maker	TV	Carbon_monoxide_alarm	Wifi	Stove	Hot_water	Microwave	Shampoo	Dishes_and_silverware	Washer	Cooking_basics	Essentials	Free_parking_on_premises	Dedicated_workspace	Refrigerator	Air_conditioning	Paid_parking_off_premises	Patio_or_balcony	High_chair	Luggage_dropoff_allowed	Childrens_books_and_toys	Building_staff	Hair_dryer	Room_darkening_shades	Long_term_stays_allowed	Smart_lock	Elevator	Paid_parking_on_premises	Fire_extinguisher	TV_with_standard_cable	Cable_TV	Keypad	Ethernet_connection	Dryer	Private_entrance	Shower_gel	Host_greets_you	Lock_on_bedroom_door	Hot_tub	First_aid_kit	Pool	Backyard	Hot_water_kettle	Lockbox	Rice_maker	Conditioner	Cleaning_before_checkout	Body_soap	EV_charger	Clothing_storage	Dining_table	Cleaning_products	Waterfront	Window_guards	Gym	Breakfast	Free_street_parking	Bathtub	Dishwasher	Childrens_dinnerware	Drying_rack_for_clothing	Baking_sheet	BBQ_grill	Indoor_fireplace	Security_cameras_on_property	Board_games	Barbecue_utensils 
		   / SELECTION=STEPWISE(SELECT=SL) 
		  STATS=(ADJRSQ CP AIC SBC SL);
RUN;

PROC GLM DATA = listings;
	CLASS review_scores_accuracy review_scores_cleanliness review_scores_checkin review_scores_communication review_scores_location review_scores_value;
	MODEL review_scores_rating = review_scores_accuracy review_scores_cleanliness review_scores_checkin review_scores_communication review_scores_location review_scores_value;
RUN;
PROC GLM DATA = listings;
	CLASS review_scores_accuracy review_scores_cleanliness review_scores_checkin review_scores_communication review_scores_location review_scores_value;
	MODEL price = review_scores_accuracy review_scores_cleanliness review_scores_checkin review_scores_communication review_scores_location review_scores_value;
RUN;


PROC GLM DATA = study2;
    MODEL logprice = description neiover ;
RUN;

/* 对设施建立stepwise 线性回归 */

DATA listings;
 SET listings;
 logprice = LOG(price);
RUN;
PROC GLMSELECT DATA = listings PLOTS = (CriterionPanel CoefficientPanel);
	CLASS Extra_pillows_and_blankets Iron Smoke_alarm Oven Heating Bed_linens Hangers Kitchen	Coffee_maker	TV	Carbon_monoxide_alarm	Wifi	Stove	Hot_water	Microwave	Shampoo	Dishes_and_silverware	Washer	Cooking_basics	Essentials	Free_parking_on_premises	Dedicated_workspace	Refrigerator	Air_conditioning	Paid_parking_off_premises	Patio_or_balcony	High_chair	Luggage_dropoff_allowed	Childrens_books_and_toys	Building_staff	Hair_dryer	Room_darkening_shades	Long_term_stays_allowed	Smart_lock	Elevator	Paid_parking_on_premises	Fire_extinguisher	TV_with_standard_cable	Cable_TV	Keypad	Ethernet_connection	Dryer	Private_entrance	Shower_gel	Host_greets_you	Lock_on_bedroom_door	Hot_tub	First_aid_kit	Pool	Backyard	Hot_water_kettle	Lockbox	Rice_maker	Conditioner	Cleaning_before_checkout	Body_soap	EV_charger	Clothing_storage	Dining_table	Cleaning_products	Waterfront	Window_guards	Gym	Breakfast	Free_street_parking	Bathtub	Dishwasher	Childrens_dinnerware	Drying_rack_for_clothing	Baking_sheet	BBQ_grill	Indoor_fireplace	Security_cameras_on_property	Board_games	Barbecue_utensils
;
	MODEL logprice = Extra_pillows_and_blankets	Iron	Smoke_alarm	Oven	Heating	Bed_linens	Hangers	Kitchen	Coffee_maker	TV	Carbon_monoxide_alarm	Wifi	Stove	Hot_water	Microwave	Shampoo	Dishes_and_silverware	Washer	Cooking_basics	Essentials	Free_parking_on_premises	Dedicated_workspace	Refrigerator	Air_conditioning	Paid_parking_off_premises	Patio_or_balcony	High_chair	Luggage_dropoff_allowed	Childrens_books_and_toys	Building_staff	Hair_dryer	Room_darkening_shades	Long_term_stays_allowed	Smart_lock	Elevator	Paid_parking_on_premises	Fire_extinguisher	TV_with_standard_cable	Cable_TV	Keypad	Ethernet_connection	Dryer	Private_entrance	Shower_gel	Host_greets_you	Lock_on_bedroom_door	Hot_tub	First_aid_kit	Pool	Backyard	Hot_water_kettle	Lockbox	Rice_maker	Conditioner	Cleaning_before_checkout	Body_soap	EV_charger	Clothing_storage	Dining_table	Cleaning_products	Waterfront	Window_guards	Gym	Breakfast	Free_street_parking	Bathtub	Dishwasher	Childrens_dinnerware	Drying_rack_for_clothing	Baking_sheet	BBQ_grill	Indoor_fireplace	Security_cameras_on_property	Board_games	Barbecue_utensils 
		   / SELECTION=STEPWISE(SELECT=SL) 
		  STATS=(ADJRSQ CP AIC SBC SL);
RUN;


/* 对设施建立stepwise 线性回归 */

PROC IMPORT 
	DATAFILE = "~/sasuser.v94/Project/result8.csv" 
	OUT = delete DBMS = CSV REPLACE;
RUN;


DATA delete;
 SET delete;
 logprice = LOG(price);
RUN;


PROC GLMSELECT DATA = delete PLOTS = (CriterionPanel CoefficientPanel);
	CLASS Extra_pillows_and_blankets Iron Smoke_alarm Oven Heating Bed_linens Hangers Kitchen	Coffee_maker	TV	Carbon_monoxide_alarm	Wifi	Stove	Hot_water	Microwave	Shampoo	Dishes_and_silverware	Washer	Cooking_basics	Essentials	Free_parking_on_premises	Dedicated_workspace	Refrigerator	Air_conditioning	Paid_parking_off_premises	Patio_or_balcony	High_chair	Luggage_dropoff_allowed	Childrens_books_and_toys	Building_staff	Hair_dryer	Room_darkening_shades	Long_term_stays_allowed	Smart_lock	Elevator	Paid_parking_on_premises	Fire_extinguisher	TV_with_standard_cable	Cable_TV	Keypad	Ethernet_connection	Dryer	Private_entrance	Shower_gel	Host_greets_you	Lock_on_bedroom_door	Hot_tub	First_aid_kit	Pool	Backyard	Hot_water_kettle	Lockbox	Rice_maker	Conditioner	Cleaning_before_checkout	Body_soap	EV_charger	Clothing_storage	Dining_table	Cleaning_products	Waterfront	Window_guards	Gym	Breakfast	Free_street_parking	Bathtub	Dishwasher	Childrens_dinnerware	Drying_rack_for_clothing	Baking_sheet	BBQ_grill	Indoor_fireplace	Security_cameras_on_property	Board_games	Barbecue_utensils
;
	MODEL logprice = Extra_pillows_and_blankets	Iron	Smoke_alarm	Oven	Heating	Bed_linens	Hangers	Kitchen	Coffee_maker	TV	Carbon_monoxide_alarm	Wifi	Stove	Hot_water	Microwave	Shampoo	Dishes_and_silverware	Washer	Cooking_basics	Essentials	Free_parking_on_premises	Dedicated_workspace	Refrigerator	Air_conditioning	Paid_parking_off_premises	Patio_or_balcony	High_chair	Luggage_dropoff_allowed	Childrens_books_and_toys	Building_staff	Hair_dryer	Room_darkening_shades	Long_term_stays_allowed	Smart_lock	Elevator	Paid_parking_on_premises	Fire_extinguisher	TV_with_standard_cable	Cable_TV	Keypad	Ethernet_connection	Dryer	Private_entrance	Shower_gel	Host_greets_you	Lock_on_bedroom_door	Hot_tub	First_aid_kit	Pool	Backyard	Hot_water_kettle	Lockbox	Rice_maker	Conditioner	Cleaning_before_checkout	Body_soap	EV_charger	Clothing_storage	Dining_table	Cleaning_products	Waterfront	Window_guards	Gym	Breakfast	Free_street_parking	Bathtub	Dishwasher	Childrens_dinnerware	Drying_rack_for_clothing	Baking_sheet	BBQ_grill	Indoor_fireplace	Security_cameras_on_property	Board_games	Barbecue_utensils 
		   / SELECTION=STEPWISE(SELECT=SL) 
		  STATS=(ADJRSQ CP AIC SBC SL);
RUN;


/* 对最终数据集拟合*/
PROC IMPORT 
	DATAFILE = "~/sasuser.v94/Project/result9.csv" 
	OUT = final DBMS = CSV REPLACE;
RUN;

PROC SQL;
	create table final1 AS
	select description,neiover, Checkin, Basic, Bathroom, Kitchen,Security,has_availability, room_type, minimum_nights,
			accommodates,bedrooms,beds, property_type, neighbourhood, host_identity_verified, host_is_superhost, bath,
			host_total_listings_count, price
	from final
	where price<10000;
quit;

DATA final1;
 SET final1;
 logprice = LOG(price);
RUN;



PROC SGPLOT DATA = final1 ;
	
	histogram price/ dataskin=gloss;
	*density price;
	*density price/type=kernel;
RUN;

PROC SGPLOT DATA = final1 ;
	
	histogram logprice/ dataskin=gloss;
	*density price;
	*density price/type=kernel;
RUN;

/* box plot */
%MACRO VBar6(var = , dat = );
	PROC SGPLOT DATA = &dat;
		vbox logprice / category= &var ;
	RUN;
%MEND;

%VBar6(var = bedrooms, dat = final1);
%VBar6(var = host_identity_verified, dat = final1);
%VBar6(var = neighbourhood, dat = final1);
%VBar6(var = host_is_superhost, dat = final1);
%VBar6(var = accommodates, dat = final1);
%VBar6(var = room_type, dat = final1);
%VBar6(var = property_type, dat = final1);
%VBar6(var = beds, dat = final1);


/* 拟合模型*/
/* 线性假设检验 */
PROC MODEL DATA=final1;

	PARMS b0-b12;
	logprice = b0+b1*neiover+b2*Checkin+b3*Basic+b4*Bathroom+b5*Kitchen+b6*Security+
	        b7*minimum_nights+b8*accommodates+b9*bedrooms+b10*beds+
	        b11*host_total_listings_count+b12*description;
	FIT logprice / WHITE PAGAN=(1  neiover Checkin Basic Bathroom Kitchen	Security minimum_nights
			accommodates	bedrooms	beds host_total_listings_count description);
RUN;

PROC GLM DATA = final1 PLOTS = DIAGNOSTICS(UNPACK) plots(MAXPOINTS=30000);
	CLASS has_availability room_type property_type neighbourhood host_identity_verified host_is_superhost 
		bath accommodates bedrooms beds minimum_nights;
	MODEL logprice = description neiover Checkin Basic Bathroom Kitchen	Security has_availability room_type minimum_nights
			accommodates	bedrooms	beds property_type neighbourhood host_identity_verified host_is_superhost bath
			host_total_listings_count room_type*property_type;
	*OUTPUT OUT = sim2_fitted (Keep = loss effort hours) Residual = r Predicted = fv;
RUN;
%MACRO NormTest(dataName=);
	PROC GLM DATA=&dataName;
		CLASS has_availability room_type property_type neighbourhood host_identity_verified host_is_superhost bath;
		MODEL logprice = description neiover Checkin Basic Bathroom Kitchen	Security has_availability room_type minimum_nights
			accommodates bedrooms bath beds property_type neighbourhood host_identity_verified host_is_superhost host_total_listings_count
			;
		OUTPUT OUT = &dataName._fitted Residual=resid;
	RUN;
	PROC UNIVARIATE DATA=&dataName._fitted NORMAL;
		VAR resid;
	RUN;
%MEND;

%NormTest(dataName = final1);
/* 共线性 */
PROC CORR DATA=final1 NOPROB RANK NOSIMPLE;
	VAR description neiover Checkin Basic Bathroom Kitchen	Security   minimum_nights
			accommodates	bedrooms	beds     logprice host_total_listings_count;
RUN;

/* VIF */
PROC GLM DATA=final1;
	CLASS has_availability room_type property_type neighbourhood host_identity_verified host_is_superhost bath;
	MODEL logprice = description neiover Checkin Basic Bathroom Kitchen	Security has_availability room_type minimum_nights bath 
			accommodates host_total_listings_count bedrooms	beds property_type neighbourhood host_identity_verified host_is_superhost / tolerance;
RUN;

PROC REG DATA=final1 plots(MAXPOINTS=30000);
	MODEL logprice = description neiover Checkin Basic Bathroom Kitchen	Security minimum_nights host_total_listings_count
			accommodates	bedrooms	beds  / TOL VIF;
RUN;

PROC GLMSELECT DATA = final1 PLOTS = (CriterionPanel CoefficientPanel);
	CLASS has_availability room_type property_type neighbourhood host_identity_verified 
			host_is_superhost bath accommodates bedrooms beds ;
	MODEL logprice = description neiover Checkin Basic Bathroom Kitchen	Security has_availability room_type minimum_nights
			accommodates bedrooms beds property_type neighbourhood host_identity_verified 
			host_is_superhost host_total_listings_count bath
		   / SELECTION=STEPWISE(SELECT=AIC) 
		  STATS=(ADJRSQ CP AIC SBC SL);
RUN;

PROC GLM DATA = final1;
	CLASS has_availability room_type property_type neighbourhood host_identity_verified host_is_superhost 
			bath accommodates bedrooms beds;
	MODEL logprice = description neiover Checkin Basic Bathroom Kitchen	Security has_availability room_type minimum_nights
			accommodates bedrooms beds property_type neighbourhood host_identity_verified room_type*property_type 
			;
RUN;

/* Logistic Regression for review_scores */
PROC IMPORT 
	DATAFILE = "~/sasuser.v94/Project/result10.csv" 
	OUT = final_review DBMS = CSV REPLACE;
RUN;


DATA final_review ;
	SET final_review;
	IF review_scores_rating >=4.9 THEN review_scores_rating = 3;
	ELSE IF 4.7<=review_scores_rating<4.9 THEN review_scores_rating = 2;
	ELSE IF 4.5<=review_scores_rating<4.7 THEN review_scores_rating = 1;
	ELSE review_scores_rating = 0;
RUN;

DATA final_review;
 SET final_review;
 logprice = LOG(price);
RUN;

/* EDA of the review_score */
DATA Color;
INPUT ID $ 1-20 Value 23 Fillcolor $ 26-37;
DATALINES;
review_scores_rating  3  LightOrange
review_scores_rating  2  LightBlue
review_scores_rating  1  LightGreen
review_scores_rating  0  LightSalmon
;
RUN;

%MACRO VBar5(var = , dat = );
	PROC SGPLOT DATA = &dat DATTRMAP = Color;
		VBAR &var / GROUP = review_scores_rating FILL ATTRID = review_scores_rating GROUPDISPLAY=CLUSTER ;
	RUN;
%MEND;

%VBar5(var = review_scores_rating, dat = final_review);
%VBar5(var = bath, dat = final_review);
%VBar5(var = bedrooms, dat = final_review);

DATA final_review;
 SET final_review;
 IF host_response_time = ' ' THEN host_response_time = 'U';
 IF host_identity_verified = ' ' THEN host_identity_verified = 'U';
 IF neighbourhood = ' ' THEN neighbourhood = 'U';
 IF host_is_superhost = ' ' THEN host_is_superhost = 'U';
 IF property_type = ' ' THEN property_type = 'U';
 IF accommodates = ' ' THEN accommodates = 'U';
RUN;

/* Randomly split the data into train (75%) and test (25%) */
DATA final_Train final_Test;
	SET final_review;
	CALL STREAMINIT(12345);
	IF RAND("Uniform") <= 0.25 THEN OUTPUT final_Test;
	ELSE OUTPUT final_Train;
RUN;

/* Fit a logistic regression model */
PROC LOGISTIC DATA = final_Train OUTEST=Coeff1 DESCENDING;
	*CLASS bath(REF = 'No full bathroom')/PARAM = REF;
	MODEL review_scores_rating = review_scores_accuracy	review_scores_cleanliness	review_scores_checkin	
	review_scores_communication	review_scores_location	review_scores_value  Basic Bathroom Kitchen Security
    bedrooms / LINK = LOGIT;
RUN;


PROC LOGISTIC DATA = final_Test INEST = Coeff1 DESCENDING;
	*CLASS bath(REF = 'No full bathroom')/PARAM = REF;
	MODEL review_scores_rating = review_scores_accuracy	review_scores_cleanliness	review_scores_checkin	
	review_scores_communication	review_scores_location	review_scores_value  Basic Bathroom Kitchen Security
    bedrooms / MAXITER=0 LINK = LOGIT ;
RUN;

PROC HPLOGISTIC DATA = final_Train ;
	CLASS bath(REF = 'No full bathroom')/PARAM = REF;
	MODEL review_scores_rating = review_scores_accuracy	review_scores_cleanliness	review_scores_checkin	
	review_scores_communication	review_scores_location	review_scores_value bath Basic Bathroom Kitchen Security
    bedrooms / LINK = LOGIT;
    SELECTION method=stepwise(select=AIC) details=all;
RUN;

PROC HPLOGISTIC DATA = final_Test;
	CLASS bath(REF = 'No full bathroom')/PARAM = REF;
	MODEL review_scores_rating = review_scores_accuracy	review_scores_cleanliness	review_scores_checkin	
	review_scores_communication	review_scores_location	review_scores_value bath Basic Bathroom Kitchen Security
    bedrooms / LINK = LOGIT;
    SELECTION method=stepwise(select=AIC) details=all;
RUN;




PROC LOGISTIC DATA = final_Train OUTEST=Coeff2 DESCENDING;
	CLASS bath(REF = 'No full bathroom') neighbourhood(REF='虹口区 / Hongkou District')   /PARAM = REF;
	MODEL review_scores_rating =  bath Basic Bathroom Kitchen  Checkin logprice 
	 beds neighbourhood  
     / LINK = LOGIT;
RUN;


PROC LOGISTIC DATA = final_Test INEST = Coeff2 DESCENDING;
	CLASS bath(REF = 'No full bathroom') neighbourhood(REF = '虹口区 / Hongkou District')  /PARAM = REF;
	MODEL review_scores_rating =  bath Basic Bathroom Kitchen  Checkin logprice 
	 beds neighbourhood  
      / LINK = LOGIT ;
RUN;

