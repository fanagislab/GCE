1. Function
  This package was developed by Wei Fan, fanwei@caas.cn, which is an alternative implementation to liubinghang's GCE software (ftp://ftp.genomics.org.cn/pub/gce).

2. Installation  
  Except the two programs coded by C++, which needs "make" to compile, the other are perl programs.

3. Input and output 
  The output file from kmerfreq can be used as input file for all the programs here.

4. Usage
  (1) Only estimate genome size, with erroneous k-mers excluded, and float-point estimatation of peak coverage value 
	perl ../estimate_genome_size.pl reads.freq.stat
  (2) Estimate genome size as well as repeat and heterozygosity, using discrete model, suitable for theoretic and good sequencing data without coverage bias 
	perl ../estimate_genome_character.pl ./reads.freq.stat 
  (3) Estimate genome size as well as repeat and heterozygosity, using continuous model, suitable for bad or common real sequencing data with severe coverage bias  
	perl ../estimate_genome_character_real.pl ./reads.freq.stat

5. COMMENTS/QUESTIONS/REQUESTS
Please send an e-mail to binghang.liu@qq.com or fanweiagis@126.com;

6. REFERENCE and CITATION
Binghang Liu, Yujian Shi, Jianying Yuan, et al. and Wei Fan*. Estimation of
genomic characteristics by analyzing k-mer frequency in de novo genome
project. arXiv.org arXiv: 1308.2012. (2013)

https://arxiv.org/abs/1308.2012

7.INSTRUCTION and HELP
http://blog.sciencenet.cn/blog-3406804-1162384.html
http://blog.sciencenet.cn/blog-3406804-1161524.html

