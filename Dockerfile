FROM python:3.9-alpine3.13

LABEL maintainer="Pandula Weerasooriya"

# No buffering on stdout or stderr
ENV PYTHONUNBUFFERED 1 

COPY requirements.txt /tmp/requirements.txt
COPY requirements.dev.txt /tmp/requirements.dev.txt

ENV PATH="/py/bin:$PATH"

ARG DEV=false

RUN python -m venv /py && \
    pip install --upgrade pip && \
    pip install -r /tmp/requirements.txt && \
    if [ $DEV = "true" ]; \
        then pip install -r /tmp/requirements.dev.txt; \
    fi && \
    rm -rf /tmp && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user


USER django-user

COPY ./app /app

WORKDIR /app

EXPOSE 8000

