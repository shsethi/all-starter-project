FROM openjdk:8-jre
MAINTAINER Shubham Sethi <shubhamsethi786@gmail.com>

ENV APP_NAME streams-starter-project
ENV APP_HOME /app/bin

RUN mkdir -p ${APP_HOME}

COPY target/${APP_NAME}.jar ${APP_HOME}/
COPY build/docker/start-app.sh ${APP_HOME}/

WORKDIR ${APP_HOME}

ENTRYPOINT ["./start-app.sh"]
