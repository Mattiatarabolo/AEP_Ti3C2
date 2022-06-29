#!/bin/sh
Vacuum="2 5"
a=5.7646
c=$((${a}*4.46690))
for v in $Vacuum
do
echo "Vacuum = $v"
RESULT=$(((${c}+${v})/${a}))
cat > TiC_${v}.scf.in << EOF
&CONTROL
 calculation = 'scf',
 restart_mode = 'from_scratch',
 prefix = 'TiC',
 pseudo_dir = '../Pseudo',
 outdir = './tmp_${v}',
 tprnfor = .true.,
 tstress = .true.,
 verbosity = 'high',
/
&SYSTEM
 ibrav = 4,
 celldm(1) = ${a},
 celldm(3) = ${RESULT},
 nat=  5,
 ntyp= 2,
 ecutwfc = 50,
 ecutrho = 440,
 occupations= 'smearing',
 smearing= 'mp',
 degauss = 0.001,
 assume_isolated = '2D'
/
&ELECTRONS
 conv_thr =  1.0d-6,
/
ATOMIC_SPECIES
  C  12.0107  C.pbe-n-rrkjus_psl.1.0.0.UPF
  Ti 47.867 Ti.pbe-spn-rrkjus_psl.1.0.0.UPF
ATOMIC_POSITIONS angstrom
  Ti   1.5252500000 0.8806034980  1.898
  C    0            1.7612069961  0.949
  Ti   0            0             0
  C    0            -1.7612069961 -0.949
  Ti   -1.525250000 -0.8806034980 -1.898
K_POINTS automatic
 12 12 1 0 0 0
EOF

~/Desktop/QuantumEspresso/bin/pw.x < TiC_${v}.scf.in > TiC_${v}.scf.out &
done
