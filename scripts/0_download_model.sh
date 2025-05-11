#!/bin/bash

#MODEL_TYPE="Cnn14", 312MB.
FILENAME1="Cnn14_mAP=0.431.pth"
wget -O $FILENAME1 "https://zenodo.org/record/3987831/files/Cnn14_mAP%3D0.431.pth?download=1"

#MODEL_TYPE="Cnn14_DecisionLevelMax", 312MB
FILENAME2="Cnn14_DecisionLevelMax_mAP=0.385.pth"
wget -O $FILENAME2 "https://zenodo.org/record/3987831/files/Cnn14_DecisionLevelMax_mAP%3D0.385.pth?download=1"