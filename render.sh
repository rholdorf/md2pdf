#!/bin/zsh

# interrompe a execução em caso de erro
set -e

# nome base para os arquivos de saída
base_name="ARC"
md_temp="${base_name}.md.tmp"
html_temp="${base_name}.html.tmp"

# Recupera o caminho original do script
script_dir=$(dirname $(realpath $0))

# define o css a ser usado
css_file="${script_dir}/estilo.css"

echo "O script está localizado em: $script_dir"

# configura mermaid-filter
export MERMAID_FILTER_THEME=neutral
export MERMAID_FILTER_SCALE=2
export MERMAID_FILTER_LOC=./images/generated

# array com os nomes dos arquivos Markdown
declare -a files=(
    "/Users/rui/src/pg/datafabric/datafabric_entendimento_e_proposta.md"
)

echo "Removendo arquivos temporários..."
rm -fv "${md_temp}"
rm -fv "${html_temp}"

echo "Concatenando para MD único..."
for file in "${files[@]}"; do
    cat "${file}" >> "${md_temp}"
    echo "\n" >> "${md_temp}"
done

# cria diretório para imagens, caso não exista

# Testa se o diretório existe
if [[ ! -d "$MERMAID_FILTER_LOC" ]]; then
  # Se não existir, cria o diretório
  mkdir -p "$MERMAID_FILTER_LOC"
  echo "Diretório '$MERMAID_FILTER_LOC' criado."
else
  echo "Diretório '$MERMAID_FILTER_LOC' já existe."
fi

echo "Convertendo de MD para HTML..."
pandoc -f markdown "${md_temp}" -t html -o "${html_temp}" -F mermaid-filter || { echo "Falha ao converter ${base_file}.md.tmp"; exit 1; }

echo "Convertendo de HTML para PDF..."
weasyprint "${html_temp}" "${base_name}.pdf" -s ${css_file} -e utf-8 || { echo "Falha ao converter HTML para PDF"; exit 1; }

echo "Pronto"
open "${base_name}.pdf"
