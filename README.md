# Docker-Arachni
Docker build for Arachni scanner

## Arachni
Arachni is a feature-full, modular, high-performance Ruby framework aimed towards helping penetration testers and administrators evaluate the security of modern web applications. see the good work here: www.arachni-scanner.com

## Why
The default sqlite deployment has many limitations as described on the arachni webui landing page. This image has been preconfigured to used postgres as the dateabase to overcome these limitations.

## versions
`treadie/arachni:latest` - arachni framework v1.4 & webui v0.5.10
`treadie/arachni:1.4-0.5.10` - arachni framework v1.4 & webui v0.5.10
`treadie/arachni:Nightly` - arachni nightly build (currently only built when required)

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

`docker run -t --name arachni --link postgres -p 9292:9292 treadie/arachni`

If this is the first time it has been run then starup will throw a warning as the `arachni_production` database has not been setup using `arachni_web_task db:setup` this also means the webui will not load. to resolve this issue, run the following command: 

`docker exec -i /opt/arachni/bin/arachni_web_task db:setup arachni`

_Note: Use the command above with caution. It's designed to setup a clean and default database. if you have scan data in your database and run this command it will be removed!_

### Database Connection
The database configuration settings for Arachni are configured by environment variables. By default they have been preconfigured with what comes out of the box from the Arachni developers. The variables of interest for this image are (with their default values):

`POSTGRES_HOST postgres`
`POSTGRES_DATABASE arachni_production`
`POSTGRES_USERNAME arachni`
`POSTGRES_PASSWORD secret`

Manipulate as required by starting the image using `-e` for example:

`docker run --name arachni --link postgres -e POSTGRES_HOST=server.com -p 9292:9292 treadie/arachni`

## Build

1. Clone repo
2. Go to repo dir
3. `docker build -t "treadie/arachni" .`
4. `docker history treadie/arachni` 
5. `docker build -t "treadie/arachni:latest" -t "treadie/arachni:1.4-0.5.10" .`