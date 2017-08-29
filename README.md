# clean-squirrel

This batch file is designed to make it simpler
to move programs, caches, or pretty much anything else
out of your AppData folders and into some other location
(like a different drive).

This should be helpful if you have limited space
on your C:\ drive and want to avoid the clutter
that comes due to installers like Squirrel
(which installs entire programs into AppData).

It creates symlinks to avoid breaking anything in the software
that uses resources from AppData.

## Usage Notes

This script requires administrative privileges to run
because it creates symbolic links. Press Win+X and select
`Command Prompt (Admin)` to run cmd with admin privileges.

-----

This script won't purge any files in the target directory.
However, it **will** overwrite any files that have conflicting names.

This problem shouldn't occur unless you specify the
install location as a directory that already has
a subdirectory named `Local` or `Roaming`.

For safety, check the contents of your
target directory before running the script.

## Example

`cleansquirrel.bat Atom D:\Programs\Atom`

Yep, that's it.

This will move the files from %appdata%\Atom
and %LocalAppData%\Atom to D:\Programs\Atom\Roaming
and D:\Programs\Atom\Local, respectively.

### Better docs

General form: `cleansquirrel.bat [/HELP] ProgramDirName TargetDir`

Passing `/HELP` as the first parameter will display docs
in the terminal, ignoring any other arguments.

The `ProgramDirName` argument should be exactly the
same as the name of the folder in your AppData
that you want to move.
For example, if you have Discord
installed in `C:\Users\YourName\AppData\Roaming\discord`,
you would want the value of `ProgramDirName` to be `discord`.

The `TargetDir` argument should be an exact path to the
directory where you'd like to move your your files.
If this directory doesn't exist, the command will create it for you.
