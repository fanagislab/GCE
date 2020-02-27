less AF.kmer.freq.stat | grep "#Kmer indivdual number" 
less AF.kmer.freq.stat | perl -ne 'next if(/^#/ || /^\s/); print; ' | awk '{print $1"\t"$2}' > AF.kmer.freq.stat.2colum 

../../gce -g 173854609857 -f AF.kmer.freq.stat.2colum >gce.table 2>gce.log
../../gce -g 173854609857 -f AF.kmer.freq.stat.2colum -c 75 -H 1 >gce2.table 2>gce2.log

