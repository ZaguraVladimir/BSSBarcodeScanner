@if NOT DEFINED ANDROID_HOME (
@echo Please set enviroment variable ANDROID_HOME. For example "c:\android\sdk"
goto :eof
)

set COMPONENT_NAME      = com_BSS_BarcodeScanner
set ADDIN_BUILD_TYPE    = release

@rem call "%ANDROID_HOME%\tools\android.bat" -v update project -n "%COMPONENT_NAME%" -t android-22 -p %~dp0

call cls
@echo ===================================== Build Java Code ========================================
call gradlew.bat clean assemble%ADDIN_BUILD_TYPE%
if not %errorlevel% == 0 exit /b %errorlevel%

@echo ==== Build C/C++ Code ====
call %ANDROID_NDK%\ndk-build.cmd

if not %errorlevel% == 0 exit /b %errorlevel%

@echo.
@echo ================================== copy libraries and files ==================================
@echo "%~dp0publish"
@echo.
if not exist "%~dp0publish" mkdir "%~dp0publish"
del /s /q "%~dp0publish\*" 1>nul

call copy /Y "%~dp0addin\build\outputs\apk\release\addin-release-unsigned.apk" "%~dp0publish\%COMPONENT_NAME%.apk" 1>nul
call copy /Y "%~dp0libs\armeabi-v7a\lib%COMPONENT_NAME%.so" "%~dp0publish\lib%COMPONENT_NAME%_ARM.so" 1>nul
call copy /Y "%~dp0manifests\*" "%~dp0publish\*" >nul 2>&1

call "c:\Program Files\7-Zip\7z.exe" a -tzip -sdel "%~dp0publish\BarcodeScanner.apk" "%~dp0publish\*.*" >nul 2>&1

call explorer "%~dp0publish"

exit