#!/bin/bash
TMPF=$(mktemp /tmp/t.XXXXXX)

cd ~
sudo smbd --help > $TMPF
if [ "$?" -ne "0" ]
then
    echo "Please install Samba first."
    rm -f $TMPF
    exit 1
fi
rm -f $TMPF
if [ "$1" = "stop" ]
then
    echo "Stopping SAMBA server..."
    sudo /etc/init.d/smbd stop
    sudo /etc/init.d/nmbd stop
    exit 0
fi
echo "Hi. Welcome. We're creating a simple Samba server on this computer."
echo ""
echo "First, we'll create and place a Samba configuration file."
touch smb.conf
echo "[global]" > smb.conf
echo "workgroup = HOMESWEETHOME" >> smb.conf
echo "encrypt passwords = yes" >> smb.conf
echo "wins support = no" >> smb.conf
echo "log level = 1" >> smb.conf
echo "max log size = 1000" >> smb.conf
echo "netbios name = CH12" >> smb.conf
echo "server string = %L Samba Server" >> smb.conf
echo "guest ok = no" >> smb.conf
echo " " >> smb.conf
echo "[homes]" >> smb.conf
echo "browsable = yes" >> smb.conf
sudo chown root:root smb.conf
sudo mv smb.conf /etc/samba/
sleep 2
echo "Now, we'll create a user account '"$USER"' and its password."
echo "You choose the password."
sleep 1
sudo smbpasswd -a $USER
sleep 1
echo "Now, we're starting the SMB file server."
sudo nmbd -D -s /etc/samba/smb.conf
sudo smbd -D -s /etc/samba/smb.conf
sleep 2
echo "You can try, on another computer, in 'Networks' folder."
echo "You should see a server named 'CH12'."
echo "You can access its contents through account '"$USER"' and its password."
echo ""
echo "IMPORTANT!!!: To stop the Samba server service, run '"$0" stop'"
echo "Don't forget to try. BYE."
echo ""

