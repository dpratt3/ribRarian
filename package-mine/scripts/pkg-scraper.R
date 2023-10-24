#!/usr/bin/env Rscript 
# https://stackoverflow.com/questions/39051381/how-to-download-the-entire-cran-repository

pkgnames <- available.packages()[,1]

library(rvest)
pkgs <- read_html("https://cran.r-project.org/web/packages/available_packages_by_name.html")
tab <- html_nodes(pkgs, "table") %>% html_table(fill = TRUE)

pkgnames <- tab[[1]][1]$X1
pkgnames <- pkgnames[nchar(pkgnames)>0]

sapply(pkgnames, download.packages, destdir = "./package-mine/compressed-R-packages")
