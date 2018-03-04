# Universal-Backup-for-Flickr

Script for backing up ANY files to Flickr

This script is primitive. It currently works on my machine, but likely will not work on other systems and workflows.

## Dependencies

Depends on [Flickcurl](http://librdf.org/flickcurl/) and [7zip](http://www.7-zip.org/).

## Usage

Run the script and give an argument with the path to the folder to be backed up.

## Notes

Very limited testing has been done with this script. I threw it together for my own use.

It leaves behind many large files after it is run in the directory that it is run from.

This script can take a long time to run. Backing up a 2gb directory took about an hour on my system with my upload speed.
