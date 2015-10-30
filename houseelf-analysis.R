library(vegan)
library(ggplot2)
library(stringr)
library(dplyr)

#1: done

#2
#this takes data on house elf dna and ear length and assigns them to groups
#based on ear length, and calculates the gc content for house elf dna

#3
#import data into R
he_data<-read.csv("data/houseelf_earlength_dna_data.csv", head=TRUE, sep=",")
head(he_data)

#4: change data to import data_1 file
he_data<-read.csv("data/houseelf_earlength_dna_data_1.csv", head=TRUE, sep=",")
head(he_data)


#5: done

#6: function to calculate GC content, regardless of sequence case
g_c_content<-function(dnaseq){
  upper<-str_to_upper(dnaseq)
  Gs<-str_count(upper, 'G')
  Cs<-str_count(upper, 'C')
  gc_content<-(Gs + Cs)/str_length(upper)*100
  return(gc_content)
}

#7
get_size_class <- function(seq){
   #Calculate the GC-content for one or more sequences
   ear_lengths <- ifelse(seq > 10, "large", "small")
   return(ear_lengths)
}

make_df_gc_earlength<-function(df){
  df %>%
  mutate(gc = g_c_content(dnaseq)) %>%
  mutate(ear_length=get_size_class(earlength)) %>%
  subset(select=-c(earlength, dnaseq)) %>%
  write.csv(file="grangers_analysis.csv", quote=FALSE)
}

make_df_gc_earlength(he_data)


