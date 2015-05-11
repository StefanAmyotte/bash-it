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

function findit() { # find a file with pattern in name
	if [ -z ${1} ];then
		echo "Please pass an argument that you want to search for"
	else
		find . -iname "*$1*" -print
	fi
}

function grepp(){ # grep by paragraph instead of by line
	[ $# -eq 1 ] && perl -00ne "print if /$1/i" || perl -00ne "print if /$1/i" < "$2";
}

function apt-history(){ # show apt log history
	case "$1" in
		install)
			cat	/var/log/dpkg.log | grep 'install '
			;;
		upgrade|remove)
			cat /var/log/dpkg.log | grep $1
			;;
		rollback)
			cat /var/log/dpkg.log | grep upgrade | \
			grep "$2" -A10000000 | \
			grep "$3" -B10000000 | \
			awk '{print $4"="$5}'
			;;
		*)
			cat /var/log/dpkg.log
			;;
	esac
}

function stopwatch(){ # keep track of elapsed time
	BEGIN=$(date +%s)
	while true; do
	    NOW=$(date +%s)
	    DIFF=$(($NOW - $BEGIN))
	    MINS=$(($DIFF / 60))
	    SECS=$(($DIFF % 60))
	    echo -ne "Time elapsed: $MINS:`printf %02d $SECS`\r"
	    sleep .1
	done
}

function countdown(){ # countdown (set min), and get alert when elapsed
	case "$1" in -s) shift;; *) set $(($1 * 60));; esac 
	local S=" "; 
	for i in $(seq "$1" -1 1); do echo -ne "$S\r $i\r"; sleep 1; done; 
	echo -e "$S\rBOOM!"
	alert 
}

function note(){ # simple note-taking
	# if file doesn't exist, create it
	[ -f $HOME/.notes ] || touch $HOME/.notes
	# no arguments, print file
	if [ $# = 0 ]; then
		cat $HOME/.notes
	# clear file if "-c" flag
	elif [ $1 = -c ]; then
		> $HOME/.notes
	# add all arguments to file
	else
		echo "$@" >> $HOME/.notes
	fi
}

function tarball(){ # create a dated tar.gz archive
	tar zcvf "$1"-`date +%Y%m%d`.tar.gz "$1"; 
}

function pp(){ # search processes and display tree  
	psls f | awk '!/awk/ && $0~var' var=${1:-".*"} ; 
}

function psgrep(){ # grep search processes
    if [ $# -lt 1 ] || [ $# -gt 1 ]; then
        echo "grep running processes"
        echo "usage: psgrep [process]"
    else
        ps aux | grep USER | grep -v grep
        ps aux | grep -i $1 | grep -v grep
    fi
}

function pskill(){ # kill by process name
	local pid pname sig="-TERM"   # Default signal.
	if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
		echo "Usage: killps [-SIGNAL] pattern"
		return;
	fi
	if [ $# = 2 ]; then sig=$1 ; fi
	for pid in $(psgrep| awk '!/awk/ && $0~pat { print $1 }' pat=${!#} ) ; do
		pname=$(psgrep | awk '$1~var { print $5 }' var=$pid )
		if ask "Kill process $pid <$pname> with signal $sig?"
			then kill $sig $pid
		fi
	done
}
