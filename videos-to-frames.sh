#!/bin/bash

FPS=1

if [ $# == 0 ]; then
    echo "Usage: $0 VIDEO_DIR [FPS]"
    exit 1
fi

work_dir=$1
if [ $# == 2 ]; then
    FPS=$2
elif [ $# == 1 ]; then
    echo "Using FPS=$FPS"
else
    echo "Too many args!"
    echo "Usage: $0 VIDEO_DIR [FPS]"
    exit 1
fi

videos=$(find $work_dir -type f -name \*.mp4 -o -name \*.MP4 -o -name \*.avi -o -name \*.AVI)

for vid in ${videos[@]}; do
    # Get name and make folder
    echo $vid
    extension="${vid##*.}"
    filename=$(basename "${vid%.*}")
    outdir="$(dirname $vid)/$filename"
    mkdir -p $outdir
    # Clear existing files to prevent stale data
    rm $outdir/*

    # Extract frames to folder
    ffmpeg -i $vid -vf fps=$FPS "$outdir/frame%03d-fps${FPS}.jpg" > /dev/null 2>&1
done

