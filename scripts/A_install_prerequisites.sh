#!/bin/sh
install_gnutls_utils() {
	output=$(yes | sudo apt-get install gnutls-utils)
	echo $output
	# gnutls-utils not found
}

install_libgnutls_dev() {
	output=$(yes | sudo apt-get install libgnutls-dev)
	echo $output
	# libgnutls-dev not found
}

install_g_plus_plus() {
	output=$(yes | sudo apt-get install g++)
	echo $output
}

install_libgnutls28_dev() {
	output=$(yes |  sudo apt-get install libgnutls28-dev)
	echo $output
}

install_uuid_dev() {
	output=$(yes | sudo apt-get install uuid-dev)
	echo $output
}

install_cmake() {
	output=$(yes | sudo apt-get install cmake)
	echo $output
}

install_gnutls_bin() {
	output=$(yes | sudo apt-get install gnutls-bin)
	echo $output
}

install_build_essential() {
	output=$(yes | sudo apt-get install build-essential)
	echo $output
}

install_libqt4_dev() {
	output=$(yes | sudo apt-get install libqt4-dev)
	echo $output
	# libqt4-dev is not available 
}

install_qt4_qmake() {
	output=$(yes | sudo apt-get install qt4-qmake)
	echo $output
	# qt4-qmake is not available
}

install_qt4_dev_tools() {
	output=$(yes | sudo apt-get install qt4-dev-tools)
	echo $output
}

install_git() {
	output=$(yes | sudo apt-get install git)
	echo $output
}

install_gnutls_bin() {
	output=$(yes | sudo apt-get install gnutls-bin)
	echo $output
}

install_curl() {
	output=$(yes | sudo apt-get install curl)
	echo $output
}


