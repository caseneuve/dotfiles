#!/bin/bash

# Path:        ~/.bin/mupdf-cache.sh
# Created:     25.04.18, 20:42    @x200
# Last update: 25.04.18, 21:47:42 @x200

# Doc: Saves current mupdf session (and backs it up @Dropbox)

cd ~/.cache
echo -e "# $(date), $HOSTNAME" > .mupdf_cache
ps aux | grep mupdf | tr -s " " | cut -d " " -f 12- >> .mupdf_cache

#sed -i "s/-c set -- //g; s/; mupdf \"$@\"//g; s/'//g" .mupdf_cache
#sed -i "s/-c set -- //g" .mupdf_cache
#sed -i "s/; mupdf \"$@\"//g" .mupdf_cache
#sed -i "s/'//g" .mupdf_cache

# delete lines containing string "mupdf"
sed -i '/mupdf/d' .mupdf_cache
cp .mupdf_cache "/home/piotr/Dropbox/config/mupdf/mupdf-session_$(date +%Y%m%d-%H%M)_$HOSTNAME"

