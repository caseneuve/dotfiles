# ~/.dotfiles/bin/i3blo-fa-replace.sh
# Created:     30.12.17, 10:57    @manjaroi3
# Last update: 30.12.17, 11:15:14 @manjaroi3

# Doc: Zamień znaki ze skryptu `battery` z font-awesome na unicode

#!/bin/bash

cd /usr/lib/i3blocks
sudo sed -i 's/⭣/↓/g' battery
sudo sed -i 's/⭡/↑/g' battery
printf "Poprawiłem skrypt /usr/lib/i3blocks:\n"
sed -n 39,45p battery
printf "\n"

