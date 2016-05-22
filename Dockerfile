FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y git openjdk-8-jre-headless tar wget

RUN useradd -U -r -d /mc -m spigot
WORKDIR /mc/build
RUN chown -R spigot:spigot /mc
USER spigot

RUN wget -O BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar

RUN java -jar BuildTools.jar --rev 1.9.4

WORKDIR ..
RUN cp build/spigot-1.9.4.jar spigot.jar
RUN rm -rf build

RUN echo eula=true > eula.txt

EXPOSE 25565

VOLUME /mc

CMD java -server -Xms512M -XX:+UseConcMarkSweepGC -jar spigot.jar
