CONVERTER_DIR=$(dirname "$0")
EXAMPLES=($(cat "${CONVERTER_DIR}/../lists/new.cows"))

SCRIPT_DIR=$(dirname "$0")

function printcow() {
  COWIMG=$1
  if [ "${2}" != "" ]; then
    COWIMG=${2}
  fi
  EXTRATEXT=$3

  echo '  <div class="cow-tile">'
  echo "    <div class=\"label\">${1}.cow${EXTRATEXT}</div>"
  echo '    <div class="wrapper">'
  echo "      <a href=\"https://raw.githubusercontent.com/charc0al/cowsay-files/master/cows/${4}${1}.cow\">"
  # echo "      <a href=\"../cows/${4}${1}.cow\" target=\"_blank\">"
  echo "        <img src=\"src_images/${COWIMG}.png\" class=\"sizer\">"
  echo '      </a>'
  echo '    </div>'
  echo '  </div>'
}

function generate() {
  echo '<head><meta property="og:image" content="ThumbnailImage.jpg" /></head>'
  echo '<h2>Cowsay file examples</h2><h4>(click to view)</h4>'
  echo '<link rel="stylesheet" type="text/css" href="src/style.css">'
  echo '<div class="image-container" style="background: #000;">'

  for cowfile in ${EXAMPLES[@]}; do
    printcow $cowfile
  done

  for cowfile in ${SCRIPT_DIR}/../cows/*.cow; do
    cowname=$(basename $cowfile)
    firstchar=${cowname:0:1}

    if [[ $firstchar != "_" && $cowname != "default.cow" ]]; then
      cowname="${cowname%.*}"

      #check if image file matching this cow name exists
      FILE=converter/src_images/${cowname}.png
      if test -f "${SCRIPT_DIR}/../$FILE"; then
        printcow $cowname
      fi


      COW="cows/true-color/${cowname}.cow"
      if test -f "${SCRIPT_DIR}/../$COW"; then
        FILE="converter/src_images/${cowname}-tc.png"
        if test -f "${SCRIPT_DIR}/../$FILE"; then
          printcow $cowname "${cowname}-tc" " (true color)" "true-color/"
        fi
      fi
    fi
  done

  echo '</div>'
}

generate > ${SCRIPT_DIR}/examples.html
