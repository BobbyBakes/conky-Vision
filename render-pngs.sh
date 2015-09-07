#! /bin/bash

INKSCAPE="/usr/bin/inkscape"

#--------------------------------------------------

echo "Enter icon size (this is the width and height): "
read SIZE
echo "Enter icon-color: "
read ICON_COLOR

#--------------------------------------------------

SOURCE="SVG/*.svg"
ICONS_DIR=$ICON_COLOR
DEFAULT_COLOR="#000000"

if [ -z "$ICON_COLOR" ]; then
    ICON_COLOR=$DEFAULT_COLOR
    ICONS_DIR=$DEFAULT_COLOR
fi

#--------------------------------------------------

if [ ! -d $ICONS_DIR ]; then
    mkdir $ICONS_DIR
fi

#--------------------------------------------------

trap "sed -i 's/<path fill=\"$ICON_COLOR\"/<path/' $SOURCE; exit" EXIT

sed -i "s/<path/<path fill=\"$ICON_COLOR\"/" $SOURCE

for i in SVG/*.svg
do

i2=${i##*/}  i2=${i2%.*}

if [ -f $ICONS_DIR/$i2.png ]; then
        echo $ICONS_DIR/$i2.png exists.
else
    echo
    echo Rendering $ICONS_DIR/$i2.png
    $INKSCAPE --export-width=$SIZE \
              --export-height=$SIZE \
              --export-png=$ICONS_DIR/$i2.png $i >/dev/null
fi
done
exit 0
