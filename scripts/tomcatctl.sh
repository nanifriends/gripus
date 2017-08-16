#!/bin/bash

### Script to start and stop the tomcat

ACTION=$1
TOMCATDIR=/demo/apache-tomcat-9.0.0.M26

case $ACTION in 
	start)  ps -ef |grep $TOMCATDIR | grep -v grep >/dev/null
		if [ $? -eq 0 ]; then 
			echo "Tomcat is laready started"
			exit 0
		fi
		echo "Starting Tomcat" 
		$TOMCATDIR/bin/startup.sh ;;
	stop)   ps -ef |grep $TOMCATDIR | grep -v grep >/dev/null
                if [ $? -ne 0 ]; then
                        echo "Tomcat is already stopped"
                        exit 0
                fi
		echo "Stopting Tomcat"
		$TOMCATDIR/bin/shutdown.sh ;;
	restart)
		echo "Restarting Tomcat" 
		ps -ef |grep $TOMCATDIR | grep -v grep >/dev/null
		if [ $? -eq 0 ]; then 
			echo "Stopting Tomcat"
                	$TOMCATDIR/bin/shutdown.sh
		fi
		echo "Starting Tomcat" 
                $TOMCATDIR/bin/startup.sh
		;;
	*) echo "Usage: $0 {start|stop|restart}"
	   exit 1 ;;
esac
