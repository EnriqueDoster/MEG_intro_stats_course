# Bioinformatics glossary
Glossary of terms regarding metagenomic sequencing and bioinformatics. Big thanks to Dr. Kate Huebner for the initial push to create this glossary.

# Table of contents
* [Absolute versus Relative Pathname](#absolute-versus-relative-pathname)
* [Alignment](#alignment)
* [Alpha diversity](#alpha-diversity)
* [AMRPlusPlus Pipeline](#amrplusplus-pipeline)
* [Assembly](#assembly)
* [Bait Capture Techniques](#bait-capture-techniques)
* [Beta diversity](#beta-diversity)
* [Bioinformatics](#bioinformatics)
* [Burrows Wheeler Alignment](#burrows-wheeler-alignment)
* [Bridge Amplification](#bridge-amplification)
* [Command line](#command-line)
* [Contig](#contig)
* [Coverage](#coverage)
* [Depth (i.e. Sampling Depth)](#depth-(i.e.-sampling-depth))
* [FASTA File format](#fasta-file-format)
* [File Transfer Protocol (FTP)](#file-transfer-protocol-(ftp))
* [Flow cell](#flow-cell)
* [GUI](#gui)
* [Home directory](#home-directory)
* [Host depletion assay](#host-depletion-assay)
* [Indel](#indel)
* [IUPAC](#iupac)
* [Kraken](#kraken)
* [K-mer](#k-mer)
* [Library](#library)
* [Linux](#linux)
* [Ordination techniques](#ordination-techniques)
* [MEGARes](#megares)
* [Microbiome](#microbiome)
* [Microbiota](#microbiota)
* [Metadata](#metadata)
* [Metagenome](#metagenome)
* [Metagenomics](#metagenomics)
* [NCBI (National Center for Biotechnology Information)](#ncbi-(national-center-for-biotechnology-information))
* [Next Generation Sequencing (NGS)](#next-generation-sequencing-(ngs))
* [Nextflow](#nextflow)
* [PacBio (Single Molecule Real Time Sequencing)](#pacbio-(single-molecule-real-time-sequencing))
* [Paired versus Single End Reads](#paired-versus-single-end-reads)
* [Phred Score (Q Score)](#phred-score-(q-score))
* [Pipeline](#pipeline)
* [Rarefaction Curve](#rarefaction-curve)
* [16S rRNA gene sequencing](#16s-rrna-gene-sequencing)
* [Read and Read Length](#read-and-read-length)
* [RefSeq](#refseq)
* [Resistome](#resistome)
* [Samtools](#samtools)
* [Scaffolding](#scaffolding)
* [Sequencing by Synthesis](#sequencing-by-synthesis)
* [Short versus Long Read Sequencing](#short-versus-long-read-sequencing)
* [Single Nucleotide Polymorphism](#single-nucleotide-polymorphism)
* [Shotgun Sequencing](#shotgun-sequencing)
* [Species Richness and Evenness](#species-richness-and-evenness)
* [Transcriptomics](#transcriptomics)
* [Trimmomatic](#trimmomatic)
* [Unique Molecular Identifiers](#unique-molecular-identifiers)
* [Whole Genome Sequencing](#whole-genome-sequencing)


----

## **Absolute versus Relative Pathname**
_An absolute pathname_ is the location of a directory or file relative to the root directory, and it always starts with the root directory (i.e., with a forward slash). _A relative pathname_ contrasts with an absolute pathname in that it tells the location of a filesystem object relative to the current directory (i.e., the directory in which the user is currently working) rather than from the root directory. That is, it is a list of directories between the current directory and a filesystem object.[Linux Information Project](http://www.linfo.org/index.html)

## **Alignment**
Using a reference sequence (i.e published sequence for genome), take reads and looks across the areas of overlap in in iterative fashion until find piece that lines up. Examples of what alignment can be used for include calculation of genetic variation across between a reference sequence and your sequencing reads (either one or multiple genomes). In eukaryotic DNA, alignment can also be used to determine variation in minor allele frequency, for example, Single nucleotide polymorphisms.[Metagenomics Wiki](http://www.metagenomics.wiki/pdf/definition)  

## **Alpha diversity**
This is the species richness (number of taxa) within a single microbial environment. Measure of many different microbial species could be detected in a specific sample.

## **AMRPlusPlus Pipeline**
AmrPlusPlus[AMR++Documentation](http://megares.meglab.org/amrplusplus/latest/html/index.html) is a Galaxy-based metagenomics pipeline that is intuitive and easy to use. The pipeline takes advantage of current and new tools to help identify and characterize resistance genes within metagenomic sequence data. The pipeline consists of the following tools:
AmrPlusPlus consist of:

1.  [Trimmomatic](http://www.usadellab.org/cms/?page=trimmomatic) for removal of low quality bases and sequences)Bolger, A. M., Lohse, M., and Usadel, B. (2014). Trimmomatic: A flexible trimmer for Illumina Sequence Data. _Bioinformatics_, doi:10.1093/bioinformatics/btu170,

1. [BWA](http://bio-bwa.sourceforge.net/) for detection of host DNA and resistance genesLi, H., and Durbin, R. (2009). Fast and accurate short read alignment with Burrows–Wheeler transform. _Bioinformatics_ 25, 1754–1760. doi:10.1093/bioinformatics/btp324,

1. [Samtools](http://www.htslib.org/) for removal of host DNA,

1. [SNPFinder](http://www.htslib.org/) for detection of haplotypes,

1. [ResistomeAnalyzer](https://github.com/cdeanj/resistomeanalyzer) for resistome analysis,

1. [RarefactionAnalyzer](https://github.com/cdeanj/rarefactionanalyzer) for rarefaction analysis.

Together, these tools make up the entire AmrPlusPlus pipeline. Only three inputs are required to run the pipeline: a single or paired fastq dataset, a resistance database (fasta), and a host genome (fasta).

## **Assembly**
Once reads are obtained from sequencing, they can be assembled them into a consensus sequence, or _contig_, which can be done by aligning and merging short fragments of sequenced DNA in order to reconstruct the original genome. Assembly methods can either be performed using a _scaffold_, or reference, where reads are mapped against a known genomic sequence; or _de novo_, where contigs are strictly determined from the overlap of reads.

## **Bait Capture Techniques**
Methods exist for proportional enrichment of wanted versus unwanted DNA. One such method is so-called bait-capture or target enrichment, an approach based on hybridization of pre-designed 120-mer biotinylated cRNA baits to target DNA for capture and subsequent enrichment. Originally used for capture and sequencing of the human exome, this approach has been expanded to eukaryotic and pathogenic bacterial genomes.Noyes, N. R., Weinroth, M. E., Parker, J. K., Dean, C. J., Lakin, S. M., Raymond, R. A., et al. (2017). Enrichment allows identification of diverse, rare elements in metagenomic resistome-virulome sequencing. _Microbiome_ 5, 142. doi:10.1186/s40168-017-0361-8}.
.]

## **Beta diversity**
The diversity in a microbial community between different environments (difference in taxonomic abundance profiles from different samples).

## **Bioinformatics**
Bioinformatics is conceptualizing biology in terms of macromolecules (in the sense of physical-chemistry) and then applying "informatics" techniques (derived from disciplines such as applied maths, computer science, and statistics) to understand and organize the information associated with these molecules, on a large-scale.Luscombe, N. M., Greenbaum, D., and Gerstein, M. (2001). What is Bioinformatics? A Proposed Definition and Overview of the Field. _Methods Inf Med_ 40(4), 346–358.
.]

## **Burrows Wheeler Alignment**
Alignment tool that utilizes the burrows wheeler transform to compress data and search for alignments faster. In the AMR++ pipeline, it is used to align sequence reads to a user selected host genome, followed by subsequent removal of aligned reads is performed with Samtools.

## **Bridge Amplification**
A process in Illumina sequencing where replicating DNA strands having to arch over to prime the next round of polymerization off neighboring surface bound oligonucleotides.[Illumina Video](https://www.youtube.com/watch?v=fCd6B5HRaZ8).


## **Command line**
A command line interface (CLI) is an all-text display mode that is provided in a console or terminal window or a shell. A console is an all-text display mode that occupies the entire display monitor screen. A terminal window is a text-only window that emulates a console and which can be opened on a _graphical user interface (GUI)_ screen. A _shell_ is a program that not only provides the command line interface for Unix like operating system but also executes (i.e., runs) commands that are typed into it.

## **Contig**
A contig (from contiguous) is a set of overlapping DNA segments that together represent a consensus region of DNA, or overlapping sequence data. They are also considered contiguous fragments of DNA sequence from an incomplete draft genome. _Chimeric_ contigs are contigs that combine sequences from more than one genome. Short sequence reads from two different genomes can be incorrectly assembled into one contig due to a short region of similar sequence.

## **Coverage**
A sequencing run generates reads that sample a genome randomly and independently. These reads are not distributed equally across an entire genome; some bases are covered by fewer reads, some by more reads than the average coverage. Depth of coverage refers to the average number of times a single base is read during a sequencing run. If the coverage is 100 X, this means that on average each base was sequenced 100 times. The more frequently a base is sequenced, the more reliable a base is called, resulting in better quality of your data. See [reccomendations for coverage depending on application](file://localhost/Users/katehuebner/Library/Application%20Support/Zotero/Profiles/ckf8dkdr.default/zotero/storage/BASN63IV/recommended-sequencing-coverage-by-application.html).[Sequence Coverage Calculator](https://support.illumina.com/downloads/sequencing_coverage_calculator.html).

## **Depth (i.e. Sampling Depth)**
Metagenomic sequencing depth has increased over the years dramatically with high throughput sequencing technology advancements. How deep is enough for metagenomic shotgun sequencing? It's a balance between sampling depth and number of samples (for a given budget). Increasing sampling depth will lead to increased detection of bacterial species and strains at lower abundance level, whereas higher number of samples will increase the statistical power to proof that experimental findings are correct.

## **FASTA File format**
Describes a sequence (RNA, DNA, protein). It consists of a header and a sequence and has one of the extensions (.fasta, .fa, .faa).

## **FASTQ File Format**
FASTQ files contain the reads (sequences) that pass internal quality control on the sequencing platform. The FASTQ format has a simple structure that contains information about the sample, how the sample and reads were processed on the sequencer, the sequencer type, the sequences, and the quality scores associated with each individual base call. The have the file extension .fastq or .fq and are typically compressed in the GNU zip format (gzip) which is similar to a .zip file but uses a different compression algorithm.

## **File Transfer Protocol (FTP)**
The File Transfer Protocol (FTP) is the standard network protocol used for the transfer of computer files between a client and server on a computer network.

## **Flow cell**
[Illumina patterned flow cell technology](https://www.youtube.com/watch?time_continue=2&v=pfZp5Vgsbw0) is the where the sequencing chemistry occurs. The flow cell is a glass slide containing small fluidic channels through which polymerases, dNTPs and buffers can be pumped. The glass inside the channels is decorated with short oligonucleotides complementary to the adapter sequences.

## **GUI**
A [GUI](http://www.linfo.org/gui.html) is a type of user interface that allows users to interact with electronic devices through graphical icons and visual indicators instead of text-based user interfaces, typed command labels or text navigation. GUIs were introduced in reaction to the perceived steep learning curve of command-line interfaces (CLIs), which require commands to be typed on a computer keyboard.

## **Home directory**
A [home directory](http://www.linfo.org/home.html), also called a login directory, is the directory on Unix-like operating systems that serves as the repository for a user's personal files, directories and programs. It is also the directory that a user is first in after logging into the system.

## **Host depletion assay**
Due to the small size of pathogen genomes in comparison to that of the genome of their host, the presence of just a few nucleated (eukaryotic) host cells in a samle can completely inundate that sample with host DNA contamination. Direct sequencing of host-contaminated samples is inefficient and therefore not cost-effective. Enzyme-based DNA degradation methods that selectively digest and deplete host DNA contamination from samples can enrich the prokaryotic material for high-throughput next-generation sequencing (NGS). This approach takes advantage of the differential methylation patterns that exist between host DNA and most pathogen genomes.

## **Indel**
Indel is a molecular biology term for an insertion or deletion of bases in the genome of an organism.

## **IUPAC**
Iupac is recognized as the world authority on chemical nomenclature, terminology, standardized methods for measurements, atomic weights, etc. This includes nucleic acid base classification.[IUPAC Bases](https://www.bioinformatics.org/sms/iupac.html)

## **Kraken**
Kraken is an ultrafast and highly accurate program for assigning taxonomic labels to metagenomic DNA sequences. Using exact alignment of _k-mers_, Kraken achieves classification accuracy comparable to the fastest _BLAST_ program.[CCB Kraken Documentation](https://ccb.jhu.edu/software/kraken/)

## **K-mer**
The term [k-mer](https://en.wikipedia.org/wiki/K-mer) typically refers to all the possible substrings of length k that are contained in a string. In computational genomics, k-mers refer to all the possible subsequences (of length k) from a read obtained through DNA Sequencing. K-mers are typically used during sequence assembly, but can also be used in sequence alignment.

## **Library**
Before sequencing a biological sample, a library of the sample's DNA needs to be prepared. The library preparation procedure usually includes fragmenting the sample's DNA and labeling (tagging) of the fragments.  The final library, ready for sequencing, is a collection of DNA fragments that together represent the entire genomic content of a given sample (organism or entire environment).

## **Linux**
[Linux](https://en.wikipedia.org/wiki/Linux) is a high performance, yet completely free and open source, Unix-like operating system that is suitable for use on a wide range of computers and other products. It was first developed by [Linus Torvalds](https://en.wikipedia.org/wiki/Linus_Torvalds).  Most distributions (i.e., versions) consist of a kernal (i.e., the core of the operating system) together with hundreds of free utilities and application programs in a coordinated package for desktop and server use.

## **Ordination techniques**
In multivariate analysis, [ordination](https://en.wikipedia.org/wiki/Ordination_(statistics)) is used mainly in _exploratory data analysis_ (rather than in hypothesis testing). Ordination orders objects that are characterized by values on multiple variables (multivariate objects) so that similar objects are near each other and dissimilar objects are farther from each other. Such relationships between the objects, on each of several axes (one for each variable), are then characterized numerically and/or graphically. Many ordination techniques exist, including principal components analysis (PCA), non-metric multidimensional scaling (NMDS), correspondence analysis (CA) and its derivatives.

## **MEGaRES**
[MegaRes](https://megares.meglab.org/) is a hand-curated antimicrobial resistance database and annotation structure that provides a foundation for the development of high throughput acyclical classifiers and hierarchical statistical analysis of big data. MEGARes can be browsed as a stand-alone resource through the website or can be easily integrated into sequence analysis pipelines through download. It contains sequence data for approximately 4,000 hand-curated antimicrobial resistance genes accompanied by an annotation structure that is optimized for use with high throughput sequencing.Lakin, S. M., Dean, C., Noyes, N. R., Dettenwanger, A., Ross, A. S., Doster, E., et al. (2017). MEGARes: an antimicrobial resistance database for high throughput sequencing. _Nucleic Acids Res_. 45, D574–D580. doi:10.1093/nar/gkw1009}
]

## **Microbiome**
This term refers to the entire habitat, including the microorganisms (bacteria, archaea, lower and higher eurkaryotes, and viruses), their genomes (i.e., genes), and the surrounding environmental conditions. This definition is based on that of “biome,” the biotic and abiotic factors of given environments. Others in the field limit the definition of microbiome to the collection of genes and genomes of members of a microbiota. It is argued that this is the definition of metagenome, which combined with the environment constitutes the microbiome. The microbiome is characterized by the application of one or combinations of metagenomics, metabonomics, metatranscriptomics, and metaproteomics combined with clinical or environmental metadata.Marchesi, J. R., and Ravel, J. (2015). The vocabulary of microbiome research: a proposal. _Microbiome_ 3, 31. doi:10.1186/s40168-015-0094-5

## **Microbiota**
The assemblage of microorganisms present in a defined environment. This microbial census is established using molecular methods relying predominantly on the analysis of 16S rRNA genes, 18S rRNA genes, or other marker genes and genomic regions, amplified and sequenced from given biological samples. Taxonomic assignments are performed using a variety of tools that assign each sequence to a microbial taxon (bacteria, archaea, or lower eukaryotes) at different taxonomic levels from phylum to species.

## **Metadata**
Keeping strict and comprehensive records of metadata is as important as the sequence data. Metadata are the “data about the data”: where the samples were taken from, when, and under which conditions. In microbial ecology, this commonly refers to physical, chemical, and other environmental characteristics of the sample's location. For example, an ocean sample metadata will typically include sampling date and time, depth, salinity, light intensity, geographical coordinates, pH, soluble gases, etc. In clinical microbiology, metadata would refer to the pathology, medical history, and vital statistics of the patient as well as the exact location and tissue from which the sample was taken, the sampling conditions, and so on.Wooley, J. C., Godzik, A., and Friedberg, I. (2010). A Primer on Metagenomics. _PLoS Comput_. _Biol._ 6. doi:10.1371/journal.pcbi.1000667

## **Metagenome**
The collection of genomes and genes from the members of a microbiota. This collection is obtained through shotgun sequencing of DNA extracted from a sample (metagenomics) followed by assembly or mapping to a reference database followed by annotation. Metataxonomic analysis, because it relies on the amplification and sequencing of taxonomic marker genes, is not metagenomics.

## **Metagenomics**
Metagenomics is the study of a collection of genetic material (genomes) from a mixed community of organisms. Metagenomics is the process used to characterize the metagenome, from which information on the potential function of the microbiota can be gained.

## **NCBI (National Center for Biotechnology Information)**
National Center for Biotechnology Information (NCBI) is part of the United States National Library of Medicine (NLM), a branch of the National Institutes of Health (NIH). The NCBI houses a series of databases relevant to biotechnology and biomedicine and is an important resource for bioinformatics tools and services. Major databases include [GenBank](https://www.ncbi.nlm.nih.gov/genbank/) for DNA sequences and [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/), a bibliographic database for the biomedical literature. Other databases include the NCBI Epigenomics database. All these databases are available online through the Entrez search engine.

## **Next Generation Sequencing (NGS)**
Also known as high-throughput sequencing, is the catch-all term used to describe a number of different modern sequencing technologies including Illumina (Solexa) sequencing. This technology signifies a paradigm shift where massive parallelization of sequencing reactions increases the yield of DNA sequenced per run. The NGS revolution is marked by the increase in yield of sequencing efforts by orders of magnitude.

## **Nextflow**
[Nextflow](https://www.nextflow.io/) enables scalable and reproducible scientific workflows using software containers. Nextflow is a reactive workflow framework and a programming DSL (domain specific language)  that eases the writing of computational pipelines with complex data.
It is designed around the idea that the Linux platform is the lingua franca (common language) of data science. Linux provides many simple command line and scripting tools, which by themselves are powerful, but when chained together facilitate complex data manipulations. Nextflow allows you to write a computational pipeline by making it simpler to put together many different tasks.

## **PacBio (Single Molecule Real Time Sequencing)**
PacBio is a biotechnology company that sequences single molecules in real time based on properties of zero mode waveguides (ZMW). It produces longer reads (up to 40 kb) but has a high error rate. SMRT Sequencing is built upon two key innovations: ZMWs and phospholinked nucleotides. ZMWs allow light to illuminate only the bottom of a well in which a DNA polymerase/template complex is immobilized. Phospholinked nucleotides allow observation of the immobilized complex as the DNA polymerase produces a completely natural DNA strand.[Video Overview of SMRT Technology](https://www.youtube.com/watch?v=WMZmG00uhwU)

## **Paired versus Single End Reads**
With _single read_ runs the sequencing instrument reads from one end of a DNA fragment to the other end. _Paired end_ runs read from one end to the other end, and then starts another round of reading from the opposite end. Since they are generated from the same physical fragment, they are said to be paired. A single-end read may be generated from only one end of the same fragment.  

## **Phred Score (Q Score)**
A [Phred quality score](https://www.illumina.com/documents/products/technotes/technote_Q-Scores.pdf) is a measure of the quality of the identification of the nucleobases generated by automated DNA sequencing. Each score represents inverse log probability of an error in base calls. Minimum score is 0, typically falls between 30-45 range. Generally, a minimum of 20 (1/100 probability of incorrect base call) is considered acceptable, but above 30 (1 in 1000) is optimal. Illumina uses ASCII base 33.

## **Pipeline**
A term borrowed by bioinformatics from computer science, this involves the chaining of processes/threads/functions etc. Commonly in bioinformatics languages such as [Python](https://www.python.org/) (or another scripting language including UNIX shell) are used to create a pipeline in order to execute, then transform, then execute another program and so on. This chaining of programs allows a bioinformatician to start with one data type, say a FASTQ file obtained from next generation sequencing data (NGS) and end up with data, such as a count matrix. To do this a number of programs which analyze and translate the data must be executed.[See Quora Answer, "What are Pipelines?"](https://www.quora.com/What-are-pipelines-in-Bioinformatics)

## **Rarefaction Curve**
To estimate the fraction of species sequenced, rarefaction curves are typically used. Additionally, you may want to know if the depth of your sequencing (how many reads you obtain that are on target) is high enough to identify rare organisms (organisms with low abundance relative to others) in your population. This is referred to as rarefaction and is calculated by randomly subsampling your sequence data at intervals between 0% and 100% in order to determine how many targets are found at each depth. A _rarefaction curve_ plots the number of species as a function of the number of individuals sampled. The curve usually begins with a steep slope, which at some point begins to flatten as fewer species are being discovered per sample: the gentler the slope, the less contribution of the sampling to the total number of operational taxonomic units or OTUs.

## **16S rRNA gene sequencing**
16S ribosomal RNA (rRNA) sequencing is a common amplicon sequencing method used to identify and compare bacteria present within a given sample. 16S rRNA gene sequencing is a well-established method for studying phylogeny and taxonomy of samples from complex microbiomes or environments that are difficult or impossible to culture. Ribosomal RNA can be used to identify and compare bacteria based on evolutionary differences in the 16S ribosomal sequence region. The ribosomal RNA (rRNA) sequence contains genes encoding structural and functional portions of the ribosomes present in all _bacteria and archaea_ and can be used to identify and distinguish different microbes. Highly _conserved regions_ are used as primer binding sites to sequence the complete rRNA gene sequences. The _hypervariable regions_ within the rRNA gene are used as species-specific signature sequences to identify the different microbes present in a sample.

## **Read and Read Length**
A read refers to the nucleotide sequence of a section of a unique fragment (DNA or RNA) produced by a sequencing platform. Some sequencing instruments give you flexibility in choosing the number of base pairs (cycles) you can read at one time. The number of cycles corresponds to the output read length. While longer read lengths give you more accurate information on the relative positions of your bases in a genome, they are more expensive than shorter ones and tend to have increased error rates towards the end of the read.

## **RefSeq**
The Reference Sequence (RefSeq) database is an open access, annotated and curated collection of publicly available nucleotide sequences (DNA, RNA) and their protein products.Pruitt, K. D., Tatusova, T., and Maglott, D. R. (2007). NCBI reference sequences (RefSeq): a curated non-redundant sequence database of genomes, transcripts and proteins. _Nucleic Acids Res_. 35, D61–D65. doi:10.1093/nar/gkl842

## **Resistome**
The antibiotic resistome is the collection of all the antibiotic resistance genes, including those usually associated with pathogenic bacteria isolated in the clinics, non-pathogenic antibiotic producing bacteria and all other resistance genes.Wright, G. D. (2007). The antibiotic resistome: the nexus of chemical and genetic diversity. _Nat. Rev. Microbiol_. 5, 175–186. doi:10.1038/nrmicro1614

## **Samtools**
SAM Tools provide various utilities for manipulating alignments in the SAM format, including sorting, merging, indexing and generating alignments in a per-position format. In the AMR++pipeline, this tool is used to remove reads that aligned to the host (or unwanted) genome.Li, H. (2011). A statistical framework for SNP calling, mutation discovery, association mapping and population genetical parameter estimation from sequencing data. _Bioinformatics_ 27, 2987–2993. doi:10.1093/bioinformatics/btr509

## **Scaffolding**
A scaffold is an ordered and oriented set of contigs. A [scaffold](https://en.wikipedia.org/wiki/Scaffolding_(bioinformatics)) will contain gaps, but there is typically some evidence to support the contig order, orientation and gap size estimates. Scaffolds can be different depending on which molecular and computational methods are used.

## **Sequencing by Synthesis**
Methods of sequencing nucleic acids that requires the direct action of DNA polymerase to produce the observable output. Bases are read one at a time, as they are incorporated during synthesis of a new strand.

## **Short versus Long Read Sequencing**
Sequencing read length depends on the instrument and chemistry used. The range of the read length of a short-read sequencing instrument is between 100 and 600 bp, while that of a long-read sequencing instrument varies between 10 to 15 kb. The choice one makes depends on the goal of the experiment; one isn’t considered universally superior to the other.

## **Single Nucleotide Polymorphism**
A single nucleotide polymorphism, or SNP (pronounced "snip"), is a variation at a single position in a DNA sequence among individuals.

## **Shotgun Sequencing**
Sequencing randomly sheared pieces of DNA. The frequency of reads genrated is proportional to the frequency of DNA sequences in the underlying genome (i.e. there is no selection).

## **Species Richness and Evenness**
[Species richness](https://en.wikipedia.org/wiki/Species_richness) is the number of different species represented in an ecological community, landscape or region. Species richness is simply a count of species, and it does not take into account the abundances of the species or their relative abundance distributions. Species diversity takes into account both species richness and species evenness. Species evenness is a diversity metric that measures similarity in species relative abundance in a community. Simpson’s and Shannon’s measures are two diversity indices that account for both abundance (richness) and evenness of the species present.

## **Transcriptomics**
The profiling of community-wide gene expression (RNA-seq) While Metagenomics tells us which microbes are present and what genomic potential they have, metatranscriptomics tells us about their activity: the genes that are highest expressed in a specific microbial environment. Thus, metatranscriptomics is the study of the function and activity of the complete set of transcripts (RNA-seq) from environmental samples.Marchesi, J. R., and Ravel, J. (2015). The vocabulary of microbiome research: a proposal. _Microbiome_ 3, 31. doi:10.1186/s40168-015-0094-5

## **Trimmomatic**
Trimmomatic is used to remove adapter contamination and low quality reads.Trimming removes several error types, including end of read substitutions, adapter sequences, missing mate-pairs, and low quality reads. Trimmomatic is a fast, multithreaded command line tool that can be used to trim and crop Illumina (FASTQ) data as well as to remove adapters. It is capable of flexible, processing paired end data.Bolger, A. M., Lohse, M., and Usadel, B. (2014). Trimmomatic: A flexible trimmer for Illumina Sequence Data. _Bioinformatics_ doi:10.1093/bioinformatics/btu170

## **Unique Molecular Identifiers**
Unique molecular identifiers (UMIs; also called Random Molecular Tags (RMTs)) are random sequences of bases used to tag each molecule (fragment) prior to library amplification, thereby aiding in the identification of PCR duplicates.  If two reads align to the same location and have the same UMI, it is highly likely that they are PCR duplicates originating from the same fragment prior to amplification. We can therefore collapse all the reads with the same genomic coordinates and UMI into a single representative read and obtain an accurate estimate of the relative concentration of the fragments in the original sample.Kivioja, T., Vähärautio, A., Karlsson, K., Bonke, M., Enge, M., Linnarsson, S., et al. (2012). Counting absolute numbers of molecules using unique molecular identifiers. Nat. Methods 9, 72–74. doi:10.1038/nmeth.1778

## **Whole Genome Sequencing**
The process of determining the complete DNA sequence (coding and non-coding sequences) of an organism's genome at a single time using next generation sequencing methods.
