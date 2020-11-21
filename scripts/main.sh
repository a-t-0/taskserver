#!/usr/bin/env bash
echo "Hello world"

# read hardcoded variables
source src/hardcoded_variables.txt

# get installation dependent parameters
LINUX_USERNAME=$(whoami)
LINUX_GROUP=$(whoami)
echo $LINUX_USERNAME
export TASKDDATA=/home/$LINUX_USERNAME/taskd
IP=$(hostname -f)
#IP=0.0.0.0
#IP=127.0.0.1
#IP=localhost
#IP=127.0.1.1
echo $IP

# remove logs of previous installation if existant
source ./src/helper.sh
mkdir -p src/logs
$(remove_logs) 


## Step A: install prerequisites
# set script location
source ./src/A_install_prerequisites.sh
# run script 
FUNCTION_OUTPUT=$(install_gnutls_utils) 
# log output
LOG_FILENAME="A_0_install_gnutls_utils.txt"
# set log script location
source ./src/helper.sh
# export content to log file
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "A_1"
FUNCTION_OUTPUT=$(install_libgnutls_dev)
LOG_FILENAME="A_1_install_libgnutls_dev.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "A_2"
FUNCTION_OUTPUT=$(install_g_plus_plus)
LOG_FILENAME="A_2_install_g_plus_plus.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "A_3"
FUNCTION_OUTPUT=$(install_libgnutls28_dev)
LOG_FILENAME="A_3_install_libgnutls28_dev.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "A_4"
FUNCTION_OUTPUT=$(install_uuid_dev)
LOG_FILENAME="A_4_install_uuid_dev.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "A_5"
FUNCTION_OUTPUT=$(install_cmake)
LOG_FILENAME="A_5_install_cmake.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "A_6"
FUNCTION_OUTPUT=$(install_gnutls_bin)
LOG_FILENAME="A_6_install_gnutls_bin.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "A_7"
FUNCTION_OUTPUT=$(install_build_essential)
LOG_FILENAME="A_7_install_build_essential.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "A_8"
FUNCTION_OUTPUT=$(install_libqt4_dev)
LOG_FILENAME="A_8_install_libqt4_dev.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "A_9"
FUNCTION_OUTPUT=$(install_qt4_qmake)
LOG_FILENAME="A_9_install_qt4_qmake.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "A_10"
FUNCTION_OUTPUT=$(install_qt4_dev_tools)
LOG_FILENAME="A_10_install_qt4_dev_tools.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "A_11"
FUNCTION_OUTPUT=$(install_git)
LOG_FILENAME="A_11_install_git.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "A_12"
FUNCTION_OUTPUT=$(install_gnutls_bin)
LOG_FILENAME="A_12_install_gnutls_bin.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "A_13"
FUNCTION_OUTPUT=$(install_curl)
LOG_FILENAME="A_13_install_curl.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)


## Step B. install taskwarrior
# set script location
source ./src/B_install_taskwarrior.sh
# run script 
FUNCTION_OUTPUT=$(install_taskwarrior) 
# log output
LOG_FILENAME="B_0_install_taskwarrior.txt"
# set log script location
source ./src/helper.sh 
# export content to log file
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

FUNCTION_OUTPUT=$(create_first_task_taskwarrior)
LOG_FILENAME="B_1_create_first_task_taskwarrior.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)


## Step C. Install taskserver
# set script location
source ./src/C_install_taskserver.sh
# run script 
FUNCTION_OUTPUT=$(curl_taskd $TASKSERVER_TAR_NAME)
# log output
LOG_FILENAME="C_0_curl_taskd.txt"
# set log script location
source ./src/helper.sh 
# export content to log file
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "C_1"
FUNCTION_OUTPUT=$(unpack_curled_taskd_tar $TASKSERVER_TAR_NAME)
LOG_FILENAME="C_1_unpack_curled_taskd_tar.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "C_2"
# TODO: drop this command, the cd is reset in the next function that is called
FUNCTION_OUTPUT=$(cd_into_unpacked_taskd_tar $TASKSERVER_TAR_NAME)
LOG_FILENAME="C_2_cd_into_unpacked_taskd_tar.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "C_3"
FUNCTION_OUTPUT=$(cmake_taskserver $TASKSERVER_TAR_NAME)
LOG_FILENAME="C_3_cmake_taskserver.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "C_4"
FUNCTION_OUTPUT=$(make_taskserver $TASKSERVER_TAR_NAME)
LOG_FILENAME="C_4_make_taskserver.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "C_5"
FUNCTION_OUTPUT=$(clean_make $TASKSERVER_TAR_NAME)
LOG_FILENAME="C_5_clean_make.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "C_6"
FUNCTION_OUTPUT=$(remove_make_cmake_cache $TASKSERVER_TAR_NAME)
LOG_FILENAME="C_6_remove_make_cmake_cache.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "C_7"
FUNCTION_OUTPUT=$(install_taskserver_make $TASKSERVER_TAR_NAME)
LOG_FILENAME="C_7_install_taskserver_make.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "C_8"
FUNCTION_OUTPUT=$(run_taskserver_command)
LOG_FILENAME="C_8_run_taskserver_command.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "C_9"
FUNCTION_OUTPUT=$(run_taskserver_tests $TASKSERVER_TAR_NAME)
LOG_FILENAME="C_9_run_taskserver_tests.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

