@echo off
if "%USERDRV%"=="" set USERDRV=C
echo Installing fdnpkg
unix wget https://www.ibiblio.org/pub/micro/pc-stuff/freedos/files/util/system/fdnpkg/fdnpkg.zip -O /tmp/fdnpkg.zip
unix eval unzip -d ${DOSEMU2_DRIVE_%USERDRV%} -qq -LL /tmp/fdnpkg.zip -x source/*
echo set DOSDIR=c: >> %USERDRV%:\autoexec.bat
