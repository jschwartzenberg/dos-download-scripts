@echo off
unix eval wget https://www.ibiblio.org/pub/micro/pc-stuff/freedos/files/distributions/1.2/repos/base/command.zip -O /tmp/c.zip
unix eval unzip -d ${DOSEMU2_DRIVE_%USERDRV%} -qq -LL /tmp/c.zip -x source/*
move %USERDRV%:\bin\command.com %USERDRV%:\command.com
