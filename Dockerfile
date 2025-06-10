FROM python:3.9-alpine3.13

ENV PYTHONUNBUFFERED 1

# COPY ./requirements.dev.txt /tmp/requirements.dev.txt
WORKDIR /app
COPY . .

# RUN npm install

EXPOSE 8000


ARG DEV=false
RUN python -m venv /py && \
  /py/bin/pip install --upgrade pip && \
  apk add --update --no-cache cairo-dev pkgconfig && \
  apk add --update --no-cache postgresql-client jpeg-dev && \
  apk add --update --no-cache --virtual .tmp-build-deps \
  build-base postgresql-dev musl-dev zlib zlib-dev linux-headers && \
  /py/bin/pip install -r requirements.txt && \
  apk del .tmp-build-deps && \
  rm -rf /root/.cache/ && \
  chown -R root:root ./static && \
  chmod -R 755 ./static


RUN /py/bin/pip install --no-cache-dir -r requirements.txt
RUN pip install psycopg2-binary

ENV PYTHONPATH "/py/lib/python3.x/site-packages:$PYTHONPATH"
ENV PYTHONPATH /app
ENV DEBUG=False

# RUN chmod +x run.sh

RUN /py/bin/pip list

ENV PATH="/py/bin:$PATH"

CMD ["./entrypoint.sh"]
