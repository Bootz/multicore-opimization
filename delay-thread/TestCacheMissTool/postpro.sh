#! /bin/bash

rm -rf temp123 temp1234
gdb --batch -x test3.gdb test3 | grep '1 Thread' > temp123
cut -s -d ":" -f 2 temp123 > temp1234

pr -m -t -s\   "test2_tcm.txt" temp1234 | gawk '{print $1,$2,$3,$4}' > test2_tcm2.txt

