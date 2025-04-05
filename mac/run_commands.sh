#!/bin/bash
export S3_LOG_PATH=$1
if [ -z "$S3_LOG_PATH" ]; then
  echo "Please provide both S3_LOG_PATH"
  exit 1
fi
echo "Load path ${S3_LOG_PATH}"
rm -rf /tmp/emr_logs
mkdir -p /tmp/emr_logs
aws s3 cp ${S3_LOG_PATH} /tmp/emr_logs/ --recursive
if [ "$(ls -A /tmp/emr_logs)" ]; then
  echo "Logs downloaded successfully."
else
  echo "No logs found in ${S3_LOG_PATH}"
  exit 1
fi
# for log_file in /tmp/emr_logs/*; do
#   echo "Processing $log_file"
#   spark-submit --deploy-mode client --class com.amazonaws.emr.SparkLogsAnalyzer /aws-emr-advisor/target/scala-2.12/aws-emr-advisor-assembly-0.3.0.jar $log_file
# done
# for report in /tmp/*.html; do
#   if [ -f "$report" ]; then
#     aws s3 cp "$report" s3://${BUCKET_NAME}/emr_advisor_output/
#     echo "Report uploaded to s3://${BUCKET_NAME}/emr_advisor_output/$(basename $report)"
#   fi
# done

spark-submit --deploy-mode client --class com.amazonaws.emr.SparkLogsAnalyzer /aws-emr-advisor/target/scala-2.12/aws-emr-advisor-assembly-0.3.0.jar /tmp/emr_logs
