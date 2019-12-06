#By Yuhan Fei
library(BiocManager)
library(biomaRt)
library(Sushi)

samples <- c('P0_No_injection', 'P0_pGC', 'P0_pUG')

for (sample in samples) {
  file_rev <- sprintf("data/%s.norm.reverse.bedGraph", sample)
  cat("Reading in",file_rev, "\n")
  var_rev <- sprintf("%s.norm.reverse.bedGraph", sample)
  assign(var_rev, read.table(file_rev, header=F, sep="\t", colClasses = c("factor", "integer", "integer", "numeric")))
  
  col_names <- c("chrom", "start", "stop", "score")
  for (i in 1:4) {
    eval(parse(text = sprintf("colnames(%s)[%s] <- col_names[%s]", var_rev, i, i)))
  } 
}
colors <- c("maroon3", "darkcyan", "coral2", "royalblue")
 
mart = useMart("ensembl", dataset="celegans_gene_ensembl")


tiff("22G_antisense_P0_R2.tiff", width = 10, height = 6, units = 'in', res = 300)
layout(matrix(c(1,1,1,1,1,1,
        2,2,2,2,2,2,
        3,3,3,3,3,3,
        4,4,4,4,4,4,
        5,5,5,5,5,5),5,6,byrow = TRUE))

par(mar=c(1,4,1,4))

chrom = "IV"
chromstart = 8889086 #
chromend = 8889805.000001 #

geneinfo = getBM(attributes = c("chromosome_name","exon_chrom_start","exon_chrom_end","external_gene_name","strand"), filters = c("chromosome_name","start","end"), values = list(chrom,chromstart,chromend), mart = mart)


names(geneinfo) = c("chrom","start","stop","gene","strand")
geneinfo$score = "."
geneinfo = geneinfo[,c(1,2,3,4,6,5)]


geneinfo_noUTR <- geneinfo[-c(5,6), ]
geneinfo_noUTR$start[1] <- 8889086
geneinfo_noUTR$stop[4] <- 8889805

geneinfo_pUG <- geneinfo[-c(5,6), ]
geneinfo_pUG$start[1] <- 8889086
geneinfo_pUG$stop[4] <- 8889787


pg2 = plotGenes(geneinfo_noUTR, chrom=chrom, chromstart=chromstart, chromend=chromend, col="grey24", bheight=0.05, plotgenetype="box",bentline=FALSE,labeltext=FALSE)

pg3 = plotGenes(geneinfo_pUG, chrom=chrom, chromstart=chromstart, chromend=chromend, col="grey24", bheight=0.05, plotgenetype="box",labeltext=FALSE)

plotBedgraph(P0_No_injection.norm.reverse.bedGraph, chrom, chromstart, chromend, color=colors[4], range=c(0,800))
ticks <- pretty(par("yaxp")[c(1,2)])
tick_labs <- c(ticks[1], tail(ticks, 1))
axis(side=2, las=2, tcl=-0.2, at=tick_labs, tcl=-0.2, cex.axis=1, mgp=c(3, 0.3, 0))
plotBedgraph(P0_pGC.norm.reverse.bedGraph, chrom, chromstart, chromend, color=colors[1], range=c(0,800))
ticks <- pretty(par("yaxp")[c(1,2)])
tick_labs <- c(ticks[1], tail(ticks, 1))
axis(side=2, las=2, tcl=-0.2, at=tick_labs, tcl=-0.2, cex.axis=1, mgp=c(3, 0.3, 0))
plotBedgraph(P0_pUG.norm.reverse.bedGraph, chrom, chromstart, chromend, color=colors[2], range=c(0,800))
ticks <- pretty(par("yaxp")[c(1,2)])
tick_labs <- c(ticks[1], tail(ticks, 1))
axis(side=2, las=2, tcl=-0.2, at=tick_labs, tcl=-0.2, cex.axis=1, mgp=c(3, 0.3, 0))

dev.off()
