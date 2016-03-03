#!/bin/bash

# Create bash scripts and auto modify the permissions, default location is home directory
# reads in scriptnames by arguements 
# user can define an alternative directory with -d flag
# -h for help
# Example create_bash_script.sh (-d $DIRECTORY) filename1 [filename 2] ...

usage () {
cat <<HELP
 
 Usage:
 Create bash scripts and auto modify the permissions, default location is home directory
 reads in scriptnames by arguements 
 user can define an alternative directory with -d flag
 -h for help
 Example create_bash_script.sh (-d $DIRECTORY) filename1 [filename 2] ...
HELP
} >&2

error () {
echo $1
usage
exit 1
}

[[ ! $1 ]] && error "Need at least one argument "


scriptname="$1"
bindir="$HOME"
filename="${bindir}/homework/${scriptname}"

if [[ -e $filename ]]; then
	echo "Filename ${filename} already exists"
	exit 1
fi

if type "$scriptname" > /dev/null 2>&1; then
	echo "There is already a command with name ${scriptname}"
	exit 1
fi 

# check bin dir
if [[ ! -d $bindir ]]; then
	# create bin directory if not
	if mkdir "$bindir"; then
		echo "created ${bindir}"
	else
		echo "Could not create ${bindir}."
		exit 1
	fi
fi


#create script
echo '#!/bin/bash' > "$filename"
#add executable
chmod 755 "$filename"
#edit
if [[ $EDITOR ]]; then
	$EDITOR "$filename"
else 
	echo "No editor"
fi
