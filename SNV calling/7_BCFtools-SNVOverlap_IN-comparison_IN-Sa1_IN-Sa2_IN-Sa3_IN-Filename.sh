#!/bin/bash -l
#SBATCH -A sens2017106
#SBATCH -p core -n 2
#SBATCH -J bcftools
#SBATCH -t 3-00:00:00
#SBATCH -C "usage_mail"


module load bioinfo-tools bcftools tabix

echo "bcftools isec --nfiles ~$1 $2 $3 $4 > $5.vcf"
bcftools isec --nfiles ~$1 $2 $3 $4 > $5.vcf

echo "bgzip $5.vcf"
bgzip -f $5.vcf

echo "done"
