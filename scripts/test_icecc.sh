#!/bin/bash

# Define the C code file name
c_code_file="test.c"

# Create a simple C code file
echo "#include <stdio.h>" > "$c_code_file"
echo "int main() {" >> "$c_code_file"
echo "    printf(\"Hello, ICECC!\\n\");" >> "$c_code_file"
echo "    return 0;" >> "$c_code_file"
echo "}" >> "$c_code_file"

# Compile the C code using ICECC
echo "Compiling the C code using ICECC..."
/usr/bin/icecc gcc -o test "$c_code_file"  # Specify the full path to icecc

# Monitor the ICECC compilation queue
echo "Monitoring ICECC compilation queue..."
while true; do
    /usr/bin/icecc-stat -s  # Use icecc-stat to display compilation queue status
    sleep 5  # Check the status every 5 seconds
    clear    # Clear the screen for a clean display
done
