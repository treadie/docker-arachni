FROM ruby:stretch

MAINTAINER treadie.io

ENV VERSION_FRAMEWORK 1.5.1
ENV VERSION_WEBUI 0.5.12
ENV POSTGRES_HOST postgres
ENV POSTGRES_DATABASE arachni_production
ENV POSTGRES_USERNAME arachni
ENV POSTGRES_PASSWORD secret
ENV PATH /opt/arachni/bin:$PATH

## Fetch latest arachni code
RUN mkdir -p /deploy
WORKDIR /deploy
RUN	wget \
    https://github.com/Arachni/arachni/releases/download/v${VERSION_FRAMEWORK}/arachni-${VERSION_FRAMEWORK}-${VERSION_WEBUI}-linux-x86_64.tar.gz
RUN tar xf *.tar.gz \
    && mv arachni-$VERSION_FRAMEWORK-$VERSION_WEBUI /arachni

## Database setup
WORKDIR /arachni

ADD database.yml system/arachni-ui-web/config/database.yml
RUN bin/arachni_web_task db:setup

## Startup boot manager
ADD scripts/startup.sh /startup.sh
RUN chmod u+x /startup.sh

EXPOSE 9292

CMD ["/startup.sh"]
