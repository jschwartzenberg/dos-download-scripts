@echo off

set DEFAULT_MIRROR=https://www.ibiblio.org/pub/micro/pc-stuff/freedos/files
set BASE_URL=%DEFAULT_MIRROR%/distributions/1.2/repos/base

set INST_DIR=%USERDRV%:\inst\fd12
set D2DU=${DOSEMU2_DRIVE_%USERDRV%}
set INST_DIR_UNIX=%D2DU%/inst/fd12

mkdir %USERDRV%:\inst
mkdir %INST_DIR%

unix eval wget %BASE_URL%/kernel.zip -O %INST_DIR_UNIX%/kernel.zip
unix eval wget %BASE_URL%/command.zip -O %INST_DIR_UNIX%/command.zip
unix eval wget %BASE_URL%/assign.zip -O %INST_DIR_UNIX%/assign.zip
unix eval wget %BASE_URL%/attrib.zip -O %INST_DIR_UNIX%/attrib.zip
unix eval wget %BASE_URL%/choice.zip -O %INST_DIR_UNIX%/choice.zip
unix eval wget %BASE_URL%/comp.zip -O %INST_DIR_UNIX%/comp.zip
unix eval wget %BASE_URL%/debug.zip -O %INST_DIR_UNIX%/debug.zip
unix eval wget %BASE_URL%/defrag.zip -O %INST_DIR_UNIX%/defrag.zip
unix eval wget %BASE_URL%/deltree.zip -O %INST_DIR_UNIX%/deltree.zip
unix eval wget %BASE_URL%/diskcomp.zip -O %INST_DIR_UNIX%/diskcomp.zip
unix eval wget %BASE_URL%/diskcopy.zip -O %INST_DIR_UNIX%/diskcopy.zip
unix eval wget %BASE_URL%/display.zip -O %INST_DIR_UNIX%/display.zip
unix eval wget %BASE_URL%/edit.zip -O %INST_DIR_UNIX%/edit.zip
unix eval wget %BASE_URL%/edlin.zip -O %INST_DIR_UNIX%/edlin.zip
unix eval wget %BASE_URL%/exe2bin.zip -O %INST_DIR_UNIX%/exe2bin.zip
unix eval wget %BASE_URL%/fc.zip -O %INST_DIR_UNIX%/fc.zip
unix eval wget %BASE_URL%/find.zip -O %INST_DIR_UNIX%/find.zip
unix eval wget %BASE_URL%/format.zip -O %INST_DIR_UNIX%/format.zip
unix eval wget %BASE_URL%/help.zip -O %INST_DIR_UNIX%/help.zip
unix eval wget %BASE_URL%/label.zip -O %INST_DIR_UNIX%/label.zip
unix eval wget %BASE_URL%/mem.zip -O %INST_DIR_UNIX%/mem.zip
unix eval wget %BASE_URL%/mode.zip -O %INST_DIR_UNIX%/mode.zip
unix eval wget %BASE_URL%/more.zip -O %INST_DIR_UNIX%/more.zip
unix eval wget %BASE_URL%/move.zip -O %INST_DIR_UNIX%/move.zip
unix eval wget %BASE_URL%/nansi.zip -O %INST_DIR_UNIX%/nansi.zip
unix eval wget %BASE_URL%/replace.zip -O %INST_DIR_UNIX%/replace.zip
unix eval wget %BASE_URL%/share.zip -O %INST_DIR_UNIX%/share.zip
unix eval wget %BASE_URL%/shsucdx.zip -O %INST_DIR_UNIX%/shsucdx.zip
unix eval wget %BASE_URL%/sort.zip -O %INST_DIR_UNIX%/sort.zip
unix eval wget %BASE_URL%/swsubst.zip -O %INST_DIR_UNIX%/swsubst.zip
unix eval wget %BASE_URL%/tree.zip -O %INST_DIR_UNIX%/tree.zip
unix eval wget %BASE_URL%/xcopy.zip -O %INST_DIR_UNIX%/xcopy.zip

