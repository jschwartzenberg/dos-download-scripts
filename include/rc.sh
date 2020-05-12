#!/bin/sh

if [ ! `which gocr` ] ; then
  echo Please install gocr and make sure that gocr is on your PATH
  exit 1
fi

if [ ! `which convert` ] ; then
  echo Please install ImageMagick and make sure that convert is on your PATH
  exit 1
fi

if [ ! `which xdotool` ] ; then
  echo Please install xdotool and make sure that xdotool is on your PATH
  exit 1
fi

if [ ! `which xwd` ] ; then
  echo Please install xwd and make sure that xwd is on your PATH
  exit 1
fi

set_window_id()
{
  while [ -z $WINDOW_ID ]; do
    WINDOW_ID=`xdotool search --name "$$"`
  done
}

is_dosemu_active()
{
  WINDOW_ID=`xdotool search --name "$$"`
  if [ -z $WINDOW_ID ]; then
    exit 1
  fi
}

# gocr has problems when there are different sizes/fonts on one shot so there are variants with crop to work around that
wait_for_text()
{
  while true; do
    is_dosemu_active

    TEXT=`xwd -silent -id $WINDOW_ID | convert xwd:- pnm:- |gocr -i -`
    if [ "${TEXT#*$1}" != "$TEXT" ]; then
      break;
    fi
    TEXT=`xwd -silent -id $WINDOW_ID | convert -crop 800x600+100+100 xwd:- pnm:- |gocr -i -m 8 -d 0 -`
    if [ "${TEXT#*$1}" != "$TEXT" ]; then
      break;
    fi
    TEXT=`xwd -silent -id $WINDOW_ID | convert -crop 640x480+0+0 xwd:- pnm:- |gocr -i -m 8 -d 0 -`
    if [ "${TEXT#*$1}" != "$TEXT" ]; then
      break;
    fi
    TEXT=`xwd -silent -id $WINDOW_ID | convert -crop 400x300+100+100 xwd:- pnm:- |gocr -i -m 8 -d 0 -`
    if [ "${TEXT#*$1}" != "$TEXT" ]; then
      break;
    fi
    TEXT=`xwd -silent -id $WINDOW_ID | convert -crop 400x300+200+200 xwd:- pnm:- |gocr -i -m 8 -d 0 -`
    if [ "${TEXT#*$1}" != "$TEXT" ]; then
      break;
    fi
    RANDOM1=`awk -v min=400 -v max=1040 'BEGIN{srand(); print int(min+rand()*(max-min+1))}'`
    RANDOM2=`awk -v min=300 -v max=768 'BEGIN{srand(); print int(min+rand()*(max-min+1))}'`
    RANDOM3=`awk -v min=20 -v max=100 'BEGIN{srand(); print int(min+rand()*(max-min+1))}'`
    RANDOM4=`awk -v min=20 -v max=100 'BEGIN{srand(); print int(min+rand()*(max-min+1))}'`
    TEXT=`xwd -silent -id $WINDOW_ID | convert -crop "$RANDOM1"x"$RANDOM2"+"$RANDOM3"+"$RANDOM4" xwd:- pnm:- |gocr -i -`
    echo Waiting for $1, but screen shows: $TEXT
    if [ "${TEXT#*$1}" != "$TEXT" ]; then
      break;
    fi
  done
}

echo_text()
{
  echo `xwd -silent -id $WINDOW_ID | convert xwd:- pnm:- |gocr -i -`
}

press_enter()
{
  xdotool key  --window $WINDOW_ID Return
}

press()
{
  xdotool key  --window $WINDOW_ID $@
}

type()
{
  xdotool type --window $WINDOW_ID $@
}
