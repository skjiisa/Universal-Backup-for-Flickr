datetime=`date '+%Y-%m-%d_%H,%M'`

dirname=`echo $1 | tr '/' ','`
dirname=`echo $dirname | tr ' ' '_'`

if [ ! -d "$1" ]; then
	echo Not a directory
	exit 1
fi

eval tar cf - $1 | 7za a -si "$dirname$datetime.tar.7z" -p -mhe -mx=0 -v1000m

if [ $? -ne 0 ]; then
	exit 1
fi

for i in $dirname$datetime.tar.7z.00*; do
	echo "Uploading $i"
	cp output.mp4 $i.mp4
	dd if=$i of=$i.mp4 bs=512 seek=3
	flickcurl -V upload $i.mp4
done
