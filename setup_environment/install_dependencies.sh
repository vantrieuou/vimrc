# Install vim 8.2
sudo apt remove vim vim-gtk vim-gtk3 vim-gnome vim-runtime vim-tiny
sudo apt install libncurses5-dev \
libgtk2.0-dev libatk1.0-dev \
libcairo2-dev python-dev \
python3-dev git checkinstall
cd ~ && sudo git clone https://github.com/vim/vim.git && cd vim
sudo ./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp=yes \
            --enable-pythoninterp=yes \
            --with-python-config-dir=$(python-config --configdir) \
            --enable-python3interp=yes \
            --with-python3-config-dir=$(python3-config --configdir) \
            --enable-perlinterp=yes \
            --enable-luainterp=yes \
            --enable-gui=gtk2 \
            --enable-cscope \
            --prefix=/usr/local

sudo checkinstall
sudo make VIMRUNTIMEDIR=/usr/local/share/vim/vim82
sudo rm -rf ~/vim
sudo apt-get install vim-gtk
