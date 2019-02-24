#
#	renames music files. 
#	sonlist should contain songnames of each track separated by a comma
#

#songs="`ls | grep "\<audio\> \<wav\>"`"
songs="`ls | grep audio | grep wav`"
for ((i=1;i<=$1; i++)); do
	songname="`cat songlist | cut -d , -f $i`"
	mv "`echo $songs | cut -d ' ' -f $i`" "${songname}.wav" 
	echo "${songname}.wav created."
	flac -0 -s "${songname}.wav"
	echo "${songname}.flac created" 
done
if [ "$?" = "0" ]; then
	eject
	echo "Process Completed"
fi
