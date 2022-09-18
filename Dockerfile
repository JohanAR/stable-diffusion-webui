FROM nvidia/cuda:11.7.1-runtime-ubuntu22.04

EXPOSE 7860

RUN apt-get update && \
    apt-get install -y python3 python3-pip python3-venv git libgl1-mesa-glx libglib2.0-0 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN groupadd -g 1000 webui && useradd --no-log-init --create-home -u 1000 -g webui webui

#ENV VIRTUAL_ENV=/home/webui/venv

WORKDIR /app
RUN chown webui:webui /app



#RUN python3 -m venv $VIRTUAL_ENV
#ENV PATH="$VIRTUAL_ENV/bin:/home/webui/.local/bin:$PATH"
ENV PATH="/home/webui/.local/bin:$PATH"

# For libgl.so.1
#RUN pip install opencv-python-headless --prefer-binary

RUN pip install --pre torch --prefer-binary --extra-index-url https://download.pytorch.org/whl/nightly/cu117

RUN pip install --pre git+https://github.com/crowsonkb/k-diffusion.git --prefer-binary --extra-index-url https://download.pytorch.org/whl/nightly/cu117
RUN pip install --pre git+https://github.com/TencentARC/GFPGAN.git@8d2447a2d918f8eba5a4a01463fd48e45126a379 --prefer-binary --extra-index-url https://download.pytorch.org/whl/nightly/cu117

COPY requirements_versions.txt requirements_versions.txt
#COPY requirements.txt requirements.txt
RUN pip install --pre -r requirements_versions.txt --prefer-binary --extra-index-url https://download.pytorch.org/whl/nightly/cu117


USER webui:webui

COPY . .

ENTRYPOINT ["./entrypoint.sh"]