unix eval wget %DEFAULT_MIRROR%/devel/basic/bwbasic/bwb220ax.zip -O %INST_DIR_UNIX%/bwb220ax.zip
unix eval wget %DEFAULT_MIRROR%/devel/tools/lib-sk32.zip -O %INST_DIR_UNIX%/lib-sk32.zip
unix eval wget %DEFAULT_MIRROR%/util/unix/touch/1.44/touch144.zip -O %INST_DIR_UNIX%/touch144.zip
unix eval wget %DEFAULT_MIRROR%/util/user/wcd/wcd602b.zip -O %INST_DIR_UNIX%/wcd602b.zip

unix eval wget %DEFAULT_MIRROR%/distributions/1.2/repos/archiver/unzip.zip -O %INST_DIR_UNIX%/unzip.zip

rem Bootstrap file extraction
unix eval unzip -d %D2DU%/ -qq -LL %INST_DIR_UNIX%/unzip.zip -x source/*

bin\unzip -qq -LL %INST_DIR%\move.zip -x source/*
bin\unzip -qq -LL %INST_DIR%\kernel.zip -x source/* bin/kernl86.sys
bin\move %USERDRV%:\bin\kernl386.sys %USERDRV%:\kernel.sys
bin\unzip -qq -LL -o %INST_DIR%\command.zip -x source/*
bin\move /Y %USERDRV%:\bin\command.com %USERDRV%:\command.com
bin\unzip -qq -LL %INST_DIR%\assign.zip -x source/*
bin\unzip -qq -LL %INST_DIR%\attrib.zip -x source/*
bin\unzip -qq -LL %INST_DIR%\choice.zip -x source/*
bin\unzip -qq -LL %INST_DIR%\comp.zip -x source/*
bin\unzip -qq -LL %INST_DIR%\debug.zip -x source/*
bin\unzip -qq -LL %INST_DIR%\defrag.zip -x source/*
bin\unzip -qq -LL %INST_DIR%\deltree.zip -x source/*
bin\unzip -qq -LL %INST_DIR%\diskcomp.zip -x source/*
bin\unzip -qq -LL %INST_DIR%\diskcopy.zip -x source/*
bin\unzip -qq -LL %INST_DIR%\display.zip -x source/*
bin\unzip -qq -LL %INST_DIR%\edit.zip -x source/*
bin\unzip -qq -LL %INST_DIR%\edlin.zip -x source/*
bin\unzip -qq -LL %INST_DIR%\exe2bin.zip -x source/*
bin\unzip -qq -LL %INST_DIR%\fc.zip -x source/*
bin\unzip -qq -LL %INST_DIR%\find.zip -x source/*
bin\unzip -qq -LL %INST_DIR%\format.zip -x source/*
bin\unzip -qq -LL %INST_DIR%\help.zip -x source/*
bin\unzip -qq -LL %INST_DIR%\label.zip -x source/*
bin\unzip -qq -LL %INST_DIR%\mem.zip -x source/*
bin\unzip -qq -LL %INST_DIR%\mode.zip -x source/*
bin\unzip -qq -LL %INST_DIR%\more.zip -x source/*
bin\unzip -qq -LL %INST_DIR%\nansi.zip -x source/*
bin\unzip -qq -LL %INST_DIR%\replace.zip -x source/*
bin\unzip -qq -LL %INST_DIR%\share.zip -x source/*
bin\unzip -qq -LL %INST_DIR%\sort.zip -x source/*
bin\unzip -qq -LL %INST_DIR%\swsubst.zip -x source/*
copy %USERDRV%:\bin\swsubst.exe %USERDRV%:\bin\join.exe
copy %USERDRV%:\bin\swsubst.exe %USERDRV%:\bin\subst.exe
bin\unzip -qq -LL %INST_DIR%\tree.zip -x source/*
bin\unzip -qq -LL %INST_DIR%\xcopy.zip -x source/*

bin\unzip -qq -LL %INST_DIR%\bwb220ax.zip -x source/*
bin\unzip -qq -LL %INST_DIR%\touch144.zip -x source/*
bin\unzip -qq -LL %INST_DIR%\wcd602b.zip -x source/*

bin\unzip -d %USERDRV%:\bin -qq -LL -j %INST_DIR%\lib-sk32.zip llib32/lib.exe
bin\unzip -d %USERDRV%:\doc\lib -qq -LL -j %INST_DIR%\lib-sk32.zip llib32/readme

copy d:\fdconfig.sys %USERDRV%:\
copy d:\autoexec.bat %USERDRV%:\
