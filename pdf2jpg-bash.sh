#!/bin/bash
#
# pdf2jpg-bash
# Version: 1.0.0
#
# Usage: pdf2jpg-bash [input file path] [output directory path]
# Depends-On: ImageMagick | GraphicsMagick
#
# Purpose:
#   This bash script will convert PDF file into JPEG images (.jpg).
#   A PDF file with multiple pages will separated as multiple JPEG image files.
#
# Copyright: 2018 Jongmin Kim <jmkim@pukyong.ac.kr>
# License: Expat

export INPUT_FILE="$1"
export INPUT_FILENAME="$(basename -- "$1")"
export INPUT_FILENAME_WO_EXT="${INPUT_FILENAME%.*}"

export OUTPUT_DIR="$2"
export OUTPUT_FILENAME_LEADING_ZERO_COUNT=6
export OUTPUT_FILEPATH="$OUTPUT_DIR/$INPUT_FILENAME_WO_EXT-%0${OUTPUT_FILENAME_LEADING_ZERO_COUNT}d.jpg"
export OUTPUT_QUALITY=100
export OUTPUT_DENSITY=300

if [ $# -ne 2 ]; then
    echo "Usage: $0 [input file path] [output directory path]"
    echo ""
    echo "Example:"
    echo "       $0 input.pdf output_dir"
    echo "             Convert \"input.pdf\" to JPEG and save to \"output_dir\"."
    exit 1
fi

echo "Input:"
echo "  File path             $INPUT_FILE"
echo "Output:"
echo "  Target directory      $OUTPUT_DIR"
echo "  File path (pattern)   $OUTPUT_FILEPATH"
echo "  Quality               $OUTPUT_QUALITY"
echo "  Density               $OUTPUT_DENSITY"

echo ""
echo -n "Creating output directory ... "

mkdir -p "$OUTPUT_DIR"

echo "done"
echo -n "Start converting ... "

convert -quality $OUTPUT_QUALITY -density $OUTPUT_DENSITY "$INPUT_FILE" +adjoin "$OUTPUT_FILEPATH"

echo "done"