## Step D. Configure taskserver
# set script location
source ./src/D_configure_taskserver.sh
echo "D_0"
# run script
FUNCTION_OUTPUT=$(mkdir_taskddata $TASKDDATA)
# log output
LOG_FILENAME="D_0_mkdir_taskddata.txt"
# set log script location
source ./src/helper.sh
# export content to log file
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "D_0_b"
FUNCTION_OUTPUT=$(mkdir_taskddata_pki $TASKDDATA)
LOG_FILENAME="D_0_b_mkdir_taskddata_pki.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "D_1"
FUNCTION_OUTPUT=$(initialise_taskserver $TASKDDATA)
LOG_FILENAME="D_1_initialise_taskserver.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "D_2"
FUNCTION_OUTPUT=$(make_pki_dir_in_taskddata $TASKDDATA)
LOG_FILENAME="D_2_make_pki_dir_in_taskddata.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "D_3"
FUNCTION_OUTPUT=$(set_local_host_in_vars_file_of_sourcedir $IP $PORT $TASKSERVER_TAR_NAME)
LOG_FILENAME="D_3_set_local_host_in_vars_file_of_sourcedir.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "D_4"
FUNCTION_OUTPUT=$(copy_pki_content_to_taskddata_dir $TASKDDATA $TASKSERVER_TAR_NAME)
LOG_FILENAME="D_4_copy_pki_content_to_taskddata_dir.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)



echo "D_7"
FUNCTION_OUTPUT=$(generate_certificates_in_pki_of_sourcedir $TASKSERVER_TAR_NAME)
LOG_FILENAME="D_7_generate_certificates_in_pki_of_sourcedir.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "D_8"
FUNCTION_OUTPUT=$(copy_generated_client_cert_from_pki_in_sourcedir_to_taskddata $TASKDDATA $TASKSERVER_TAR_NAME)
LOG_FILENAME="D_8_copy_generated_client_cert_from_pki_in_sourcedir_to_taskddata.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "D_9"
FUNCTION_OUTPUT=$(copy_generated_client_key_from_pki_in_sourcedir_to_taskddata $TASKDDATA $TASKSERVER_TAR_NAME)
LOG_FILENAME="D_9_copy_generated_client_key_from_pki_in_sourcedir_to_taskddata.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "D_10"
FUNCTION_OUTPUT=$(copy_generated_server_cert_from_pki_in_sourcedir_to_taskddata $TASKDDATA $TASKSERVER_TAR_NAME)
LOG_FILENAME="D_10_copy_generated_server_cert_from_pki_in_sourcedir_to_taskddata.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "D_11"
FUNCTION_OUTPUT=$(copy_generated_server_key_from_pki_in_sourcedir_to_taskddata $TASKDDATA $TASKSERVER_TAR_NAME)
LOG_FILENAME="D_11_copy_generated_server_key_from_pki_in_sourcedir_to_taskddata.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "D_12"
FUNCTION_OUTPUT=$(copy_generated_server_crl_from_pki_in_sourcedir_to_taskddata $TASKDDATA $TASKSERVER_TAR_NAME)
LOG_FILENAME="D_12_copy_generated_server_crl_from_pki_in_sourcedir_to_taskddata.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "D_13"
FUNCTION_OUTPUT=$(copy_generated_ca_cert_from_pki_in_sourcedir_to_taskddata $TASKDDATA $TASKSERVER_TAR_NAME)
LOG_FILENAME="D_13_copy_generated_ca_cert_from_pki_in_sourcedir_to_taskddata.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "D_14"
FUNCTION_OUTPUT=$(configure_taskd_for_client_cert $TASKDDATA)
LOG_FILENAME="D_14_configure_taskd_for_client_cert.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "D_15"
FUNCTION_OUTPUT=$(configure_taskd_for_client_key $TASKDDATA)
LOG_FILENAME="D_15_configure_taskd_for_client_key.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "D_16"
FUNCTION_OUTPUT=$(configure_taskd_for_server_cert $TASKDDATA)
LOG_FILENAME="D_16_configure_taskd_for_server_cert.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "D_17"
FUNCTION_OUTPUT=$(configure_taskd_for_server_key $TASKDDATA)
LOG_FILENAME="D_17_configure_taskd_for_server_key.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "D_18"
FUNCTION_OUTPUT=$(configure_taskd_for_server_crl $TASKDDATA)
LOG_FILENAME="D_18_configure_taskd_for_server_crl.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "D_19"
FUNCTION_OUTPUT=$(configure_taskd_for_ca_cert $TASKDDATA)
LOG_FILENAME="D_19_configure_taskd_for_ca_cert.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

#TODO: Define PWD
echo "D_21"
FUNCTION_OUTPUT=$(configure_taskserver_log $TASKDDATA $PWD)
LOG_FILENAME="D_21_configure_taskserver_log.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

