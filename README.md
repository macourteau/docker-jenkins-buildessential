# Docker container with Jenkins, Docker, build-essential and clang

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

See the [Jenkins docs](https://github.com/jenkinsci/docker/blob/master/README.md)
for more information about the parameters to pass to docker.

It is important to pass the `/var/run/docker.sock` volume mount from the host
to the container, to use the daemon from the host instead of running a Docker
daemon inside this container.
