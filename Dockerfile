FROM alpine:3.12
LABEL maintainer="mjy@z.mjyai.com"

ENV AccessKeyId="testid" \
    AccessKeySec="testsecret" \
    DomainRR="www" \
    DomainName="example.com" \
    DomainType="A"

RUN apk update \
    && apk add curl bash openssl \
    && rm -rf /var/cache/apk/*

COPY ali_ddns.sh /root/ali_ddns.sh
RUN chmod +x /root/ali_ddns.sh

ENTRYPOINT crontab -l | { cat; echo "*/5 * * * * /root/ali_ddns.sh >/dev/null 2>&1"; } | crontab - && crond -f -d 8