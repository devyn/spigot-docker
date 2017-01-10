#!/bin/bash
docker run -d -i -t -p 25565:25565 --restart=always --name minecraft -v mc:/mc spigot-docker:1.11
