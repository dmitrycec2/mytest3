#!/bin/bash

mk_params() {
	cd profiles/${profile_name}
	java -jar ../../jmeter_parser_ALL.jar scripts_params.xlsx $1  
	cd ${C_DIR}
	}
 
# SET VAR AND DIR
profile_name=${1}
mkdir -p results/${profile_name}
C_DIR=$PWD

START_TIME_HUMAN=$(TZ=GMT-3 date '+%Y-%m-%d %H:%M' --date="$1")
START_TIME=$(TZ=GMT-3 date --date="$1" +%s)
echo "Test will run $START_TIME_HUMAN"
CUR_TIME_HUMAN=$(TZ=GMT-3 date '+%Y-%m-%d %H:%M')
CUR_TIME=$(TZ=GMT-3 date +%s)
echo "Curr time $CUR_TIME_HUMAN"

# CREATE FILE PARAMS:
mk_params "UC15"

while [ "$CUR_TIME" -lt "$START_TIME" ]; do
    sleep 10
    CUR_TIME=$(TZ=GMT-3 date +%s)
done

# START TEST:
echo "Start Test"
CUR_TIME_HUMAN=$(TZ=GMT-3 date '+%Y-%m-%d %H:%M')
echo "START TEST $CUR_TIME_HUMAN"
sh ./jmeter-start-test.sh "UC15" ${profile_name}