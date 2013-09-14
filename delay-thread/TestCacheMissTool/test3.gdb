set logging off
shell rm -rf test3.gdb.txt
set $missrate = 0
set $lastmissrate = 0
set $llastmissrate = 0
#set $uptrend = 1
#set $downtrend = 1
break 85
commands 1
set $missrate = (values[1] - tempvalues[1])*180.0/(values[2] - tempvalues[2])
# find botomm
if $missrate > $lastmissrate
  if $llastmissrate > $lastmissrate
    set logging file test3.gdb.txt
    set logging on
    #shell echo -n "time: " >> test3.gdb.txt
    print i-10
    set logging off

    #info threads
    #shell ./findloopiter.sh > findloopitertmp
    #shell cat findloopitertmp

    #set logging file test3.gdb.txt
    #set logging on
    #source findloopitertmp
    #shell echo >> test3.gdb.txt
    #set logging off

  end
end

# find peak
if $missrate < $lastmissrate
  if $llastmissrate < $lastmissrate
    set logging file test3.gdb.txt
    set logging on
    #shell echo -n "time: " >> test3.gdb.txt
    print i-10
    set logging off
  end
end

set $llastmissrate = $lastmissrate
set $lastmissrate = $missrate

#record last "info thread" output
shell rm -rf infothread.txt
set logging file infothread.txt
set logging on
info threads
set logging off

continue
end
run

shell rm -rf infothread.txt
shell rm -rf findloopitertmp
