#!/bin/bash

# Define default values
SCHEDULER_IP="scheduler_hostname_or_IP"
ROLE="none"

# Function to display usage information
function usage {
    echo "Usage: $0 [-s | -r] -i SCHEDULER_IP"
    echo "  -s: Configure as an ICECC scheduler"
    echo "  -r: Configure as an ICECC remote client"
    echo "  -i SCHEDULER_IP: Specify the IP address or hostname of the ICECC scheduler"
    exit 1
}

# Process command-line arguments
while getopts "sri:" opt; do
    case $opt in
        s)
            ROLE="scheduler"
            ;;
        r)
            ROLE="client"
            ;;
        i)
            SCHEDULER_IP="$OPTARG"
            ;;
        *)
            usage
            ;;
    esac
done

# Check if a valid role was specified
if [ "$ROLE" != "scheduler" ] && [ "$ROLE" != "client" ]; then
    echo "Invalid role. Use either -s for scheduler or -r for client."
    usage
fi

# Install ICECC Scheduler (if applicable)
if [ "$ROLE" == "scheduler" ]; then
    echo "Installing ICECC Scheduler..."

    # ./icecc_build.sh

    # Configure ICECC Scheduler
    echo "Configuring ICECC Scheduler..."
    sudo sed -i 's/MAX_JOBS=.*$/MAX_JOBS=4/' /etc/icecc/icecc-scheduler.conf

    # Restart the Scheduler Service
    sudo systemctl restart icecc-scheduler

    echo "ICECC Scheduler configuration complete!"
fi

# Install ICECC Client (if applicable)
if [ "$ROLE" == "client" ]; then
    echo "Installing ICECC Client..."
    sudo apt-get update
    sudo apt-get install -y icecc

    # Configure ICECC Client
    echo "Configuring ICECC Client..."
    sudo sed -i "s/ICECC_SCHEDULER=.*/ICECC_SCHEDULER=\"$SCHEDULER_IP\"/" /etc/icecc/icecc.conf

    # Start the Client Service
    sudo systemctl start iceccd

    # Enable the Client Service to start on boot (optional)
    sudo systemctl enable iceccd

    echo "ICECC Client configuration complete!"
fi

exit 0
