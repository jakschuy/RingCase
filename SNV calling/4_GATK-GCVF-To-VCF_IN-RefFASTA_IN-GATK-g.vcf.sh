#!/bin/bash -l
#SBATCH -A sens2017106
#SBATCH -p core -n 4
#SBATCH -J GATK-VCF
#SBATCH -t 3-00:00:00
#SBATCH -C "usage_mail"


module load bioinfo-tools GATK tabix

echo Note! this is used on GATK GVCF outputs, after HaplotypeCaller, before compressing!

echo compressing output
bgzip $2

echo indexing compressed output
tabix -p vcf $2.gz

echo running GenotypeGVCF
gatk  \
   -T GenotypeGVCFs \
   -R $1 \
   -V $2.gz \
   | bgzip > $2.vcf.gz

echo removing temp files
rm $2.gz $2.gz.tbi

echo "done, output is called $2.vcf.gz"
