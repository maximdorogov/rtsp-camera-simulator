#!/bin/sh

SRC_TYPE=$1
VIDEO_SRC=$2
SOURCE_PATH=$(dirname $(realpath "$VIDEO_SRC"))
FILE_NAME=$(basename "$VIDEO_SRC")
PORT=$4

if [ "$SRC_TYPE" = "-folder" ]; then
    VIDEOS=`ls $VIDEO_SRC`
    SOURCE_PATH=$(realpath "$VIDEO_SRC")
else
    VIDEOS=$FILE_NAME
    SOURCE_PATH=$(dirname $(realpath "$VIDEO_SRC"))
fi

docker run --rm -v $SOURCE_PATH:/videos -p $PORT:8554 --name rtsp-server -d  rtsp-server > /dev/null

for VIDEO_FILE in $VIDEOS
do
docker exec -d rtsp-server ffmpeg -re \
    -stream_loop -1 \
    -i ./videos/$VIDEO_FILE \
    -c copy \
    -f rtsp rtsp://localhost:8554/$VIDEO_FILE

echo "streaming on rtsp://localhost:$PORT/$VIDEO_FILE"
done