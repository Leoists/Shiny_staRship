library(rgl);
library(DT);
library(crosstalk);
library(dplyr);
library(stringr);


options(datatable.na.strings=c('NULL','','NA'));
options(DT.options=list(dom='Bfrtip',paging=F,scrollY='70vh' #'500px'
                        ,scrollX=TRUE #'20vw' #'100px'
                        ,pageLength= -1,class=c('display','compact','order-column')));
load('demo_data.rdata');
source('functions.R');
NULL
