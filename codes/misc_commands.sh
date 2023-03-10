loadkeys br-abnt2
iwctk
station wlan0 connect "Network Name"
mount /dev/sda4 /mnt
mount /dev/sda6 /boot
mount /dev/sda6 /boot/efi
lsbk
pacstrap /mnt base base-devel linux linux-firmware nano dhcpcd
genfstab -U -p /mnt >> /mnt/etc/fstab
arch-chroot /mnt
pacman -S dosfstools os-prober mtools network-manager-applet networkmanager wpa_supplicant wireless_tools dialog grub efibootmgr

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch_grub --recheck
grub-mkconfig -o /boot/grub/grub.cfg


sudo pacman -S packagekit-qt5 vim git 
sudo vim /etc/pacman.conf
# ILoveCandy
sudo pacman -Syu
sudo pacman -Syu --noconfirm ffmpeg gst-plugins-ugly gst-plugins-good gst-plugins-base gst-plugins-bad gst-libav gstreamer fwupd ntfs-3g flatpak gnome-software-packagekit-plugin packagekit-qt5 gnome-terminal ncdu ripgrep neofetch dosfstools os-prober mtools network-manager-applet networkmanager wpa_supplicant wireless_tools dialog grub efibootmgr gedit python-pip bashtop bash-completion speedtest-cli

sudo systemctl start bluetooth.service --now
pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
yay -Y --gendb
yay --save --answerclean All --answerdiff None
yay -S google-chrome
yay -Syu gnome-browser-connector chrome-gnome-shell

git config --global user.name ""
git config --global user.email ""
git config --global --list


echo -E '"\e[5~": history-search-backward
"\e[6~": history-search-forward
set enable-bracketed-paste off' > ~/.inputrc

sudo gedit /etc/default/grub
sudo os-prober
sudo grub-mkconfig -o /boot/grub/grub.cfg
sudo gedit /boot/grub/grub.cfg
sudo gedit /etc/security/faillock.conf # set deny=0

gsettings set org.gnome.desktop.peripherals.keyboard delay 250
gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 40

alias sudo='sudo ' # https://askubuntu.com/questions/22037/aliases-not-available-when-using-sudo
# jupyter code bug: https://stackoverflow.com/questions/71106136/jupyter-extension-for-vscode-on-linux-throws-error-when-doing-anything-jupyter-r/71245496#71245496


sudo EDITOR=vim visudo
ALL=(ALL) NOPASSWD: ALL

vim ~/.bashrc 
HISTSIZE=300000
HISTFILESIZE=200000
export HISTCONTROL=ignoreboth:erasedups
export PS1="\[$(tput bold)\]\t\[$(tput sgr0)\] [\u \[$(tput sgr0)\]\[\033[38;5;45m\]\w\[$(tput sgr0)\]]\\$ \[$(tput sgr0)\]"
export HISTTIMEFORMAT="%F %T "

IFS=','; for dist in `neofetch --help | awk '/AIX/,/Zorin/ {print}'| tr '\n' ' ' | sed -E 's/(NOTE:|\s)//g'`; do clear &&  echo $dist && neofetch --ascii_distro $dist && sleep 1  ; done

sed -n '/um/{/tres/{/dois/{p}}}' umdoistres
grep -P '(?=.*um)(?=.*dois)(?=.*tres)' umdoistres
rg '(?=.*um)(?=.*dois)(?=.*tres)' umdoistres --pcre2 -N
awk '/um/&&/dois/&&/tres/' umdoistres
