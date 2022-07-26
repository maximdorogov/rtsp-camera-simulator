# RTSP Camera Simulator (Work in progress)

This project is based on [rtsp-simple-server](https://github.com/aler9/rtsp-simple-server) and [ffmpeg](https://ffmpeg.org/ffmpeg.html#Synopsis) converter. This tool provides a simple way to simulate rtsp camera streams from local videos.

## Requirements

* Docker (thats all!)

## Build

```sh
docker build -f docker/Dockerfile . -t rtsp-server
```

## Run streamer

Streaming a single video:

```sh
./run_server.sh --video <video path> -p <port>
```

Streaming multiple videos from a folder

```sh
./run_server.sh --folder <folder path> -p <port>
```

>All videos will be served in the same port.

### Acepted options

- `-v` | `--video`: Path to the video which will be streamed.
- `-f` | `--folder`: Path to folder with multiple videos to stream.
- `-p` | `--port`: Port where the streams will be served.

Each video will be streamed in a loop in `rtsp://localhost:<port>/<video name>`