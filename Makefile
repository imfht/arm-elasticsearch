IMAGE = "jahrik/arm-elasticsearch"
TAG = "arm32v7"

all: build

build:
	@docker build -t ${IMAGE}:$(TAG) .

push:
	@docker push ${IMAGE}:$(TAG)

deploy:
	@docker stack deploy -c docker-compose.yml elk

.PHONY: all build push deploy
