#! /bin/bash

# cd to current path
dirname=`dirname $0`
tmp="${dirname#?}"
if [ "${dirname%$tmp}" != "/" ]; then
	dirname=$PWD/$dirname
fi
echo $dirname
cd "$dirname"

# close driver if it running
AppName=pentablet
AppDir=pentablet
pid=`ps -e|grep $AppName`
appScript=$AppName".sh"
if [ -n "$pid" ]; then
	echo $pid
	arr=()
	while read -r line; do
	   arr+=("$line")
	done <<< "$pid"
	for val in "${arr[@]}";
	do
		appid=`echo $val | awk '{print $1}'`
	   	name=`echo $val | awk '{print $4}'`
	   	echo "ID:"$appid 
		echo "Name:"$name
		if [ "$name" = "$appRunScript" ]; then
			echo "close $appRunScript"
			kill -15 $appid
		elif [ "$name" = "$AppName" ]; then
			echo "close $AppName"
			kill -15 $appid
		fi
	done
fi

#Copy rule
sysRuleDir="/lib/udev/rules.d"
appRuleDir=./App$sysRuleDir
ruleName="10-xp-pen.rules"

#echo "$appRuleDir/$ruleName"
#echo "$sysRuleDir/$ruleName"

if [ -f $appRuleDir/$ruleName ]; then
	str=`cp $appRuleDir/$ruleName $sysRuleDir/$ruleName`
	if [ "$str" !=  "" ]; then 
		echo "$str";
	fi
else
	echo "Cannot find driver's rules in package"
	exit
fi

#install app
sysAppDir="/usr/lib"
appAppDir=./App$sysAppDir/$AppName
exeShell="pentablet.sh"

#echo $sysAppDir
#echo $appAppDir

if [ -d "$appAppDir" ]; then
	str=`cp -rf $appAppDir $sysAppDir`
	if [ "$str" !=  "" ]; then 
		echo "$str";
	fi
else
	echo "Cannot find driver's files in package"
	exit
fi

#echo "shell path "$sysAppDir/$AppDir/$exeShell
if [ -f $sysAppDir/$AppDir/$exeShell ]; then
	str=`chmod +0755 $sysAppDir/$AppName/$exeShell`
	if [ "$str" !=  "" ]; then 
		echo "Cannot add permission to start script"
		echo "$str";
	fi
else
	echo "can not find start script"
	exit
fi

#echo "exe path "$sysAppDir/$AppDir/$AppName
if [ -f $sysAppDir/$AppDir/$AppName ]; then
	str=`chmod +0555 $sysAppDir/$AppDir/$AppName`
	if [ "$str" !=  "" ]; then 
		echo "Cannot add permission to app"
		echo "$str";
	fi
else
	echo "can not find app"
	exit
fi

# install shortcut
sysDesktopDir=/usr/share/applications
sysAppIconDir=/usr/share/icons
sysAutoStartDir=/etc/xdg/autostart

appDesktopDir=./App$sysDesktopDir
appAppIconDir=./App$sysAppIconDir
appAutoStartDir=./App$sysAutoStartDir

appDesktopName=xp$AppName.desktop
appIconName=$AppName.png


#echo $appDesktopDir/$appDesktopName
#echo $sysDesktopDir/$appDesktopName
#echo $appAppIconDir/$appIconName
#echo $sysAppIconDir/$appIconName

if [ -f $appDesktopDir/$appDesktopName ]; then
	str=`cp $appDesktopDir/$appDesktopName $sysDesktopDir/$appDesktopName`
	if [ "$str" !=  "" ]; then 
		echo "$str";
	fi
else
	echo "Cannot find driver's shortcut in package"
	exit
fi

if [ -f $appAppIconDir/$appIconName ]; then
	str=`cp $appAppIconDir/$appIconName $sysAppIconDir/$appIconName`
	if [ "$str" !=  "" ]; then 
		echo "$str";
	fi
else
	echo "Cannot find driver's icon in package"
	exit
fi

if [ -f $appAutoStartDir/$appDesktopName ]; then
	str=`cp $appAutoStartDir/$appDesktopName $sysAutoStartDir/$appDesktopName`
	if [ "$str" !=  "" ]; then 
		echo "$str";
	fi
else
	echo "Cannot find set auto start"
fi

#Copy config files
chmod +x /usr/lib/pentablet/pentablet
chmod +x /usr/lib/pentablet/pentablet.sh
confPath="/usr/lib/pentablet/conf/xppen"

chmod +0777 $confPath

if [ -f $confPath/config.xml ]; then
	chmod +0666 $confPath/config.xml
fi

if [ -f $confPath/language.ini ]; then
	chmod +0666 $confPath/language.ini
fi

if [ -f $confPath/name_config.ini ]; then
	chmod +0666 $confPath/name_config.ini
fi

if [ -f "/etc/xdg/autostart/pentablet.desktop" ]; then
	rm /etc/xdg/autostart/ugee-pentablet.desktop
fi

echo "Installation successful!"
echo "If you are installing for the first time, please use it after restart."
