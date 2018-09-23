* hw3.sas
  written by Steve Simon
  September 23, 2018;

** preliminaries **;

ods pdf
 file="/folders/myfolders/survival-lecture3/sas/hw3.pdf";

*
  1. Recalculate the sample size in the lecture if the 
  early dropout rate is 0.1 or 0.3 instead of 0.2.
;

data adjustment;
  do i = 1 to 3;
    dropout_rate = i / 10;
    m1 = 25;
    m2 = 50;
    lambda = 0.4;
    t = 3;
    adj1 = (1 - dropout_rate) * (1 - exp(-lambda*t));
    adj2 = (1 - dropout_rate) * (1 - exp(-2*lambda*t));
    n1 = m1 / adj1;
    n2 = m2 / adj2;
    output;
  end;
run;

proc print data=adjustment;
run;

*
  2. Recalculate the sample size if the average time of 
  follow up is 2 years or 4 years instead of 3 years.
;

data adjustment;
  do i = 1 to 3;
    t = i + 1;
    m1 = 25;
    m2 = 50;
    lambda = 0.4;
    dropout_rate = 0.2;
    adj1 = (1 - dropout_rate) * (1 - exp(-lambda*t));
    adj2 = (1 - dropout_rate) * (1 - exp(-2*lambda*t));
    n1 = m1 / adj1;
    n2 = m2 / adj2;
    output;
  end;
run;

proc print data=adjustment;
run;

*
  3. Recalculate the sample size if the baseline hazard 
  is 0.2 or 0.6 instead of 0.4.
;

data adjustment;
  do i = 1 to 3;
    dropout_rate = 0.2;
    m1 = 25;
    m2 = 50;
    lambda = 2*i / 10;
    t = 3;
    adj1 = (1 - dropout_rate) * (1 - exp(-lambda*t));
    adj2 = (1 - dropout_rate) * (1 - exp(-2*lambda*t));
    n1 = m1 / adj1;
    n2 = m2 / adj2;
    output;
  end;
run;

proc print data=adjustment;
run;

*
  4. Recalculate the sample size if the hazard ratio is 
  1.8 or 2.2 instead of 2.0.
;

data sample_size;
  do i = 1 to 3;
    hr = 2.0 + (i-2)*0.2; 
    theta = log(hr);
    pi = 0.33;
    z_alpha = probit(0.975);
    z_beta = probit(0.8);
    m = (z_alpha+z_beta)**2/(theta**2*pi*(1-pi));
    output;
  end;
run;

proc print data=sample_size;
run;

ods pdf close;
