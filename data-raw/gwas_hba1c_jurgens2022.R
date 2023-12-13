## code to prepare `gwas_hba1c_jurgens2022` dataset goes here

# HbA1c GWAS from Jurgens et al. (PMID: 35177841)
hba1c_gwas <- "/Users/xx20081/Documents/local_data/Jurgens_Pirruccello_2022_GWAS_Sumstats/GWAS_sumstats/GWAS_sumstats_EUR__invnorm_glycatedhaemoglobinhba1c__TOTALsample.tsv.gz"

# mapping of the column names
mapping <- list(
  SNP = "SNP",
  CHR  = "CHR",
  BP   = "BP",
  EA   = "ALLELE1",
  OA   = "ALLELE0",
  EAF  = "A1FREQ",
  P    = "P",
  BETA = "BETA",
  SE   = "SE"
)

# standardise and add / top up RSID values
dat = genepi.utils::standardise_gwas(hba1c_gwas, mapping, drop=TRUE, fill=TRUE, build="GRCh37", populate_rsid="b37_dbsnp156")
dat[is.na(RSID)|RSID=="", RSID := paste0(CHR,":",BP,"[b37]",OA,",",EA)]

# the data directory to output to
output_dir <- system.file("extdata", "gwas", "hba1c_jurgens2022", package="TargetExplorerData")

# check split and save into the output dir
chr_list <- split_data_into_chr(dat, output_dir)

