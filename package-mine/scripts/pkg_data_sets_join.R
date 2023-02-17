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

# write.csv(linked_packages, "../../seed-data/only_packages.csv", row.names = FALSE)
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
write.csv(all_keys, "../../seed-data/all_keys_verbose.csv", row.names = F)

# write joins table with only the numeric indicators
only_keys = all_keys[, c("pkg_key", "data_key")]
write.csv(only_keys, "../../seed-data/pkg_data_joins.csv", row.names = FALSE)

# write only table of datasets
only_data = all_keys[, c("data_set", "data_key", "user_id")]
# add date updated
date_modified = "2023-02-13"
reps = dim(only_data)[[1]]
only_data = cbind.data.frame(only_data, rep(date_modified, reps))
colnames(only_data) = c("data_set", "data_key", "user_id", "date_modified")

write.csv(only_data, "../../seed-data/data_keys.csv", row.names = FALSE)

