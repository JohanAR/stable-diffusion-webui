#!/usr/bin/bash

python3 -m venv $VIRTUAL_ENV

# (optional) install requirements for CodeFormer (face restoration)
CODEFORMER_REQS=repositories/CodeFormer/requirements.txt
if [[ -f "$CODEFORMER_REQS" ]]; then
  pip install -r "$CODEFORMER_REQS" --prefer-binary
fi

echo "### Launching webui.py ###"
python3 webui.py --listen --show-negative-prompt --ui-settings-file=/app/runtime/ui-config.json
