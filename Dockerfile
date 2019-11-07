FROM golang AS build
ENV GOPATH=/go
RUN go get -u github.com/gcla/termshark/cmd/termshark

FROM ubuntu

RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
    tshark; \
    apt-get autoremove; apt-get clean; \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY --from=build /go/bin/termshark /usr/local/bin/termshark
COPY bin /bin
