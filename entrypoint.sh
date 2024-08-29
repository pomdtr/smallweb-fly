#!/bin/sh

rclone serve webdav /home/fly/smallweb --addr 0.0.0.0:8081 &
exec smallweb up --host 0.0.0.0 --port 8080
