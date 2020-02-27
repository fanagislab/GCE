
GCE (genomic charactor estimator) is a bayes model based method to estimate the 
genome size, genomic repeat content and the heterozygsis rate of the sequencing
sample. The estimated result can be used to help design the sequencing strategy
in de novo genome project.

GCE is primarily hosted on BGI's ftp site (ftp://ftp.genomics.org.cn/pub/gce).
Now the lastest version gce-1.0.2 is also available on Github (https://github.com/fanagislab/GCE).
Note that gce-1.0.2 is compatible with the latest kmerfreq version 4.0 (max depth 65535).
kmerfreq version 4.0 is available on Github (https://github.com/fanagislab/kmerfreq).

Note that the estimation accuracy is also highly depended on the sequencing data quality, very low quality 
sequencing data, in which no clear peak can be viewed on the kmer frequency curve, should not be used.


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
GCE generates two output files: 

(1) Estimation result file: gce.table:
there are two tables, one is ai table and the other is frequency table.
#ai table:
showing the estimated ci and ai for kmer species and Ci and bi for kmer individuals. 
the range of i is from 1 to max peak.
#i      c[i]    a[i]    C[i]    b[i]

#frequency table:
showing the raw depth distribution of kmer species(real_P(x)), the raw depth distribution
of kmer individuals(real_F(x)), the estimated depth distribution of kmer species(est_P(x)) 
and the estimated depth distribution of kmer individuals(est_F(x)).
#depth  real_P(x)       real_F(x)       est_P(x)        est_F(x)

For more details about kmer species and kmer individuals, please read the manuscript.

(2) Estimation log file: gce.log

The most valuable estimation results can be found at the file end:

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


PERFORMANCE
gce is a extremely fast tool for estimating the genomic charactor. For the
standard discrete model, the max memory is about 1.5MB, taking less than one
second. For the continuous model, when setting -D 8, the max memeroy is about
1.5MB, taking about 5 seconds. The memory and time cost is only related to the
max kmer depth and the depth distribution, not related with K size.

COMMENTS/QUESTIONS/REQUESTS
Please send an e-mail to binghang.liu@qq.com or fanweiagis@126.com;

REFERENCE and CITATION
Binghang Liu, Yujian Shi, Jianying Yuan, et al. and Wei Fan*. Estimation of genomic characteristics by analyzing k-mer frequency in de novo genome project. arXiv.org arXiv: 1308.2012. (2013)

https://arxiv.org/abs/1308.2012

INSTRUCTION and HELP
http://blog.sciencenet.cn/blog-3406804-1162384.html
http://blog.sciencenet.cn/blog-3406804-1161524.html

