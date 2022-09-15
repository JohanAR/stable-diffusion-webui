FROM nvidia/cuda:11.7.1-runtime-ubuntu22.04

EXPOSE 7860

RUN apt-get update && \
    apt-get install -y python3 python3-pip python3-venv git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN groupadd -g 1000 webui && useradd --no-log-init --create-home -u 1000 -g webui webui

ENV VIRTUAL_ENV=/home/webui/venv

WORKDIR /app
RUN chown webui:webui /app


USER webui:webui

RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:/home/webui/.local/bin:$PATH"

#COPY requirements_versions.txt requirements_versions.txt
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt --prefer-binary

# For libgl.so.1
RUN pip install opencv-python-headless --prefer-binary

COPY . .

ENTRYPOINT ["./entrypoint.sh"]
