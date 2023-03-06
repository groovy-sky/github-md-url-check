FROM golang:alpine3.16 as base

RUN apk add --no-cache git && go install github.com/groovy-sky/gmuv/v2@latest 

FROM alpine:latest

COPY --from=base /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=base /go/bin/gmuv /gmuv

COPY entrypoint.sh /entrypoint.sh

RUN chmod a+x *.sh &&  mkdir -p .archives && chown nobody:nobody / && chown nobody:nobody .archives

USER nobody

ENTRYPOINT ["./entrypoint.sh"]

LABEL maintainer = "groovy-sky"
LABEL org.opencontainers.image.source = "https://github.com/groovy-sky/gmuv"