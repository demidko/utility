FROM gcc:10 as xmake
USER root
RUN curl -fsSL https://xmake.io/shget.text | bash

FROM xmake as builder
WORKDIR /project
COPY src ./src
COPY xmake.lua ./xmake.lua
RUN /root/.local/bin/xmake f -y --links=pthread --root
RUN /root/.local/bin/xmake -y --root

FROM alpine as backend
WORKDIR /usr/local/bin/
RUN apk update --no-cache \
    && apk upgrade --no-cache \
    && apk add --no-cache tzdata curl bash libstdc++ libc6-compat \
    &&  cp /usr/share/zoneinfo/Asia/Vladivostok /etc/localtime
COPY --from=builder /project/build/main/* ./
ENTRYPOINT ["/usr/local/bin/app"]