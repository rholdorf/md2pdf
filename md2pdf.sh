#!/bin/zsh
set -e
# configura mermaid-filter
export MERMAID_FILTER_THEME=neutral
export MERMAID_FILTER_SCALE=2
export MERMAID_FILTER_LOC="./images/generated"

usage() {
    echo "Use: md2pdf.sh -i 'file1.md file2.md ...' -o output_file"
    exit 1
}
# read the options
while getopts "i:o:" opt; do
    case $opt in
        i)
            input_files=(${(s: :)OPTARG})  # Converte a string em um array
            ;;
        o)
            output_file="$OPTARG"
            ;;
        *)
            usage
            ;;
    esac
done
# check if the required arguments were passed
if [ ${#input_files[@]} -eq 0 ] || [ -z "$output_file" ]; then
    usage
fi

# get the script directory
script_dir=$(dirname $(realpath $0))

# set the css file
css_file="${script_dir}/estilo.css"

# set temp file names
md_temp="${output_file}.md.tmp"
html_temp="${output_file}.html.tmp"

removeTemp(){
    # remove, if there is any
    rm -f "$md_temp"
    rm -f "$html_temp"
}

removeTemp
echo "Concat input files into single MD..."
for file in "${input_files[@]}"; do
  cat "${file}" >> "${md_temp}"
  echo "\n" >> "${md_temp}"
done

# create generated images folder, if needed
if [[ ! -d "$MERMAID_FILTER_LOC" ]]; then
  mkdir -p "$MERMAID_FILTER_LOC"
fi

echo "From MD to HTML (pandoc)..."
pandoc -f markdown "${md_temp}" -t html -o "${html_temp}" -F mermaid-filter || { echo "Fail while converting ${base_file}.md.tmp to HTML"; exit 1; }
echo "From HTML to PDF (weasyprint)..."
weasyprint "${html_temp}" "${output_file}" -s ${css_file} -e utf-8 || { echo "Fail while converting HTML to PDF"; exit 1; }
echo "Done"
removeTemp
open "${output_file}"
