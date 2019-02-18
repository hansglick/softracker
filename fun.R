# rm(list=ls())
# 
# datafolder = "C:/Users/Bar Yokhai/Desktop/stackoverflow/powerapp/"
# filename= "benefice.rds"
# pathfilename = paste0(datafolder,filename)
# benefice = readRDS(file = pathfilename)
# 
# 
# 
# # parameters functions
# param_date = "2016-04-21"
# param_central_node = "r"
# param_top_n = 10
# param_bottom_n = 10





# Fonction that build the centralnode df
build_centralnode_df = function(param_central_node,param_top_n,param_bottom_n){
  
  solution = benefice[benefice$central_node==param_central_node,]
  hypest = solution %>%
    group_by(date) %>%
    top_n(n = param_top_n, wt = coefficient)
  hypest <- split( hypest ,f = hypest$date)
  
  worst = solution %>%
    group_by(date) %>%
    top_n(n = (param_bottom_n)*(-1), wt = coefficient)
  worst <- split( worst ,f = worst$date)
  
  result = list(hypest,worst)
  names(result) = c("hypest","worst")
  
  return(result)
}










# Fonction that build bubbles
build_bubbles = function(list_of_df,param_date){
  
  hypest_tags_df = list_of_df$hypest[[param_date]]
  worst_tags_df = list_of_df$worst[[param_date]]
  
  hypest_bubbles = bubbles(value = hypest_tags_df$coefficient,
                           label = hypest_tags_df$voisin,
                           color = hypest_tags_df$tagColor,
                           key = hypest_tags_df$tagID,
                           textColor = hypest_tags_df$tagtextColor
                           )
  worst_bubbles = bubbles(value = worst_tags_df$coefficient,
                           label = worst_tags_df$voisin,
                           color = worst_tags_df$tagColor,
                           key = worst_tags_df$tagID,
                          textColor = worst_tags_df$tagtextColor)
  
  solution = list(hypest_bubbles,worst_bubbles)
  names(solution)=c("hypest","worst")
  return(solution)

}



# list_of_dataframes = build_centralnode_df(param_central_node = "ruby",param_top_n =5 ,param_bottom_n = 10)
# bubbles = build_bubbles(list_of_dataframes,"2016-04-21")

