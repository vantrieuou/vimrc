sudo apt-get install vim-gtk
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim.gtk 1
sudo update-alternatives --set editor /usr/bin/vim.gtk
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim.gtk 1
sudo update-alternatives --set vi /usr/bin/vim.gtk
sudo update-alternatives --install /usr/bin/vi vim /usr/bin/vim.gtk 1
sudo update-alternatives --set vim /usr/bin/vim.gtk
sudo apt-get install editorconfig
