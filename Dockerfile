FROM debian:latest

MAINTAINER treadie.io

ENV VERSION_FRAMEWORK 2.0dev
ENV VERSION_WEBUI 1.0dev
ENV POSTGRES_HOST postgres
ENV POSTGRES_DATABASE arachni_production
ENV POSTGRES_USERNAME arachni
ENV POSTGRES_PASSWORD secret
ENV PATH /opt/arachni/bin:$PATH

RUN apt-get update && apt-get install -y curl

RUN curl -#L http://downloads.arachni-scanner.com/nightlies/arachni-2.0dev-1.0dev-linux-x86_64.tar.gz | tar zx && mv /arachni-2.0dev-1.0dev /opt/arachni

ADD database.yml /opt/arachni/system/arachni-ui-web/config/database.yml

EXPOSE 9292

CMD ["arachni_web","--host","0.0.0.0"]