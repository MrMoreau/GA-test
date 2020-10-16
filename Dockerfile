FROM ubuntu as builder
RUN apt-get update \
 && apt-get install -y wget \
 && wget https://github.com/svenstaro/miniserve/releases/download/v0.10.0/miniserve-v0.10.0-linux-x86_64 \
 && chmod 555 miniserve-v0.10.0-linux-x86_64
COPY index.html .

FROM scratch
COPY --from=builder miniserve-v0.10.0-linux-x86_64 /
COPY --from=builder index.html /
ENTRYPOINT ["/miniserve-v0.10.0-linux-x86_64", "-p80", "/index.html"]
EXPOSE 80/tcp
