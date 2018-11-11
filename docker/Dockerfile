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

# gosu
# grab gosu for easy step-down from root
RUN set -eux; \
	apt-get update; \
	apt-get install -y gosu; \
	rm -rf /var/lib/apt/lists/*; \
# verify that the binary works
	gosu nobody true

# Tini
# For signal processing and zombie killing
ENV TINI_VERSION v0.18.0
ENV ARCH armhf
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-${ARCH} /usr/local/bin/tini
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-${ARCH}.asc /usr/local/bin/tini.asc
RUN gpg --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7
RUN gpg --verify /usr/local/bin/tini.asc
RUN rm -rf /usr/local/bin/tini.asc
RUN chmod +x /usr/local/bin/tini
RUN tini -h

# Install Elasticsearch
ENV ES_VERSION 5.6.12
ENV ES_URL https://artifacts.elastic.co/downloads/elasticsearch/
ENV ES_HOME /usr/share/elasticsearch
RUN wget ${ES_URL}elasticsearch-${ES_VERSION}.deb && \
	dpkg -i elasticsearch-${ES_VERSION}.deb && \
  rm elasticsearch-${ES_VERSION}.deb
WORKDIR ${ES_HOME}
ENV PATH ${ES_HOME}/bin:$PATH

# COPY start.sh /usr/local/bin/start.sh
# RUN chmod +x /usr/local/bin/start.sh
# COPY config/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml
# COPY config/jvm.options /etc/elasticsearch/jvm.options
# COPY config/log4j2.properties /etc/elasticsearch/log4j2.properties

EXPOSE 9200 9300
# CMD ["/usr/local/bin/start.sh"]

COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["elasticsearch"]

# # Symlink the config files
# ENV LOGSTASH_ETC /etc/logstash
# RUN mkdir -p ${LOGSTASH_ETC}
# COPY logstash.conf ${LOGSTASH_ETC}/logstash.conf
# RUN ln -sf ${LOGSTASH_HOME}/config/log4j2.properties ${LOGSTASH_ETC}/log4j2.properties
# RUN ln -sf ${LOGSTASH_HOME}/config/logstash.yml ${LOGSTASH_ETC}/logstash.yml
# RUN ln -sf ${LOGSTASH_HOME}/config/jvm.options ${LOGSTASH_ETC}/jvm.options
# RUN chown -R logstash:logstash ${LOGSTASH_HOME}
# RUN chown -R logstash:logstash ${LOGSTASH_ETC}
# 
# # comment out some troublesome configuration parameters
# #   path.config: No config files found: /etc/logstash/conf.d/*
# RUN set -ex; \
# 	if [ -f "$LOGSTASH_ETC/logstash.yml" ]; then \
# 		sed -ri 's!^path\.config:!#&!g' "$LOGSTASH_ETC/logstash.yml"; \
# 	fi; \
# # Lower java initial heap size in jvm.options
# 	if [ -f "$LOGSTASH_ETC/jvm.options" ]; then \
# 	  sed -ri 's/^-Xms1g/-Xms500m/g' "$LOGSTASH_ETC/jvm.options"; \
# 	  sed -ri 's/^-Xmx1g/-Xmx500m/g' "$LOGSTASH_ETC/jvm.options"; \
# 	fi; \
# # if the "log4j2.properties" file exists (logstash 5.x),
# # let's empty it out so we get the default:
# # "logging only errors to the console"
# 	if [ -f "$LOGSTASH_ETC/log4j2.properties" ]; then \
# 		cp "$LOGSTASH_ETC/log4j2.properties" "$LOGSTASH_ETC/log4j2.properties.dist"; \
# 		truncate --size=0 "$LOGSTASH_ETC/log4j2.properties"; \
# 	fi;
# 
# COPY docker-entrypoint.sh /
# RUN chmod +x /docker-entrypoint.sh
# 
# ENTRYPOINT ["/docker-entrypoint.sh"]
# CMD ["-f", "/etc/logstash/logstash.conf"]
