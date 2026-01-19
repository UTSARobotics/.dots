#   Instructions

### Update packages
```bash
sudo pacman -Syu
```
### Installing yay
```bash
mkdir -p $HOME/Documents/github
cd $HOME/Documents/github
git clone https://aur.archlinux.org/yay.git
```
```bash
cd yay
makepkg -si 
```
### apps to install
```bash
sudo pacman -S --needed neovim qt6ct tmux wev kvantum brightnessctl gimp gmic gimp-plugin-gmic ghostscript gsfonts mypaint-brushes imagemagick nodejs-lts-iron npm clang docker xorg-xhost ufw openssh unzip git base-devel fastfetch stow noto-fonts-emoji usbutils libreoffice-fresh zip kicad kicad-library kicad-library-3d sl firefox discord kitty cmake xclip
```
```bash
yay -S gimp-plugin-resynthesizer docker-buildx webapp-manager
```
### Create your fonts directory
```bash
mkdir -p $HOME/.local/share/fonts
```
### Download the font directly from the Nerd Fonts project
```bash
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip -O /tmp/FiraCode.zip
```
### Unzip
```bash
unzip /tmp/FiraCode.zip -d $HOME/.local/share/fonts/FiraCode
```
### Refresh the font cache
```bash
fc-cache -fv
```
### Verify the font is installed
```bash
fc-list | grep "FiraCode Nerd Font Mono"
```
### if you want more fonts, run this
### makes github directory
```bash
mkdir -p $HOME/Documents/github
cd $HOME/Documents/github
```
### Installs font bulk download & downloads it ~2-3 GB!
```bash
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git

cd nerd-fonts

./install.sh
```
### Refresh the font cache
```bash
fc-cache -fv
```
### Installing Zsh, ohmyzsh, ohmyposh, zinit
#### Zsh
```bash
sudo pacman -S zsh
```
```bash
chsh -s /bin/zsh
```
#### ohmyzsh
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
#### ohmyposh
```bash
yay -S oh-my-posh
```
#### zinit
```bash
sudo pacman -S zoxide
```
```bash
git clone https://github.com/zdharma-continuum/zinit.git $HOME/.local/share/zinit/zinit.git
```
```bash
source "${HOME}/.local/share/zinit/zinit.git/zinit.zsh"
```
```bash
source $HOME/.zshrc
```
### Removing files to make links later
```bash
rm $HOME/.bashrc
rm $HOME/.bash_history
rm $HOME/.bash_logout
rm $HOME/.bash_profile
rm $HOME/.zshrc

rm  -rf $HOME/.config/kitty
rm  -rf $HOME/.config/nvim
sudo rm /etc/systemd/logind.conf
```
# Stow:
run `stow .` from the dots directory

make sure to have the dots on the home directory

### Github setup
```bash
git config --global user.name R5
```
```bash
git config --global user.email robotics.utsa@gmail.com
```
```bash
git config --global init.defaultBranch main
```
### Github ssh setup
```bash
eval "$(ssh-agent -s)"
```
```bash
ssh-keygen -t ed25519 -C robotics.utsa@gmail.com
```
```bash
xclip -selection clipboard $HOME/.ssh/id_ed25519.pub 
```
```bash
ssh -T git@github.com
```
### OpenSSH
####  Start SSH daemon
```bash
sudo systemctl start sshd
sudo systemctl enable sshd
```
####  allow port
```bash
sudo ufw allow 22/tcp
```
##  Kvantum
- Create a Kvantum symlink
```bash
ln -s $HOME/.dots/misc/Kvanthum/ $HOME/Documents/
```
- Go to Kvantum Manager application and install the Nordic Darker Theme inside the Kvantum folder
- Apply the theme in Kvantum manager
- go into the qt6ct app and also select dark Kvantum
### sddm
```bash
https://github.com/uiriansan/SilentSDDM
```

```bash
yay -S sddm-silent-theme
```

```bash
sudo pacman -S --needed sddm qt6-svg qt6-virtualkeyboard qt6-multimedia-ffmpeg
```

```bash
sudo git clone -b master --depth 1 https://github.com/keyitdev/sddm-astronaut-theme.git /usr/share/sddm/themes/sddm-astronaut-theme
```

```bash
sudo cp -r /usr/share/sddm/themes/sddm-astronaut-theme/Fonts/* /usr/share/fonts/
```

####  If you dont have a sddm.conf in /etc/

```bash
sudo sddm --example-config | sudo tee /etc/sddm.conf > /dev/null
sudo mkdir -p /etc/sddm.conf.d
```
```bash
[Theme]
Current=sddm-astronaut-theme``
```

```bash
sudo -e /etc/sddm.conf.d/virtualkbd.conf
```
```bash
echo "[General]                         
InputMethod=qtvirtualkeyboard" | sudo tee /etc/sddm.conf.d/virtualkbd.conf
```
edit the 'ConfigFile=' section to change theme
```bash
sudo -e /usr/share/sddm/themes/sddm-astronaut-theme/metadata.desktop
```
metadata.desktop
```bash
[SddmGreeterTheme]
Name=sddm-astronaut-theme
Description=sddm-astronaut-theme
Author=keyitdev
Website=https://github.com/Keyitdev/sddm-astronaut-theme
License=GPL-3.0-or-later
Type=sddm-theme
Version=1.3
ConfigFile=Themes/frogo-falling.conf
Screenshot=Previews/astronaut.png
MainScript=Main.qml
TranslationsDirectory=translations
Theme-Id=sddm-astronaut-theme
Theme-API=2.0
QtVersion=6
```

copy the mp4 file to the background folder

```bash
sudo cp ~/.dots/misc/man-with-jellyfish-in-space.mp4 /usr/share/sddm/themes/sddm-astronaut-theme/Backgrounds/
```
copy the conf file into the themes
```bash
sudo cp ~/.dots/misc/man-with-jelly.conf /usr/share/sddm/themes/sddm-astronaut-theme/Themes/
```
to Test theme use 
```bash
sddm-greeter-qt6 --test-mode --theme /usr/share/sddm/themes/sddm-astronaut-theme/
```
