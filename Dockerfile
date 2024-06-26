FROM python:3.8-alpine3.20

RUN mkdir /app && mkdir /config
ENV HOME=/config

COPY startup.sh /app
RUN chmod +x /app/startup.sh

RUN apk update && \
    apk add unzip && \
    wget -c https://github.com/soranosita/crops/archive/refs/tags/v1.1.0.zip

RUN unzip '*.zip'
RUN mv crops*/** /app && mv /app/src/** /app && rm -r /app/src && rm *.zip

WORKDIR /app
RUN rm settings.json
RUN pip install -r requirements.txt

ENTRYPOINT ["/app/startup.sh"]