less AI.kmer.freq.stat | grep "#Kmer indivdual number" 
less AI.kmer.freq.stat | perl -ne 'next if(/^#/ || /^\s/); print; ' | awk '{print $1"\t"$2}' >AI.kmer.freq.stat.2column

../../gce -g 113291624814 -f AI.kmer.freq.stat.2column >gce.table 2>gce.log
../../gce -g 113291624814 -f AI.kmer.freq.stat.2column -c 64 -H 1  >gce2.table 2>gce2.log

