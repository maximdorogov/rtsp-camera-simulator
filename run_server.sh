#!/bin/sh


SOURCE_PATH=$(dirname $(realpath "$2"))
FILE_NAME=$(basename "$2")
PORT=$4

echo $SOURCE_PATH
echo $FILE_NAME

docker run --rm -v $SOURCE_PATH:/videos -p $PORT:8554 --name rtsp-server -d  rtsp-server

docker exec -d rtsp-server ffmpeg -re \
    -stream_loop -1 \
    -i ./videos/$FILE_NAME \
    -c copy \
    -f rtsp rtsp://localhost:8554/$FILE_NAME

echo "streaming on rtsp://localhost:$PORT/$FILE_NAME" 