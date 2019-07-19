#Reference: https://pandas-gbq.readthedocs.io/en/latest/

#python -m pip install pandas-gbq -U
 

from google.cloud import bigquery

from google.oauth2 import service_account

import pandas_gbq


credentials = service_account.Credentials.from_service_account_file('path/servicekey.json')

pj_id='projectid'

sql="SELECT visitorid,totals.visits,totals.hits,hits.hour FROM [projectid:viewid.ga_sessions_20190130] limit 5"

df = pandas_gbq.read_gbq(sql, project_id=pj_id, credentials=credentials)



