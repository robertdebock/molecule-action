FROM alpine:3

WORKDIR /github/workspace

RUN apk add --update --no-cache py-pip gcc python-dev musl-dev libffi-dev openssl-dev make

RUN pip install 'molecule[docker]'
