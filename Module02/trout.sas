/* trout.sas, trout experiment, Table 5.10, p125 */

/* Read in trout data */
data trout;
  length SULFA 8 HEMO 8;
  input SULFA HEMO;
  datalines;
1 6.7
1 7.8
1 5.5
1 8.4
1 7.0
1 7.8
1 8.6
1 7.4
1 5.8
1 7.0
2 9.9
2 8.4
2 10.4
2 9.3
2 10.7
2 11.9
2 7.1
2 6.4
2 8.6
2 10.6
3 10.4
3 8.1
3 10.6
3 8.7
3 10.7
3 9.1
3 8.8
3 8.1
3 7.8
3 8.0
4 9.3
4 9.3
4 7.2
4 7.8
4 9.3
4 10.2
4 8.7
4 8.6
4 9.3
4 7.2
;
run;

/* Boxplot of Hemoglobin by treatment (SULFA) */
proc sgplot data=trout;
  vbox HEMO / category=SULFA;
  xaxis label="Treatment";
  yaxis label="Hemoglobin (grams per 100 ml)";
  title "Hemoglobin by Treatment";
run;

/* One-way ANOVA treating SULFA as a categorical factor */
proc glm data=trout plots=diagnostics(unpack);
  class SULFA;
  model HEMO = SULFA;
  /* Save fitted values and residuals */
  output out=diag p=Pred r=Resid ;
quit;

/* Residuals vs Fitted */
proc sgplot data=diag;
  scatter x=Pred y=Resid / markerattrs=(symbol=CircleFilled);
  refline 0 / axis=y;
  xaxis label="Fitted Values";
  yaxis label="Residuals";
  title "Residuals vs Fitted";
run;

/* Residuals vs Treatment Factor */
proc sgplot data=diag;
  scatter x=SULFA y=Resid / markerattrs=(symbol=CircleFilled);
  refline 0 / axis=y;
  xaxis label="SULFA";
  yaxis label="Residuals";
  title "Residuals vs Treatment";
run;

/* Normal Q–Q of Residuals */
proc univariate data=diag noprint;
  var Resid;
  qqplot Resid / normal(mu=est sigma=est)
                 square
                 odstitle="Normal Q–Q Plot of Studentized Residuals";
run;



