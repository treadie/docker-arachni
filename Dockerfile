FROM debian:latest

MAINTAINER treadie.io

ENV VERSION_FRAMEWORK 1.4
ENV VERSION_WEBUI 0.5.10
ENV POSTGRES_HOST postgres
ENV POSTGRES_DATABASE arachni_production
ENV POSTGRES_USERNAME arachni
ENV POSTGRES_PASSWORD secret
ENV PATH /opt/arachni/bin:$PATH

# Setup deps
RUN apt-get update && apt-get install -y curl

# Setup Arachni (64bit)
RUN	curl -#L https://github.com/Arachni/arachni/releases/download/v${VERSION_FRAMEWORK}/arachni-${VERSION_FRAMEWORK}-${VERSION_WEBUI}-linux-x86_64.tar.gz | tar zx && mv /arachni-$VERSION_FRAMEWORK-$VERSION_WEBUI /opt/arachni

#uncomment for nightly build
#RUN curl -#L http://downloads.arachni-scanner.com/nightlies/arachni-2.0dev-1.0dev-linux-x86_64.tar.gz | tar zx
#RUN	mv /arachni-2.0dev-1.0dev /opt/arachni

# Configure Arachni to use postgres (default config)
ADD database.yml /opt/arachni/system/arachni-ui-web/config/database.yml

EXPOSE 9292

CMD ["arachni_web","--host","0.0.0.0"]

# To build
#   1. go to path with dockerfile
#   2. docker build -t "treadie/arachni" .
#   3. docker history treadie/arachni
#   4. docker build -t "treadie/arachni:latest" -t "treadie/arachni:1.4-0.5.10" .
# To setup db
#   docker run --name arachni --link postgres -p 9292:9292 treadie/arachni '/opt/arachni/bin/arachni_web_task db:setup'
# To run
#   docker run --name arachni --link postgres -p 9292:9292 treadie/arachni
