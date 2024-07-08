# md2pdf

Simple script to help render markdown documents as pdf.

## How it works

Takes Markdown files, with or without Mermaid syntax, converts to HTML using Pandoc and then converts to PDF using Weasyprint.

### Pre-Reqs

|  |
|--|
| [pandoc](https://pandoc.org/installing.html) |
| [weasyprint](https://weasyprint.org) |
| [mermaid-filter](https://github.com/raghur/mermaid-filter) |

## Execução

Make sure ```Pandoc```, ```Weasyprint``` e ```mermaid-filter``` are properly installed, according to the their instructions.

CD into de directory where your MDs are, and:

### Linux, MacOS, WSL

```bash
./md2pdf.sh
```

## Optionally, configure VSCode

You may want to have VSCode working with Markdown and Mermaid, by adding these extensions:

|  |  |
|--|--|
| [Markdown Preview Mermaid Support](https://marketplace.visualstudio.com/items?itemName=bierner.markdown-mermaid) | Id: bierner.markdown-mermaid <br> Description: Adds Mermaid diagram and flowchart support to VS Code's builtin markdown preview <br> Version: 1.23.0 <br> Publisher: Matt Bierner |
| [Markdown All in One](https://marketplace.visualstudio.com/items?itemName=yzhang.markdown-all-in-one) | Id: yzhang.markdown-all-in-one <br> Description: All you need to write Markdown (keyboard shortcuts, table of contents, auto preview and more) <br> Version: 3.6.2 <br> Publisher: Yu Zhang |
| [markdownlint](https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint) | Id: DavidAnson.vscode-markdownlint <br> Description: Markdown linting and style checking for Visual Studio Code <br> Version: 0.55.0 <br> Publisher: David Anson |
