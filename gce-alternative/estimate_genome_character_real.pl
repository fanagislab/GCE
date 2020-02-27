#!/usr/bin/perl

=head1 Name

estimate_genome_character_real.pl   --  estimate c, G, and ai values, the pipeline program

=head1 Description

Note that this program is specially developed for dealing with real data that may have sequencing coverage
bias problem, which only use the P(x) to estimate c and G, use P(x) to identify the turning point.

Use 3 methods to deal with coverage bias: most rough, non-bias model, and coverage-bias model.

=head1 Version

  Author: Fan Wei, fanw@genomics.org.cn
  Version: 1.0,  Date: 2011-8-12
  Note:

=head1 Usage

  perl estimate_genome_character_real.pl  <species_frequency_file.stat>
  --species <string> set the prefix for result file, default="input_file"
  --ranks <int>  set the number of ranks within one unit of genomic frequency , default=1
  --verbose   output running progress information to screen  
  --help      output help information to screen  

=head1 Exmple


=cut

use strict;
use Getopt::Long;
use FindBin qw($Bin $Script);
use File::Basename qw(basename dirname); 
use Data::Dumper;
use File::Path;  ## function " mkpath" and "rmtree" deal with directory

##get options from command line into variables and set default values
my ($Species_name, $LowFreq_cutoff, $Ranks_within_genomic_freq, $Verbose,$Help);
GetOptions(
	"species:s"=>\$Species_name,
	"ranks:i"=>\$Ranks_within_genomic_freq,
	"verbose"=>\$Verbose,
	"help"=>\$Help
);
$Ranks_within_genomic_freq ||= 1;

die `pod2text $0` if (@ARGV == 0 || $Help);

my $kmerfreq_stat_file = shift;

$Species_name ||= basename($kmerfreq_stat_file);

my $output_character_file = $Species_name.".final.genomic.characters";
open OUT, ">$output_character_file" || die "fail $output_character_file";


my $lowfreq_cutoff = 0;
my $c_value = 0;
my $px_peak_depth = 0;
my $total_kmer_individuals = 0;
my $nonadjusted_correct_kmer_individuals = 0;
my $adjusted_error_kmer_individuals = 0;    ##adjusted
my $adjusted_correct_kmer_individuals = 0;  ##adjusted
my $rough_estimated_G = 0;
my $middle_estimated_G = 0;
my $final_estimated_G = 0;

my $kmerfreq_stat_cG_file = $kmerfreq_stat_file.".c.G";
`perl $Bin/estimate_genome_size.pl $kmerfreq_stat_file > $kmerfreq_stat_cG_file`;

open IN, $kmerfreq_stat_cG_file || die "fail open $kmerfreq_stat_cG_file";
while (<IN>) {
	if (/The automatically calculated lowfreq cutoff is:\s+(\d+)/) {
		$lowfreq_cutoff = $1;
	}
	if (/c by P\(x\):\s+(\S+)/) {
		$c_value = $1;
	}
	if (/Integer c by p\(x\) and f\(x\):\s+(\d+)/) {
		$px_peak_depth = $1;
	}
	if (/Total kmer individuals:\s+(\d+)/) {
		$total_kmer_individuals = $1;
	}
	if (/Total kmer individuals\(lowfreq excluded\):\s+(\d+)/) {
		$nonadjusted_correct_kmer_individuals = $1;
	}
}
close IN;

$rough_estimated_G = int($nonadjusted_correct_kmer_individuals / $px_peak_depth);
$middle_estimated_G = int($nonadjusted_correct_kmer_individuals / $c_value);

print OUT "The number of ranks within one unit of genomic frequency: $Ranks_within_genomic_freq\n";

print OUT "The automatically calculated lowfreq cutoff from P(x) is: $lowfreq_cutoff\n";
print OUT "The estimated float-precision c by P(x) is: $c_value\n";
print OUT "The estimated integer-precision c by P(x) is: $px_peak_depth\n";
print OUT "\nThe total number of kmer individuals is: $total_kmer_individuals\n";
print OUT "\nThe total number of nonadjusted-correct kmer individuals is: $total_kmer_individuals\n";
print OUT "\nThe total number of adjusted-correct kmer individuals is: \n";

