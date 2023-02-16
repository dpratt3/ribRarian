#!/usr/bin/env Rscript

pkg_data = read.csv("pkg_data.csv")

head(pkg_data) # inspect 

data_set_length = length(pkg_data$data_set)

# firt, assign null values a key of 0
pkg_data$key[pkg_data$data_set == "null"] = 0

for(i in 1:data_set_length){
    data_set = pkg_data$data_set[[i]]
    print(data_set)
}   

package_data$data_set[[1]]

# Look at mushroom, housing, credit (for seeding)




