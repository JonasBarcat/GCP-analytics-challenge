#It's needed to create a Service Account with the correct permissions to connect to BigQuery
#This is a general example of api call request to bigquery

from flask import Flask, jsonify
from google.cloud import bigquery

app = Flask(__name__)

#construct BigQuery client
client = bigquery.Client()

#endpoint get name
@app.route('/api/name', methods=['GET'])
def query_bigquery():
    query = "SELECT * FROM `bigquery-public-data.dataset_id.table_id` LIMIT 10"
    #querying
    query_job = client.query(query)
    results = query_job.result()
    #become results in dictionary
    data = [dict(row) for row in results]
    #return as json
    return jsonify(data)


if __name__ == '__main__':
    app.run(debug=True)