`$Bin/estimate_multiple_poissons  -r 254 -l $lowfreq_cutoff -g 10 -m $c_value -d 0.0001 -z 1  $kmerfreq_stat_file`;
`$Bin/estimate_multiple_poissons  -r 254 -l $lowfreq_cutoff -g 10 -m $c_value -d 0.0001 -z 8  $kmerfreq_stat_file`;

my $px_peak_kmer_indivduals = 0;
my $px_leftToPeak_kmer_individuals = 0;
##load data from input file
open IN, $kmerfreq_stat_file  || die "fail open $kmerfreq_stat_file\n";
while (<IN>) {
	next if(/^\s/ || /^\#/);
	s/^>=//;   ##freq最大边界255的也计算在内
	##print $_;
	my @t = split /\s+/;
	my $freq = $t[0];
	my $px_num = $t[1];
	my $fx_num = $t[4];
	if ($freq >= 1 && $freq <= $px_peak_depth) {
		$px_leftToPeak_kmer_individuals += $freq * $px_num;
		if ($freq == $px_peak_depth) {
			$px_peak_kmer_indivduals = $freq * $px_num;
			last;
		}
	}
}
close IN;

print OUT "The px_peak_kmer_indivduals is: $px_peak_kmer_indivduals\n";
print OUT "The px_leftToPeak_kmer_individuals is: $px_leftToPeak_kmer_individuals\n";


my $theory_peak_rate = 0.0;
my $theory_leftToPeak_rate = 0.0;
open IN, "$kmerfreq_stat_file.z8.cdd"  || die "fail open $kmerfreq_stat_file.cdd\n";
while (<IN>) {
	next if(/^\s/ || /^\#/);
	my ($depth,$rate) = ($1,$2) if (/^(\d+)\s+(\S+)/);
	if ($depth >= 1 && $depth <= $px_peak_depth) {
		$theory_leftToPeak_rate += $depth*$rate;
		if ($depth == $px_peak_depth) {
			$theory_peak_rate = $depth*$rate;
		}
	}
	
}
close IN;

print OUT "The theoretic peak rate is: $theory_peak_rate\n";
print OUT "The theoretic left to peak rate is: $theory_leftToPeak_rate\n";


$adjusted_error_kmer_individuals = $px_leftToPeak_kmer_individuals - $px_peak_kmer_indivduals * $theory_leftToPeak_rate / $theory_peak_rate;
$adjusted_correct_kmer_individuals = $total_kmer_individuals - $adjusted_error_kmer_individuals;

$final_estimated_G = int($adjusted_correct_kmer_individuals / $c_value);

print OUT "\nThe total number of adjusted erroneous kmers: $adjusted_error_kmer_individuals\n";
print OUT "The total number of adjusted correct kmers: $adjusted_correct_kmer_individuals\n";

##get a1 from rank-z1 result
open IN, "$kmerfreq_stat_file.z1.gfd" || die "fail";
my $nonbias_a1 = 0;
while (<IN>) {
	if (/Last Round: /) {
		<IN>; <IN>;
		my $line = <IN>;
		chomp $line;
		my @t = split /\s+/, $line;
		if ($t[0] == 1) {
			$nonbias_a1 = $t[1];
		}
		
	}
}

open IN, "$kmerfreq_stat_file.z8.gfd" || die "fail";
my $withbias_a1 = 0;
while (<IN>) {
	if (/Last Round: /) {
		<IN>; <IN>;
		while (<IN>) {
			chomp;
			my @t = split /\s+/, $_;
			if ($t[0] < 1.5) {
				$withbias_a1 += $t[1];
			}else
			{	last;
			}
		}

	}
}

print OUT "\nEstimated G and a[1]:\n";
print OUT "most rough      : $rough_estimated_G\tnone\n";
print OUT "discreate model : $middle_estimated_G\t$nonbias_a1\n";
print OUT "continuous model: $final_estimated_G\t$withbias_a1\n";



`perl $Bin/draw_kmer_real_theoretic_dist_real.pl  $Species_name  $kmerfreq_stat_file  $kmerfreq_stat_file.z1.cdd  $kmerfreq_stat_file.z8.cdd $lowfreq_cutoff`;
`perl $Bin/distribute_svg.pl  $Species_name\_real_theory_distribution.lst  $Species_name\_real_theory_distribution.svg`;


close OUT;


