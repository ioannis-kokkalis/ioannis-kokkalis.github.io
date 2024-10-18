FROM alpine:3.20.3
RUN apk add --no-cache curl && curl -L https://github.com/gohugoio/hugo/releases/download/v0.136.0/hugo_0.136.0_Linux-64bit.tar.gz | tar -xz \
    && mv hugo /usr/local/bin/hugo