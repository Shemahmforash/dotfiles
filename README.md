# dotfiles
Dotfiles

## .vimrc

Install Vundle:
`git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`

Then all dependencies for plugins
```
brew install vim git npm ctags
sudo npm -g install instant-markdown-d jshint
sudo pip install isort jedi yapf flake8 virtualenvwrapper autopep8
```

To install vundle plugins, open vim and run: `:PluginInstall`
