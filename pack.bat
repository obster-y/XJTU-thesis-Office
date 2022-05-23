@echo off
setlocal enabledelayedexpansion

:: :: Copy Themes :: ::
set SOURCE=Themes\
set DESTINATION="%APPDATA%\Microsoft\Templates\Document Themes\"
xcopy /e /y /c %SOURCE% %DESTINATION%
echo.

:: :: Pack Files :: ::
::Use `:` as delimiter to filter directories
set DIR_FILTERS=".git:Themes:Tools:Requirements"
set DIRS=%cd%

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


:: :: Update Caption Labels :: ::
set FILETOMODDIR=word
set FILETOMOD=%FILETOMODDIR%\settings.xml
set LABELTOADD="w:caption w:name=\"图\" w:pos=\"below\" w:chapNum=\"1\" w:numFmt=\"decimal\" w:sep=\"period\"#w:caption w:name=\"表\" w:pos=\"below\" w:chapNum=\"1\" w:numFmt=\"decimal\" w:sep=\"period\""

:: Release settings.xml ::
unzip -o -q "%APPDATA%\Microsoft\Templates\Normal.dotm" %FILETOMOD%

:: Update caption labels ::
set NOCAP=

for /f "tokens=*" %%a in ('%DIRS%\Tools\xml sel -t -c "//w:caption[@w:name='图']" "%FILETOMOD%"') do set NOCAP="1"

if NOT defined NOCAP (
    :ADDLABEL
    for /f "delims=#, tokens=1*" %%i in (%LABELTOADD%) do (
        %cd%\Tools\xml ed -L -s //w:captions -t elem -n "%%i" %FILETOMOD%
        set LABELTOADD="%%j"
        goto ADDLABEL
    )

    zip -qu "%APPDATA%\Microsoft\Templates\Normal.dotm" %FILETOMOD%

    echo 已写入交叉引用标签
    echo.
)

:: Minify xml ::
::for /F usebackq^ delims^=^ eol^= %%L in ("%DIRS%\%FILETOMOD%") do ( < nul set /P ="%%L" )

:: Clear workspace ::
del %FILETOMOD%
rd %FILETOMODDIR%


:: :: DONE :: ::
echo 安装完毕，请认真阅读「使用说明」与模板中的所有批注
pause