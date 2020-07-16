## Don't peak!
# Try doing Lesson 2 step 2 on your own first, but if you are struggling you can find the answers below

# You can find more information about changing the color in plots here:
# http://www.cookbook-r.com/Graphs/Colors_(ggplot2)/

##### Set up environment
library("phyloseq")
library("dplyr")
library("ggplot2")
library("data.table")
library("tidyr")
library("forcats")
library("vegan")


# Load the data
source("./scripts/load_data.R")

#
##
### Lesson 2 step 2 deliverable - figure 1
##
#

## Creating boxplot at AMR mechanism level
mechanism_amr.ps <- tax_glom(amr.ps, "mechanism")
# Calculate diversity values
mechanism_amr_shotgun_diversity_values <- estimate_richness(mechanism_amr.ps)
# Add SeqType, DataType, and Sample columns
mechanism_amr_shotgun_diversity_values <- mechanism_amr_shotgun_diversity_values %>%
  mutate(SeqType = "shotgun", DataType = "resistome", Sample = row.names(mechanism_amr_shotgun_diversity_values))

# Add metadata
mechanism_amr_shotgun_diversity_values <- left_join(mechanism_amr_shotgun_diversity_values, sample_metadata, by = "Sample")

deliverable_fig1 <- ggplot(mechanism_amr_shotgun_diversity_values, aes(x = Group, y = Shannon, color = Group)) +
  geom_boxplot() + # make boxplot
  geom_point() + # add points
  labs(x = "Treatment group", y = "Shannon's diversity index", col = "Treatment group") + 
  scale_color_grey() +
  coord_flip() +
  theme(axis.text.x = element_text( size = 18, angle = 45),
        axis.title.x = element_text(size = 18),
        axis.text.y = element_text(size = 18),
        axis.title.y = element_text(size = 18),
        panel.background = element_rect(fill = "white"))
deliverable_fig1
ggsave("Deliverable_fig1.jpeg", width = 60, height = 30, units = "cm") 


#
##
### Lesson 2 step 2 deliverable - figure 2
##
#

## Creating boxplot at AMR mechanism level
phylum_kraken.ps <- tax_glom(kraken_microbiome.ps, "phylum")

phylum_kraken.ps.rel <- transform_sample_counts(phylum_kraken.ps, function(x) x / sum(x) )

phylum_kraken.ps.rel.melt <- psmelt(phylum_kraken.ps.rel)

phylum_kraken.ps.rel.melt <- phylum_kraken.ps.rel.melt %>%
  group_by(phylum) %>%
  mutate(mean_phylum_rel_abundance = mean(Abundance))

phylum_kraken.ps.rel.melt$phylum <- as.character(phylum_kraken.ps.rel.melt$phylum)
phylum_kraken.ps.rel.melt$mean_phylum_rel_abundance <- as.numeric(phylum_kraken.ps.rel.melt$mean_phylum_rel_abundance)

phylum_kraken.ps.rel.melt$phylum[phylum_kraken.ps.rel.melt$mean_phylum_rel_abundance < 0.005] <- "Low abundance phyla (< 0.5%)"


##### Plot phyla relative abundances
deliverable_fig2 <-  ggplot(phylum_kraken.ps.rel.melt, aes(x = Sample, y = Abundance, fill = phylum)) +
  geom_bar(stat = "identity") +
  facet_wrap(~Group, scales = "free_x") +
  labs(x = "Treatment group", y = "Relative abundance", col = "Phylum", title = "Relative abundance of phyla by treatment group") + 
  theme(axis.text.x = element_text( size = 18, angle = 45),
        axis.title.x = element_text(size = 18),
        axis.text.y = element_text(size = 18),
        axis.title.y = element_text(size = 18),
        panel.background = element_rect(fill = "white")) +
  scale_fill_brewer(palette="Set3")

deliverable_fig2
ggsave("Deliverable_fig2.jpeg", width = 60, height = 30, units = "cm") 



