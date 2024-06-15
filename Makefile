all: docker

.PHONY: docker

docker:
	docker context create builder_context
	docker buildx create --use builder_context
	docker buildx build --platform linux/amd64,linux/arm64 -t macourteau/docker-jenkins-buildessential .
	docker buildx rm
