
options(scipen=999)
library(seqinr)

#Define work environment
setwd(paste(rstudioapi::getSourceEditorContext()$path, "/..", sep = ""))

#How many DNA sequences?
Vlength <- 19
Vamount <- 1000000

#Define DNA Structure
Nucleotides <- c("A", "T", "C", "G")

#prepare vector
Vnumbers <- rep(NA, Vamount)

#Generate numbers
for (i in 1:Vamount) {
  Vnumbers[i] <- paste(sample(Nucleotides,Vlength,replace = TRUE), collapse = "")
}

#Generate unique names for each sequence
Names <- paste("seq", 1:Vamount, sep = "")

#Save sequences in a fasta file
write.fasta(as.list(Vnumbers), names = Names, file.out = paste("FASTAout_L",Vlength,"_A", Vamount, ".fasta", sep = ""))


