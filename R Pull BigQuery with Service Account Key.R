##Authentication with service account key. First need to create a service account key in GCP consol and download the Json file to a local folder
##Benefit of this authentication is there is no need for manual click on the web to authenticate


install.packages("googleAuthR")

library(googleAuthR) ##this package manages the authentication with service account key
library(bigrquery) ##this package manages data query



#set scope
#list of all scopes: https://developers.google.com/identity/protocols/googlescopes

options(googleAuthR.scopes.selected='https://www.googleapis.com/auth/bigquery') 


#Authentication:
service_token <- gar_auth_service(json_file="C:/path/token.json")
 

#Start pulling data
SELECT clientId,date,hits.eventInfo.eventCategory	
FROM `projectid.viewid.ga_sessions_*`
where _TABLE_SUFFIX > '20190101'  

sql_string <- "select visitId, hits.eventInfo.eventCategory,hits.eventInfo.eventValue,date
FROM   [projectid:viewid.ga_sessions_20190201],
[projectid:viewid.ga_sessions_20190202]
where hits.eventInfo.eventCategory='lead_score'
"

sql_string <- "
SELECT
clientId,hits.eventInfo.eventCategory,hits.sourcePropertyInfo.sourcePropertyDisplayName,date
FROM
(TABLE_DATE_RANGE_STRICT([projectid:viewid.ga_sessions_],
TIMESTAMP('2019-01-01'),
TIMESTAMP('2019-01-30')))
where hits.eventInfo.eventCategory='lead_score'
"
project_id <- "projectid" # put your project ID here

query_results <- query_exec(sql_string, project = project_id, useLegacySql = FALSE)


head(query_results)
nrow(query_results)


sql_string <- "
SELECT
clientId,hits.customDimensions.index,hits.customDimensions.value,date
FROM
(TABLE_DATE_RANGE_STRICT([projectid:viewid.ga_sessions_],
TIMESTAMP('2019-01-01'),
TIMESTAMP('2019-01-30')))
where  hits.customDimensions.index=113
"
project_id <- "projectid" # put your project ID here

query_results2 <- query_exec(sql_string, project = project_id, useLegacySql = FALSE)

head(query_results2)
nrow(query_results2)



