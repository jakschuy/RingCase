#!/bin/bash -l
#SBATCH -A sens2017106
#SBATCH -p core -n 2
#SBATCH -J PicardGatherVCF
#SBATCH -t 3-00:00:00
#SBATCH -C "usage_mail"


module load bioinfo-tools picard tabix



java -jar $PICARD_HOME/picard.jar GatherVcfs \
      --INPUT $1_chr1.bam_marked_duplicated.ReadGroups.bam.vcf.gz \
      --INPUT $1_chr2.bam_marked_duplicated.ReadGroups.bam.vcf.gz \
      --INPUT $1_chr3.bam_marked_duplicated.ReadGroups.bam.vcf.gz \
      --INPUT $1_chr4.bam_marked_duplicated.ReadGroups.bam.vcf.gz \
      --INPUT $1_chr5.bam_marked_duplicated.ReadGroups.bam.vcf.gz \
      --INPUT $1_chr6.bam_marked_duplicated.ReadGroups.bam.vcf.gz \
      --INPUT $1_chr7.bam_marked_duplicated.ReadGroups.bam.vcf.gz \
      --INPUT $1_chr8.bam_marked_duplicated.ReadGroups.bam.vcf.gz \
      --INPUT $1_chr9.bam_marked_duplicated.ReadGroups.bam.vcf.gz \
      --INPUT $1_chr10.bam_marked_duplicated.ReadGroups.bam.vcf.gz \
      --INPUT $1_chr11.bam_marked_duplicated.ReadGroups.bam.vcf.gz \
      --INPUT $1_chr12.bam_marked_duplicated.ReadGroups.bam.vcf.gz \
      --INPUT $1_chr13.bam_marked_duplicated.ReadGroups.bam.vcf.gz \
      --INPUT $1_chr14.bam_marked_duplicated.ReadGroups.bam.vcf.gz \
      --INPUT $1_chr15.bam_marked_duplicated.ReadGroups.bam.vcf.gz \
      --INPUT $1_chr16.bam_marked_duplicated.ReadGroups.bam.vcf.gz \
      --INPUT $1_chr17.bam_marked_duplicated.ReadGroups.bam.vcf.gz \
      --INPUT $1_chr18.bam_marked_duplicated.ReadGroups.bam.vcf.gz \
      --INPUT $1_chr19.bam_marked_duplicated.ReadGroups.bam.vcf.gz \
      --INPUT $1_chr20.bam_marked_duplicated.ReadGroups.bam.vcf.gz \
      --INPUT $1_chr21.bam_marked_duplicated.ReadGroups.bam.vcf.gz \
      --INPUT $1_chr22.bam_marked_duplicated.ReadGroups.bam.vcf.gz \
      --INPUT $1_chrX.bam_marked_duplicated.ReadGroups.bam.vcf.gz \
      --INPUT $1_chrY.bam_marked_duplicated.ReadGroups.bam.vcf.gz \
      --INPUT $1_chrM.bam_marked_duplicated.ReadGroups.bam.vcf.gz \
      --OUTPUT $1.merge.vcf


echo "bgzip $1.merge.vcf"
bgzip -f $1.merge.vcf
echo "tabix -p vcf $1.merge.vcf.gz"
tabix -p vcf $1.merge.vcf.gz



done
