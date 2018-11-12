FROM arm32v7/openjdk:8-jdk

# Add logstash user and group first to make sure their IDs get assigned consistently
RUN groupadd -r elasticsearch && useradd -r -m -g elasticsearch elasticsearch

# Install dependencies
RUN apt-get update
RUN apt-get install -y \
    software-properties-common \
    libcurl4-openssl-dev \
    wget \
    curl

# Install Elasticsearch
ENV ES_VERSION 5.6.12
ENV ES_URL https://artifacts.elastic.co/downloads/elasticsearch/
ENV ES_HOME /usr/share/elasticsearch
RUN wget ${ES_URL}elasticsearch-${ES_VERSION}.deb && \
	dpkg -i elasticsearch-${ES_VERSION}.deb && \
  rm elasticsearch-${ES_VERSION}.deb
WORKDIR ${ES_HOME}
ENV PATH ${ES_HOME}/bin:$PATH

EXPOSE 9200 9300

COPY start.sh /
RUN chmod +x /start.sh

CMD ["/start.sh"]
