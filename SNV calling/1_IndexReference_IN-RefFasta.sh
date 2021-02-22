#!/bin/bash -l
#SBATCH -A sens2017106
#SBATCH -p core -n 8
#SBATCH -J Picard
#SBATCH -t 1-00:00:00
#SBATCH -C "usage_mail"


module load bioinfo-tools picard samtools

echo "samtools faidx $1"
samtools faidx $1

echo "java -jar $PICARD_HOME/picard.jar CreateSequenceDictionary --REFERENCE $1"
java -jar $PICARD_HOME/picard.jar \
	CreateSequenceDictionary \
	--REFERENCE $1

echo done
