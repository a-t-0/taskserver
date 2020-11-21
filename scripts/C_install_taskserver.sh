#!/bin/sh
curl_taskd() {
	TASKSERVER_TAR_NAME=$1
	output=$(curl -O https://taskwarrior.org/download/$TASKSERVER_TAR_NAME.tar.gz)
	echo $output
	# TODO: switch from stable release 1.1.0 to latest release 1.2.0
}

unpack_curled_taskd_tar() {
	TASKSERVER_TAR_NAME=$1
	output=$(tar -xzf $TASKSERVER_TAR_NAME.tar.gz)
	echo $output
}

cd_into_unpacked_taskd_tar() {
	TASKSERVER_TAR_NAME=$1
	output=$(cd $TASKSERVER_TAR_NAME)
	echo $output
}

cmake_taskserver() {
	TASKSERVER_TAR_NAME=$1
	output=$(cd $TASKSERVER_TAR_NAME/ && cmake -DCMAKE_BUILD_TYPE=release .)
	echo $output
}

make_taskserver() {
	TASKSERVER_TAR_NAME=$1
	output=$(cd $TASKSERVER_TAR_NAME/ && make)
	echo $output
}

clean_make() {
	TASKSERVER_TAR_NAME=$1
	output=$(cd $TASKSERVER_TAR_NAME/ && make clean)
	echo $output
}

remove_make_cmake_cache() {
	TASKSERVER_TAR_NAME=$1
	output=$(cd $TASKSERVER_TAR_NAME/ && rm CMakeCache.txt)
	echo $output
}

install_taskserver_make() {
	TASKSERVER_TAR_NAME=$1
	output=$(cd $TASKSERVER_TAR_NAME/ && sudo make install)
	echo $output
}

run_taskserver_command() {
	output=$(taskd)
	echo $output
	# TODO: test output
}

run_taskserver_tests() {
	TASKSERVER_TAR_NAME=$1
	output=$(/$TASKSERVER_TAR_NAME/./run_all)
	echo $output
	# TODO: verify test results
}
