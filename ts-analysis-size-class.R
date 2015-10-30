get_data<-function(){
  data<-read.csv("surveys.csv")
  return(data)
}

get_data()

get_size_class<-function(weight, threshold){
  if(weight>threshold){
    size_class<-"large"
  }
  else{
    size_class<-"small"
  }
  return(size_class)
}

add_size_class<-function(df){
  data_w_size_class<-
    df %>% 
    na.omit() %>%
    rowise() %>%
    mutate(size_class=get_size_class(weight, 50))
  return(data_w_size_class)
}