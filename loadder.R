# import data
benefice = readRDS(file = "data/benefice.rds")

# central nodes
central_nodes = unique(benefice$central_node)

# les dates
all_dates = unique(benefice$date)
all_dates = all_dates[order(all_dates,decreasing = FALSE)]

# startingnode
startingnode = "machine-learning"