all: docker

.PHONY: docker

docker:
	docker build -t macourteau/docker-jenkins-buildessential .
