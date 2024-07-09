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
# verifica os parâmetros nomeados
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
# Verificação se os parâmetros foram fornecidos
if [ ${#input_files[@]} -eq 0 ] || [ -z "$output_file" ]; then
    usage
fi

# Recupera o caminho original do script
script_dir=$(dirname $(realpath $0))

# define o css a ser usado
css_file="${script_dir}/estilo.css"

echo "Removing temporary files..."
# set temp file names
md_temp="${output_file}.md.tmp"
html_temp="${output_file}.html.tmp"
# remove, if there is any
rm -fv "${md_temp}"
rm -fv "${html_temp}"

echo "Concatenando para MD único..."
for file in "${input_files[@]}"; do
  cat "${file}" >> "${md_temp}"
  echo "\n" >> "${md_temp}"
done

# cria diretório para imagens, caso não exista
if [[ ! -d "$MERMAID_FILTER_LOC" ]]; then
  mkdir -p "$MERMAID_FILTER_LOC"
fi

echo "From MD to HTML (pandoc)..."
pandoc -f markdown "${md_temp}" -t html -o "${html_temp}" -F mermaid-filter || { echo "Fail while converting ${base_file}.md.tmp to HTML"; exit 1; }

echo "From HTML to PDF (weasyprint)..."
weasyprint "${html_temp}" "${output_file}" -s ${css_file} -e utf-8 || { echo "Fail while converting HTML to PDF"; exit 1; }

echo "Done"
open "${output_file}"
