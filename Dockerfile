FROM python:3.10.3-slim-bullseye AS base

ENV TZ Australia/Melbourne
ENV http_proxy http://myproxy:8080/
ENV https_proxy http://myproxy:8080/
ENV no_proxy localhost,127.0.0.1

ADD crt/*.crt /usr/local/share/ca-certificates/
RUN update-ca-certificates

FROM base AS development

ADD requirements.txt /tmp/requirements.txt
RUN apt update \
    && apt upgrade -y \
    && apt install -y --no-install-recommends \
    libpq-dev \
    pip \
    && /usr/local/bin/python3 -m pip install --upgrade pip \
    && pip install --no-cache-dir -r tmp/requirements.txt \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m developer && echo "developer:developer" | chpasswd && adduser developer sudo

FROM base AS production

ENV PYTHONPATH "${PYTHONPATH}:/usr/local/bin/python:/home/developer"
ADD requirements.txt /tmp/requirements.txt
RUN apt update \
    && apt upgrade -y \
    && apt install -y --no-install-recommends \
    libpq-dev \
    pip \
    && /usr/local/bin/python3 -m pip install --upgrade pip \
    && pip install --no-cache-dir -r tmp/requirements.txt \
    && python -m pip uninstall -y pip \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m developer && echo "developer:developer" | chpasswd && adduser developer sudo

ADD /app /home/developer/app
RUN chmod 777 /home/developer/app
WORKDIR /home/developer/app

# ENTRYPOINT ["python", "-m", "app.main"]
