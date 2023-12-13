## code to prepare `gencode_gene_annotations` dataset goes here

# download the Release 19 (GRCh37.p13) Comprehensive gene annotation 'GFF3' file
# https://www.gencodegenes.org/human/release_19.html

fp <- "/Users/xx20081/Downloads/gencode.v19.annotation.gff3.gz"

genes <- data.table::fread(fp, skip=7, fill=TRUE, sep="\t")

data.table::setnames(genes, names(genes), c('chromosome','annotation_source','feature_type','start','end','score','strand','phase','additional'))

genes[, chromosome := as.character(sub("chr","",chromosome))]
genes <- genes[chromosome %in% c(as.character(1:22),"X","Y"), ]

genes[, ID := sub(".*ID=(.*?);.*", "\\1", additional)]
genes[, Parent := sub(".*Parent=(.*?);.*", "\\1", additional)]
genes[, gene_id := sub(".*gene_id=(.*?);.*", "\\1", additional)]
genes[, transcript_id := sub(".*transcript_id=(.*?);.*", "\\1", additional)]
genes[, gene_type := sub(".*gene_type=(.*?);.*", "\\1", additional)]
genes[, gene_status := sub(".*gene_status=(.*?);.*", "\\1", additional)]
genes[, gene_name := sub(".*gene_name=(.*?);.*", "\\1", additional)]
genes[, transcript_type := sub(".*transcript_type=(.*?);.*", "\\1", additional)]
genes[, transcript_status := sub(".*transcript_status=(.*?);.*", "\\1", additional)]
genes[, transcript_name := sub(".*transcript_name=(.*?);.*", "\\1", additional)]
genes[, level := sub(".*level=([0-9]*?);.*", "\\1", additional)]

cols <- c(CHR='chromosome',
             SOURCE='annotation_source',
             FEATURE_TYPE='feature_type',
             BP_START='start',
             BP_END='end',
             STRAND='strand',
             GENE_ID="gene_id",
             GENE_TYPE="gene_type",
             GENE_NAME="gene_name",
             TRANSCRIPT_ID="transcript_id",
             TRANSCRIPT_TYPE="transcript_type",
             TRANSCRIPT_NAME="transcript_name")

genes[, names(genes)[!names(genes)%in%cols] := NULL]
data.table::setnames(genes, cols, names(cols))

# the data directory to output to
# output_dir <- system.file("extdata", "genes", "gencode", package="TargetExplorerData")
output_dir <- "/Users/xx20081/git/TargetExplorerData/inst/extdata/genes/gencode"

# check split and save into the output dir
chr_list <- split_data_into_chr(genes, "CHR", output_dir)


