# Docker-Arachni
Docker build for Arachni scanner

## Arachni
Arachni is a feature-full, modular, high-performance Ruby framework aimed towards helping penetration testers and administrators evaluate the security of modern web applications. see the good work here: www.arachni-scanner.com

## Why
The default sqlite deployment has many limitations as described on the arachni webui landing page. This image has been preconfigured to used postgres as the dateabase to overcome these limitations.

## versions
`treadie/arachni:latest` - arachni framework v1.4 & webui v0.5.10
`treadie/arachni:1.4-0.5.10` - arachni framework v1.4 & webui v0.5.10

## How

### Prereqs
This image relies on a seperate and running postgres instance. The easiest way of doing this is using the official postgres Docker image

Pull postgres
`docker pull postgres`

Configure postgres for arachni
`docker run --name postgres -e POSTGRES_PASSWORD=secret -e POSTGRES_USER=arachni -e POSTGRES_DB=arachni_production -d postgres`

Feel free to manipulate and modify the above command for production environments as you see fit. I plan to create a compose file to automate this whole process, but not there yet.

### Pull
To pull this image from the Docker registry, open a shell prompt and enter:
`docker pull treadie/arachni`

### Usage
Run a container from the image with the following command:
`docker run --name arachni --link postgres -p 9292:9292 treadie/arachni`

_note: this will fail to run if the _`arachni_production`_ database has not been setup using _`arachni_web_task db:setup`_ to do this run the following command _`docker run --name arachni --link postgres -p 9292:9292 treadie/arachni '/opt/arachni/bin/arachni_web_task db:setup'`

### Database Connection
The database configuration settings for Arachni are configured by environment variables. By default they have been preconfigured with what comes out of the box from the Arachni developers. The variables of interest for this image are (with their default values):

`POSTGRES_HOST postgres`
`POSTGRES_DATABASE arachni_production`
`POSTGRES_USERNAME arachni`
`POSTGRES_PASSWORD secret`

Manipulate as required by starting the image using `-e` for example:

`docker run --name arachni --link postgres -e POSTGRES_HOST=localhost -p 9292:9292 treadie/arachni`


