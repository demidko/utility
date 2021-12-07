FROM gcc as builder
WORKDIR /project
COPY src ./src
COPY test ./test
COPY xmake.lua ./xmake.lua
RUN curl -fsSL https://xmake.io/shget.text | bash
RUN /root/.local/bin/xmake -qy --root
RUN /root/.local/bin/xmake run -qy --root test
RUN /root/.local/bin/xmake install -qy --root -o release app

FROM debian as backend
WORKDIR root
COPY --from=builder /project/release ./app
ENTRYPOINT ["/root/app/bin/app"]