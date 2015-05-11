function ds(){ # Size of directories in MB
    echo "size of directories in MB"
    if [ $# -lt 1 ] || [ $# -gt 2 ]; then
        echo "you did not specify a directy, using pwd"
        DIR=$(pwd)
        find $DIR -maxdepth 1 -type d -exec du -sm \{\} \; | sort -n
    else
        find $1 -maxdepth 1 -type d -exec du -sm \{\} \; | sort -n
    fi
}

function lls() { # Counts files, subdirectories and directory size and displays details about files
	echo -n " <`find . -maxdepth 1 -mindepth 1 -type f | wc -l | tr -d '[:space:]'` files>"  # count files
	echo -n " <`find . -maxdepth 1 -mindepth 1 -type d | wc -l | tr -d '[:space:]'` dirs/>"  # count sub-directories
	echo -n " <`find . -maxdepth 1 -mindepth 1 -type l | wc -l | tr -d '[:space:]'` links@>" # count links
	echo " <~`du -sh . 2> /dev/null | cut -f1`>"	                                         # total disk space used by this directory and all subdirectories
	ROWS=`stty size | cut -d' ' -f1`
	FILES=`find . -maxdepth 1 -mindepth 1 |
	wc -l | tr -d '[:space:]'`
	ls -hlAF --group-directories-first
}
