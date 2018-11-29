IMAGE = "jahrik/arm-elasticsearch"
TAG := $(shell uname -m)
STACK = "elk"

all: build

build:
	@docker build -t ${IMAGE}:$(TAG) -f Dockerfile_${TAG} .

push:
	@docker push ${IMAGE}:$(TAG)

deploy:
	@docker stack deploy -c docker-compose.yml ${STACK}

.PHONY: all build push deploy
