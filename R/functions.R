
clean_data <- function(df){
  
  dfnew <- df[complete.cases(df[,c("state", "shape", "lat", "lon")]),]
 
   dfnew <- dfnew %>% 
    mutate_at(c("lat", "lon"), as.numeric) %>% 
    mutate_at(c("shape", "state"), as.factor) %>% 
    mutate(date = as_date(date, format = "%m/%d/%Y"))
  
  return(dfnew)
}

plot_data <- function(df){
  
  df$yearmon <- zoo::as.yearmon(df$date)
  
  df_counts <- df %>% 
    group_by(yearmon) %>% 
    summarize(n=n())
  
  plt <- ggplot(df_counts, aes(x = yearmon, y = n)) +
    geom_line() +
    xlab("") + 
    ylab("# of UFO Reports") + 
    theme_classic() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
    
  return(plt)
}
