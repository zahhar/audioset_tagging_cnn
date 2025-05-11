#!/bin/bash

# ------ Paths ------
VENV_PYTHON="./.venv/bin/python"
SCRIPT_DIR="./src"

# Check arguments
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <soundfile_wav_or_mp3>" >&2
    exit 1
fi

SOUNDFILE="$1"

# ------ Audio tagging ------
"$VENV_PYTHON" "$SCRIPT_DIR/inference.py" audio_tagging \
    --model_type="Cnn14" \
    --checkpoint_path="Cnn14_mAP=0.431.pth" \
    --audio_path="$SOUNDFILE"

# ------ Sound event detection ------
"$VENV_PYTHON" "$SCRIPT_DIR/inference.py" sound_event_detection \
    --model_type="Cnn14_DecisionLevelMax" \
    --checkpoint_path="Cnn14_mAP=0.431.pth" \
    --audio_path="$SOUNDFILE"