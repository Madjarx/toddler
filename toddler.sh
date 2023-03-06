#!/bin/bash

# You can find some useful information about Bash on this link, kudos to them.
# 
# https://github.com/LeCoupa/awesome-cheatsheets
#
# TODO - make it automated with nodemon examples
# TODO - modify the script so that it takes in the arguments for the output and work directory
# TODO - make styling of the md files a bit better
# TODO - make js examples
# TODO - fix file exclusions
# TODO - add persistent files that dont get wiped with every script invokation
# TODO - make the script manage "TODO" folder with TODO.md / PERSISTENT.md, like a sideproject, low level ticket management

########################################################################################


# Colors
Color_Off='\033[0m' # Text Reset
Black='\033[0;30m'  # Black
Red='\033[0;31m'    # Red
Green='\033[0;32m'  # Green
Yellow='\033[0;33m' # Yellow
Blue='\033[0;34m'   # Blue
Purple='\033[0;35m' # Purple
Cyan='\033[0;36m'   # Cyan
White='\033[0;97m'  # White


########################################################################################
#                                                                                      #
#                 EDIT THESE LOCATIONS ACCORDING TO YOUR NEEDS                         #
#                                                                                      #
########################################################################################

# Set the directory to search
# HINT - you can change this to specific paths relative to the scripts location
# I'm working on automating this script with nodemon on every git action
directory= "./"

# Set the output file (replace with your desired filename and directory)
# I chose markdown cus of its preview abilities
output_file="./todo/TODO.md"


########################################################################################


# Comment this line out if you wish to preserve your todo md files
# This should prevent git from pushing the todo files to the github
echo 'todo' >> .gitignore


########################################################################################



# Check if the output file exists.
# If not, create one and prompt Feedback
if [ ! -f $output_file ]; then
  echo " "
  echo -e "${Yellow}Output file not in the stated directory.${Color_Off}"
  echo "Creating output file for you..."
  mkdir -p $(dirname $output_file)
  touch $output_file
  echo " "
  echo -e "Created output file at ${Yellow}$output_file${Color_Off}\n"
  echo " "
fi


# Clear the output file and prompt the Feedback
echo "" > $output_file

now=$(date +"%T")
u="$USER"
echo "## Script Ran at: $now by $u" > $output_file

echo " "
echo -e "${Purple}Sniffing around for TODO comments. This may take a bit...${Color_Off}"
echo " "
echo -e "Pasting the results in ${Yellow}$output_file${Color_Off}\n"
echo " "


########################################################################################


# Find all files in the directory (with exclusions), remember to use \ (backslash)
# Heres some info on file exclusions:
# https://math2001.github.io/article/bashs-find-command/
# 
#   -not -name '*.txt' \
files=$(find . -type f \
  -not -name '*.log' \
  -not -name '*.sh' \
  -not -name '*.lock' \
  -not -name 'package.json' \
  -not -path './node_modules/*' \
  -not -path './todo/*' \
  -not -path './.git/*' \
  -not -path './.expo/*'
)


for file in $files
do

  todos=$(grep -E -o -i "(\/\/|#|\/\*)\s*TODO\s*(.*)" "$file")

  if [ ! -z "$todos" ]; then

    echo -e "${Green}Found TODO in $file${Color_Off}"
    total_files=$((total_files+1))
    total_todos=$((total_todos+$(echo "$todos" | wc -l)))
    echo -e "${Cyan}Todos in $file:${Color_Off}\n$todos\n"

    echo "### $file" >> $output_file
    echo -e "Todos:\n$todos\n" >> $output_file
  fi
done

echo -e "\n Found ${Green}$total_todos TODOs${Color_Off} in ${Green}$total_files files.${Color_Off}\n"


########################################################################################
