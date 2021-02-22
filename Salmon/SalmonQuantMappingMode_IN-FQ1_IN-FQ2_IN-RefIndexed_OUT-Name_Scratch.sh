#!/bin/bash -l
#SBATCH -A sens2017106
#SBATCH -p core -n 16
#SBATCH -J SalmonQuantification
#SBATCH -t 5-00:00:00
#SBATCH -C "usage_mail"


module load bioinfo-tools Salmon

cp $1 $TMPDIR/in_1.fq.gz
gunzip $TMPDIR/*

cp $2 $TMPDIR/in_2.fq.gz
gunzip $TMPDIR/*


echo "salmon quant -i $3 -l libtype A -1 $1 -2 $2 --validateMappings -o $4"
salmon quant -i $3 -l A -1 $TMPDIR/in_1.fq -2 $TMPDIR/in_2.fq --validateMappings -o $4

echo done
