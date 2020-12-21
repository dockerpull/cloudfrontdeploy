FROM docker:latest

RUN apk -Uuv add python3 py3-pip bash && \
    python3 -m pip install awscli && \
	apk --purge -v del py-pip && \
	rm /var/cache/apk/* && \
	aws --version

ENV AWS_PAGER=''

COPY entrypoint.sh /bin/

RUN adduser --disabled-password --gecos "" --uid 1001 action
USER action

ENTRYPOINT ["entrypoint.sh"]
