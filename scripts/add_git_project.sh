#!/bin/bash

# Initialize a new Git repository
git init

# Create recommended files
touch .gitignore
touch README.md
touch LICENSE

# Add some initial content to README.md
echo "# My Project" >> README.md
echo "This is a brief description of my project." >> README.md

# Create a .gitignore file and add the "poky" directory
echo "# Ignore node_modules directory for Node.js projects" >> .gitignore
echo "node_modules/" >> .gitignore
echo "# Ignore the 'poky' directory" >> .gitignore
echo "poky/" >> .gitignore

# Prompt the user to select a license
echo "Choose a license for your project:"
select LICENSE_CHOICE in "MIT License" "GPL v2" "GPL v3" "Apache License 2.0" "Quit"; do
  case $LICENSE_CHOICE in
    "MIT License")
      LICENSE_TEXT=$(cat <<EOF
MIT License

Copyright (c) [Year] [Your Name]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS," WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOF
)
      break
      ;;
    "GPL v2")
      LICENSE_TEXT=$(cat <<EOF
GNU General Public License, version 2

Copyright (C) [Year] [Your Name]

This program is free software; you can redistribute it and/or modify it
under the terms of the GNU General Public License as published by the Free
Software Foundation; either version 2 of the License, or (at your option)
any later version.

This program is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
more details.

You should have received a copy of the GNU General Public License along
with this program; if not, write to the Free Software Foundation, Inc.,
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
EOF
)
      break
      ;;
    "GPL v3")
      LICENSE_TEXT=$(cat <<EOF
GNU General Public License, version 3

Copyright (C) [Year] [Your Name]

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
EOF
)
      break
      ;;
    "Apache License 2.0")
      LICENSE_TEXT=$(cat <<EOF
Apache License
Version 2.0, January 2004

Copyright (C) [Year] [Your Name]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
EOF
)
      break
      ;;
    "Quit")
      echo "Exiting without creating a license."
      exit 0
      ;;
    *)
      echo "Invalid choice. Please select a valid license or Quit."
      ;;
  esac
done

# Get the current year from the system
CURRENT_YEAR=$(date +"%Y")

# Get the Git global user name
GIT_USER_NAME=$(git config --global user.name)

# Replace placeholders in the license text with actual values
LICENSE_TEXT="${LICENSE_TEXT//\[Year\]/$CURRENT_YEAR}"
LICENSE_TEXT="${LICENSE_TEXT//\[Your Name\]/$GIT_USER_NAME}"

# Save the selected license text to the LICENSE file
echo "$LICENSE_TEXT" > LICENSE

# Commit the initial files
git add .
git commit -m "Initial commit"

echo "Git repository initialized with recommended files and the selected license."
