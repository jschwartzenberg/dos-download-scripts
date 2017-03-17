if [ ! `which 7z` ] ; then
  echo Please install 7zip and make sure that 7z is on your PATH
  exit 1
fi

extract_7z()
{
  EXTRACT_ARCHIVE="$1"
  EXTRACT_FILENAME="$2"
  EXTRACT_DESTINATION=$3
  echo Extracting $EXTRACT_FILENAME
  7z e "$EXTRACT_ARCHIVE" $EXTRACT_FILENAME -o"$EXTRACT_DESTINATION" -y -ssc- >/dev/null
}

extract_to_c()
{
  extract_7z "${TMP_DIR}"/"$1" "$2" ${DRIVE_C}
}

extract_to_c_bin()
{
  extract_7z "${TMP_DIR}"/"$1" "$2" ${DRIVE_C}/bin
}
