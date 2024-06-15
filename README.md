![Docker Automated build](https://img.shields.io/docker/automated/macourteau/docker-jenkins-buildessential.svg)
![Docker Build Status](https://img.shields.io/docker/automated/macourteau/docker-jenkins-buildessential.svg)
![Docker Pulls](https://img.shields.io/docker/pulls/macourteau/docker-jenkins-buildessential.svg)

# Docker container with Jenkins, Docker, build-essential and more

[Docker Hub](https://hub.docker.com/r/macourteau/docker-jenkins-buildessential)

Includes:

*   [Jenkins](https://jenkins.io)
*   [Docker](https://www.docker.com)
*   [build-essential](https://packages.debian.org/build-essential)
*   [go](https://golang.org/)
*   [amazon-ecr-credential-helper](https://github.com/awslabs/amazon-ecr-credential-helper)

## Running
Run like this:

```
docker run \
    -p 8080:8080 \
    -p 50000:50000 \
    --env JAVA_OPTS=-Dhudson.footerURL=http://mycompany.com \
    -v jenkins_home:/var/jenkins_home \
    -v /var/run/docker.sock:/var/run/docker.sock \
    macourteau/docker-jenkins-buildessential:latest
```

See the
[Jenkins docs](https://github.com/jenkinsci/docker/blob/master/README.md)
for more information about the parameters to pass to docker.

It is important to pass the `/var/run/docker.sock` volume mount from the host
to the container, to use the daemon from the host instead of running a Docker
daemon inside this container.

## Using `amazon-ecr-credential-helper`

Create a `credentials` file in the `aws` directory (see `credentials.sample`),
create a `config.json` file in the `docker` directory (see
`config.json.sample`), and add volume mounts:

```
    -v $(pwd)/aws:/root/.aws \
    -v $(pwd)/docker:/root/.docker \
```
