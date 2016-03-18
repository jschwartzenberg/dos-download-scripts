extract_7z()
{
  ARCHIVE="$1"
  FILENAME="$2"
  DESTINATION=$3
  echo Extracting $FILENAME
  7z e "$ARCHIVE" $FILENAME -o"$DESTINATION" -y -ssc- >/dev/null
}

extract_to_c()
{
  extract_7z "${TMP_DIR}"/"$1" "$2" ${DRIVE_C}
}

extract_to_c_bin()
{
  extract_7z "${TMP_DIR}"/"$1" "$2" ${DRIVE_C}/bin
}
