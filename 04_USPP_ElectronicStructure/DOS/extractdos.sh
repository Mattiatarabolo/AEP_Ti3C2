#!/bin/sh
kgrid="6 12 18 24 30 36"
for k in $kgrid
do
echo "kpoints = $k"
cat > readdos_${k}.in << EOF
&DOS
 outdir = './tmp_${k}',
 prefix = 'TiC',
 fildos = 'TiC_${k}.dos'
/
EOF

~/Desktop/QuantumEspresso/bin/dos.x < readdos_${k}.in > dos_TiC_${k}.out &
done
