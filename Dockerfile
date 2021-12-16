FROM gcc:10 as builder
WORKDIR /project
COPY src ./src
COPY xmake.lua ./xmake.lua
RUN apt -qy update && apt -yq upgrade \
    && apt -qy install python3-pip \
    && pip3 -q install conan \
    && curl -fsSL https://xmake.io/shget.text | bash
RUN /root/.local/bin/xmake -qy --root

FROM alpine as backend
WORKDIR root
RUN apk update --no-cache && apk upgrade --no-cache && apk add --no-cache bash libstdc++ gcompat libc6-compat
COPY --from=builder /project/build/main/* ./
ENTRYPOINT ["/root/app"]