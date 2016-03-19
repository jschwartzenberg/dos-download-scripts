if [ ! `which wget` ] ; then
  echo Please install wget and make sure that wget is on your PATH
  exit 1
fi

download_file()
{
  SOURCE=$1
  DESTINATION=$2
  if [ -f "$DESTINATION" ]
  then
    echo "$DESTINATION" found, not redownloading
  else
    echo Downloading "$SOURCE"...
    wget --quiet "$SOURCE" -O "$DESTINATION"
  fi
}
