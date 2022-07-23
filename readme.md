# RTSP Camera Simulator (WIPgit status)

This project is based on [rtsp-simple-server](https://github.com/aler9/rtsp-simple-server) and provides a simple way to simulate rtsp camera streams from local videos.

## Requirements

* Docker (thats all!)

## Build

```sh
docker build -f docker/Dockerfile . -t rtsp-streamer
```

## Run streamer

Streaming a single video:

```sh
./run_server.sh -video <video path> -p <port>
```

Streaming multiple videos server from a folder

```sh
./run_server.sh -folder <folder path> -p <port>
```

All videos will be served at `rtsp://localhost:<port>/<video name>`