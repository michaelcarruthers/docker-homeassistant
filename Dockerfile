FROM debian:buster-slim

EXPOSE 8123

VOLUME '/home/homeassistant/.homeassistant'

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
  --assume-yes \
  --quiet

RUN DEBIAN_FRONTEND=noninteractive apt-get install \
  --assume-yes            \
  --no-install-recommends \
  --quiet                 \
  autoconf                \
  gcc                     \
  libffi-dev              \
  libssl-dev              \
  python3-dev             \
  python3-minimal         \
  python3-pip             \
  python3-setuptools      \
  python3-wheel

RUN groupadd homeassistant --gid 999 
RUN useradd homeassistant \
  --create-home    \
  --gid 999        \
  --groups dialout \
  --system         \
  --uid 999

RUN pip3 install \
  aiohttp_cors  \
  homeassistant \
  SQLAlchemy 

RUN rm --force --recursive /root/.cache

USER homeassistant
ENTRYPOINT 'hass'
