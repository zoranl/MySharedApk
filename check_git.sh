#!/bin/bash


clone_pyaxmlparser(){
	echo "pyaxmlparser not found, clonning it"
	git clone https://github.com/appknox/pyaxmlparser.git
	cd pyaxmlparser
	python3 setup.py build
	python3 setup.py install
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

check_pyaxmlparser