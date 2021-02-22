
#start of loop
for files in $(ls /proj/sens2017106/delivery01267/INBOX/P10052/P*/ -d)
do


#define variables
fq1=$files/02-FASTQ/180725_A00187_0051_AH3CJJDRXX/$(ls $files/02-FASTQ/180725_A00187_0051_AH3CJJDRXX | head -n 1)
fq2=$files/02-FASTQ/180725_A00187_0051_AH3CJJDRXX/$(ls -r $files/02-FASTQ/180725_A00187_0051_AH3CJJDRXX | head -n 1)
filefolder=$(basename $files)

echo "$fq1"
echo "$fq2"
echo "$filefolder"

#start batch
sbatch SalmonQuantMappingMode_IN-FQ1_IN-FQ2_IN-RefIndexed_OUT-Name.sh \
	$fq1 \
	$fq2 \
	/proj/sens2017106/nobackup/wharf/jaksch/jaksch-sens2017106/play/Salmon-on-hg38-ali9-rnaSeq/gencode.v36.transcripts.fa_index \
	$filefolder \

done
