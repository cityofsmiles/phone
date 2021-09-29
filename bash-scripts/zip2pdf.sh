#!/usr/bin/env bash

set -Eeuo pipefail
trap cleanup SIGINT SIGTERM ERR EXIT

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

usage() {
  cat << EOF 
Usage: $(basename "${BASH_SOURCE[0]}") [-h] [-v] [-f] -p param_value arg1 [arg2...]

Script description here.

Available options:

-h, --help      Print this help and exit
-v, --verbose   Print script debug info
-f, --flag      Some flag description
-p, --param     Some param description
EOF
  exit
}

cleanup() {
  trap - SIGINT SIGTERM ERR EXIT
  # script cleanup here
  cd $curdir
  rm *.csv
  rm "$zipfile"
}

setup_colors() {
  if [[ -t 2 ]] && [[ -z "${NO_COLOR-}" ]] && [[ "${TERM-}" != "dumb" ]]; then
    NOFORMAT='\033[0m' RED='\033[0;31m' GREEN='\033[0;32m' ORANGE='\033[0;33m' BLUE='\033[0;34m' PURPLE='\033[0;35m' CYAN='\033[0;36m' YELLOW='\033[1;33m'
  else
    NOFORMAT='' RED='' GREEN='' ORANGE='' BLUE='' PURPLE='' CYAN='' YELLOW=''
  fi
}

msg() {
  echo >&2 -e "${1-}"
}

die() {
  local msg=$1
  local code=${2-1} # default exit status 1
  msg "$msg"
  exit "$code"
}

parse_params() {
  # default values of variables set from params
  flag=0
  dir=''

  while :; do
    case "${1-}" in
    -h | --help) usage ;;
    -v | --verbose) set -x ;;
    --no-color) NO_COLOR=1 ;;
    -f | --flag) flag=1 ;; # example flag
    -d | --dir) # example named parameter
      dir="${2-}"
      shift
      ;;
    -?*) die "Unknown option: $1" ;;
    *) break ;;
    esac
    shift
  done

  args=("$@")

  # check required params and arguments
 # [[ -z "${dir-}" ]] && die "Missing required parameter: dir"
  [[ ${#args[@]} -eq 0 ]] && die "Missing script arguments"

  return 0
}

parse_params "$@"
setup_colors

# script logic here

curdir=$(pwd)

cd $curdir

outdir="$1"

grading="$2"

unzip "*.zip"

for csvfile in *.csv;
do
  sed 's/\bMale\b/Boy/g;s/\bMALE\b/BOY/g' "$csvfile" | tail -n+2 | cut --delimiter=, -f2,3,6,9 | sort --field-separator=',' -k4 -k2 -k3  > out-"$csvfile" ;

  filename="${csvfile%.*}"  

  echo -e "\nLast Name, First Name, Score\n" > "$filename".txt

  data=$(sed 's/\r//' out-"$csvfile" | awk -F, '{print $2,$3,$1}' OFS=,)
    
  echo "$data" >> "$filename".txt

  mv "$filename".txt "$csvfile"

  soffice --headless --convert-to pdf:calc_pdf_Export "$csvfile"

  section=$(echo $filename | cut -d')' -f 1)
  section=$(echo $section | cut -d'(' -f 2)

  if [ -d $outdir/$grading/$section/summary ];then
    echo "Output folder exists."
  else
    mkdir -p $outdir/$grading/$section/summary
  fi

  mv "$filename".pdf $outdir/$grading/$section/"$filename".pdf 
done

cd $outdir/$grading

for dir in *
do
  cd $outdir/$grading/$dir
  qpdf --empty --pages *.pdf -- ./summary/summary.pdf
done

notify-send "Done!"

msg "${RED}Read parameters:${NOFORMAT}"
msg "- flag: ${flag}"
msg "- dir: ${dir}"
msg "- arguments: ${args[*]-}"

