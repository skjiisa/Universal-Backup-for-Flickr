# Universal-Backup-for-Flickr

Script for backing up ANY files to Flickr

Flickr gives each user 1 TB of storage for uploading pictures and video. This script encrypts files, then masks them as videos to upload to Flickr to take advantage of that 1 TB of storage as universal file backup.

This script is primitive. It currently works on my machine, but likely will not work on other systems and workflows.

## Usage

### Dependencies

Depends on

* tar
    * macOS: _included_
    * Arch: `sudo pacman -S tar`
* [Flickcurl](http://librdf.org/flickcurl/) 
    * macOS: `brew install flickcurl`
    * Arch: `sudo pacman -S flickcurl`
* [7-Zip](http://www.7-zip.org/)
    * macOS: `brew install p7zip`
    * Arch: `sudo pacman -S p7zip`

### Install

1. Clone the repository or download it as a zip and extract.
1. Set the script permissions to be able to be run:

```
    sudo chmod +x flickrbackup.sh
```

### Making a backup

Flickcurl must be first configured and linked to your Flickr account. Test it (ex: `flickcurl upload [filename]`) to make sure file uploading works properly.

Run the script and give an argument with the path to the folder to be backed up. `output.mp4` must be in the working directory.

### Restoring a backup

There is currently no script for restoring backups. It must be done by hand. The procedure is to remove the first 1536 bytes (three 512-byte blocks) from the mp4 files downloaded from Flickr, then extract the encrypted archive parts using 7-Zip, and finally unpackaging the tarball. This can be done easily using `dd`. An example backup restore:

    dd if=relative,path,to,folder,2018-03-04_08,06.tar.7z.001.mp4 of=relative,path,to,folder,2018-03-04_08,06.tar.7z.001 skip=3
    dd if=relative,path,to,folder,2018-03-04_08,06.tar.7z.002.mp4 of=relative,path,to,folder,2018-03-04_08,06.tar.7z.002 skip=3
    7za x relative,path,to,folder,2018-03-04_08,06.tar.7z.001
    tar xf relative,path,to,folder,2018-03-04_08,06.tar

**Note**: using the command in the 7z man page `7za x -so directory.tar.7z | tar xf -` will not work as the `-so` flag while piping to tar prevents the user from being able to enter the password to decrypt the archive.

## Other Notes

Very limited testing has been done with this script. I threw it together for my own use.

It leaves behind many large files after it is run in the directory that it is run from.

This script can take a long time to run. Backing up a 2gb directory took about an hour on my system with my upload speed (about 6 mbps).
