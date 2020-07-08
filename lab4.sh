#!/bin/sh
#Kashyap Patel, 216785339

#this tests if the user inputed the path or not.
if test $# -eq 0
then
   printf "You should enter the path name of the files\n"
   printf  "Use: lab3.sh path\n"
   printf "Example lab3.sh ~\n"
   exit 2
fi

#this assigns n1 the count of matched files.
n1=$(find $1 -readable -name '*.rec' | wc -l)

#this assigns listFiles the files name that matched.
find $1 -readable -name '*.rec' > listFiles  

#if it doesnt find any files the count will be 0 and hence the code will exit with an error .
if test $n1 -eq 0
then
   printf "There is no readable *.rec files that exist in specified path or its subdirectories"
   exit 1
fi

#an infinite while loop that only exits when the user inputs lowercase q.
while :
do
      printf "\ncommand: "
      read n2
#this tests the user input and gives what is required, if anything other than "q" or "l" its says
# not recognized files and goes back to asking for a command.
   case $n2 in
      q) printf "\ngoodbye\n"
         rm listFiles 
         exit 0 ;;

      l) find $1 -readable -name '*.rec' ;;
#while loop that reads the temporary file with the file paths and does grep operations on it.
      ci) printf "\nFound courses are:\n" 
		while read f
		do
    			c1=$(grep "COURSE" $f | cut -b 14-)
			c2=$(grep "CREDITS" $f | cut -b 11)
			printf "\n$c1 has $c2 credits."
		done < listFiles;;

      sl) printf "\nHere is a unique list of student number in all courses:\n"
		  while read f
		  do
	    		grep -E -o "[0-9]{6}" "$f"
		  done < listFiles;;
#n4 here is a counter that adds the total number of students enrolled.      
      sc)       
		  while read f
		  do
	    		n3=$(grep -E -o "[0-9]{6}" "$f" | wc -l)
			n4=`expr $n4 + $n3`
		  done < listFiles
	  printf "There are $n4 registered students in all courses." ;;

      cc) printf "There are $n1 course files." ;;

      h | help) printf "\nl or list: lists found courses"
                printf "\nci: gives the name of all courses plus number of credits"
                printf "\nsl: gives a unique list of all students registered in all courses"
                printf "\nsc: gives the total number of unique students registered in all courses"
                printf "\ncc: gives the total numbers of found course files."
                printf "\nh or help: prints the current message."
                printf "\nq or quit: exits from the script"
           ;;

      *) echo "Unrecognized command!" ;;
   esac
done
   
