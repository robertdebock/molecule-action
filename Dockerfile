FROM alpine:3

WORKDIR /usr/src/molecule

RUN apk add --update --no-cache py-pip gcc python-dev musl-dev libffi-dev openssl-dev make

RUN pip install molecule

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

