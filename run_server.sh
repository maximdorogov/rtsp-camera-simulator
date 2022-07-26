#!/bin/sh

while [[ $# -gt 0 ]]; do
  case $1 in
    -f|--folder)
      if [[ ! -d $2 ]]; then
        echo "$1 should be a path of existing directory"; exit 1
      fi
      videos=`ls $2`
      if [ -z "$videos" ]; then
        echo "no videos in the current path"; exit 1
      fi
      source_path=$(realpath "$2")
      shift 2 ;;
    -v|--video)
      if [[ ! -f $2 ]]; then
        echo "$1 should be a path of existing file"; exit 1
      fi
      videos=$(basename "$2")
      source_path=$(dirname $(realpath "$2"))
      shift 2 ;;
    -p|--port)
      #if ! [[ $2 =~ '^[0-9]+$' ]]; then
      #  echo " $2 port must be a number"; exit 1
      #fi
      # validate port
      port=$2
      shift 2 ;;
    -*)
      echo "Unknown option $1"
      exit 1 ;;
  esac
done

if [ ! "$source_path" ] || [ ! "$port" ]; then
  echo "Souce file/s and port must be provided"
  exit 1
fi

docker run --rm -v $source_path:/videos -p $port:8554 --name rtsp-server -d  rtsp-server > /dev/null

for video_file in $videos
do
docker exec -d rtsp-server ffmpeg -re \
    -stream_loop -1 \
    -i ./videos/$video_file \
    -vcodec libx264 \
    -f rtsp -rtsp_transport tcp rtsp://localhost:8554/$video_file

echo "streaming on rtsp://localhost:$port/$video_file"
done