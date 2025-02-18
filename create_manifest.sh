#!/bin/bash

MANIFEST_ID=0
LINK_BASE="https://github.com/zoranl/MySharedApk/raw/refs/heads/master/"


clone_pyaxmlparser(){
	echo "pyaxmlparser not found, clonning it"
	git clone https://github.com/appknox/pyaxmlparser.git
	cd pyaxmlparser
	python3 setup.py build
	python3 setup.py install
	cd ..
}

check_pyaxmlparser() {
echo check_pyaxmlparser

if [ -d pyaxmlparser ]; then
	#check if folder is from git
	git ls-remote pyaxmlparser -q
	error_code=$?
	echo $error_code
		if [ $error_code -eq 0 ]; then
			#no errors, skip clone
			return
		fi;
fi
clone_pyaxmlparser
}

create_node() {
#APK=com.zoranl.mymath-v1\(0.9b\)-debug.apk
APK_NAME=$(stat -c%n "$APK")
APK_SIZE=$(stat -c%s "$APK")
APK_DATE=$(stat -c%W "$APK")
APK_DATE_H=$(stat -c%w "$APK")
echo "Size of $APK = $APK_NAME $APK_DATE $APK_DATE_H $APK_SIZE bytes."

#python3 <<HEREDOC
#from pyaxmlparser import APK
#apk = APK('./com.zoranl.mymath-v1(0.9b)-debug.apk')
#print(apk.package)
#HEREDOC
#
#python3 <<HEREDOC
#from pyaxmlparser import APK
#apk = APK('./com.zoranl.mymath-v1(0.9b)-debug.apk')
#print(apk.application)
#HEREDOC
#
#python3 <<HEREDOC
#from pyaxmlparser import APK
#apk = APK('./com.zoranl.mymath-v1(0.9b)-debug.apk')
#print(apk.version_name)
#HEREDOC


APK_VERSION=$(python3 <<HEREDOC
import sys

from pyaxmlparser import APK
apk = APK("$APK")
print(apk.version_name)
HEREDOC
)
echo "Version of $APK = $APK_VERSION"


APK_TITLE=$(python3 <<HEREDOC
from pyaxmlparser import APK
apk = APK("$APK")
print(apk.application)
HEREDOC
)
echo "Title of $APK = $APK_TITLE"

APK_PACKAGE=$(python3 <<HEREDOC
from pyaxmlparser import APK
apk = APK("$APK")
print(apk.package)
HEREDOC
)
echo "Package of $APK = $APK_PACKAGE"

APK_VERSION_CODE=$(python3 <<HEREDOC
from pyaxmlparser import APK
apk = APK("$APK")
print(apk.version_code)
HEREDOC
)
echo "Package of $APK = $APK_VERSION_CODE"


echo "<apk>"
echo $APK_NAME   
echo $APK_DATE
echo $APK_DATE_H
APK_DATE_H_2=${APK_DATE_H%.*}
echo $APK_DATE_H_2
echo $APK_SIZE
echo $APK_TITLE
echo $APK_PACKAGE
echo $APK_VERSION_CODE
echo $APK_VERSION
echo "</apk>"


STRING="\t<apk>\n"

STRING+="\t\t<id>"
STRING+=$((MANIFEST_ID++))
STRING+="</id>\n"

STRING+="\t\t<appName>"
STRING+=$APK_NAME   
STRING+="</appName>\n"

STRING+="\t\t<appTitle>"
STRING+=$APK_TITLE
STRING+="</appTitle>\n"

STRING+="\t\t<dateCreated>"
STRING+=$APK_DATE
STRING+="</dateCreated>\n"

STRING+="\t\t<dateCreatedReadable>"
STRING+=$APK_DATE_H_2
STRING+="</dateCreatedReadable>\n"

#STRING+=$APK_DATE_H

STRING+="\t\t<fileSize>"
STRING+=$APK_SIZE
STRING+="</fileSize>\n"

STRING+="\t\t<package>"
STRING+=$APK_PACKAGE
STRING+="</package>\n"

#STRING+=$APK_VERSION_CODE

STRING+="\t\t<version>"
STRING+=$APK_VERSION
STRING+="</version>\n"

STRING+="\t\t<link>"
STRING+=$LINK_BASE$APK_NAME
STRING+="</link>\n"

STRING+="\t</apk>\n"

echo -e "created:$STRING"

#return "$STRING"
}

create_manifest() {
echo create_manifest
MANIFEST="<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\n"
MANIFEST+="<applications>\n"
for i in *.apk; do
    [ -f "$i" ] || break
    echo found:$i
	APK=$i
	create_node
	#echo "created2:$STRING"
	MANIFEST+="$STRING"
done
MANIFEST+="</applications>\n"
}

check_pyaxmlparser

create_manifest

echo -e created manifest:$MANIFEST
echo -e $MANIFEST > manifest.xml
