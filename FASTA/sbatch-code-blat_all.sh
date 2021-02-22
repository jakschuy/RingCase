#!/bin/bash -l
#SBATCH -A sens2017106
#SBATCH -p core -n 3
#SBATCH -J pblat_JS_v8_paper1mio
#SBATCH -t 8-00:00:00
#SBATCH -C usage_mail

module load bioinfo-tools bwa blat

blat GRCh37.primary_assembly.genome.fa.gz FASTAout_L6_A1000000.fasta FASTAout_L6_A1000000_results_v8_paper.psl -stepSize=3 -tileSize=6 -minScore=6
blat GRCh37.primary_assembly.genome.fa.gz FASTAout_L11_A1000000.fasta FASTAout_L11_A1000000_results_v8_paper.psl -stepSize=3 -tileSize=6 -minScore=11
blat GRCh37.primary_assembly.genome.fa.gz FASTAout_L14_A1000000.fasta FASTAout_L14_A1000000_results_v8_paper.psl -stepSize=4 -tileSize=8 -minScore=14
blat GRCh37.primary_assembly.genome.fa.gz FASTAout_L20_A1000000.fasta FASTAout_L20_A1000000_results_v8_paper.psl -stepSize=5 -tileSize=11 -minScore=20
blat GRCh37.primary_assembly.genome.fa.gz FASTAout_L21_A1000000.fasta FASTAout_L21_A1000000_results_v8_paper.psl -stepSize=5 -tileSize=11 -minScore=21
blat GRCh37.primary_assembly.genome.fa.gz FASTAout_L26_A1000000.fasta FASTAout_L26_A1000000_results_v8_paper.psl -stepSize=5 -tileSize=11 -minScore=26
blat GRCh37.primary_assembly.genome.fa.gz FASTAout_L145_A1000000.fasta FASTAout_L145_A1000000_results_v8_paper.psl -stepSize=5 -tileSize=11 -minScore=145
