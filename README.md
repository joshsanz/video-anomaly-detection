# Video Anomaly Detection

Basic video anomaly detection using Histogram of Oriented Optical Flow (HOOF) features and IsolationTrees for 
unsupervised outlier prediction.

## Setup

Create and activate a virtual environment, then run
```sh
pip install -r requirements.txt
```

## Preprocessing

Run the `videos-to-frames.sh` script for each directory which contains a set of videos you which to process.
For example,
```sh
./videos-to-frames.sh /data/recordings/2024-05-21/ 10
```
will extract 10 frames per second from each video in `/data/recordings/2024-05-21` into a subdirectory named 
after the video.

## Anomaly Detection

The jupyter notebook `video-anomaly-detection.ipynb` walks through the process of loading and examining your 
dataset, then generating the HOOF features, and finally fitting an IsolationForest to predict anomaly frames.
The results and a sample of both anomaly and in-distribution stills will be saved alonside the original 
videos.
