library(vegan)
library(ggplot2)
library(stringr)

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
g_c_content(he_data$dnaseq)


