FROM alpine:3

ENV ANSIBLE_ROLES_PATH ../

WORKDIR /github/workspace

RUN apk add --update --no-cache -virtual build_dependencies py-pip gcc python-dev musl-dev libffi-dev openssl-dev make && \
  pip install 'molecule[docker]' && \
  apk del build_dependencies

CMD molecule test
