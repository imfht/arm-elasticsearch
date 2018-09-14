IMAGE = "jahrik/arm-elasticsearch"
TAG = "arm32v7"

all: build

build:
	@docker build -t ${IMAGE}:$(TAG) ./docker
	@docker tag ${IMAGE}:$(TAG) ${IMAGE}:latest

push:
	@docker push ${IMAGE}:$(TAG)
	@docker push ${IMAGE}:latest

deploy:
	@docker stack deploy -c elastic-stack.yml elk

.PHONY: all build push deploy
