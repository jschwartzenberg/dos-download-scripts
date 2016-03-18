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

