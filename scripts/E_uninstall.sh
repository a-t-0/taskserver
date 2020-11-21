#!/bin/sh

uninstall_taskwarrior() {
	output=$(yes | sudo apt-get remove taskwarrior)
	echo $output
}

uninstall_timewarrior() {
	output=$(yes | sudo apt-get remove timewarrior)
	echo $output
}


# used to create an uninstaller file for taskserver
install_checkinstall() {
	output=$(yes | sudo apt-get update)
	output=$(yes | sudo apt-get install checkinstall)
	echo $output
}

# installs/overwrites taskd taskserver installer
# and creates an uninstaller at the same time
checkinstall_taskserver() {
	TASKSERVER_TAR_NAME=$1
	output=$(cd $TASKSERVER_TAR_NAME/ && echo | sudo checkinstall  -D -y)
	echo $output
}

uninstall_taskserver() {
	TASKSERVER_TAR_NAME=$1
	# TODO: determine if the cd can be dropped
	output=$(cd $TASKSERVER_TAR_NAME/ && sudo dpkg -r taskd)
	echo $output
}

remove_dot_taskd_folder() {
	output=$(sudo rm -r ~/.task)
	echo $output
}

remove_var_taskd_folder() {
	TASKDDATA=$1
	output=$(sudo rm -r $TASKDDATA)
	echo $output
}

remove_checkinstall() {
	output=$(yes | sudo apt-get update)
	output=$(yes | apt-get remove checkinstall)
	echo $output
}
