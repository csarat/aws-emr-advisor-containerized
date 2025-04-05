# aws-emr-advisor-containerized
EMR advisor containerized

```
docker build -t aws-emr-advisor:local .
docker stop aws-emr-advisor || true
docker rm aws-emr-advisor || true
docker run -it --name aws-emr-advisor aws-emr-advisor:local s3://bucket/logs/emr-serverless/applications/applicationId/jobs/jobrunId/sparklobs/eventlog_v2_jobrunId/
```