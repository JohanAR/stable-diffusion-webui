#!/usr/bin/bash

# python3 -m venv $VIRTUAL_ENV

# (optional) install requirements for CodeFormer (face restoration)
CODEFORMER_REQS=repositories/CodeFormer/requirements.txt
if [[ -f "$CODEFORMER_REQS" ]]; then
  pip install --pre -r "$CODEFORMER_REQS" --prefer-binary --extra-index-url https://download.pytorch.org/whl/nightly/cu117
fi

echo "### Launching webui.py ###"
python3 webui.py --no-half --listen --show-negative-prompt \
  --ckpt=repositories/stable-diffusion/models/ldm/stable-diffusion-v1/model.ckpt \
  --ui-settings-file=/app/runtime/ui-config.json
