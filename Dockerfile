FROM alpine:3

WORKDIR /github/workspace

RUN apk add --update --no-cache python py-pip docker && \
    apk add --update --no-cache --virtual build_dependencies gcc python-dev musl-dev libffi-dev openssl-dev make && \
    pip install 'molecule[docker]' && \
    apk del build_dependencies

CMD cd ${GITHUB_REPOSITORY} ; /usr/bin/molecule test
