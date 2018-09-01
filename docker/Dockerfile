FROM arm32v7/ubuntu

# Configure envars
ENV ES_VERSION 6.3.2
ENV ES_URL=https://artifacts.elastic.co/downloads/elasticsearch/
ENV ES_HOME /opt/elasticsearch
ENV ES_PACKAGE elasticsearch-${ES_VERSION}.tar.gz
ENV ES_GID 991
ENV ES_UID 991

# Install dependencies
RUN apt-get update
RUN apt-get install -y \
    software-properties-common \
    libcurl4-openssl-dev \
    curl
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get update
RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
RUN apt-get install -y oracle-java8-installer

# Install Elasticsearch
RUN mkdir -p ${ES_HOME}
RUN curl -O ${ES_URL}${ES_PACKAGE}
RUN tar xzf ${ES_PACKAGE} -C ${ES_HOME} --strip-components=1
WORKDIR ${ES_HOME}
RUN rm -f ${ES_PACKAGE}
# RUN cp -R config /etc/elasticsearch/
RUN groupadd -r elasticsearch -g ${ES_GID}
RUN useradd -r -s /usr/sbin/nologin -M -c "Elasticsearch service user" -u ${ES_UID} -g elasticsearch elasticsearch
RUN mkdir -p /var/log/elasticsearch /etc/elasticsearch /etc/elasticsearch/scripts /var/lib/elasticsearch
RUN chown -R elasticsearch:elasticsearch ${ES_HOME} /var/log/elasticsearch /var/lib/elasticsearch /etc/elasticsearch
RUN touch /var/log/elasticsearch/elasticsearch.log
ADD elasticsearch.yml /etc/elasticsearch/elasticsearch.yml
ADD jvm.options /etc/elasticsearch/jvm.options
ADD log4j2.properties /etc/elasticsearch/log4j2.properties

ADD ./elasticsearch-init /etc/init.d/elasticsearch
RUN sed -i -e 's#^ES_HOME=$#ES_HOME='$ES_HOME'#' /etc/init.d/elasticsearch \
 && chmod +x /etc/init.d/elasticsearch

# START
ADD ./start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

EXPOSE 9200 9300
VOLUME /var/lib/elasticsearch

CMD [ "/usr/local/bin/start.sh" ]
