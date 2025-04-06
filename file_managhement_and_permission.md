<div> ------------------------------ Best View Raw format, Forgot to add identation based on git---------------------------------- </div>
 
 ls: Lists files and directories.
     Usage: ls [options]
        Options:
          -a: Includes hidden files.
          -l: Detailed list format.
          -h: Human-readable file sizes.

cd: Changes the current directory.
    Usage: cd [directory]
      Examples:
         cd ~: Goes to the home directory.
         cd ..: Moves up one directory level.

 mkdir: Creates a new directory.
    Usage: mkdir [directory_name]

 touch: Creates an empty file or updates a file's timestamp.
   Usage: touch [file_name]

 cp: Copies files or directories.
   Usage: cp [source] [destination]
    Options:
       -r: Recursive copy for directories.

 mv: Moves or renames files and directories.
    Usage: mv [source] [destination]

 rm: Deletes files or directories.
    Usage: rm [file_name]
     Options:
        -r: Recursive deletion for directories.
        -i: Prompts for confirmation before deleting.

 rmdir: Deletes empty directories.
     Usage: rmdir [directory_name]
     Example:
        parent_dir/
           ├── empty_dir
           └── non_empty_dir
                └── file.txt
     To delete empty_dir, you would use:
       bash
        rmdir parent_dir/empty_dir
    If you try to delete non_empty_dir without removing file.txt first, rmdir will fail:
      bash
       rmdir parent_dir/non_empty_dir
       
  Deleting Empty Directories Recursively
      bash
        find parent_dir -type d -empty -delete
     This command uses find to search for directories (-type d) that are empty (-empty) within parent_dir and deletes them (-delete).


-------------------------------------------------

Permission Management Commands
  chmod: Changes file permissions.
     Usage: chmod [permissions] [file_name]
           Permission Types:
               r: Read permission.
               w: Write permission.
               x: Execute permission.
          Permission Groups:
              u: User (owner).
              g: Group.
              o: Others.
              a: All (equivalent to ugo).
         Examples:
            chmod u=rw,g=r,o=r file.txt: Sets read and write for the owner, read-only for the group and others.
            There are some rules and specific assignement of nu to r=4,w=2,x=1 using that we find octal representation
            chmod 644 file.txt: Sets permissions using octal notation. 

 chown: Changes the owner of a file or directory.
      Usage: chown [new_owner] [file_name]
           Example: sudo chown root file.txt

 chgrp: Changes the group ownership of a file or directory.
      Usage: chgrp [new_group] [file_name]
          Example: sudo chgrp developers file.txt

 Viewing Permissions
    ls -l: Displays detailed file information, including permissions.
        Example: ls -l file.txt

 Permission Notation
      Symbolic Notation: Uses letters like u, g, o, and a to specify permissions.
         Example: chmod u+x file.txt adds execute permission for the owner.
      Octal Notation: Uses numbers to represent permissions.
              Example: chmod 755 file.txt sets permissions as rwxr-xr-x.

Best Practices
       Always use the -i option with rm to avoid accidental deletions.
       Use chmod carefully, as incorrect permissions can lead to security issues.
       Regularly check file permissions using ls -l to ensure they are appropriate.
