#!/bin/bash -l
#SBATCH -A sens2017106
#SBATCH -p core -n 5
#SBATCH -J SalmonBuildRefIndex
#SBATCH -t 5-00:00:00
#SBATCH -C "usage_mail"


module load bioinfo-tools Salmon


echo "salmon index -t $1 -i $1_index --genocde -k 31"
salmon index -t $1 -i $1_index --gencode -k 31

echo done