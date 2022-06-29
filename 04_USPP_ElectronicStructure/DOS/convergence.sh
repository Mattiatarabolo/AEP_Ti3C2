#!/bin/sh
kgrid="6 12 18 24 30 36"
div=3
for k in $kgrid
do
echo "kpoints = $k"
cat > TiC_${k}.nscf.in << EOF
&CONTROL
 calculation = 'nscf',
 restart_mode = 'from_scratch',
 prefix = 'TiC',
 pseudo_dir = '../../Pseudo',
 outdir = './tmp_${k}',
 tprnfor = .true.,
 tstress = .true.,
 verbosity = 'high',
/
&SYSTEM
 ibrav = 0,
 celldm(1) = 5.803,
 nat=  5,
 ntyp= 2,
 ecutwfc = 40,
 ecutrho = 208,
 occupations= 'tetrahedra',
 assume_isolated = '2D'
/
&ELECTRONS
 conv_thr =  1.0d-6,
/
ATOMIC_SPECIES
 C  12.0107  C.pbe-n-rrkjus_psl.1.0.0.UPF
 Ti 47.867 Ti.pbe-spn-rrkjus_psl.1.0.0.UPF
CELL_PARAMETERS (alat=  5.80300000)
   1.005285529   0.000001187   0.000000000
  -0.502641736   0.870603399   0.000000000
   0.000000000   0.000000000   6.133275892

ATOMIC_POSITIONS (crystal)
C             0.3333352963        0.6666647037        0.4297659504
C             0.6666647037        0.3333352963        0.5702340496
Ti           -0.0000000000       -0.0000000000        0.5000000000
Ti            0.3333351210        0.6666648790        0.6237195016
Ti            0.6666648790        0.3333351210        0.3762804984
K_POINTS automatic
 ${k} ${k} 1 0 0 0
EOF

cp -r /home/tara/Desktop/TitaniumCarbide/04_USPP_ElectronicStructure/Bands/tmp /home/tara/Desktop/TitaniumCarbide/04_USPP_ElectronicStructure/DOS
mv /home/tara/Desktop/TitaniumCarbide/04_USPP_ElectronicStructure/DOS/tmp /home/tara/Desktop/TitaniumCarbide/04_USPP_ElectronicStructure/DOS/tmp_${k}
cp /home/tara/Desktop/TitaniumCarbide/04_USPP_ElectronicStructure/Bands/TiC.scf.in /home/tara/Desktop/TitaniumCarbide/04_USPP_ElectronicStructure/DOS
mv /home/tara/Desktop/TitaniumCarbide/04_USPP_ElectronicStructure/DOS/TiC.scf.in /home/tara/Desktop/TitaniumCarbide/04_USPP_ElectronicStructure/DOS/TiC_${k}.scf.in
cp /home/tara/Desktop/TitaniumCarbide/04_USPP_ElectronicStructure/Bands/TiC.scf.out /home/tara/Desktop/TitaniumCarbide/04_USPP_ElectronicStructure/DOS
mv /home/tara/Desktop/TitaniumCarbide/04_USPP_ElectronicStructure/DOS/TiC.scf.out /home/tara/Desktop/TitaniumCarbide/04_USPP_ElectronicStructure/DOS/TiC_${k}.scf.out
~/Desktop/QuantumEspresso/bin/pw.x < TiC_${k}.nscf.in > TiC_${k}.nscf.out &
done
