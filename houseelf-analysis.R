#this takes data on house elf dna and ear length and assigns them to groups
#based on ear length, and calculates the gc content for house elf dna

get_data<-function(){
  data<-read.csv("surveys.csv")
  return(data)
}
