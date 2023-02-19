#!/usr/bin/env Rscript 

# titanic

titanic_pkgs = c(
                "causaldata",
                "fdm2id",
                "COUNT",
                "lgrdata",
                "DALEX",
                "socviz",
                "Przewodnik",
                "radiant.data",
                "prettyglm",
                "mlr3data",
                "Rmixmod",
                "FFTrees",
                "RMixtComp",
                "CornerstoneR",
                "msme",
                "ggmosaic",
                "outliertree",
                "UPG",
                "easyalluvial",
                "moreparty",
                "stablelearner",
                "twoxtwo",
                "Stat2Data",
                "resampledata")

# housing
housing_pkgs = c(
                "MASS",
                "openintro",
                "dobson",
                "multgee",
                "randomForestSRC",
                "fasterElasticNet",
                "housingData",
                "A3",
                "lba",
                "BSDA",
                "Ecdat",
                "PSLM2015"
                )
# mushrooms
mushroom_pkgs = c(
                "ggESDA",
                "data.tree",
                "treemisc",
                "greed",
                "ClusterR",
                "mixdir",
                "arules",
                "arulesCBA",
                "cba"
                )

# print(housing_pkgs)
# print(titanic_pkgs)
# print(musrhoom_pkgs)

file_types = c(".rda", ".RData", ".csv")

# load all titanic datasets and write to seed data folder. EXACT MATCHES ONLY. 
for(i in 1:length(titanic_pkgs)){
    for(t in file_types){
        tryCatch({
            path = paste0("../uncompressed-R-packages/", titanic_pkgs[[i]], "/data/titanic", t)
            data = load(file = path)
            write.csv(titanic, paste0("../../seed-data1/data-tables/", titanic_pkgs[[i]], "-titanic.csv"), row.names = FALSE)
        }, error = function(e){
            print(titanic_pkgs[[i]]) # inspect error
        })
    }
}

# # load all housing datasets and write to seed data folder. EXACT MATCHES ONLY. 
for(i in 1:length(housing_pkgs)){
    for(t in file_types){
        tryCatch({
            path = paste0("../uncompressed-R-packages/", housing_pkgs[[i]], "/data/housing", t)
            data = load(file = path)
            write.csv(housing, paste0("../../seed-data1/data-tables/", housing_pkgs[[i]], "-housing.csv"), row.names = FALSE)
        }, error = function(e){
            print(housing_pkgs[[i]]) # inspect error
        })
    }
}

# # load all mushroom datasets and write to seed data folder. EXACT MATCHES ONLY. 
for(i in 1:length(mushroom_pkgs)){
    for(t in file_types){
        tryCatch({
            path = paste0("../uncompressed-R-packages/", mushroom_pkgs[[i]], "/data/mushroom", t)
            data = load(file = path)
            write.csv(mushroom, paste0("../../seed-data1/data-tables/", mushroom_pkgs[[i]], "-mushroom.csv"), row.names = FALSE)
        }, error = function(e){
            print(mushroom_pkgs[[i]]) # inspect error
        })
    }
}


