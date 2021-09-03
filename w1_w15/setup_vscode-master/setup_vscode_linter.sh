#!/bin/bash

# Install JSHint NPM package and VS Code extension
npm install -g jshint
code --install-extension dbaeumer.jshint

# Tell JSHint to use be aware of ES6 syntax. 
cat >~/.jshintrc <<EOL
{
  "esversion": 6
}
EOL
