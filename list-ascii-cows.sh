#!/bin/bash
SCRIPT_DIR=$(dirname "$0")

for cowfile in ${SCRIPT_DIR}/cows/*.cow; do
  cowname=$(basename $cowfile)
  cowname="${cowname%.*}"
  firstchar=${cowname:0:1}

  if [[ $firstchar != "_" && $cowname != "default.cow" ]]; then
    imgname=""
    FILE=${SCRIPT_DIR}/converter/src_images/${cowname}.png
    if test -f "$FILE"; then
      imgname="$FILE"
    else
      if [[ $cowname =~ ^.*-tc$ ]]; then
        shortname="${cowname%-tc*}"
        FILE=${SCRIPT_DIR}/converter/src_images/${shortname}.png
        if test -f "$FILE"; then
          imgname="$FILE"
        fi
      fi
    fi
    if [ -z "$imgname" ]; then
        echo "$cowname"
    fi
  fi
done
