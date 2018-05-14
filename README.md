# Arachni Docker Container

A fully automagic arachni web deployment in Docker. Readily deployable
with Docker Compose or directly from docker hub.

## Arachni

Arachni is a feature-full, modular, high-performance Ruby framework
aimed towards helping penetration testers and administrators evaluate
the security of modern web applications. see the good work here:
www.arachni-scanner.com

## SYNOPSIS

This image is docker-compose ready and can be instantly booted with:

```
sudo docker-compose up
```

Alternatively, the docker image can be obtained from Docker Hub and run with a configured
postgres image. The image should linked with the name `postgres`. The database can be run as follows:

```
sudo docker run -d \
    --name postgres \
    -e POSTGRES_DB=arachni \
    -e POSTGRES_PASS=secret \
    -e POSTGRES_USERNAME=arachni \
    --network=arachni_net \
    postgres:10.3
```

The arachni docker image can then be run with:

```
sudo docker run \
    --name arachni \
    --network=arachni_net \
    -p 9292:9292 \
    tredie.io/arachni:latest
```

### Credentials

The default administrator account is: admin@admin.admin
A new random password will be assigned and displayed in the docker with each boot. 

## LICENSE

All configuration files and scripts are licensed under the MIT license.
