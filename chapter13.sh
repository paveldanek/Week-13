#!/bin/bash

if [ "$1" = "undo" ]
then
    cd ~
    echo "Reverting back to your original start-up file."
    sudo cp .bashrc.bkup .bashrc
    echo "Restart your terminal."
    exit 0
fi
cd ~
sudo mv .bashrc .bashrc.bkup
touch .bashrc
echo "PATH=$PATH" > .bashrc
echo "PS1='\[\033[01;35m\]BEHOLD THE BOSS $ \[\033[00m\]'" >> .bashrc
echo "PAGER=less" >> .bashrc
echo "LESS=meiX" >> .bashrc
echo "export PATH PAGER LESS" >> .bashrc
echo "umask 022" >> .bashrc

echo "Restart your terminal to apply changes to your"
echo "start-up file. To revert back, run '"$0" undo'."
echo "Now, restart your terminal. Don't forget ^^^^^^^^^"
echo ""

