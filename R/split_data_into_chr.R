split_data_into_chr <- function(dat, chr_col="CHR",  output_dir) {

  data.table::setnames(dat,chr_col,"CHR")
  stopifnot("No chromosome column found" = c("CHR") %in% names(dat))
  stopifnot("Dat should be a data.table" = inherits(dat, 'data.table'))

  if(!all(dat$CHR %in% c(as.character(1:22),"X","Y"))) {
    warning("chromosome coding issue; will attempt recoding e.g.")
    print(dat[which(!dat$CHR %in% c(as.character(1:22),"X","Y"))[[1]], ])
    dat[, CHR := as.character(CHR)]
    dat[, CHR := ifelse(CHR=="23","X",ifelse(CHR=="24","Y",CHR))]
  }
  stopifnot("CHR column contains values other than 1:22|X|Y" = all(dat$CHR %in% c(as.character(1:22),"X","Y")))

  chr_list <- split(dat, by="CHR")

  for(i in seq_along(chr_list)) {

    file_name <- paste0("chr",names(chr_list)[i],".fst") #.RDS
    file_path <- file.path(output_dir, file_name)
    fst::write_fst(chr_list[[i]], file_path, compress=100)
    #
    # saveRDS(chr_list[[i]], file=file_path)

  }

  return(chr_list)

}
