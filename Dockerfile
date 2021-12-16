FROM gcc:10 as builder
WORKDIR /project
COPY src ./src
COPY xmake.lua ./xmake.lua
RUN curl -fsSL https://xmake.io/shget.text | bash
RUN /root/.local/bin/xmake -qy --root

FROM alpine as backend
WORKDIR root
RUN apk update --no-cache && apk upgrade --no-cache && apk add --no-cache bash libstdc++ libc6-compat
COPY --from=builder /project/build/main/* ./
ENTRYPOINT ["/root/app"]