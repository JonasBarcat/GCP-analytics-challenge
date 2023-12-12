# GCP Analytics IaC

This project is based on the requested challenge. A complete analytics system implemented on Google Cloud Platform. Considering a Source of Data sending information to a Pub/Sub topic, which one will push data to BigQuery (Data Base intended for analytics). External users can query this database via the API depicted in the architectural diagram. For analytics and monitoring, it's implemented a solution with Looker, for data analytics, and Cloud Monitoring to observe metrics.


![Architectural Diagram](/images/architecture.jpg)


## Prior Considerations

There are many assumptions to take in account.

- There is an external data source which is subscribed to Pub/Sub topic.
- All IAM roles and permissions are already created and assigned.
- Data for ingestion has a simple structure. User's FirstName for simplicity.

```json
{
    "name": "FirstName",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "client's first name"
  }
```
- In some resources, configurations are purely illustrative.
- Focus on the main structure. Detailed or in-depth configuration is discarded.


### Architectural explanation

1- *Data Ingestion* is achieved via Pub/Sub topic, external data sources can subscribe to the topic. Pub/Sub will directly send data to BigQuery via Push subscription, it means that Pub/Sub initiates requests to BigQuery to deliver messages.

2- *BigQuery* as a main database, it has been chosen because of it's analytics purposes. It can be connected to Looker (for analytics) and Cloud Functions (for specific functionality). 

3- *API HTTP* made in python. Cloud Functions is the solution to run the API python code. The code is stored in a Cloud Storage (bucket). Cloud Function consumes the code from the bucket and deploys it. This program queries BigQuery Database to get information and expose it to the clients.

4- *Analytics and Monitoring*. In the one hand, the service to implement analytics is Looker, to explore and share insights in real time BigQuery Data. On the other hand, Cloud Monitoring is the preferred service for metrics and monitoring.



## Metrics and Monitoring

There were proposed 3 metrics for monitoring, these metrics were chosen according to aim project functionality.

- API Requests/minute.
- Successful GET.
- Failed GET.

We implement these metrics via Cloud Monitoring in order to diagnose the system and API health. Also, information schema can be Monitored and logged, for future enhancements. Cloud Monitoring collects API metrics information and  expose it in a dashboard in a human-friendly way.

In case of scale to multiple systems we can separate and group dashboards regarding to the correspondent analytics system. If scalability problems are not faced, then you may affront one dashboard with multiple metrics becoming it confusing and unintelligible. it's worth mentioning that thinking on scalability makes systems easier to maintain.

![Illustrative chart](/images/monitoringdashboard.jpg)


The above illustrative image depicts how API metrics should be shown.


## Deployment

In the next image you can find the basic idea from where to start creating pipeline for CI/CD. It uses a Boolean variable to define if it's needed to deploy the infrastructure to cloud or to remove infrastructure via labels. Also when a new feature is added then pipeline is triggered and according to input variable value it will choose one flow. For CI stage, the project is tested and once passed then it is integrated to create a new artifact for future consumption. CD stage consumes the beforehand created artifact and deploys the code, runs the terraform apply/destroy command.

![Pipeline design](/images/pipelinediagram.jpg)

## Future Enhancements

 - [ ] Resources labeling for easier resources management.
 - [ ] API proxy with Cloud Endpoints.
 - [ ] Security with Cloud Armor.
 - [ ] Data standardization for ingestion.

