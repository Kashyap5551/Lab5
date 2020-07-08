#!/bin/sh
#Kashyap Patel, 216785339



n1=$(find $1 -readable -name '*.rec' | wc -l)
if test $n1 -eq 0
then
   printf "There is no readable *.rec files that exist in specified path or its subdirectories"
   exit 4
fi


case $2 in
      h) printf "Here are defined commands:\n
                 creg: give the list of course names with the total number of students registered in\n
                 each course.\n
                 stc ######: gives the name of all course names in which the student with ###### id\n
                 registered in.\n
                 gpa ######: gives the GPA of the student defined with id ###### using the     following\n      formula: (course_1*credit_1 +   . . . + course_n*credit_n) / (credit_1+ . . . +\n
                 credit_n)\n
                 h: prints the current message.\n" ;;
      creg)  find $1 -readable -name '*.rec' > listFiles
		while read f
		do
    			c1=$(grep -i "COURSE" $f | cut -d ":" -f2 | sed -e 's/^\s*//g')
		     	tr [:lower:] [:upper:] < $c1 > $c2
                        c3=$(grep -E -o "[0-9]{6}" "$f" | wc -l)           
			printf "\nIn "$c2", $c3 students register."
		done < listFiles
		rm listFiles
                exit 0;;
          
      stc) if test $3 -eq 0
		then
   		printf "The student id should be 6 numbers."
   		exit 3
	   fi

	   case $3 in
		*[0-9][0-9][0-9][0-9][0-9][0-9]*) while read g
					do 
					counter=`expr counter + 1`
					find $3 -readable -name '*.rec' > listFiles2
             				g1=$(grep "COURSE" $g | cut -d ":" -f2 | sed -e 's/^\s*//g')
		     	      		tr [:lower:] [:upper:] < $g1 > $g2
					g3=$(grep "CREDITS" $g | cut -d ":" -f2 | sed -e 's/^\s*//g')
					printf "$counter. $g2 which has $g3 credits."
					done < listFiles2 
					rm listFiles2;;
		
		*) printf "The student id should be 6 numbers."	
		exit 2		
	   esac  ;;

	gpa) if test $3 -eq 0
		then
   		printf "The student id should be 6 numbers."
   		exit 1
	   fi

	   case $3 in
		*[0-9][0-9][0-9][0-9][0-9][0-9]*) while read g
					do 
					counter=`expr counter + 1`
					find $3 -readable -name '*.rec' > listFiles2
             				g1=$(grep "COURSE" $g | cut -d ":" -f2 | sed -e 's/^\s*//g')
		     	      		tr [:lower:] [:upper:] < $g1 > $g2
					g3=$(grep "CREDITS" $g | cut -d ":" -f2 | sed -e 's/^\s*//g')
					printf "$counter. $g2 which has $g3 credits."
					done < listFiles2 ;;
		
		*) printf "The student id should be 6 numbers."	 		
	   esac  ;;
              
	
   esac





