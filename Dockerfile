FROM alpine:3

RUN apk --update --no-cache add git aws-cli

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
