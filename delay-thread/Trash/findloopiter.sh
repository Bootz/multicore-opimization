#! /bin/bash

#for each thread
#grep : ttt > findloopitertmp
grep : infothread.txt | while read line; do
#grep : ttt | while read line; do
  #echo "$line"
  line2=${line#*at }
  echo 'shell echo '\'"$line2"\'
  filename=${line2%:*} 
  #echo "$filename"
  lineno=${line2#*:} 
  #echo "$lineno"
  test=$(echo $line2 | grep '/')
  if [ -n "$test" ]; then
    dirpart=${filename%/*}
    cd "$dirpart"
    dirpart2=$(pwd)
    cd - > /dev/null
    filepart=${filename##*/}
    #echo "$dirpart2"
    #echo "$filepart"

    #for each nested controlling loop in one thread
    #process find loop counter name in line-index.txt
    grep $dirpart2':'$filepart':.*:.*:.*'$lineno line-index.txt | while read llvmline; do
       #echo $llvmline 
       step1=${llvmline%:*}
       #echo $step1
       countername=${step1##*:}
       echo 'print __loopcounter'$countername
    done
  else
    #echo "$filename"
    #process find loop counter name in line-index.txt
    grep '.*:'$filename':.*:.*:.*'$lineno line-index.txt | while read llvmline; do
       #echo $llvmline 
       step1=${llvmline%:*}
       #echo $step1
       countername=${step1##*:}
       echo 'print __loopcounter'$countername
    done
  fi
  #echo
done

