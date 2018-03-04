datetime=`date '+%Y-%m-%d_%H,%M'`

dirname=`echo $1 | tr '/' ','`
dirname=`echo $dirname | tr ' ' '_'`

if [ ! -d "$1" ]; then
	echo Not a directory
	exit 1
fi

7za a "$dirname$datetime.7z" "$1" -p -mhe -mx=0 -v1000m

for i in $dirname$datetime.7z.00*; do
	echo "Uploading $i"
	cp ~/output.mp4 $i.mp4
	dd if=$i of=$i.mp4 seek=1506 oflag=seek_bytes
	flickcurl upload $i.mp4
done
