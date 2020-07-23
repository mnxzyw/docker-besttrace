FROM debian as builder

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive \
    apt-get install -y wget zip \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /app
RUN wget -c https://cdn.ipip.net/17mon/besttrace4linux.zip \
  && unzip besttrace4linux.zip -d /app

FROM debian:stable-slim
COPY --from=builder /app/besttrace /usr/local/bin
RUN chmod +x /usr/local/bin/besttrace
ENTRYPOINT ["besttrace"]
