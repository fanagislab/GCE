We have developed two implementations for GCE, the first gce-1.0.2 is 
recommended for common users, and the latter gce-alternative can be used in 
comparison and verifying purpose. Both can take the kmerfreq output
as input file, except for a little difference: gce-1.0.0 must remove the header
lines and only keeps the data lines, while gce-alternative does not need that.

1. gce-1.0.2

GCE (genomic charactor estimator) is a bayes model based method to estimate the 
genome size, genomic repeat content and the heterozygsis rate of the sequencing
sample, developed by Binghang Liu (binghang.liu@qq.com). The estimated result 
can be used to design the sequencing strategy.

GCE is primarily hosted on BGI's ftp site (ftp://ftp.genomics.org.cn/pub/gce).
Now the lastest version gce-1.0.2 is also available on Github (https://github.com/fanagislab/GCE).
Note that gce-1.0.2 is compatible with the latest kmerfreq version 4.0 (max
depth 65535), which is available on Github (https://github.com/fanagislab/kmerfreq).


INSTALLATION
Download the package and run

tar -xzvf gce.tar.gz 
make (to build the executable file "gce")

in the compiled version, you can use the gce directly.

USAGE
gce -f test.freq -g total_kmer_num

Options:
-f      depth frequency file, is a list file containing at least two lines, the first line
	is depth and the second line is frequency(not the ratio) of the depth, other
	line is not recognized in the program. 
-g 	total kmer number counted from the reads. It is suggested to set this
	value for accurate estimation. If not, the total kmer number will be calculated using data in
	kmer_depth_file, which often missing data and cause error in estimation
-c	unqiue coverage depth. It is suggested to be set when there is no
	clear peak or there is clear un-unique peaks, especially when the
	heterozygous ratio is high.
-H	when the heterozygous caused peak is clear, it is suggested to use
	hybrid mode.
-b	when there is sequencing bias, you need to set the value.

-m	estiation mode, there are standard discrete model(default) and continuous model. You can
	set 1 to use continuous model, but its stability is not well.
-M      max depth value, information for larger depth will be ignored; If you increase this value,
	the estimation accuaray will be higher, but the run speed will be slower. 

-D	set the raw distance for continuous model, which decide the peak
	number.
	
-h: display help information.


Run examples:

First use a kmer counting tool to calculate kmer frequency for the sequencing data, get result file AF.kmer.freq.stat
	kmerfreq -k 17 -t 10 -p AF  ./raw_reads.lib

Then get the total kmer number for gce option "-g", and the depth frequency file for gce option "-f":
	less AF.kmer.freq.stat | grep "#Kmer indivdual number" 
	less AF.kmer.freq.stat | perl -ne 'next if(/^#/ || /^\s/); print; ' | awk '{print $1"\t"$2}' > AF.kmer.freq.stat.2colum 

Run gce in homozygous mode, suitable for homozygous and near-homozygous genome (-g and -f must be set at the same time) 
        ./gce -g 173854609857 -f AF.freq.stat.2colum >gce.table 2>gce.log

Run gce in heterzygous mode, siutable for heterozgyous genome (-H and -c must be set at the same time) 
        ./gce -g 173854609857 -f AF.freq.stat.2colum -c 75 -H 1 >gce2.table 2>gce2.log


OUTPUT
GCE generates two output files: gce.table and gce.log

The most valuable estimation results can be found at the end of gce.log file:

Final estimation table:
raw_peak        effective_kmer_species  effective_kmer_individuals      coverage_depth  genome_size     a[1]    b[1]
75      742400596       168346645871    75.8021 2.22087e+09     0.663012        0.271515

Column explanation:
raw_peak: the major peak on the kmer species curve, corresponding to the non-repeatitive and non-heterozygous genomic regions
effective_kmer_species: total number of genuine kmer species (without low-frequency kmers caused by sequencing errors)
effective_kmer_individuals: total number of genuine kmer individuals (without low-frequency kmers caused by sequencing errors)      
coverage_depth: estimated coverage depth of genuine kmers
genome_size: estimated genome size (genome_size = effective_kmer_individuals / coverage_depth)
a[1]: the ratio of unique kmers in all the kmer species in the genome
b[1]: the ratio of unique kmers in all the kmer individuals in the genome

2. gce-alternative

Function
  This package was developed by Wei Fan (fanweiagis@126.com), which is an alternative implementation to liubinghang's GCE software (ftp://ftp.genomics.org.cn/pub/gce).

Installation  
  Except the two programs coded by C++, which needs "make" to compile, the other are perl programs.

Input and output 
  The output file from kmerfreq can be used as input file for all the programs here.

Usage
  a.Only estimate genome size, with erroneous k-mers excluded, and float-point estimatation of peak coverage value 
	perl ../estimate_genome_size.pl reads.freq.stat
  b.Estimate genome size as well as repeat and heterozygosity, using discrete model, suitable for theoretic and good sequencing data without coverage bias 
	perl ../estimate_genome_character.pl ./reads.freq.stat 
  c.Estimate genome size as well as repeat and heterozygosity, using continuous model, suitable for bad or common real sequencing data with severe coverage bias  
	perl ../estimate_genome_character_real.pl ./reads.freq.stat


3. Reference

Binghang Liu, Yujian Shi, Jianying Yuan, et al. and Wei Fan*. Estimation of genomic characteristics by analyzing k-mer frequency in de novo genome project. arXiv.org arXiv: 1308.2012. (2013)

https://arxiv.org/abs/1308.2012

4.Help 
http://blog.sciencenet.cn/blog-3406804-1162384.html
http://blog.sciencenet.cn/blog-3406804-1161524.html

5. Contact
Please send an e-mail to binghang.liu@qq.com or fanweiagis@126.com;
