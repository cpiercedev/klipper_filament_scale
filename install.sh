#!/bin/bash 
KLIPPER_PATH="${HOME}/klipper"
KLIPPER_CONFIG_PATH="${HOME}/klipper_config"
SYSTEMDDIR="/etc/systemd/system"



# Step 1:  Verify Klipper has been installed
check_klipper()
{
    if [ "$(sudo systemctl list-units --full -all -t service --no-legend | grep -F "klipper.service")" ]; then
        echo "Klipper service found!"
    else
        echo "Klipper service not found, please install Klipper first"
        exit -1
    fi

}

# Step 2: link extension to Klipper
link_extension()
{
    echo "Linking extension to Klipper..."
    ln -sf "${SRCDIR}/klipper_filament_scale.py" "${KLIPPER_PATH}/klippy/extras/klipper_filament_scale.py"
}
# Step 3: Copy all config files if they do not exist
copy_config()
{
        if [ ! -f "${KLIPPER_CONFIG_PATH}/filament_scale_hardware.cfg" ]
    then
       cp -u "${SRCDIR}/Macros/filament_scale_hardware.cfg" "${KLIPPER_CONFIG_PATH}/filament_scale_hardware.cfg"
    else
        echo "File found. Do nothing"
    if [ ! -f "${KLIPPER_CONFIG_PATH}/filament_scale_vars.cfg" ]
    then
       cp -u "${SRCDIR}/Macros/filament_scale_vars.cfg" "${KLIPPER_CONFIG_PATH}/filament_scale_vars.cfg"
    else
        echo "File found. Do nothing"
    
    
    #cp -n "${SRCDIR}/ercf_hardware.cfg" "${KLIPPER_CONFIG_PATH}/client_macros.cfg"
}
# Step 3: Update Config Files
link_config()
{
    #ln -sf "${SRCDIR}/ercf_hardware.cfg" "${KLIPPER_CONFIG_PATH}/ercf_hardware.cfg"
    ln -sf "${SRCDIR}/Macros/filament_scale_software.cfg" "${KLIPPER_CONFIG_PATH}/filament_scale_software.cfg"
}
# Step 4: Install startup script
install_script()
{
# Create systemd service file
    SERVICE_FILE="${SYSTEMDDIR}/klipper_filament_scale.service"
    #[ -f $SERVICE_FILE ] && return
    if [ -f $SERVICE_FILE ]; then
        sudo rm "$SERVICE_FILE"
    fi
    

    echo "Installing system start script..."
    sudo /bin/sh -c "cat > ${SERVICE_FILE}" << EOF
[Unit]
Description=Dummy Service for klipper_filament_scale plugin
After=klipper.service
[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/bin/bash -c 'exec -a klipper_filament_scale sleep 1'
ExecStopPost=/usr/sbin/service klipper restart
TimeoutStopSec=1s
[Install]
WantedBy=multi-user.target
EOF
# Use systemctl to enable the systemd service script
    sudo systemctl daemon-reload
    sudo systemctl enable klipper_filament_scale.service
}

# Step 5: restarting Klipper
restart_klipper()
{
    echo "Restarting Klipper..."
    sudo systemctl restart klipper
}

# Helper functions
verify_ready()
{
    if [ "$EUID" -eq 0 ]; then
        echo "This script must not run as root"
        exit -1
    fi
}

# Force script to exit if an error occurs
set -e

# Find SRCDIR from the pathname of this script
SRCDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )"/ && pwd )"

# Parse command line arguments
while getopts "k:" arg; do
    case $arg in
        k) KLIPPER_PATH=$OPTARG;;
    esac
done

# Run steps
verify_ready
link_extension
link_config
install_script
restart_klipper