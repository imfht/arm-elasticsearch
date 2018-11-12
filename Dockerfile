FROM arm32v7/openjdk:8-jdk

# grab gosu for easy step-down from root
ENV GOSU_USER 0:0
# ENV GOSU_CHOWN /tmp
RUN set -eux; \
  apt-get update; \
  apt-get install -y gosu; \
  rm -rf /var/lib/apt/lists/*; \
# verify that the binary works
  gosu nobody true

ENV ES_VERSION 6.4.3
ENV ES_URL https://artifacts.elastic.co/downloads/elasticsearch/
ENV ES_HOME /usr/share/elasticsearch
ENV ES_PATH_CONF /ect/elasticsearch
RUN wget ${ES_URL}elasticsearch-${ES_VERSION}.deb && \
  dpkg -i elasticsearch-${ES_VERSION}.deb && \
  rm elasticsearch-${ES_VERSION}.deb

ENV PATH /usr/share/elasticsearch/bin:$PATH

WORKDIR /usr/share/elasticsearch

RUN set -ex \
  && for path in \
    ./tmp \
    ./data \
    ./logs \
    ./config \
    ./config/scripts \
  ; do \
    mkdir -p "$path"; \
    chown -R elasticsearch:elasticsearch "$path"; \
  done

COPY config ./config

VOLUME /usr/share/elasticsearch/data

COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

EXPOSE 9200 9300
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["elasticsearch"]
