#!/bin/bash

# Ensure system binaries are in PATH
export PATH="/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

# Check arguments
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <sound1.wav> <sound2.mp3>"
    exit 1
fi

SOUND1=$1
SOUND2=$2

# ------ Paths ------
VENV_PYTHON="./.venv/bin/python"
SCRIPT_DIR="./src"

# ------ Inference audio tagging result with pretrained model. ------
MODEL_TYPE="Cnn14"
CHECKPOINT_PATH="Cnn14_mAP=0.431.pth"

#1. Play first sound
echo "▶ Playing first sound: $SOUND1"
afplay "$SOUND1" &
wait

#2. Play second sound
echo "▶ Playing second sound: $SOUND2"
afplay "$SOUND2" &
wait

#3. Calculate similarity
echo "🔍 Analyzing similarity..."
SIMILARITY=$("$VENV_PYTHON" "$SCRIPT_DIR/inference.py" compare_embeddings \
    --model_type=$MODEL_TYPE \
    --checkpoint_path=$CHECKPOINT_PATH \
    --audio_path1="$SOUND1" \
    --audio_path2="$SOUND2")

echo "Similarity score: $SIMILARITY"

#4. Interpret and speak result
say -v "Samantha" "Similarity score is $SIMILARITY"

if (( $(echo "$SIMILARITY >= 0.9" | bc -l) )); then
    say -v "Samantha" "These sounds are very similar."
elif (( $(echo "$SIMILARITY >= 0.7" | bc -l) )); then
    say -v "Samantha" "These sounds are similar."
elif (( $(echo "$SIMILARITY >= 0.5" | bc -l) )); then
    say -v "Samantha" "These sounds are somewhat similar."
else
    say -v "Samantha" "These sounds are different."
fi