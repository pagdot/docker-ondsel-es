FROM ghcr.io/linuxserver/baseimage-kasmvnc:debianbookworm

# set version label
ARG BUILD_DATE=
ARG VERSION=2024.1.0
ARG ONDSEL_VERSION=2024.1.0.35694
LABEL build_version="pag.dev version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="pagdot"

# title
ENV TITLE="Ondsel ES"

RUN \
  echo "**** add icon ****" && \
  curl -o \
    /kclient/public/icon.png \
    https://avatars.githubusercontent.com/u/122486098 && \
  echo "**** install packages ****" && \
  install -d 755 /app && \
  curl -o /app/Ondsel_ES.AppImage https://github.com/Ondsel-Development/FreeCAD/releases/download/${VERSION}/Ondsel_ES_${ONDSEL_VERSION}-Linux-x86_64.AppImage && \
  chmod 755 /app/Ondsel_ES.AppImage

# add local files
COPY /root /

# ports and volumes
EXPOSE 3000

VOLUME /config