#TODO: Define PWD
echo "D_22"
FUNCTION_OUTPUT=$(configure_taskserver_pid $TASKDDATA $PWD)
LOG_FILENAME="D_22_configure_taskserver_pid.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "D_22_b"
FUNCTION_OUTPUT=$(configure_taskserver_ciphers)
LOG_FILENAME="configure_taskserver_ciphers.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)


echo "D_23"
FUNCTION_OUTPUT=$(configure_taskserver_ip_and_port $IP $PORT)
LOG_FILENAME="D_23_configure_taskserver_ip_and_port.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "D_24_a"
FUNCTION_OUTPUT=$(show_taskd_config)
LOG_FILENAME="D_24_a_show_taskd_config.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "D_24_b"
FUNCTION_OUTPUT=$(start_taskdctl)
LOG_FILENAME="D_24_b_start_taskdctl.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "D_24_c"
FUNCTION_OUTPUT=$(show_running_taskdctl)
LOG_FILENAME="D_24_c_show_running_taskdctl.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "D_24_d"
FUNCTION_OUTPUT=$(modify_taskd_service_file $LINUX_USERNAME $LINUX_GROUP $TASKDDATA)
LOG_FILENAME="D_24_d_modify_taskd_service_file.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "D_24_e"
FUNCTION_OUTPUT=$(copy_taskd_service_file)
LOG_FILENAME="D_24_e_copy_taskd_service_file.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "D_24_f"
FUNCTION_OUTPUT=$(reload_deamon)
LOG_FILENAME="D_24_f_.reload_deamontxt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "D_24_g"
FUNCTION_OUTPUT=$(start_taskd_server)
LOG_FILENAME="D_24_g_start_taskd_server.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "D_24_h"
FUNCTION_OUTPUT=$(check_status_taskd_server)
LOG_FILENAME="D_24_h_check_status_taskd_server.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "D_24_i"
FUNCTION_OUTPUT=$(enable_starting_taskd_server_at_boot)
LOG_FILENAME="D_24_i_enable_starting_taskd_server_at_boot.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)



echo "D_25"
FUNCTION_OUTPUT=$(add_organisation_to_taskserver $TASKDDATA $TW_ORGANISATION)
LOG_FILENAME="D_25_add_organisation_to_taskserver.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "D_26"
FUNCTION_OUTPUT=$(add_user_to_taskserver $TASKDDATA $TW_ORGANISATION $TW_USERNAME)
LOG_FILENAME="D_26_add_user_to_taskserver.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

# Read user key from log using helper.sh
KEY=$(read_user_key_from_log)

echo "D_28"
FUNCTION_OUTPUT=$(generate_user_certificate $TASKSERVER_TAR_NAME $TW_USERNAME)
LOG_FILENAME="D_28_generate_user_certificate.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "D_30"
FUNCTION_OUTPUT=$(copy_user_certificate_to_dot_task_dir $LINUX_USERNAME $TASKSERVER_TAR_NAME)
LOG_FILENAME="D_30_copy_user_certificate_to_dot_task_dir.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "D_31"
FUNCTION_OUTPUT=$(copy_user_certificate_key_to_dot_task_dir $LINUX_USERNAME $TASKSERVER_TAR_NAME)
LOG_FILENAME="D_31_copy_user_certificate_key_to_dot_task_dir.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "D_32"
FUNCTION_OUTPUT=$(copy_ca_cert_to_dot_task_dir $LINUX_USERNAME $TASKSERVER_TAR_NAME)
LOG_FILENAME="D_32_copy_ca_cert_to_dot_task_dir.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "D_33_a"
FUNCTION_OUTPUT=$(configure_taskserver_config_user_certificate $LINUX_USERNAME $TW_USERNAME)
LOG_FILENAME="D_33_a_configure_taskserver_config_user_certificate.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "D_33_b"
FUNCTION_OUTPUT=$(configure_taskserver_config_user_key $LINUX_USERNAME $TW_USERNAME)
LOG_FILENAME="D_33_b_configure_taskserver_config_user_key.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "D_34"
FUNCTION_OUTPUT=$(configure_taskserver_config_ca_cert $LINUX_USERNAME)
LOG_FILENAME="D_34_configure_taskserver_config_ca_cert.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "D_34_b"
FUNCTION_OUTPUT=$(configure_taskserver_config_ciphers)
LOG_FILENAME="D_34_b_configure_taskserver_config_ciphers.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "D_35"
FUNCTION_OUTPUT=$(configure_taskserver_config_ip_and_port $IP $PORT)
LOG_FILENAME="D_35_configure_taskserver_config_ip_and_port.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "D_36"
echo "in main KEY=$KEY"
FUNCTION_OUTPUT=$(set_taskserver_credentials $TW_ORGANISATION $TW_USERNAME $KEY)
LOG_FILENAME="D_36_set_taskserver_credentials.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)

echo "D_38"
FUNCTION_OUTPUT=$(first_taskserver_sync_init)
LOG_FILENAME="D_38_first_taskserver_sync_init.txt"
$(write_to_log $LOG_LOCATION $LOG_FILENAME $FUNCTION_OUTPUT)
