#!/bin/bash -l
#SBATCH -A sens2017106
#SBATCH -p core -n 4
#SBATCH -J GATK-ASA
#SBATCH -t 3-00:00:00
#SBATCH -C "usage_mail"


module load bioinfo-tools GATK tabix

echo "Note:reference must be indexed with samtools faidx reference.fa"
echo "Note:reference must be dictionaried with java -jar $PICARD_HOME/picard.jar CreateSequenceDictionary --REFERENCE reference.fa"
echo "Note:bam file must be labelled for duplicates (picard MarkDuplicates) and labelled with ReadGroups (picard AddOrReplaceReadGroups)"
echo "Note:bam file (after picard pipeline) must be indexed"

echo run HaplotypeCaller
echo "gatk -T HaplotypeCaller -R $1 -I $2 -ERC GVCF -G Standard -G AS_Standard > $2.g.GVCF"
gatk \
   -T HaplotypeCaller \
   -R $1 \
   -I $2 \
   -ERC GVCF \
   -G Standard \
   -G AS_Standard \
   | bgzip > $2.g.GVCF.gz

echo index compressed HaplotypeCaller output
echo "tabix -p vcf $2.g.GVCF.gz"
tabix -p vcf $2.g.GVCF.gz

echo run GenotypeGVCF
echo "gatk -T GenotypeGVCFs -R $1 -V $2.g.GVCF.gz > $2.vcf"
gatk  \
   -T GenotypeGVCFs \
   -R $1 \
   -V $2.g.GVCF.gz \
   | bgzip > $2.vcf.gz

echo remove GVCF files
echo "rm $2.g.GVCF.gz $2.g.GVCF.gz.tbi"
rm $2.g.GVCF.gz $2.g.GVCF.gz.tbi


echo done
