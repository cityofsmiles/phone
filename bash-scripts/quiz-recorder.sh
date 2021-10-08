#!/usr/bin/env bash

set -Eeuo pipefail
trap cleanup SIGINT SIGTERM ERR EXIT

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

usage() {
  cat << EOF 
Usage: $(basename "${BASH_SOURCE[0]}") [-h] [-v] -i inputdir -o outputdir -g gradingperiod -q quiznum

Automatically record scores downloaded from Google forms.

Available options:

-h, --help           Print this help and exit
-v, --verbose        Print script debug info
-i, --inputdir       Directory for input zipped files
-o, --outputdir      Directory for outputs
-g, --gradingperiod  The current grading period, e.g., '1st-Grading'
-q, --colname        The quiz number to be recorded, e.g., 'Q1'
EOF
  exit
}

cleanup() {
  trap - SIGINT SIGTERM ERR EXIT
  # script cleanup here
  cd ${inputdir}
  rm *.csv
#  rm *.zip
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
  inputdir='/home/jonathan/Downloads'
  outputdir='/home/jonathan/Documents/excel/21-22/Class-Records/outputs'
  gradingperiod='Current-Grading-Period'
  quiznum='Q1'

  while :; do
    case "${1-}" in
    -h | --help) usage ;;
    -v | --verbose) set -x ;;
    --no-color) NO_COLOR=1 ;;
    -i | --inputdir) 
      inputdir="${2-}" 
      shift
      ;;
    -o | --outputdir) 
      outputdir="${2-}"
      shift
      ;;
    -g | --gradingperiod) 
      gradingperiod="${2-}"
      shift
      ;;
    -q | --quiznum) 
      quiznum="${2-}"
      shift
      ;;
    -?*) die "Unknown option: $1" ;;
    *) break ;;
    esac
    shift
  done

  args=("$@")

  # check required params and arguments
  [[ -z "${inputdir-}" ]] && die "Missing required parameter: inputdir"
  [[ -z "${outputdir-}" ]] && die "Missing required parameter: outputdir"
  [[ -z "${gradingperiod-}" ]] && die "Missing required parameter: gradingperiod"
  [[ -z "${quiznum-}" ]] && die "Missing required parameter: quiznum"
 # [[ ${#args[@]} -eq 0 ]] && die "Missing script arguments"

  return 0
}

parse_params "$@"
setup_colors

# script logic here

unzip_files() {
  cd ${inputdir}
  unzip "*.zip"
}

