#!/bin/bash

# Make VS Code the default editor
echo 'export EDITOR="code --wait"' >> ~/.bashrc

# Install extensions
code --install-extension ms-vscode.atom-keybindings
code --install-extension RoscoP.ActiveFileInStatusBar
code --install-extension vincaslt.highlight-matching-tag
code --install-extension vortizhe.simple-ruby-erb
code --install-extension ZneuRay.erb-vscode-snippets
code --install-extension MS-vsliveshare.vsliveshare
code --install-extension msjsdiag.debugger-for-chrome

# Update VS Code settings.
cat >./settings.json <<EOL
{
    "atomKeymap.promptV3Features": true,
    "editor.multiCursorModifier": "ctrlCmd",
    "editor.formatOnPaste": true,
    "editor.rulers": [80],
    "emmet.includeLanguages": {
        "erb": "html",
        "jsx": "html"
    }
}
EOL
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     cp ./settings.json ~/.config/Code/User;;
    Darwin*)    cp ./settings.json ~/Library/Application\ Support/Code/User;;
    *)          echo "This script only works on Linux or Mac"
esac
rm -f ./settings.json
