This Dockerfile automatically builds spigot 1.9.4.

**By building this container, you agree to the terms of the [Minecraft EULA](https://account.mojang.com/documents/minecraft_eula). You must have a license for the game.**

## Example: building

    docker build -t spigot-docker:1.9.4 .

## Example: running

    docker run -d -i -t -p 25565:25565 --restart=always --name minecraft -v mc:/mc spigot-docker:1.9.4

This will run the server in the background and automatically restart it with the
docker daemon. It will keep STDIN open and run in a TTY. To get to the minecraft
server console, run

    docker attach minecraft

To exit from the console, hit ctrl-P then ctrl-Q. Also, to see the entire server
log, run

    docker logs minecraft

Files will usually be in `/var/lib/docker/volumes/mc/_data/`. If they aren't,
use

    docker volume inspect mc

to find the correct path.
