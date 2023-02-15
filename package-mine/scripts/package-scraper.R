# https://stackoverflow.com/questions/39051381/how-to-download-the-entire-cran-repository

pkgnames <- available.packages()[,1]

library(rvest)
pkgs <- read_html("https://cran.r-project.org/web/packages/available_packages_by_name.html")
tab <- html_nodes(pkgs, "table") %>% html_table(fill = TRUE)

pkgnames <- tab[[1]][1]$X1
pkgnames <- pkgnames[nchar(pkgnames)>0]

sapply(pkgnames, download.packages, destdir = "/home/david/git/app-academy/capstone/R-packages")

# sapply(pkgnames, install.packages, dependencies = TRUE,  destdir = "/home/david/git/app-academy/capstone/R-packages")
# for(i in 1: length(pkgnames)}{
#     install.packages(pkgnames[i], dependencies = TRUE)
# }

### Datasets available in all packages:
# https://stats.oarc.ucla.edu/r/faq/how-can-i-see-what-data-sets-are-available-when-i-start-r/
# data(package = .packages(all.available = TRUE))

# Data in a particular package
# data(package = "A3")

# R packages that share data: https://r-pkgs.org/data.html

