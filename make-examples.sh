#!/bin/bash
SCRIPT_DIR=$(dirname "$0")

makeExamples() {
  for cowfile in ${SCRIPT_DIR}/cows/*.cow; do
    cowname=$(basename $cowfile)
    firstchar=${cowname:0:1}

    if [[ $firstchar != "_" && $cowname != "default.cow" ]]; then
      # skip any cows that start with _, these are test cows
      echo ""
      echo "## ${cowname}"
      cowname="${cowname%.*}"

      imgname=""

      #check if image file matching this cow name exists
      FILE=converter/src_images/${cowname}.png
      if test -f "${SCRIPT_DIR}/$FILE"; then
        imgname="$FILE"
      fi
      if [ -z "$imgname" ]; then  #if cow doesn't have a png image related, then just print the cow normally
          echo '```'
          cowsay -f ${cowfile} "$cowname"
          echo '```'
      else # otherwise insert an image tag for the source image
        echo "<img src=\"https://charc0al.github.io/cowsay-files/$imgname\" height=\"200\" />"
      fi
      echo ""
    fi
  done


  # Show true color cows separately
  echo ""
  echo "# True Color cows"
  for cowfile in ${SCRIPT_DIR}/cows/true-color/*.cow; do
    cowname=$(basename $cowfile)
    echo ""
    echo "## ${cowname}"
    cowname="${cowname%.*}"

    imgname=""

    #check if image file matching this cow name exists
    FILE="converter/src_images/${cowname}-tc.png"
    if test -f "${SCRIPT_DIR}/$FILE"; then
      imgname="$FILE"
    else  # if image doesn't exist, check if one without the -tc suffix exists
      FILE="converter/src_images/${cowname}.png"
      if test -f "${SCRIPT_DIR}/$FILE"; then
        imgname="$FILE"
      fi
    fi
    if [ -z "$imgname" ]; then  #if cow doesn't have a png image related, then just print the cow normally
        echo '```'
        echo "COW SOURCE IMAGE NOT FOUND"
        echo '```'
    else # otherwise insert an image tag for the source image
      echo "<img src=\"https://charc0al.github.io/cowsay-files/$imgname\" height=\"200\" />"
    fi
    echo ""
  done
}

makeExamples > "${SCRIPT_DIR}/examples.md"
