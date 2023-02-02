ARG ARCH= 
FROM ${ARCH}ubuntu:rolling

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install gstreamer1.0-tools gstreamer1.0-alsa -y && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["gst-launch-1.0"]