record_csv() {
  for csvfile in *.csv;
  do
    filename="${csvfile%.*}"  

    section=$(echo "$filename" | cut -d')' -f 1)
    section=$(echo $section | cut -d'(' -f 2)

    sed 's/\bMale\b/Boy/g;s/\bMALE\b/BOY/g' "$csvfile" | tail -n+2 | cut --delimiter=, -f2,3,6,9 | sort --field-separator=',' -k2 -k3  > out-"$csvfile" 

    while IFS="," read -r score lastname firstname gender
    do
        cleanscore=$(echo $score | cut -d'.' -f 1 | tr -d ' ')
        echo -e "$lastname.$firstname, $cleanscore, $gender" | tr '[:upper:]' '[:lower:]' | tr -d ' ' >> lower-"$csvfile"
        #cat lower-"$csvfile" | tr -d '"' > clean-"$csvfile"

        total=$(echo $score | cut -d'/' -f 2 | tr -d ' ' )

        percent=$( echo "100 * cleanscore / total" | bc -l)

        if [ $percent -ge 75 ]; then
          rating="Passed"
        else
          rating="Failed"
        fi

        echo -e "$lastname.$firstname, $rating" | tr '[:upper:]' '[:lower:]' | tr -d ' ' >> ratings-"$csvfile"
        cat ratings-"$csvfile" | tr -d '"' > Ratings-"$csvfile"

    done < out-"$csvfile"
    
    cat lower-"$csvfile" | tr -d '"' > clean-"$csvfile"

    mv clean-"$csvfile" "$csvfile"

    # Create directories and files
    if [ ! -d $outputdir/$gradingperiod/$section/summary ];then
      mkdir -p $outputdir/$gradingperiod/$section/summary
    fi

    if [ ! -d $outputdir/$gradingperiod/$section/ratings ];then
      mkdir -p $outputdir/$gradingperiod/$section/ratings
    fi

    quiz_summary="$outputdir/$gradingperiod/$section/summary/$section-Quizzes.csv"
    ratings_summary="$outputdir/$gradingperiod/$section/ratings/$section-Quiz-Results.csv"

    if [[ ! -f "$quiz_summary" ]]; then
      echo "Name" > "$quiz_summary"
    fi

    if [[ ! -f "$ratings_summary" ]]; then
      echo "Name" > "$ratings_summary"
    fi

    # Remove the gender column before joining
    awk -i inplace -F, '{for(i=0;++i<=NF-2;)printf $i",";print $(NF-1)}' "$quiz_summary"   

    # Remove the headers before joining
    heading=$(head -1 "$ratings_summary")
    sed -i '1d' "$ratings_summary"
    sed -i '1d' "$quiz_summary"

    # Join summary
    join -t "," --nocheck-order "$quiz_summary" "$csvfile" > "$quiz_summary.out"
    join -t "," --nocheck-order -a1 -v1 "$quiz_summary" "$csvfile" | awk '{print $0",\"\",\"\""}' >> "$quiz_summary.out"
    join -t "," --nocheck-order -a2 -v2 "$quiz_summary" "$csvfile" | sed -e 's/ /,\"\",\"\" /' >> "$quiz_summary.out"
    sort "$quiz_summary.out" -o "$quiz_summary.out"

    # Join ratings
    join -t "," --nocheck-order "$ratings_summary" "Ratings-$csvfile" > "$ratings_summary.out"
    join -t "," --nocheck-order -a1 -v1 "$ratings_summary" "Ratings-$csvfile" | awk '{print $0",\"\""}' >> "$ratings_summary.out"
    join -t "," --nocheck-order -a2 -v2 "$ratings_summary" "Ratings-$csvfile" | sed -e 's/ /,\"\" /' >> "$ratings_summary.out"
    sort "$ratings_summary.out" -o "$ratings_summary.out"
      
    # Add back the header to ratings summary
    heading="$heading, $quiznum"
    echo $heading > "$ratings_summary"
    cat "$ratings_summary.out" >> "$ratings_summary"
    
    # Convert rating summary to pdf
    cd $outputdir/$gradingperiod/$section/ratings
    soffice --headless --convert-to pdf:calc_pdf_Export "$ratings_summary"
    cd $inputdir

    # Sort the quiz summary for recording
    colnum=$(head -1 "$quiz_summary.out" | sed 's/[^,]//g' | wc -c)
    cat "$quiz_summary.out" | sort --field-separator=',' -k$colnum -k1  > "$quiz_summary.record"
    awk -i inplace -F, '{for(i=0;++i<=NF-2;)printf $i",";print $(NF-1)}' "$quiz_summary.record"

    # Add back the header to quiz summary
    echo $heading > "$quiz_summary"
    cat "$quiz_summary.out" >> "$quiz_summary"
    echo $heading > "$quiz_summary.record.csv"
    cat "$quiz_summary.record" >> "$quiz_summary.record.csv"

    # Move/rename files
    rm "$quiz_summary.out" 
    mv "$csvfile" $outputdir/$gradingperiod/$section/"$csvfile"
    mv Ratings-"$csvfile" $outputdir/$gradingperiod/$section/ratings/Ratings-"$csvfile"
    rm "$ratings_summary.out"
    rm "$quiz_summary.record"

  done
}



main() {
  unzip_files
  record_csv
}

main

msg "${RED}Read parameters:${NOFORMAT}"
msg "- quiznum: ${quiznum}"
msg "- inputdir: ${inputdir}"
msg "- outputdir: ${outputdir}"
msg "- gradingperiod: ${gradingperiod}"


