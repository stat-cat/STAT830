/* Map numeric treatment codes to labeled categories */
proc format;
  value trtfmt
    1 = 'Commercial'
    2 = 'Vacuum'
    3 = 'Mixed Gas'
    4 = 'CO2';
run;

/* Read in the data */
data meat_packing;
  length Steak 8 Treatment 8 Count 8;
  input Steak Treatment Count;
  format Treatment trtfmt.;
  datalines;
1  1  7.66
6  1  6.98
7  1  7.80
12 2  5.26
5  2  5.44
3  2  5.80
10 3  7.41
9  3  7.33
2  3  7.04
8  4  3.51
4  4  2.91
11 4  3.66
;
run;

/* Boxplot of (log) bacterial counts by packaging technique */
proc sgplot data=meat_packing;
  vbox Count / category=Treatment;
  xaxis label="Packaging technique";
  yaxis label="Log(count/cm2) of bacteria";
  title "Log Bacterial Count by Packaging Technique";
run;

/* One-way ANOVA treating Treatment as a categorical factor */
proc glm data=meat_packing plots=diagnostics(unpack);
  class Treatment;
  model Count = Treatment;
quit;

/* Critical F value at alpha = 0.05 for df1=3, df2=8 */
data Fcrit;
  /* Upper-tail 0.05 critical value = 95th percentile */
  F_crit1 = quantile('F', 0.95, 3, 8);
  /* Equivalent function */
  F_crit2 = finv(0.95, 3, 8);
  put "F_crit (quantile) = " F_crit1 8.4;
  put "F_crit (finv)     = " F_crit2 8.4;
run;

proc print data=Fcrit;
run;
