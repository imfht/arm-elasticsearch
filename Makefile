IMAGE = "jahrik/arm-elasticsearch"
TAG := $(shell uname -m)
STACK = "elk"

all: build

build:
	@docker build -t ${IMAGE}:$(TAG) -f Dockerfile_${TAG} .
	@docker build -t jahrik/elasticsearch:5.6.12 -f Dockerfile_x86_64 .

push:
	@docker push ${IMAGE}:$(TAG)
	@docker push jahrik/elasticsearch:5.6.12

deploy:
	@docker stack deploy -c docker-compose.yml ${STACK}

.PHONY: all build push deploy
