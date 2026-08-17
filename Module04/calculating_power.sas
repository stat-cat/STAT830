
*sample power calculation;

*review options in proc power to match the experimental design you are interested in conducting.
This provides power for a one-way ANOVA test;

proc power; 
  onewayanova test=overall 
  alpha = .05 
  groupmeans = (0 5 10) /*you'd provide these estimated group means. This example involves a 3-level predictor with these estimated mean responses per level*/
  stddev = 3 /*standard deviation, sigma*/
  npergroup = 4   
  power = .; /*whichever option is left blank is the value that will be estimated given other parameters */
run;
