#!/bin/bash -l
#SBATCH -A sens2017106
#SBATCH -p core -n 6
#SBATCH -J Picard
#SBATCH -t 5-00:00:00
#SBATCH -C "usage_mail"


module load bioinfo-tools picard samtools


echo "java -jar $PICARD_HOME/picard.jar MarkDuplicates --INPUT=$1 --OUTPUT=$1_marked_duplicates.bam --METRICS_FILE=$1_marked_dup_metrics.txt"
java -jar $PICARD_HOME/picard.jar MarkDuplicates \
      INPUT=$1 \
      OUTPUT=$1_marked_duplicates.bam \
      METRICS_FILE=$1_marked_dup_metrics.txt

echo "java -jar $PICARD_HOME/picard.jar AddOrReplaceReadGroups I=$1_marked_duplicates.bam O=$1_marked_duplicated.ReadGroups.bam RGID=4 RGLB=lib1 RGPL=illumina RGPU=unit1 RGSM=20"
java -jar $PICARD_HOME/picard.jar AddOrReplaceReadGroups \
      I=$1_marked_duplicates.bam \
      O=$1_marked_duplicated.ReadGroups.bam \
      RGID=4 \
      RGLB=lib1 \
      RGPL=illumina \
      RGPU=unit1 \
      RGSM=20

echo "samtools index $1_marked_duplicated.ReadGroups.bam"
samtools index $1_marked_duplicated.ReadGroups.bam

echo "rm $1_marked_duplicates.bam $1_marked_dup_metrics.txt"
rm $1_marked_duplicates.bam $1_marked_dup_metrics.txt

echo done
