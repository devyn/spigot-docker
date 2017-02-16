FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y git openjdk-8-jre-headless tar wget

RUN useradd -U -r -d /mc -m spigot
WORKDIR /mc-build
RUN chown -R spigot:spigot /mc-build /mc
USER spigot

RUN wget -O BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar

RUN java -jar BuildTools.jar --rev 1.11.2

WORKDIR /mc
RUN echo eula=true > eula.txt

EXPOSE 25565

VOLUME /mc

CMD cp /mc-build/spigot-1.11.2.jar ./spigot.jar && java -server -Xms512M -XX:+UseConcMarkSweepGC -jar spigot.jar
