#!/bin/bash -l
#SBATCH -A sens2017106
#SBATCH -p core -n 16
#SBATCH -J SalmonQuantification
#SBATCH -t 5-00:00:00
#SBATCH -C "usage_mail"


module load bioinfo-tools Salmon


echo "salmon quant -i $3 -l libtype A -1 $1 -2 $2 --validateMappings -o $4"
salmon quant -i $3 -l A -1 $1 -2 $2 --validateMappings -o $4

echo done
