@echo off

rem SET VAR AND DIR
set profile_name=%1
set script_name=%2
if not exist results\%profile_name% (mkdir results\%profile_name%)

rem CREATE FILE PARAMS:
pushd profiles\%profile_name%
java -jar ..\..\jmeter_parser_ALL.jar scripts_params.xlsx %script_name%
popd

rem START TESTS:
start jmeter-start-test.cmd scripts\%script_name%.jmx %profile_name% ^&^& exit

