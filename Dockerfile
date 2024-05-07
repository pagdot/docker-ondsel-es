FROM debian:bookworm AS downloader
ARG VERSION=2024.2.0
ARG ONDSEL_VERSION=2024.2.0.37191

RUN apt update
RUN apt install -y wget
RUN wget https://github.com/Ondsel-Development/FreeCAD/releases/download/${VERSION}/Ondsel_ES_${ONDSEL_VERSION}-Linux-x86_64.AppImage
RUN chmod +x ./Ondsel_ES_${ONDSEL_VERSION}-Linux-x86_64.AppImage
RUN ./Ondsel_ES_${ONDSEL_VERSION}-Linux-x86_64.AppImage --appimage-extract

FROM ghcr.io/linuxserver/baseimage-kasmvnc:debianbookworm

# set version label
ARG BUILD_DATE
ARG VERSION=2024.2.0
LABEL build_version="pag.dev version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="pagdot"

# title
ENV TITLE="Ondsel ES"

COPY --from=downloader /squashfs-root/ /app/

RUN \
  echo "**** add icon ****" && \
  curl -o \
    /kclient/public/icon.png \
    https://avatars.githubusercontent.com/u/122486098

# add local files
COPY /root /

# ports and volumes
EXPOSE 3000

VOLUME /config
