## code to prepare `gwas_hba1c_jurgens2022` dataset goes here

# HbA1c GWAS from Shah et al. HERMES HF incidence sumstats downloaded from the KnowledgePortal
hfinc_gwas <- "/Users/xx20081/Downloads/humgen/diabetes2/users/mvg/portal/MI/ftp/HERMES_Jan2019_HeartFailure_summary_data.txt"

# mapping of the column names
mapping <- list(
  RSID = "SNP",
  CHR  = "CHR",
  BP   = "BP",
  EA   = "A1",
  OA   = "A2",
  EAF  = "freq",
  P    = "p",
  BETA = "b",
  SE   = "se"
)

# standardise and add / top up RSID values
dat = genepi.utils::standardise_gwas(hfinc_gwas, mapping, drop=TRUE, fill=TRUE, build="GRCh37", populate_rsid=FALSE)#"b37_dbsnp156")

# the data directory to output to
output_dir <- system.file("extdata", "gwas", "hf_shah2020", package="TargetExplorerData")

# check split and save into the output dir
chr_list <- split_data_into_chr(dat, output_dir)

