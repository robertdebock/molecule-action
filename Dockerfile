FROM alpine:3

ENV ANSIBLE_ROLES_PATH ../

WORKDIR /github/workspace

RUN apk add --update --no-cache python py-pip && \
    apk add --update --no-cache --virtual build_dependencies gcc python-dev musl-dev libffi-dev openssl-dev make && \
    pip install 'molecule[docker]' && \
    apk del build_dependencies

CMD pwd ; find ./ ; /usr/bin/molecule test
