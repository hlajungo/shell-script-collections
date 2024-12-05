#!/bin/bash

mkdir -p "test"
touch "test/input.txt"
touch "test/answer.txt"

>"test/run.sh"
cat << EOF | tee -a "test/run.sh" > /dev/null

color()
{
  if [ "\$#" -ne 2 ] ; then
    echo "[ERROR] color <color-name> <text> expected two arguments, but got \$#" >&2
    return 1
  fi

  local -r colorName="\$1"
  local -r message="\$2"

  local colorCode="0;37"
  case "\${colorName,,}" in
    black          ) colorCode='0;30' ;;
    red            ) colorCode='0;31' ;;
    green          ) colorCode='0;32' ;;
    yellow         ) colorCode='0;33' ;;
    blue           ) colorCode='0;34' ;;
    magenta        ) colorCode='0;35' ;;
    cyan           ) colorCode='0;36' ;;
    white          ) colorCode='0;37' ;;
    bright_black   ) colorCode='0;90' ;;
    bright_red     ) colorCode='0;91' ;;
    bright_green   ) colorCode='0;92' ;;
    bright_yellow  ) colorCode='0;93' ;;
    bright_blue    ) colorCode='0;94' ;;
    bright_magenta ) colorCode='0;95' ;;
    bright_cyan    ) colorCode='0;96' ;;
    bright_white   ) colorCode='0;97' ;;
    gray           ) colorCode='0;90' ;;
    *              ) colorCode='0;37' ;;
  esac

  echo -e "\e[\${colorCode}m\${message}\e[0m"
}

# xclip required.
# don't have xclip or don't have one of the graphical interface.
if ! command -v xclip >/dev/null 2>&1 || { [ -z "\$DISPLAY" ] && [ -z "\$WAYLAND_DISPLAY" ]; }; then
    echo "xclip is not installed or there is no graphical interface, the code will not be copied to the clipboard."
fi

if [[ -z "\$1" ]]; then
  echo "Error: A input file is needed." >&2
  exit 1
fi

DIR="\$(dirname "\$(realpath \$0)")"
cd \$DIR


g++ ../\$1 -o \$1.bin || exit 1;
TIME1=\$(date +%s%3N)
./\$1.bin <input.txt > output.txt
TIME2=\$(date +%s%3N)

# -w忽略換行符
diff -w output.txt answer.txt > /dev/null
if [ \$? -eq 0 ]; then
  color bright_green "Accept, code is copied to clipbroad."
  xclip -sel clip ../\$1
  color green "Output."
  color green "----------"
  cat output.txt
  color yellow "Time: \$((TIME2 - TIME1)) ms"
else
  color red "Output."
  color red "----------"
  cat output.txt
  color red "Answer."
  color red "----------"
  cat answer.txt
fi
EOF

