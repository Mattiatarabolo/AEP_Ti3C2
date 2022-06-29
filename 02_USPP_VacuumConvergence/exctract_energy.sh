#!/bin/sh
Vacuum="2 5 7 10 12 15 17 20 22 25 30"
for v in $Vacuum
do
printf "${v}"
awk 'BEGIN{FS=" *= *"} /!    total energy/{split($2,a," +");print "  " a[1]}' TiC_${v}.scf.out 
done > energy.dat
