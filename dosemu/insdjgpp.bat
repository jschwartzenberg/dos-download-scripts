@echo off

mkdir c:\inst
mkdir c:\inst\djgpp

unix eval wget http://na.mirror.garr.it/mirrors/djgpp/current/unzip32.exe -O ${DOSEMU2_DRIVE_C}/inst/djgpp/unzip32.exe

unix eval wget http://na.mirror.garr.it/mirrors/djgpp/current/v2/djdev205.zip -O ${DOSEMU2_DRIVE_C}/inst/djgpp/djdev205.zip
unix eval wget http://na.mirror.garr.it/mirrors/djgpp/current/v2apps/rhid15ab.zip -O ${DOSEMU2_DRIVE_C}/inst/djgpp/rhid15ab.zip
unix eval wget http://na.mirror.garr.it/mirrors/djgpp/current/v2gnu/bnu232b.zip -O ${DOSEMU2_DRIVE_C}/inst/djgpp/bnu232b.zip
unix eval wget http://na.mirror.garr.it/mirrors/djgpp/current/v2gnu/gcc910b.zip -O ${DOSEMU2_DRIVE_C}/inst/djgpp/gcc910b.zip
unix eval wget http://na.mirror.garr.it/mirrors/djgpp/current/v2gnu/gdb801b.zip -O ${DOSEMU2_DRIVE_C}/inst/djgpp/gdb801b.zip
unix eval wget http://na.mirror.garr.it/mirrors/djgpp/current/v2gnu/mak421b.zip -O ${DOSEMU2_DRIVE_C}/inst/djgpp/mak421b.zip

mkdir djgpp
cd djgpp

c:\inst\djgpp\unzip32 c:\inst\djgpp\djdev205.zip
c:\inst\djgpp\unzip32 c:\inst\djgpp\rhid15ab.zip
c:\inst\djgpp\unzip32 c:\inst\djgpp\bnu232b.zip
c:\inst\djgpp\unzip32 -o c:\inst\djgpp\gcc910b.zip
c:\inst\djgpp\unzip32 c:\inst\djgpp\gdb801b.zip
c:\inst\djgpp\unzip32 c:\inst\djgpp\mak421b.zip

echo path c:\djgpp\bin;%%PATH%% > c:\envdjgpp.bat
echo set DJGPP=c:\djgpp\djgpp.env >> c:\envdjgpp.bat
echo call envdjgpp.bat >> c:\userhook.bat
