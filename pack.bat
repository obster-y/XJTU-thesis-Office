@echo off
setlocal enabledelayedexpansion

set DIRS=%cd%


:: :: Copy Themes :: ::
set SOURCE=Themes\
set DESTINATION="%APPDATA%\Microsoft\Templates\Document Themes\"
xcopy /e /y /c %SOURCE% %DESTINATION%
echo.


:: :: Pack Template and Manuals :: ::
::Use `:` as delimiter to filter directories
set DIR_FILTERS=".git:Themes:Tools:Requirements"

for /f %%i in ('dir /b %DIRS%') do (
    set FileAttr=%%~ai
    if "!FileAttr:~0,1!"=="d" if ":!DIR_FILTERS:%%i=!"==":%DIR_FILTERS%" (
        cd %%i
        for /f "tokens=1* delims=-" %%a in ("%%i") do (
            %DIRS%\Tools\zip -qrS "%DIRS%\%%a.%%b" .\*
            echo 已打包「%%a」
        )
        cd ../
    )
)
echo.


:: :: Update Caption Labels in Normal.dotm :: ::
set FILETOMODDIR=word
set FILETOMOD=%FILETOMODDIR%\settings.xml

::labels should be seperated by `#'
set LABELTOADD="w:caption w:name=\"图\" w:pos=\"below\" w:chapNum=\"1\" w:numFmt=\"decimal\" w:sep=\"period\"#w:caption w:name=\"表\" w:pos=\"below\" w:chapNum=\"1\" w:numFmt=\"decimal\" w:sep=\"period\""

:: Backup Normal.dotm ::
copy /y "%APPDATA%\Microsoft\Templates\Normal.dotm" "%APPDATA%\Microsoft\Templates\Normal.dotm.XJTU.bak"

:: Release settings.xml ::
unzip -o -q "%APPDATA%\Microsoft\Templates\Normal.dotm" %FILETOMOD%

:: Update caption labels ::
set NOCAPS=
for /f "tokens=*" %%i in ('%DIRS%\Tools\xml sel -t -c "//w:captions" %FILETOMOD%') do set NOCAPS="1"
if NOT defined NOCAPS (
    %DIRS%\Tools\xml ed -L -s //w:settings -t elem -n "w:captions" %FILETOMOD%
)

:ADDLABEL
for /f "delims=#, tokens=1*" %%i in (%LABELTOADD%) do (
    set NOCAP=
    set ww=%%i
    for /f "tokens=*" %%i in ('%DIRS%\Tools\xml sel -t -c "//w:caption[@w:name='!ww:~19,1!']" %FILETOMOD%') do set NOCAP="1"
    if NOT defined NOCAP (
        %DIRS%\Tools\xml ed -L -s //w:captions -t elem -n "%%i" %FILETOMOD%
        echo 已添加标签「!ww:~19,1!」
    )
    set LABELTOADD="%%j"
    goto ADDLABEL
)
%DIRS%\Tools\zip -qu "%APPDATA%\Microsoft\Templates\Normal.dotm" %FILETOMOD%

echo 已写入交叉引用标签
echo.

:: Minify xml ::
::for /F usebackq^ delims^=^ eol^= %%L in ("%DIRS%\%FILETOMOD%") do ( < nul set /P ="%%L" )

:: Clear workspace ::
del %FILETOMOD%
rd %FILETOMODDIR%


:: :: DONE :: ::
echo 打包完毕，请认真阅读「使用说明」与模板中的所有批注
pause