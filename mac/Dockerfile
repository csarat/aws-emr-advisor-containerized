# Use Amazon Corretto 17 as the base image
FROM amazoncorretto:17

# Set environment variables for Java
ENV JAVA_HOME=/usr/lib/jvm/java-17-amazon-corretto
ENV PATH=$JAVA_HOME/bin:$PATH

# Set environment variables for Hadoop and Spark
ENV HADOOP_VERSION=3.4.1
ENV SPARK_VERSION=3.5.4
ENV HADOOP_HOME=/opt/hadoop
ENV SPARK_HOME=/opt/spark
ENV PATH=$PATH:$HADOOP_HOME/bin:$SPARK_HOME/bin

# Install necessary tools
RUN yum -y update && \
    yum -y install unzip wget tar gzip git procps && \
    yum clean all

# Install AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf awscliv2.zip aws

#RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    #unzip awscliv2.zip && \
    #./aws/install && \
    #rm -rf awscliv2.zip aws

# Install Hadoop
RUN wget https://dlcdn.apache.org/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz && \
    tar -xzf hadoop-${HADOOP_VERSION}.tar.gz && \
    mv hadoop-${HADOOP_VERSION} ${HADOOP_HOME} && \
    rm hadoop-${HADOOP_VERSION}.tar.gz

# Install Spark
RUN wget https://dlcdn.apache.org/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop3.tgz && \
    tar -xzf spark-${SPARK_VERSION}-bin-hadoop3.tgz && \
    mv spark-${SPARK_VERSION}-bin-hadoop3 ${SPARK_HOME} && \
    rm spark-${SPARK_VERSION}-bin-hadoop3.tgz

# Install SBT
RUN curl -L https://www.scala-sbt.org/sbt-rpm.repo -o /etc/yum.repos.d/sbt-rpm.repo && \
    yum -y install sbt && \
    yum clean all

# Clone the repository and set the working directory
RUN git clone https://github.com/aws-samples/aws-emr-advisor.git /aws-emr-advisor
WORKDIR /aws-emr-advisor

# Build the project
RUN sbt clean compile assembly

# Create a script to run the application
COPY ./run_commands.sh /

# Make the script executable
RUN chmod +x /run_commands.sh

# Set the entry point to the script
ENTRYPOINT ["/bin/bash", "/run_commands.sh"]
