#!/usr/bin/env bash
# read hardcoded variables
source scripts/hardcoded_variables.txt
echo "Hi, I will uninstall the taskwarrior setup now, I will let you know when it's done.\n\n"

LINUX_GROUP=$(whoami)
LINUX_USERNAME=$(whoami)
export TASKDDATA=/home/$LINUX_USERNAME/taskd

## E Uninstall remove taskwarrior
source ./scripts/E_uninstall.sh
# run script 
FUNCTION_OUTPUT=$(uninstall_taskwarrior) 
# log output
LOG_FILENAME="Uninstall_E_1_uninstall_taskwarrior.txt"
# set log script location
source ./scripts/helper.sh 
## export content to log file
$(write_to_log  $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "E_2"
FUNCTION_OUTPUT=$(uninstall_timewarrior)
LOG_FILENAME="Uninstall_E_2_uninstall_timewarrior.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "E_3"
FUNCTION_OUTPUT=$(install_checkinstall)
LOG_FILENAME="Uninstall_E_3_install_checkinstall.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

# set different script location
source ./scripts/C_install_taskserver.sh

echo "E_4"
FUNCTION_OUTPUT=$(curl_taskd $TASKSERVER_TAR_NAME)
LOG_FILENAME="Uninstall_E_4_curl_taskd.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "E5"
FUNCTION_OUTPUT=$(unpack_curled_taskd_tar $TASKSERVER_TAR_NAME)
LOG_FILENAME="Uninstall_E_5_unpack_curled_taskd_tar.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "E6"
FUNCTION_OUTPUT=$(cmake_taskserver $TASKSERVER_TAR_NAME)
LOG_FILENAME="Uninstall_E_6_cmake_taskserver.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "\n\nE_7 (a minute of patience please, it will proceed automatically)\n"
FUNCTION_OUTPUT=$(checkinstall_taskserver $TASKSERVER_TAR_NAME)
LOG_FILENAME="Uninstall_E_7_checkinstall_taskserver.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "E_8"
FUNCTION_OUTPUT=$(uninstall_taskserver $TASKSERVER_TAR_NAME)
LOG_FILENAME="Uninstall_E_8_uninstall_taskserver.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "E_9"
FUNCTION_OUTPUT=$(remove_dot_taskd_folder)
LOG_FILENAME="Uninstall_E_9_remove_dot_taskd_folder.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "E_10"
FUNCTION_OUTPUT=$(remove_var_taskd_folder $TASKDDATA)
LOG_FILENAME="Uninstall_E_10_remove_var_taskd_folder.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "Completed de-installation of the taskwarrior setup."
