#!/bin/bash -l
#SBATCH -A sens2017106
#SBATCH -p core -n 8
#SBATCH -J bamtoolsSplit
#SBATCH -t 5-00:00:00
#SBATCH -C "usage_mail"


module load bioinfo-tools bamtools

echo "bamtools split -in $1 -reference"
bamtools split -in $1 -reference