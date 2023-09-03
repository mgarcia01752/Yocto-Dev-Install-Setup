#!/bin/bash

# Check if an email address is provided as an argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <your_email@example.com>"
    exit 1
fi

# Email address for the SSH key comment
email="$1"

# Function to generate an SSH key pair
generate_ssh_key() {
    local key_type="$1"
    local key_comment="$2"
    local key_filename="$3"

    echo "Generating $key_type SSH key..."
    ssh-keygen -t $key_type -b 4096 -C "$key_comment" -f "$key_filename"

    if [ $? -eq 0 ]; then
        echo "Successfully generated $key_type SSH key."
    else
        echo "Failed to generate $key_type SSH key."
        exit 1
    fi
}

# Generate an SSH key pair for SSH authentication
generate_ssh_key "rsa" "$email (SSH)" ~/.ssh/id_rsa

# Generate an SSH key pair for Git repositories
generate_ssh_key "ed25519" "$email (Git)" ~/.ssh/id_ed25519

# Output public keys for the user to copy and use
echo -e "\nPublic SSH keys:"
cat ~/.ssh/id_rsa.pub
cat ~/.ssh/id_ed25519.pub

echo -e "\nPublic keys have been generated."
