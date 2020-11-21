#!/bin/sh
install_taskwarrior() {
	output=$(yes | sudo apt-get install taskwarrior)
	echo $output
}

create_first_task_taskwarrior() {
	output=$(yes | task add first test task)
	echo $output
}
