#!/bin/bash

# Path:        ~/.bin/mupdf-cache.sh
# Created:     25.04.18, 20:42    @x200
# Last update: 02.08.18, 16:27:59 @x200

# Doc: Saves current mupdf session (and backs it up @Dropbox)

TEMPFILE='/tmp/mupdf_cache'
CACHEDIR='/home/piotr/.cache/mupdf-cache'
CACHEFILE=$CACHEDIR/cached_$(date +%Y%m%d-%H%M)

[[ -d $CACHEDIR ]] || mkdir $CACHEDIR

echo -e "# $(date), $HOSTNAME" > $TEMPFILE
ps aux | grep mupdf | tr -s " " | cut -d " " -f 12- >> $TEMPFILE

#sed -i "s/-c set -- //g; s/; mupdf \"$@\"//g; s/'//g" .mupdf_cache
#sed -i "s/-c set -- //g" .mupdf_cache
#sed -i "s/; mupdf \"$@\"//g" .mupdf_cache
#sed -i "s/'//g" .mupdf_cache

# delete lines containing string "mupdf"
sed -i '/mupdf/d' $TEMPFILE

cp $TEMPFILE $CACHEFILE

if [[ -f $CACHEFILE ]]; then
    echo "Succesfully cached mupdf session in file: $CACHEFILE "
else
    echo "Error" && exit 1
fi

