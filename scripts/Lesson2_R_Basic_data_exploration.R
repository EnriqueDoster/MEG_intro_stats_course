##### Set up environment
library("dplyr");packageVersion("dplyr")
library("ggplot2");packageVersion("ggplot2")
library("ggpubr");packageVersion("ggpubr")
path.data = "../Data/Objects"
path.figures = "../Figures"
path.rds = "../RDS"
##### Load phyloseq object
ps <- readRDS(file.path(path.data, "ps.sdct.rds"))
ps
##### Agglomerate ASVs to phylum rank
ps.phylum <- tax_glom(ps, "Phylum")
ps.phylum
##### Estimate richness and diversity
plot_richness(ps.phylum, x = Category1, color = Category 2, measures = c("Observed", "Shannon", "InvSimpson")) +
  geom_boxplot() +
  facet_wrap(~CategoryX, scales = "free_x")
##### Convert OTU abundances to relative abundances
ps.phylum.rel <- transform_sample_counts(ps.phy, function(x) x / sum(x) )
ps.phylum.rel
##### Convert phyloseq object to data.frame
ps.phylum.melt <- psmelt(ps.phylum.rel)
head(ps.phylum.melt)
##### Plot phyla abundances
plot.phylum <- ggplot(ps.phylum.melt, aes(x = Category1, y = Category2, fill = Phylum)) +
  geom_bar(stat = "identity") +
  facet_wrap(~Category1) +
  theme_bw()
##### Save plot to figures directory
ggsave(file.path(path.figures, "phylum.abundance.png"), plot.phylum)