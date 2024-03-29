@echo off
rem Copyright (C) 2012 The Android Open Source Project
rem
rem Licensed under the Apache License, Version 2.0 (the "License");
rem you may not use this file except in compliance with the License.
rem You may obtain a copy of the License at
rem
rem      http://www.apache.org/licenses/LICENSE-2.0
rem
rem Unless required by applicable law or agreed to in writing, software
rem distributed under the License is distributed on an "AS IS" BASIS,
rem WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
rem See the License for the specific language governing permissions and
rem limitations under the License.

rem don't modify the caller's environment
setlocal
fltmc>nul
if "%errorlevel%" NEQ "0" (goto UACPrompt) else (goto UACAdmin)
:UACPrompt
%1 start "" mshta vbscript:createobject("shell.application").shellexecute("""%~0""","::",,"runas",1)(window.close)&exit
exit /B
:UACAdmin
set JAVA_HOME="%~dp0jre1.8.0_202"
set JRE8_PATH="%~dp0jre1.8.0_202\bin"

set PATH=%PATH%;%JRE8_PATH%

rem Change current directory and drive to where the script is, to avoid
rem issues with directories containing whitespaces.
cd /d %~dp0

for /f "delims=" %%a in ('bin\archquery') do set vmarch=%%a

start lib\monitor-%vmarch%\monitor
