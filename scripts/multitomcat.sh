#!/bin/bash

ACTION=$1
TOMCAT1=/demo/apache-tomcat-9.0.0.M26
TOMCAT2=/sample/apache-tomcat-9.0.0.M26
ps -ef |grep $TOMCAT1 |grep -v grep >/dev/null
STAT1=$?
ps -ef |grep $TOMCAT2 |grep -v grep >/dev/null
STAT2=$?

case $ACTION in 
	start)
		if [ $STAT1 -eq 0 -a $STAT2 -eq 0 ]; then
			echo "Tomcat $TOMCAT1 and Tomcat $TOMCAT2 is already running"
			exit 0
		elif [ $STAT1 -eq 1 -a $STAT2 -eq 0 ]; then 
			echo "Stopping $TOMCAT2"
			$TOMCAT2/bin/shutdown.sh >/dev/null
		elif [ $STAT1 -eq 0 -a $STAT2 -eq 1 ]; then 
			echo "Starting $TOMCAT2"
			$TOMCAT2/bin/startup.sh >/dev/null
			exit 0
		fi
		echo "Starting $TOMCAT1"
		$TOMCAT1/bin/startup.sh >/dev/null
		echo "Starting $TOMCAT2"
		$TOMCAT2/bin/startup.sh >/dev/null
		;;
	stop) 
		if [ $STAT1 -eq 1 -a $STAT2 -eq 1 ]; then 
			echo "Tomcat $TOMCAT1 and Tomcat $TOMCAT2 is already stopped"
			exit 0
		elif [ $STAT1 -eq 0 -o $STAT2 -eq 0 ]; then 
			if [ $STAT2 -eq 0 ]; then 
				echo "Stopping $TOMCAT2"
				$TOMCAT2/bin/shutdown.sh  >/dev/null
			fi
			if [ $STAT1 -eq 0 ]; then 
				echo "Stoppting $TOMCAT1"
				$TOMCAT1/bin/shutdown.sh >/dev/null
			fi
			exit
		fi	
		echo "Stopping $TOMCAT2"
		$TOMCAT2/bin/shutdown.sh  >/dev/null	
		echo "Stoppting $TOMCAT1"
		$TOMCAT1/bin/shutdown.sh >/dev/null
		;;
esac







