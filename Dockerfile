FROM ubuntu:rolling as build

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt install -y --no-install-recommends bison build-essential ca-certificates flex git ninja-build pkg-config python3-pip libasound2-dev
RUN python3 -m pip install meson
RUN rm -rf /var/lib/apt/lists/*

RUN git clone https://gitlab.freedesktop.org/gstreamer/gstreamer.git
WORKDIR /gstreamer

ARG GSTREAMER_CONFIG="\
-Dauto_features=disabled \
-Dtools=enabled \
-Dgst-plugins-base:audioconvert=enabled \
-Dgst-plugins-base:audiomixer=enabled \
-Dgst-plugins-base:audiorate=enabled \
-Dgst-plugins-base:audioresample=enabled \
-Dgst-plugins-base:tcp=enabled \
-Dgst-plugins-base:alsa=enabled \
-Dgood=enabled \
-Dgst-plugins-good:audiofx=enabled \
-Dgst-plugins-good:audioparsers=enabled \
-Dbad=enabled \
-Dgst-plugins-bad:removesilence=enabled \
-Dugly=disabled \
-Dlibav=disabled \
-Ddevtools=disabled \
-Dges=disabled \
-Drtsp_server=disabled \
"

RUN meson setup --prefix=/gstreamer-install ${GSTREAMER_CONFIG} builddir
RUN meson compile -C builddir
RUN meson install -C builddir

FROM ubuntu:rolling

COPY --from=build /gstreamer-install/ /usr/local/

RUN apt update && apt install -y --no-install-recommends libasound2 && rm -rf /var/lib/apt/lists/*

ENV LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH

ENTRYPOINT ["gst-launch-1.0"]
