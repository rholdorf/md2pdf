# md2pdf

Simple script to help render markdown documents as pdf.

## How it works

Takes Markdown files, with or without Mermaid syntax, converts to HTML using Pandoc and then converts to PDF using Weasyprint. Works fine in Mac, Linux and WSL.

## Execution

Make sure [pandoc](https://pandoc.org/installing.html), [weasyprint](https://weasyprint.org) and [mermaid-filter](https://github.com/raghur/mermaid-filter) are installed, according to the their instructions.

CD into de directory where your MDs are, and:

```bash
./md2pdf.sh
```

## Optionally, enhance VSCode

You may want to have VSCode working with Markdown and Mermaid, by adding these extensions:

| Extension | Description | Publisher |
|--|--|--|
| [Markdown Preview Mermaid Support](https://marketplace.visualstudio.com/items?itemName=bierner.markdown-mermaid) | Adds Mermaid diagram and flowchart support to VS Code's builtin markdown preview | Matt Bierner |
| [Markdown All in One](https://marketplace.visualstudio.com/items?itemName=yzhang.markdown-all-in-one) | All you need to write Markdown (keyboard shortcuts, table of contents, auto preview and more) | Yu Zhang |
| [markdownlint](https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint) | Markdown linting and style checking for Visual Studio Code | David Anson |
