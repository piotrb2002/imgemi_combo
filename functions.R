# library(openxlsx)
# library(purrr)
# library(dplyr)
# library(rlang)
# setwd('C:/Users/pbpol/OneDrive/Dokumenty/NIO/robocze/Zani/ZANI/clinical_database')
# sheet_names <- getSheetNames('IMGEMI_CRF_1.xlsx')
# db <- map(sheet_names, read.xlsx, xlsxFile='IMGEMI_CRF_1.xlsx', startRow=2)
# names(db) <- sheet_names
# 

subjects <- na.omit(db$Main[db$Main$eligible=='Yes', 'subject_id'])
db <- lapply(db, 
    function(frame){frame <- frame[frame$subject_id%in%subjects,]})

get_log <- function(id, log_name){
  log_name_str <- as_string(ensym(log_name))
  frame <- db[[log_name_str]]
  frame[frame$subject_id%in%id,]
}

get_missing <- function(log_name, subj_list=c()){
  if(length(subj_list)==0){
    subj_list <- db$Main$subject_id
    log_name_str <- as_string(ensym(log_name))
    frame <- db[[log_name_str]]
    out <- setdiff(subj_list, frame$subject_id)
  }else{
    log_name_str <- as_string(ensym(log_name))
    frame <- db[[log_name_str]]
    out <- setdiff(subj_list, frame$subject_id)
  }
  out
}




