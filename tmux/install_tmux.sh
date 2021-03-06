#! /bin/bash

TMUX_PATH=$(pwd)

# libevent
tar -zxvf $TMUX_PATH/libevent-2.1.8-stable.tar.gz -C $TMUX_PATH
cd $TMUX_PATH/libevent-2.1.8-stable
./configure && make
make install
ln -s /usr/local/lib/libevent-2.1.so.6 /usr/lib64/libevent-2.1.so.6

# tmux
tar -zxvf $TMUX_PATH/tmux-2.6.tar.gz -C $TMUX_PATH
cd $TMUX_PATH/tmux-2.6
./configure 
make
make install
if [ -f /usr/bin/tmux ]; then
    rm -f /usr/bin/tmux
fi
ln -s /usr/local/bin/tmux /usr/bin/tmux

# tmux conf
/bin/cp -rf $TMUX_PATH/.tmux/ ~/
cd ~
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .

# term color
echo 'export TERM=xterm-256color' >> ~/.bashrc
source ~/.bashrc

### powerline

cp $TMUX_PATH/PowerlineSymbols.otf /usr/share/fonts/
fc-cache -vf /usr/share/fonts/
