FROM ubuntu:18.04 AS base

RUN apt-get update && \
    apt-get install -y git openjdk-11-jre-headless tar wget

RUN useradd -U -r -d /mc -m spigot && \
    mkdir /mc-build && \
    chown -R spigot:spigot /mc-build /mc

USER spigot

FROM base AS build

WORKDIR /mc-build

RUN wget -O BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar

RUN java -jar BuildTools.jar --rev 1.14.1

FROM base

COPY --from=build /mc-build/spigot-1.14.1.jar /mc-build/spigot.jar

EXPOSE 25565

VOLUME /mc
WORKDIR /mc

CMD echo eula=true > eula.txt && \
  cp /mc-build/spigot.jar . && \
  java -server -Xms512M -XX:+UseConcMarkSweepGC -jar spigot.jar
