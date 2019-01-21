proc import 
	datafile= '/folders/myfolders/STA/cereal.csv'
	out=cereal
	dbms=csv
	replace;
getnames=yes;
run;

proc print data=cereal;
run;

proc univariate data=cereal normal;
histogram Overall_score Price_per_Serving;
run;

title "Cereal Price per Serving vs. Overall Score";
proc sgplot data=cereal;
format Price_per_Serving dollar5.2;
scatter y=Overall_score x=Price_per_Serving/ markerattrs=(size=10 symbol=Circlefilled);
run;

proc means data=cereal median mean std;
var Sugars__g_;
run;

data cereal;
set cereal;
if Sugars__g_ >=5 then group=1;
else group=2;
run;

proc format;
value sugar_group
1 = 'High Sugar'
2 = 'Low Sugar';
run;

proc tabulate data=cereal;
	format group sugar_group.;
	class group;
	var Overall_score Price_per_Serving;
	tables (Overall_score Price_per_Serving), group*(mean stderr)/rtspace=60;
run;

title "Cereal Price per Serving vs. Overall Score";
proc sgplot data=cereal;
format Price_per_Serving dollar5.2;
scatter y=Overall_score x=Price_per_Serving/ 
	colorresponse=Sugars__g_
	markerattrs=(size=10 symbol=Circlefilled)
	filledoutlinedmarkers
	colormodel=TwoColorRamp;
run;

proc corr data=cereal pearson spearman;
var Overall_score Price_per_Serving;
run;


