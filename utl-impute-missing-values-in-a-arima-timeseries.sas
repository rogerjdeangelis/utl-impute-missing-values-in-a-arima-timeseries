Stackexchange: Impute missing values in a arima timeseries                                                                
                                                                                                                          
githib                                                                                                                    
https://tinyurl.com/y58vp94u                                                                                              
https://github.com/rogerjdeangelis/utl-impute-missing-values-in-a-arima-timeseries                                        
                                                                                                                          
To forcast the next twelve months see                                                                                     
https://tinyurl.com/y6x7rn5c                                                                                              
https://github.com/rogerjdeangelis?tab=repositories&q=forecast&type=&language=                                            
                                                                                                                          
To forecast the next 12 months see                                                                                        
                                                                                                                          
Problem:                                                                                                                  
                                                                                                                          
    Jan-Nov of 1954 have missing values. We need to impute those 11                                                       
    consecutive months.                                                                                                   
                                                                                                                          
     1953           1954        1955           1956                                                                       
       ---------------+----------+----------------                                                                        
   6.0 +              |          |               + 6.0                                                                    
       |              | We need  |      .        |                                                                        
       |              | to impute|       .       |                                                                        
       |              | the      |     .         |                                                                        
       |              | missing  |        .      |                                                                        
       |              | 11 months|         . .   |                                                                        
       |        ..    | in 1954  |  ...          |                                                                        
   5.5 +       .  .   |          |.         .    + 5.5                                                                    
       |    ...       |          . .             |                                                                        
       |           .  |          |               |                                                                        
       | ...          |          |               |                                                                        
       |            . |          |               |                                                                        
       |.             |          |               |                                                                        
       |              |          |               |                                                                        
   5.0 +              |          |               + 5.0                                                                    
       ---------------+----------+----------------                                                                        
     1953           1954        1955           1956                                                                       
                                                                                                                          
                           YEARS                                                                                          
                                                                                                                          
Related links                                                                                                             
https://tinyurl.com/yy9jjmvb                                                                                              
https://stats.stackexchange.com/questions/104565/how-to-use-auto-arima-to-impute-missing-values                           
                                                                                                                          
Javlacalle profile                                                                                                        
https://stats.stackexchange.com/users/48766/javlacalle                                                                    
                                                                                                                          
https://tinyurl.com/y6cuyw8n                                                                                              
https://communities.sas.com/t5/New-SAS-User/forecasting-of-credit-card-bank-profit-for-next-12-months/m-p/678959          
                                                                                                                          
Forecast profits for the next twelve months                                                                               
                                                                                                                          
There appears to be a faily four month component so instaead of                                                           
an arima model I would just forecasr profits as the average the months.                                                   
                                                                                                                          
