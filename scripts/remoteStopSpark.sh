#! /bin/bash


MASTERNODE=node01


getProjectDirectory () {
	PROJECT_DIR=$( cd -- "$( dirname $( dirname -- "${BASH_SOURCE[0]}" ))" &> /dev/null && pwd )
}

piSCP () {
	scp -qrp -o LogLevel=QUIET $1 pi@$MASTERNODE:$2
}

piSSH () {
	ssh pi@$MASTERNODE $@
}

copyStopScriptToCluster () {
	piSCP $PROJECT_DIR/scripts/runOnCluster/stopSpark.sh \~
}

stopSpark () {
	piSSH ./stopSpark.sh
}

main () {
	getProjectDirectory
	copyStopScriptToCluster
	stopSpark
}

main

