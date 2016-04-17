. ./include/diskimage_download+extract.sh

download_and_extract_pcdos()
{
  INST_DIR=$TMP_DIR/inst

  mkdir -p $INST_DIR
  download_and_extract "$IMGURL" "$IMGCNT" $INST_DIR

  mkdir -p "$1"
  cp $INST_DIR/IBMBIO.COM "$1"
  cp $INST_DIR/IBMDOS.COM "$1"
  cp $INST_DIR/COMMAND.COM "$1"
}
