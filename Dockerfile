FROM node:latest

RUN apt-get update

RUN apt-get install -y \
  xvfb \
  x11-xkb-utils \
  xfonts-100dpi \
  xfonts-75dpi \
  xfonts-scalable \
  xfonts-cyrillic \
  x11-apps \
  clang \
  libdbus-1-dev \
  libgtk2.0-dev \
  libnotify-dev \
  libgnome-keyring-dev \
  libgconf2-dev \
  libasound2-dev \
  libcap-dev \
  libcups2-dev \
  libxtst-dev \
  libxss1 \
  libnss3-dev \
  gcc-multilib \
  g++-multilib

WORKDIR /dist/
COPY ./package.json ./yarn.lock /dist/
RUN yarn install

COPY ./src/ /dist/src/

ENV DISPLAY :99.0
RUN Xvfb -ac -screen scrn 1280x2000x24 :99.0 &

ARG TELEGRAM_BOT_TOKEN
ENV TELEGRAM_BOT_TOKEN $TELEGRAM_BOT_TOKEN

ENV PORT 8000
EXPOSE $PORT

CMD xvfb-run --server-args="-screen 0 1024x768x24" npm start
