if [ ! `which wget` ] ; then
  echo Please install wget and make sure that wget is on your PATH
  exit 1
fi

download_file()
{
  DOWNLOAD_SOURCE=$1
  DOWNLOAD_DESTINATION=$2
  if [ -f "$DOWNLOAD_DESTINATION" ]
  then
    echo "$DOWNLOAD_DESTINATION" found, not redownloading
  else
    echo Downloading "$DOWNLOAD_SOURCE"...
    wget --quiet "$DOWNLOAD_SOURCE" -O "$DOWNLOAD_DESTINATION"
  fi
}
