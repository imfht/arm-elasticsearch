FROM arm32v7/ubuntu

# Configure envars
ENV ES_VERSION 5.6.12
ENV ES_URL=https://artifacts.elastic.co/downloads/elasticsearch/

# Install dependencies
RUN apt-get update
RUN apt-get install -y \
    software-properties-common \
    libcurl4-openssl-dev \
    wget \
    curl
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get update
RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
RUN apt-get install -y oracle-java8-installer

RUN wget ${ES_URL}elasticsearch-${ES_VERSION}.deb && \
	dpkg -i elasticsearch-${ES_VERSION}.deb

COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh
# COPY config/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml
# COPY config/jvm.options /etc/elasticsearch/jvm.options
# COPY config/log4j2.properties /etc/elasticsearch/log4j2.properties

RUN rm elasticsearch-${ES_VERSION}.deb

EXPOSE 9200 9300

CMD ["/usr/local/bin/start.sh"]