Here is a plot of the monthly averages for the three years.                                                               
Use this as the 2007 forecast.                                                                                            
                                                                                                                          
                                                                                                                          
%utl_submit_r64('                                                                                                         
 library(xts);                                                                                                            
 library(forecast);                                                                                                       
 library(dplyr);                                                                                                          
 library(tsbox);                                                                                                          
 library(haven);                                                                                                          
 library(data.table);                                                                                                     
 library(SASxport);                                                                                                       
want<- ts_df(log(AirPassengers));                                                                                         
want;                                                                                                                     
write.xport(want,file="d:/xpt/want.xpt");                                                                                 
');                                                                                                                       
                                                                                                                          
                                                                                                                          
proc datasets lib=work nolist;                                                                                            
 delete  want;                                                                                                            
run;quit;                                                                                                                 
                                                                                                                          
libname xpt xport "d:/xpt/want.xpt";                                                                                      
data want;                                                                                                                
  set xpt.want;                                                                                                           
run;quit;                                                                                                                 
libname xpt clear;                                                                                                        
                                                                                                                          
data sd1.have sd1.havMis;                                                                                                 
   retain year month date value;                                                                                          
   format date date9.;                                                                                                    
   set want(rename=time=date);                                                                                            
   *if _n_ in (10,60:71,100,130) then value=.;                                                                            
   year=year(date);                                                                                                       
   month=_n_;                                                                                                             
   put year +1 month +1 date mmddyy6. +1 value 7.4 +1  @@;                                                                
run;quit;                                                                                                                 
                                                                                                                          
data sd1.have sd1.havMis;                                                                                                 
   retain year month date value;                                                                                          
   format date date9.;                                                                                                    
   set want(rename=time=date);                                                                                            
   put date mmddyy6. value 7.4 +1 @@;                                                                                     
run;quit;                                                                                                                 
                                                                                                                          
                                                                                                                          
/*                   _                                                                                                    
(_)_ __  _ __  _   _| |_                                                                                                  
| | `_ \| `_ \| | | | __|                                                                                                 
| | | | | |_) | |_| | |_                                                                                                  
|_|_| |_| .__/ \__,_|\__|                                                                                                 
        |_|                                                                                                               
*/                                                                                                                        
                                                                                                                          
options validvarname=upcase;                                                                                              
data sd1.havMis ;                                                                                                         
   retain year month ;                                                                                                    
   format date mmddyy10. value 7.4;                                                                                       
   informat date mmddyy6. value 7.4;                                                                                      
   input date  value 7.4  @@;                                                                                             
   value=value+uniform(1234)/1e5;                                                                                         
   year=year(date);                                                                                                       
   month=_n_;                                                                                                             
   original_value=value;                                                                                                  
   if _n_ in (10,60:71,100,130) then value=.;                                                                             
   output sd1.havMis;                                                                                                     
cards;                                                                                                                    
010149 4.7185 020149 4.7707 030149 4.8828 040149 4.8598 050149 4.7958 060149 4.9053 070149 4.9972                         
080149 4.9972 090149 4.9127 100149 4.7791 110149 4.6444 120149 4.7707 010150 4.7449 020150 4.8363                         
030150 4.9488 040150 4.9053 050150 4.8283 060150 5.0039 070150 5.1358 080150 5.1358 090150 5.0626                         
100150 4.8903 110150 4.7362 120150 4.9416 010151 4.9767 020151 5.0106 030151 5.1818 040151 5.0938                         
050151 5.1475 060151 5.1818 070151 5.2933 080151 5.2933 090151 5.2149 100151 5.0876 110151 4.9836                         
120151 5.1120 010152 5.1417 020152 5.1930 030152 5.2627 040152 5.1985 050152 5.2095 060152 5.3845                         
070152 5.4381 080152 5.4889 090152 5.3423 100152 5.2523 110152 5.1475 120152 5.2679 010153 5.2781                         
020153 5.2781 030153 5.4638 040153 5.4596 050153 5.4337 060153 5.4931 070153 5.5759 080153 5.6058                         
090153 5.4681 100153 5.3519 110153 5.1930 120153 5.3033 010154 5.3181 020154 5.2364 030154 5.4596                         
040154 5.4250 050154 5.4553 060154 5.5759 070154 5.7104 080154 5.6802 090154 5.5568 100154 5.4337                         
110154 5.3132 120154 5.4337 010155 5.4889 020155 5.4510 030155 5.5872 040155 5.5947 050155 5.5984                         
060155 5.7526 070155 5.8972 080155 5.8493 090155 5.7430 100155 5.6131 110155 5.4681 120155 5.6276                         
010156 5.6490 020156 5.6240 030156 5.7589 040156 5.7462 050156 5.7621 060156 5.9243 070156 6.0234                         
080156 6.0039 090156 5.8721 100156 5.7236 110156 5.6021 120156 5.7236 010157 5.7526 020157 5.7071                         
030157 5.8749 040157 5.8522 050157 5.8721 060157 6.0450 070157 6.1420 080157 6.1463 090157 6.0014                         
100157 5.8493 110157 5.7203 120157 5.8171 010158 5.8289 020158 5.7621 030158 5.8916 040158 5.8522                         
050158 5.8944 060158 6.0753 070158 6.1964 080158 6.2246 090158 6.0014 100158 5.8833 110158 5.7366                         
120158 5.8201 010159 5.8861 020159 5.8348 030159 6.0064 040159 5.9814 050159 6.0403 060159 6.1570                         
070159 6.3063 080159 6.3261 090159 6.1377 100159 6.0088 110159 5.8916 120159 6.0039 010160 6.0331                         
020160 5.9687 030160 6.0379 040160 6.1334 050160 6.1570 060160 6.2823 070160 6.4329 080160 6.4069                         
090160 6.2305 100160 6.1334 110160 5.9661 120160 6.0684                                                                   
;;;;                                                                                                                      
run;quit;                                                                                                                 
                                                                                                                          
                                                                                                                          
SD1.HAVMIS total obs=144                                                                                                  
                                                                                                                          
                                       ORIGINAL_                                                                          
 YEAR    MONTH     DATE      VALUE       VALUE                                                                            
                                                                                                                          
 1949       1     JAN1949    4.7185      4.7185                                                                           
 1949       2     FEB1949    4.7707      4.7707                                                                           
 1949       3     MAR1949    4.8828      4.8828                                                                           
 1949       4     APR1949    4.8598      4.8598                                                                           
 1949       5     MAY1949    4.7958      4.7958                                                                           
 1949       6     JUN1949    4.9053      4.9053                                                                           
 1949       7     JUL1949    4.9972      4.9972                                                                           
 1949       8     AUG1949    4.9972      4.9972                                                                           
 1949       9     SEP1949    4.9127      4.9127                                                                           
 1949      10     OCT1949     .          4.7791                                                                           
 1949      11     NOV1949    4.6444      4.6444                                                                           
 1949      12     DEC1949    4.7707      4.7707                                                                           
,,,,                                                                                                                      
                                                                                                                          
 1954      61     JAN1954     .          5.3181   Let see how well we can estimate                                        
 1954      62     FEB1954     .          5.2364   the missing months in 1954                                              
 1954      63     MAR1954     .          5.4596                                                                           
 1954      64     APR1954     .          5.4250                                                                           
 1954      65     MAY1954     .          5.4553                                                                           
 1954      66     JUN1954     .          5.5759                                                                           
 1954      67     JUL1954     .          5.7104                                                                           
 1954      68     AUG1954     .          5.6802                                                                           
 1954      69     SEP1954     .          5.5568                                                                           
 1954      70     OCT1954     .          5.4337                                                                           
 1954      71     NOV1954     .          5.3132                                                                           
 1954      72     DEC1954    5.4337      5.4337                                                                           
....                                                                                                                      
 1960     133     JAN1960    6.0331      6.0331                                                                           
 1960     134     FEB1960    5.9687      5.9687                                                                           
 1960     135     MAR1960    6.0379      6.0379                                                                           
 1960     136     APR1960    6.1334      6.1334                                                                           
 1960     137     MAY1960    6.1570      6.1570                                                                           
 1960     138     JUN1960    6.2823      6.2823                                                                           
 1960     139     JUL1960    6.4329      6.4329                                                                           
 1960     140     AUG1960    6.4069      6.4069                                                                           
 1960     141     SEP1960    6.2305      6.2305                                                                           
 1960     142     OCT1960    6.1334      6.1334                                                                           
 1960     143     NOV1960    5.9661      5.9661                                                                           
 1960     144     DEC1960    6.0684      6.0684                                                                           
                                                                                                                          
                                                                                                                          
options ls=64 ps=32;                                                                                                      
proc plot data=sd1.havMis (obs=85);                                                                                       
  plot value*month='.' / box haxis=49 to 85 href=61 72;                                                                   
run;quit;                                                                                                                 
                                                                                                                          
                                                                                                                          
    Jan-Nov of 1954 have missing values. We need to impute those 11                                                       
    consecutive months.                                                                                                   
                                                                                                                          
     1953           1954        1955           1956                                                                       
       ---------------+----------+----------------                                                                        
   6.0 +              |          |               + 6.0                                                                    
       |              | We need  |      .        |                                                                        
       |              | to impute|       .       |                                                                        
       |              | the      |     .         |                                                                        
       |              | missing  |        .      |                                                                        
       |              | 11 months|         . ..  |                                                                        
       |        ..    | in 1954  |  ...          |                                                                        
   5.5 +       .  .   |          |.         .    + 5.5                                                                    
       |    ...       |          . .             |                                                                        
       |           .  |          |               |                                                                        
       | ...          |          |               |                                                                        
       |            . |          |               |                                                                        
       |.             |          |               |                                                                        
       |              |          |               |                                                                        
   5.0 +              |          |               + 5.0                                                                    
       ---------------+----------+----------------                                                                        
     1953           1954        1955           1956                                                                       
                                                                                                                          
                           YEARS                                                                                          
                                                                                                                          
                                                                                                                          
options ls=64 ps=32;                                                                                                      
proc plot data=want (where=(49<=month<=85));                                                                              
  format time year.;                                                                                                      
  plot value*month='.' original_value*month='o' / overlay box haxis=49 to 85 href=61 72;                                  
run;quit;                                                                                                                 
                                                                                                                          
/*           _               _                                                                                            
  ___  _   _| |_ _ __  _   _| |_                                                                                          
 / _ \| | | | __| `_ \| | | | __|                                                                                         
| (_) | |_| | |_| |_) | |_| | |_                                                                                          
 \___/ \__,_|\__| .__/ \__,_|\__|                                                                                         
                |_|                                                                                                       
*/                                                                                                                        
                                                                                                                          
 Plot of VALUE*MONTH.           Symbol used is '.'.                                                                       
 Plot of ORIGINAL_VALUE*MONTH.  Symbol used is 'o'.                                                                       
                                                                                                                          
       ---------------+----------+----------------                                                                        
   6.0 +              |          |               + 6.0                                                                    
       |              |o=observed|               |                                                                        
       |              |i=imputed |      o        |                                                                        
       |              |          |       o       |                                                                        
   5.8 +              |          |               + 5.8                                                                    
       |              |          |     o  o      |        Month YR   Residual                                             
 VALUE |              |     oo   |               |        ========   ========                                             
       |              |          |           oo  |           JAN54   -0.05                                                
   5.6 +        oo    |   ii     |  ooo    o     + 5.6       FEB54    0.12                                                
       |              |  o  i o  |               |           MAR54    0.02                                                
       |       o      | i    i   |o              |           APR54    0.13                                                
       |    ooo   o   | o     io i o        o    |           MAY54    0.15                                                
   5.4 +              | o      i |               + 5.4       JUN54    0.02                                                
       |           o  |i        i|               |           JUL54   -0.15                                                
       |  oo          o         o|               |           AUG54   -0.18                                                
       |              oo         |               |           SEP54   -0.12                                                
   5.2 +            o |          |               + 5.2       OCT54   -0.05                                                
       |             o|          |               |           NOV54    0.04                                                
       |              |          |               |           DEC54    0.00                                                
       |              |          |               |                                                                        
   5.0 +              |          |               + 5.0                                                                    
       ---------------+----------+----------------                                                                        
     1953           1954        1955           1956                                                                       
                                                                                                                          
                                                                                                                          
WORK.WANT total obs=14                                                                                                    
                                  MISSING_ ORIGINAL_                                                                      
  DATE     TIME    MONTH  VALUE   VALUES    VALUES   RESIDUAL                                                             
                                                                                                                          
 JAN49 01/01/1949   1   4.71850  4.7185   4.71850  0.0000000                                                              
 FEB49 02/01/1949   2   4.77070  4.7707   4.77070  0.0000000                                                              
 MAR49 03/01/1949   3   4.88280  4.8828   4.88280  0.0000000                                                              
 APR49 04/01/1949   4   4.85980  4.8598   4.85980  0.0000000                                                              
 MAY49 05/01/1949   5   4.79580  4.7958   4.79580  0.0000000                                                              
 JUN49 06/01/1949   6   4.90530  4.9053   4.90530  0.0000000                                                              
 JUL49 07/01/1949   7   4.99720  4.9972   4.99720  0.0000000                                                              
 AUG49 08/01/1949   8   4.99720  4.9972   4.99720  0.0000000                                                              
 SEP49 09/01/1949   9   4.91270  4.9127   4.91270  0.0000000                                                              
 OCT49 10/01/1949  10   4.77768   .       4.77910  -.0014222                                                              
 NOV49 11/01/1949  11   4.64440  4.6444   4.64440  0.0000000                                                              
 DEC49 12/01/1949  12   4.77070  4.7707   4.77070  0.0000000                                                              
 ..                                                                                                                       
                                                                                                                          
 JAN54 01/01/1954  61   5.26418   .       5.31811  -0.05393                                                               
 FEB54 02/01/1954  62   5.35853   .       5.23641   0.12213                                                               
 MAR54 03/01/1954  63   5.48122   .       5.45960   0.02162                                                               
 APR54 04/01/1954  64   5.55953   .       5.42501   0.13452                                                               
 MAY54 05/01/1954  65   5.60667   .       5.45530   0.15136                                                               
 JUN54 06/01/1954  66   5.59834   .       5.57590   0.02244                                                               
 JUL54 07/01/1954  67   5.55822   .       5.71041  -0.15218                                                               
 AUG54 08/01/1954  68   5.49340   .       5.68021  -0.18681                                                               
 SEP54 09/01/1954  69   5.43026   .       5.55680  -0.12655                                                               
 OCT54 10/01/1954  70   5.38047   .       5.43370  -0.05324                                                               
 NOV54 11/01/1954  71   5.35714   .       5.31321   0.04393                                                               
 DEC54 12/01/1954  72   5.43371  5.4337   5.43371   0.00000                                                               
...                                                                                                                       
                                                                                                                          
 JAN60 01/01/1960  133  6.03311  6.0331   6.03311      0                                                                  
 FEB60 02/01/1960  134  5.96871  5.9687   5.96871      0                                                                  
 MAR60 03/01/1960  135  6.03791  6.0379   6.03791      0                                                                  
 APR60 04/01/1960  136  6.13340  6.1334   6.13340      0                                                                  
 MAY60 05/01/1960  137  6.15700  6.1570   6.15700      0                                                                  
 JUN60 06/01/1960  138  6.28231  6.2823   6.28231      0                                                                  
 JUL60 07/01/1960  139  6.43290  6.4329   6.43290      0                                                                  
 AUG60 08/01/1960  140  6.40691  6.4069   6.40691      0                                                                  
 SEP60 09/01/1960  141  6.23051  6.2305   6.23051      0                                                                  
 OCT60 10/01/1960  142  6.13340  6.1334   6.13340      0                                                                  
 NOV60 11/01/1960  143  5.96611  5.9661   5.96611      0                                                                  
 DEC60 12/01/1960  144  6.06841  6.0684   6.06841      0                                                                  
                                                                                                                          
/*                                                                                                                        
 _ __  _ __ ___   ___ ___  ___ ___                                                                                        
| `_ \| `__/ _ \ / __/ _ \/ __/ __|                                                                                       
| |_) | | | (_) | (_|  __/\__ \__ \                                                                                       
| .__/|_|  \___/ \___\___||___/___/                                                                                       
|_|                                                                                                                       
*/                                                                                                                        
                                                                                                                          
%utlfkil(d:/txt/pgm.txt);                                                                                                 
                                                                                                                          
* WORKS;                                                                                                                  
%utl_submit_r64('                                                                                                         
 library(xts);                                                                                                            
 library(forecast);                                                                                                       
 library(dplyr);                                                                                                          
 library(tsbox);                                                                                                          
 library(haven);                                                                                                          
 library(data.table);                                                                                                     
 library(SASxport);                                                                                                       
 havmis<-read_sas("d:/sd1/havMis.sas7bdat")[,3:4];                                                                        
 x <- xts(havmis[,-1], order.by = havmis$DATE);                                                                           
 y<-x;                                                                                                                    
 fit <- auto.arima(x);                                                                                                    
 summary(fit);                                                                                                            
 kr <- KalmanRun(x, fit$model);                                                                                           
 id.na <- which(is.na(x));                                                                                                
 "ID.NA";                                                                                                                 
 id.na;                                                                                                                   
 "List of miissing values Y[ID.NA]";                                                                                      
 y[id.na];                                                                                                                
 for (i in id.na) y[i] <- fit$model$Z %*% kr$states[i,];                                                                  
 sapply(id.na, FUN = function(x, Z, alpha) Z %*% alpha[x,],Z = fit$model$Z, alpha = kr$states);                           
 "Imputed values Y[ID.NA]";                                                                                               
 y[id.na];                                                                                                                
 "Y";                                                                                                                     
 want<- ts_df(y);                                                                                                         
 write.xport(want,file="d:/xpt/want.xpt");                                                                                
');                                                                                                                       
                                                                                                                          
proc datasets lib=work nolist;                                                                                            
 delete  want;                                                                                                            
run;quit;                                                                                                                 
                                                                                                                          
libname xpt xport "d:/xpt/want.xpt";                                                                                      
data want;                                                                                                                
  format date monyy5.;                                                                                                    
  merge xpt.want sd1.havmis(keep=original_value);                                                                         
  date=time;                                                                                                              
  month=_n_;                                                                                                              
  residual=value-original_value;                                                                                          
run;quit;                                                                                                                 
libname xpt clear;                                                                                                        
                                                                                                                          
/*                                                                                                                        
| | ___   __ _                                                                                                            
| |/ _ \ / _` |                                                                                                           
| | (_) | (_| |                                                                                                           
|_|\___/ \__, |                                                                                                           
         |___/                                                                                                            
*/                                                                                                                        
                                                                                                                          
 ARIMA(3,1,3) with drift                                                                                                  
                                                                                                                          
 Coefficients:                                                                                                            
          ar1     ar2      ar3      ma1      ma2     ma3   drift                                                          
       0.8869  0.2599  -0.5745  -0.9852  -0.7370  0.8133  0.0101                                                          
 s.e.  0.1250  0.1921   0.1182   0.1011   0.1457  0.0893  0.0015                                                          
                                                                                                                          
 sigma^2 estimated as 0.006736:  log likelihood=136.39                                                                    
 AIC=-256.77   AICc=-255.7   BIC=-233.07                                                                                  
                                                                                                                          
 Training set error measures:                                                                                             
                       ME       RMSE       MAE        MPE     MAP                                                         
 E      MASE                                                                                                              
 Training set 0.001598417 0.07948823 0.0665744 0.01865762 1.20914                                                         
 7 0.7417884                                                                                                              
                     ACF1                                                                                                 
 Training set -0.04820165                                                                                                 
 [1] "ID.NA"                                                                                                              
  [1]  10  60  61  62  63  64  65  66  67  68  69  70  71 100 130                                                         
                                                                                                                          
 [1] "List of miissing values Y[ID.NA]"                                                                                   
            VALUE                                                                                                         
 1949-10-01    NA                                                                                                         
 1953-12-01    NA                                                                                                         
 1954-01-01    NA                                                                                                         
 1954-02-01    NA                                                                                                         
 1954-03-01    NA                                                                                                         
 1954-04-01    NA                                                                                                         
 1954-05-01    NA                                                                                                         
 1954-06-01    NA                                                                                                         
 1954-07-01    NA                                                                                                         
 1954-08-01    NA                                                                                                         
 1954-09-01    NA                                                                                                         
 1954-10-01    NA                                                                                                         
 1954-11-01    NA                                                                                                         
 1957-04-01    NA                                                                                                         
 1959-10-01    NA                                                                                                         
                                                                                                                          
 [1] "Imputed values Y[ID.NA]"                                                                                            
               VALUE                                                                                                      
 1949-10-01 4.777679                                                                                                      
 1953-12-01 5.168427                                                                                                      
 1954-01-01 5.264181                                                                                                      
 1954-02-01 5.358533                                                                                                      
 1954-03-01 5.481216                                                                                                      
 1954-04-01 5.559532                                                                                                      
 1954-05-01 5.606667                                                                                                      
 1954-06-01 5.598344                                                                                                      
 1954-07-01 5.558221                                                                                                      
 1954-08-01 5.493396                                                                                                      
 1954-09-01 5.430258                                                                                                      
 1954-10-01 5.380466                                                                                                      
 1954-11-01 5.357140                                                                                                      
 1957-04-01 5.925411                                                                                                      
 1959-10-01 5.956306                                                                                                      
                                                                                                                          
                                                                                                                          
