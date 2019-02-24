#checks the condition of the disk. If it is okay, then the script will rip the
# disc into wav files.

$devic="/dev/sr0"
cdparanoia -A -d /dev/sr0

if ["$?"=="0"]
then 
	cdda2wav -B -q -s -D /dev/sr0 
	if ["$?"=="0"] 
	then
		echo "Rip Complete."
		eject
	else
		echo "Error. Ripping Failed."
	fi
else
	echo "Disc dmaged beyond ripping"
	eject
fi
