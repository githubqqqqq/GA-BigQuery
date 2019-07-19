##Authentication with web service. no need to download service account key, need to manually click on 'Allow' on Chrom the first time
##Benefit of this authentication is there is no need to have the permission to create service account key
##disadvantage of this authentication is you will need to manually click on the allow button and you need chrom installed


install.packages("bigrquery")

install.packages("devtools")
install.packages("readr")

devtools::install_github("rstats-db/bigrquery")

library(bigrquery)
 


###########################################################Get today's data################################################################
yesterday<- Sys.Date()-1
yesterday_str<-format(yesterday,"%Y%m%d")

yesterday_str


# Use your project ID here

project_id <- "projectid" # put your project ID here

# Example query

sql_string <- paste("select channelGrouping as C1 FROM   [projectid:viewid.ga_sessions_",yesterday_str,"] limit 10",sep="")


# Execute the query and store the result

query_results <- query_exec(sql_string, project = project_id, useLegacySql = FALSE)

query_results
 
 













