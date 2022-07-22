# RTSP Camera Simulator

This project is based on [rtsp-simple-server](https://github.com/aler9/rtsp-simple-server) and provides a simple way to simulate rtsp camera streams from local videos.

## Requirements

* Docker (thats all!)

## Build

```sh
docker build -f docker/Dockerfile . -t rtsp-streamer
```

## Run streamer

```sh
./run_server.sh -video <video path> -p <port>
```
