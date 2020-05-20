# scan_output_transformation
Gem to scans on .json format from produtil and generate export file with data to be used by clients.

This script is in Ruby Language.

Originally, in produtil, this scans files are compressed on .zip and .tar.gz files. So, what does this script do? Go to
produtil, download this compressed files, uncompress them, read a mapping file to help on .csv generation and create four
files: inventory, middleware, instance and logs.


## Execution

This script can be executed inside or outside produtil server and there are some options we'll se below that cooperates 
for both cases

After installing, a new command `scan_output` will be available and this command has options `--output-dir`, `--scan-dir`, 
`--extract-dir` and `--mapping-file-path`.

The basic sintaxe of this command is `scan_output <client name> <client_prefix` and the output of this command are four
files: inventory, middleware, instance and one for log.

### --scan-dir

This option is used to map from which directory the scan files will be read. It's useful when you already have a scan dir
on your computer and don't want to update it from produtil.

If this option don't used with the command, the script will download all scans from produtil server and save them in `./scans`
directory that will be created on your current path.

### --mapping-file-path

In produtil, there is a mapping file used for matching some codes in json files to plain text. If you've already have this file
on your computer, you can use this options to provide the path for this file. 

If you haven't, if this options not present, this script will download original mapping file from produtil and save it on 
`mapping/appmapping.csv` on your current directory.

### --extract-dir

This option must be user with `--scan-dir` because it's where your scan will be extracted after downloading. 

### --output-dir

It's an options for setting in which repository the CSV files generated will be saved. If this option won't be used, the files
will be saved on current path.


## PRODUTIL execution

Produtil is a server from where the scans are downloaded, so if you want to execute this script from there, you:
* **MUST** be logged in as `root`
* **MUST** use the option `--scan-dir`
* **MUST NOT** execute this command in `/root` path
* **MUST** go to hour home directory and execute ir from there
