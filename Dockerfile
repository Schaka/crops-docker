FROM python:3.8-alpine3.20

RUN mkdir /app && mkdir /config
ENV HOME=/config

COPY startup.sh /app
RUN chmod +x /app/startup.sh

RUN apk update && \
    apk add git && \
    git clone https://github.com/resu-detcader/crops.git

RUN mv crops*/** /app && mv /app/src/** /app && rm -r /app/src

WORKDIR /app
RUN rm settings.json
RUN pip install -r requirements.txt

ENTRYPOINT ["/app/startup.sh"]