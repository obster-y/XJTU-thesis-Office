@echo off
setlocal enabledelayedexpansion

:: :: Copy Themes :: ::
set SOURCE=Themes\
set DESTINATION="%APPDATA%\Microsoft\Templates\Document Themes\"
xcopy %SOURCE% %DESTINATION% /E /Y

:: :: Pack Documents :: ::
::Use `:` as delimiter to filter directories
set DIR_FILTERS=".git:Themes:Tools:Requirements"
set DIRS=%cd%

for /f %%i in ('dir /b %DIRS%') do (
    set FileAttr=%%~ai
    if "!FileAttr:~0,1!"=="d" if ":!DIR_FILTERS:%%i=!"==":%DIR_FILTERS%" (
        cd %%i
        for /f "tokens=1* delims=-" %%a in ("%%i") do (
            %DIRS%\Tools\zip -qrS "%DIRS%\%%a.%%b" .\*
        )
        cd ../
    )
)

echo 打包完毕，请认真阅读「使用说明」与模板中的所有批注

pause