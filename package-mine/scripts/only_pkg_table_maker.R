#!/usr/bin/env Rscript 

# This script will make the table for 
pkg_data = read.csv("pkg_data.csv")
# print(pkg_data)

 # https://cran.r-project.org/web/packages/mcr/

# make packages with link
canonical_link = "https://CRAN.R-project.org/package="
only_pkgs = unique(pkg_data$package)

# put links in after checking to make sure that they're not dead
# Addapted from: https://stackoverflow.com/questions/52911812/check-if-url-exists-in-r

valid_url <- function(url_in,t=2){
  con <- url(url_in)
  check <- suppressWarnings(try(open.connection(con,open="rt",timeout=t),silent=T)[1])
  suppressWarnings(try(close.connection(con),silent=T))
  ifelse(is.null(check),TRUE,FALSE)
}

links = vector()

# check each URL and write "null" if they don't work
for(i in 1:length(only_pkgs)){
    url = paste0(canonical_link, only_pkgs[[i]])
    if(valid_url(url)){
        links[[i]] = url
    } else {
        links[[i]] = "null"
    }
    print(i)
}

# put links and packages together, along with date modified
date_modified = rep("2023-02-13", length(only_pkgs))
linked_packages = cbind.data.frame(only_pkgs, links, date_modified)

write.csv(linked_packages, "../../seed-data1/Packages.csv", row.names = FALSE)



