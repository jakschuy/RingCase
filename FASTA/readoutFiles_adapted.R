Sys.setenv(LANG="en")
rm(list=ls())

library(dplyr)

#Define work environment
setwd(paste(rstudioapi::getSourceEditorContext()$path, "/..", sep = ""))
ProjectName <- "FASTA_Result_output"
input_folder <- "FASTA_Result_input"
A <- 1000000
reference <- 3101804739



#create folder for output graphs
if (!dir.exists(paste(getwd(), "/",ProjectName, "/", sep="")))  {
  dir.create(paste(getwd(), "/", ProjectName, "/", sep=""))     }

#load all samples
if (file.exists(paste(getwd(), "/",ProjectName, "/saveEnvironment_", A, ".RData", sep=""))) {
  load(paste(getwd(), "/",ProjectName, "/saveEnvironment_", A, ".RData", sep=""))} else {
    

#load files
allFiles <- list.files(path = paste(getwd(), "/", input_folder, "/", sep=""), pattern = ".psl")
columnName <- c("match",	"mismatch", "rep.match", "Ns", "QgapCount", "QgapBases", "TgapCount", "TgapBases", "strand", "Qname", "Qsize", "Qstart", "Qend", "Tname", "Tsize", "Tstart", "Tend", "blockCount", "blockSizes", "qStarts", "tStarts")

i<-1
for (i in 1:length(allFiles)) {
  #test for empty files
  emptyFile <- read.delim(file = paste(getwd(), "/", input_folder, "/", allFiles[i], sep=""),nrows = 10, header = FALSE)
  emptyFile_logical <- ifelse(nrow(emptyFile)<=5, yes = "empty", no = "notempty")
  
  #arrange empty df
  if (emptyFile_logical == "empty") {
  subdat <- as.data.frame(matrix(nrow = 1, ncol = length(columnName[c(2:8,10)]), data = "empty"))
  }else{
  #load non-empty files  
  subdat <- read.delim(file = paste(getwd(), "/", input_folder, "/", allFiles[i], sep=""), skip = 5, header = FALSE)[,c(2:8, 10)]
  }
  
  #label and annotate
  colnames(subdat) <- columnName[c(2:8,10)]
  subdat_identifier <- strsplit(allFiles[i], "_")
  subdat_identifier <- sapply(subdat_identifier, function (x) x[2])
  subdat$File <- subdat_identifier
  
  
  #filter against imperfect hits
  subdat <- subdat[subdat$mismatch==0 | subdat$mismatch=="empty", names(subdat)!="mismatch"]
  subdat <- subdat[subdat$rep.match==0 | subdat$rep.match=="empty", names(subdat)!="rep.match"]
  subdat <- subdat[subdat$Ns==0 | subdat$Ns=="empty", names(subdat)!="Ns"]
  subdat <- subdat[subdat$QgapCount==0 | subdat$QgapCount=="empty", names(subdat)!="QgapCount"]
  subdat <- subdat[subdat$QgapBases==0 | subdat$QgapBases=="empty", names(subdat)!="QgapBases"]
  subdat <- subdat[subdat$TgapCount==0 | subdat$TgapCount=="empty", names(subdat)!="TgapCount"]
  subdat <- subdat[subdat$TgapBases==0 | subdat$TgapBases=="empty", names(subdat)!="TgapBases"]
  

  #save to environment
  assign(x = allFiles[i], value = subdat)
  
  #clear memory
  gc()
}

#clean environment
remove(subdat, subdat_identifier, emptyFile, emptyFile_logical, columnName, i, allFiles)

#save environment for processed data
save.image(file = paste(getwd(), "/",ProjectName, "/saveEnvironment_", A, ".RData", sep=""))

#close load command
}



#collect all loaded files, 
  #table: group Qnames to files -> excludes duplicates
  #save non-duplicated Qname per Lx in dat_all
dat_all <- vector()
while (length(ls(pattern = ".psl")) > 0) {
  
  dat_all <- rbind(dat_all, as.data.frame(table(do.call(rbind, mget(ls(pattern = ".psl")[1]))))[,-3])
  remove(list=ls(pattern = ".psl")[1])
  
  #clear memory
  gc()
}

#count sequences per File
dat_counted <- dat_all %>% 
  group_by(File, add = TRUE) %>%
  summarise(counted = sum(as.character(Qname) != "empty"))

#add FDR
dat_counted$FDR <- dat_counted$counted / A

#save table
write.table(x = dat_counted, file = paste(getwd(), "/",ProjectName, "/FASTA_Result_counted_", A, ".csv", sep=""), sep = ";", row.names = FALSE, quote = FALSE)

#save environment for processed data
save.image(file = paste(getwd(), "/",ProjectName, "/saveEnvironment_processed", A, ".RData", sep=""))

#prepare dable for binomail test
dat_binomial <- dat_counted
dat_binomial$Length <- strsplit(as.character(dat_binomial$File), "L")
dat_binomial$Length <- as.numeric(sapply(dat_binomial$Length, function (x) x[2]))

#Binomial test
i<-1
dat_binomial$pval <- NA
dat_binomial$CI <- NA
dat_binomial$nullVal <- NA

for (i in 1:length(dat_binomial$File)){
  subdat_test <- binom.test(1, 1, dat_binomial$FDR[i], alternative="greater")
  dat_binomial[i,"pval"] <- subdat_test$p.value
  dat_binomial[i,"CI"] <- paste(subdat_test$conf.int, collapse = ",")
  dat_binomial[i,"nullVal"] <- subdat_test$null.value
  
}

#save table
write.table(x = dat_binomial, file = paste(getwd(), "/",ProjectName, "/FASTA_Result_FDR_", A, ".csv", sep=""), sep = ";", row.names = FALSE, quote = FALSE)

