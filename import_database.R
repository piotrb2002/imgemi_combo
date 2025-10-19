library(openxlsx)
library(purrr)
setwd('C:/Users/pbpol/OneDrive/Dokumenty/NIO/robocze/Zani/ZANI/clinical_database')
files <- list.files()
files <- files[-which(files=='legend.txt')]

sheet_names <- getSheetNames('IMGEMI_CRF_1.xlsx')
sheet_names <- sheet_names[-which(sheet_names=='molecular_log')]
sheets <- map(sheet_names, function(sheet_name){
  map(files, read.xlsx, sheet = sheet_name, startRow=2)
})

sheet_colnames <- lapply(sheets, lapply, colnames)

lapply(sheet_colnames, function(para) {
  setdiff(union(para[[1]], para[[2]]), intersect(para[[1]], para[[2]]))
})

setwd('C:/Users/pbpol/OneDrive/Dokumenty/NIO/robocze/medstat/projects/imgemi')