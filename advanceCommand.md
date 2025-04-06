<div> Best view Raw format, Forgot to coorect identation as per git </div>

Processing
    In the context of text manipulation, processing refers to the act of analyzing, transforming, or extracting data from text files. 
    This can involve filtering, sorting, aggregating, or modifying the data in some way. 
    Tools like awk are designed for processing data,
      allowing you to perform complex operations such as 
          extracting specific fields,
          performing arithmetic operations,
          or applying conditional logic.

Stream Editor
    A stream editor is a tool that processes text as a stream of characters or lines,
    allowing you to edit the text without loading the entire file into memory. 
    This approach is efficient for handling large files. sed is a classic example of a stream editor, 
    primarily used for simple text transformations like 
             search and replace,
             inserting lines,
             or deleting text.

awk:

   Processing: awk is primarily used for data processing.
       It can extract specific fields, perform calculations, and apply complex logic to filter or transform data.
  
   Editing: While awk can modify text, it's not its primary purpose. However,
      it can be used to edit text by manipulating fields or lines based on conditions.
  
   Example: Extracting specific columns from a CSV file and performing calculations on them.

sed:

   Editing: sed is primarily a stream editor, focusing on editing text directly.
        It's excellent for simple transformations like replacing strings or deleting lines.

   Processing: While sed can perform some basic filtering, 
        it's not designed for complex data processing like awk.

  Example: Replacing all occurrences of a word in a text file.
  
Programming Constructs:

  awk: Offers robust programming constructs like if-else, while, for loops, and multi-dimensional arrays.

  sed: Has limited programming constructs, mainly pattern matching and simple conditionals.

 #created data.txt file with content
  echo "John 25 USA
  Alice 30 UK
  Bob 35 Canada" >> data.txt

  awk '{print $1, $3}' data.txt
  This prints the first and third fields of each line in data.txt.
   OutPut
       John USA
       Alice UK
       Bob Canada


  sed 's/USA/United States/g' data.txt
  This replaces all occurrences of "USA" with "United States" in file.txt.
  OutPut
      John 25 United States
      Alice 30 UK
      Bob 35 Canada
      
  echo '1 Line' > example.txt
  echo '2 Line' >> example.txt
   This prints lines containing the specified regular expression.
  awk '/regex/ {print $0}' input_file
  awk '/[0-9]/ {print $1}' example.txt
  Output
  1
  2

 awk 'BEGIN {print "Header"} {print $0} END {print "Footer"}' example.txt
   This prints a header before processing the file and a footer after.
 Output
 Header
 1
 2
 Footer

 echo '11 added at Line 3 and 11' >> example.txt
 echo 'added at line 4 12' >> example.txt
 Conditional Statements:
   awk '{if ($1 > ) print $0}' example.txt
   OutPut
     11 added at Line 3 and 11
     added at line 4 12

Loop
   awk '{total = 0; for (i = 1; i <= NF; i++) total += $i; print total}' example.txt
   This calculates the sum of all fields in each line.

Scripting with awk
    create a file named script.awk with the following content:

  text
     BEGIN { print "Processing file..." }
      { print $1, $3 }
     END { print "Processing complete." }

 Then, run it using:
   awk -f script.awk input_file

sed 's/old_string/new_string/flags' file

  s: The substitute command.
  old_string: The pattern to search for.
  new_string: The replacement string.
  flags: Optional flags like g for global replacement, i for case-insensitive matching, or a number to specify which occurrence to replace.

Replace a String:
  sed 's/old/new/' file.txt
  Replaces the first occurrence of "old" with "new" in each line.

Global Replacement:
  sed 's/old/new/g' file.txt
  Replaces all occurrences of "old" with "new" in each line.

Delete Lines:
  sed '/pattern/d' file.txt
  Deletes lines containing the specified pattern.

Insert Text:
  sed '1i\This is the first line.' file.txt
  Inserts a line at the beginning of the file.

Multiple Commands:
  sed -e 's/old/new/' -e '/pattern/d' file.txt
  Runs multiple commands sequentially.

Regular Expressions
  sed supports regular expressions for complex pattern matching. For example:
  sed -E 's/regex_pattern/new_string/g' file.txt

Using sed with Pipes
  You can pipe output from other commands to sed for processing:
   echo "Hello, World!" | sed 's/World/Linux/'
  This replaces "World" with "Linux" in the piped input.




