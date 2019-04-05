# Universal-Backup-for-Flickr

Script for backing up ANY files to Flickr

Flickr gives each user 1 TB of storage for uploading pictures and video. This script encrypts files, then masks them as videos to upload to Flickr to take advantage of that 1 TB of storage as universal file backup.

This script is primitive. It currently works on my machine, but likely will not work on other systems and workflows.

## Dependencies

Depends on [Flickcurl](http://librdf.org/flickcurl/) and [7zip](http://www.7-zip.org/).

These are available on pacman for Arch as `flickcurl` and `p7zip` repectively.

## Usage

### Making a backup

Flickcurl must be first configured and linked to your Flickr account. Test it (ex: `flickcurl upload [filename]`) to make sure file uploading works properly.

Run the script and give an argument with the path to the folder to be backed up. `output.mp4` must be in the working directory.

### Restoring backup

There is currently no script for restoring backups. It must be done by hand. The procedure is to remove the first 1536 bytes (three 512-byte blocks) from the mp4 files downloaded from Flickr, then extract the encrypted archive parts using 7-Zip, and finally unpackaging the tarball. This can be done easily using `dd`. An example backup restore:

    dd if=relative,path,to,file,2018-03-04_08,06.tar.7z.001.mp4 of=relative,path,to,file,2018-03-04_08,06.tar.7z.001 skip=3
    dd if=relative,path,to,file,2018-03-04_08,06.tar.7z.002.mp4 of=relative,path,to,file,2018-03-04_08,06.tar.7z.002 skip=3
    7za x relative,path,to,file,2018-03-04_08,06.tar.7z.001
    tar xf relative,path,to,file,2018-03-04_08,06.tar

## Notes

Very limited testing has been done with this script. I threw it together for my own use.

It leaves behind many large files after it is run in the directory that it is run from.

This script can take a long time to run. Backing up a 2gb directory took about an hour on my system with my upload speed.
