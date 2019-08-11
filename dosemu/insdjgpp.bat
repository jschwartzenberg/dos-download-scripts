@echo off

set DEFAULT_MIRROR=https://na.mirror.garr.it/mirrors/djgpp/current

set INST_DIR=%USERDRV%:\inst\djgpp
set D2DU=${DOSEMU2_DRIVE_%USERDRV%}
set INST_DIR_UNIX=%D2DU%/inst/djgpp

mkdir %USERDRV%:\inst
mkdir %INST_DIR%

unix eval wget %DEFAULT_MIRROR%/unzip32.exe -O %INST_DIR_UNIX%/unzip32.exe

unix eval wget %DEFAULT_MIRROR%/v2/djdev205.zip -O %INST_DIR_UNIX%/djdev205.zip
unix eval wget %DEFAULT_MIRROR%/v2apps/rhid15ab.zip -O %INST_DIR_UNIX%/rhid15ab.zip
unix eval wget %DEFAULT_MIRROR%/v2gnu/bnu232b.zip -O %INST_DIR_UNIX%/bnu232b.zip
unix eval wget %DEFAULT_MIRROR%/v2gnu/gcc910b.zip -O %INST_DIR_UNIX%/gcc910b.zip
unix eval wget %DEFAULT_MIRROR%/v2gnu/gdb801b.zip -O %INST_DIR_UNIX%/gdb801b.zip
unix eval wget %DEFAULT_MIRROR%/v2gnu/mak421b.zip -O %INST_DIR_UNIX%/mak421b.zip

mkdir djgpp
cd djgpp

%INST_DIR%\unzip32 %INST_DIR%\djdev205.zip
%INST_DIR%\unzip32 %INST_DIR%\rhid15ab.zip
%INST_DIR%\unzip32 %INST_DIR%\bnu232b.zip
%INST_DIR%\unzip32 -o %INST_DIR%\gcc910b.zip
%INST_DIR%\unzip32 %INST_DIR%\gdb801b.zip
%INST_DIR%\unzip32 %INST_DIR%\mak421b.zip

echo path %USERDRV%:\djgpp\bin;%%PATH%% > %USERDRV%:\envdjgpp.bat
echo set DJGPP=%USERDRV%:\djgpp\djgpp.env >> %USERDRV%:\envdjgpp.bat
echo call envdjgpp.bat >> %USERDRV%:\userhook.bat
