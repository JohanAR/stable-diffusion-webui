#!/bin/bash

REPOS=repositories
SRC=src
mkdir -p outputs "$REPOS" runtime "$SRC"

# --- Stable diffusion

SD_REPO="$REPOS"/stable-diffusion
if [[ ! -d "$SD_REPO" ]] ; then
  git clone https://github.com/CompVis/stable-diffusion.git "$SD_REPO"
fi

# --- Taming transformers

TT_REPO="$REPOS"/taming-transformers
if [[ ! -d "$TT_REPO" ]] ; then
  git clone https://github.com/CompVis/taming-transformers.git "$TT_REPO"
fi

# --- CodeFormer

CF_REPO="$REPOS"/CodeFormer
if [[ ! -d "$CF_REPO" ]] ; then
  git clone https://github.com/sczhou/CodeFormer.git "$CF_REPO"
fi

CF_WTS="$CF_REPO"/weights/CodeFormer
mkdir -p "$CF_WTS"
wget -c --show-progress -P "$CF_WTS"/ \
  https://github.com/sczhou/CodeFormer/releases/download/v0.1.0/codeformer.pth

CFFL_WTS="$CF_REPO"/weights/facelib
mkdir -p "$CFFL_WTS"
wget -c --show-progress -P "$CFFL_WTS"/ \
  https://github.com/sczhou/CodeFormer/releases/download/v0.1.0/detection_Resnet50_Final.pth
wget -c --show-progress -P "$CFFL_WTS"/ \
  https://github.com/sczhou/CodeFormer/releases/download/v0.1.0/parsing_parsenet.pth

# --- BLIP

BLIP_REPO="$REPOS"/BLIP
if [[ ! -d "$BLIP_REPO" ]] ; then
  git clone https://github.com/salesforce/BLIP.git repositories/BLIP
fi

# --- GFPGAN

GFPGAN_WTS="$SRC"/gfpgan/experiments/pretrained_models
mkdir -p "$GFPGAN_WTS"
wget -c --show-progress -P "$GFPGAN_WTS"/ \
  https://github.com/TencentARC/GFPGAN/releases/download/v1.3.0/GFPGANv1.3.pth

# --- Stable diffusion (manual step)

SD_CKPT="$SD_REPO"/models/ldm/stable-diffusion-v1/model.ckpt
if [[ ! -f "$SD_CKPT" ]] ; then
  echo ">>> Stable diffusion v1 model is missing <<<"
  echo
  echo "You need to create a Hugging Face account and download sd-v1-4.ckpt from here:"
  echo
  echo "https://huggingface.co/CompVis/stable-diffusion-v-1-4-original"
  echo
  echo "Then move it to: $SD_CKPT"
  exit 1
fi

echo ">>> All done! <<<"
echo
echo "You can down run:"
echo "docker-compose build"
echo "docker-compose up"
