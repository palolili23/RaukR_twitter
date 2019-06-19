## function for creating twitter name worldcloud
## funciton take two arguments, input is twitter data; var_name is variable/column data

library(rtweet)
library(tibble)
library(ggplot2)
library(tm)
library(wordcloud)
library(wordcloud2)
library(RColorBrewer)

rt.df.ording=function(input,var_name){
  input=as.data.frame(input)
  rt.df=as.data.frame(table(input[,var_name]))
  names(rt.df)[1]=var_name
  rt.df.ord=rt.df[order(rt.df[,"Freq"],decreasing=T),]
  if (var_name=="source"){
    rt.df.ord[,var_name]=factor(rt.df.ord[,var_name],
                                levels=c(as.character(rt.df.ord[,var_name])))
  }
  if (var_name=="name"){
    r.name.clean=gsub("[^[:alnum:][:blank:]?&/\\-]", "", rt.df.ord[,var_name])
    rt.df.ord[,var_name]=r.name.clean
    names(rt.df.ord)=c("word","freq")
    # row.names(rt.df.ord)=rt.df.ord[,var_name]
  }
  
  return(rt.df.ord)
}

R.name=rt.df.ording(rt.R,"name")
Python.name=rt.df.ording(rt.python,"name")