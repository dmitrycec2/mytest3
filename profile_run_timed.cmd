@echo off

rem SET VAR AND DIR
set TIMEOUT=10
set ST=%~2
echo Test will run: %ST%
echo.
echo ===
echo ВНИМАНИЕ! Цикл проверки будет бесконечным в случае времени запуска меньше текущего!
echo ===
echo.
set profile_name=%1
if not exist results\%profile_name% (mkdir results\%profile_name%)

rem CREATE FILE PARAMS:
pushd profiles\%profile_name%
java -jar ..\..\jmeter_parser_ALL.jar scripts_params.xlsx UC15
popd

rem WAIT FOR RUN:
:do
 echo _______________________!
 set Y=%DATE:~6,4%
 set M=%DATE:~3,2%
 set D=%DATE:~0,2%
 set CT=%Y%-%M%-%D% %TIME:~0,5%
 echo Curr time: %Y%-%M%-%D% %TIME:~0,8% Run time: %ST%
 timeout /t %TIMEOUT% /NOBREAK
:while
 if "%CT%" GEQ "%ST%" (goto next) else (goto do)
:next

echo.
echo START TESTS!

rem START TESTS:
rem start jmeter-start-test.cmd scripts\UC15.jmx %profile_name% ^&^& exit

