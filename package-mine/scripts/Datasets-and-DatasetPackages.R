#!/usr/bin/env Rscript 

# This script will make the table for the package-data joins as well as just the datasets
pkg_data = read.csv("pkg_data.csv") 

print(pkg_data)

pkg_names = unique(pkg_data$package)

pkg_keys = list()

# put in the package keys
for(i in 1:length(pkg_names)){
    pkg_data_subset = pkg_data[pkg_data$package == pkg_names[[i]], ] # subset by package
    pkg_data_subset$pkg_key = i
    pkg_keys[[i]] = pkg_data_subset
    print(i)
}

# Put all packages in a single list
all_pkg_keys = do.call(rbind, pkg_keys)

# move package key to the far left
all_pkg_keys = all_pkg_keys[c(3, 1, 2)] # put keys

# write.csv(linked_packages, "../../seed-data1/only_packages.csv", row.names = FALSE)
print(all_pkg_keys)

# put in data keys
data_names = unique(pkg_data$data_set)

data_keys = list()

# put in the package keys
for(i in 1:length(data_names)){
    pkg_data_subset = all_pkg_keys[all_pkg_keys$data_set == data_names[[i]], ] # subset by package
    pkg_data_subset$data_key = i
    data_keys[[i]] = pkg_data_subset
    print(i)
}

# write joins table
all_keys = do.call(rbind, data_keys)
all_keys$user_id = 0

# inspect housing data as an example
all_keys[all_keys$data_set == "housing", ]

# write joins table with rows as an EXAMPLE only
write.csv(all_keys, "../../seed-data1/all_keys_verbose.csv", row.names = F)

# write joins table with only the numeric indicators AND the dataset name (added recently)
pkg_names = paste0(pkg_data$package, "-", pkg_data$data_set)

only_keys = all_keys[, c("pkg_key", "data_key")]
only_keys = cbind.data.frame(only_keys, pkg_names)

colnames(only_keys) = c("pkg_key", "data_key", "table_name")

# Add seed user key
user_id = rep(0, dim(only_keys)[[1]]) # user ID of 0 is the CRAN
only_keys$user_id = user_id

write.csv(only_keys, "../../seed-data1/DatasetPackages.csv", row.names = FALSE)

# write only table of datasets
only_data = all_keys[, c("data_set", "data_key", "user_id")]
# add date updated
date_modified = "2023-02-13"
reps = dim(only_data)[[1]]
only_data = cbind.data.frame(only_data, rep(date_modified, reps))
colnames(only_data) = c("name", "data_key", "user_id", "date_modified")

# Remove data key since it is now redundant due to unique function
only_data = subset(only_data, select = -c(data_key))

write.csv(unique(only_data), "../../seed-data1/Datasets.csv", row.names = FALSE)

