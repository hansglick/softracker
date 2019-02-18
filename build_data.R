rm(list=ls())

# import libraries
library(RColorBrewer)



# update benefice.rds table
datafolder = "C:/Users/Bar Yokhai/Desktop/stackoverflow/app/"
filename = "benefice.rds"
pathfilename = paste0(datafolder,filename)
benefice = readRDS(pathfilename)


# Creation de la palette graphique arc-en-ciel
pal <- colorRampPalette(brewer.pal(n = 11, name = "Spectral"))


# Récupération de tout les tags du monde
tagsA = unique(benefice$central_node)
tagsB = unique(benefice$voisin)
tags=sample(unique(c(tagsA,tagsB)))


# Creation des colonnes
tagID = seq(1,length(tags))
tagColor = pal(length(tags))
tagtextColor = rep("white",length(tagColor))
index_inf = floor(length(tagColor) / 11) * 3 
index_sup = floor(length(tagColor) / 11) * 8 
tagtextColor[index_inf : index_sup] = "black"


# Création du dictionnaire des tags
tags_dic = data.frame("tagID" = tagID,
                      "tagColor" = tagColor,
                      "tag" = tags,
                      "tagtextColor" =tagtextColor, 
                      stringsAsFactors = F)


# Merge avec la table bénéfice
benefice_new = merge(x = benefice,y = tags_dic, all.x = TRUE, by.x = "voisin",by.y = "tag")



# on prend que le top 30 pour l'app
benefice_new = benefice_new %>%
  group_by(central_node,date) %>%
  top_n(n =30,wt = coefficient)


# save le RDS
foldername = "C:/Users/Bar Yokhai/Desktop/stackoverflow/powerapp/"
pathfilename = paste0(foldername,"benefice.rds")
saveRDS(object = benefice_new,file = pathfilename)
