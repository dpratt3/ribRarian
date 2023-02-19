#!/usr/bin/env Rscript 
date_updated = "2023-02-13" # hardcoded for now

pkg_list = list.files(path = "../uncompressed-R-packages")

# print(pkg_list)

# example_idx <- which(pkg_list == "MASS")
# print(example_idx)

# example_idx = 17 # a different example

package_data = list()

null_data_sets = 0 # count the number of packages that are null

for(p in 1:length(pkg_list)){
    
    # print names of data files associated with each package
    data_files <- list.files(path = paste0("../uncompressed-R-packages/", pkg_list[[p]], "/data")) # example_idx
    data_files <- sub(".rda", "", c(data_files), fixed = TRUE) 
    data_files <- sub(".RData", "", c(data_files), fixed = TRUE )
    data_files <- sub(".txt.gz", "", c(data_files), fixed = TRUE )
    data_files <- sub(".csv", "", c(data_files), fixed = TRUE )
    data_files <- sub(".tab.gz", "", c(data_files), fixed = TRUE )
    data_files <- sub(".R", "", c(data_files), fixed = TRUE )
    
    # print( length(data_files) ) # how many data sets exist in particular pkg?
    reps = length(data_files)

    # stop packages with no data from being deleted
    if(reps == 0){
        reps = 1
        data_files = "null"
        null_data_sets = null_data_sets + 1
    } 

    # create relationship between package and data sets
    package_data[[p]] = cbind.data.frame( rep(pkg_list[[p]], reps),  data_files ) # example_idx
    print(p)
}

# Put all packages together 
pkg_data = do.call(rbind, package_data)
colnames(pkg_data) = c("package", "data_set")

# make sure all empty values are coded to null
pkg_data$data_set[pkg_data$data_set == ""] = "null"

# write csv for inspection purposes
pkg_data = as.data.frame(pkg_data)
pkg_data =  pkg_data[order(pkg_data$data_set), ]
write.csv(pkg_data, "pkg_data.csv", row.names = FALSE)

# measure length of unique values
length(unique(pkg_data$package)) # only about 8,000 or so of these have associated data
length(unique(pkg_data$data_set)) # <--- Number of uniquely named datasets, including null
length(unique(pkg_data$data_set)) - null_data_sets # Number of non-null packages (around 28,000)
print(null_data_sets) # <--- number of packages with no data (around 10,000)

# Write packages table

# Write datasets table

# Create numeric joins table 

