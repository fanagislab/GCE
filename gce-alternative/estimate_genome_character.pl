#!/usr/bin/perl

=head1 Name

estimate_genome_character.pl   --  estimate c, G, and ai values, the pipeline program

=head1 Description

Note that this program is developed for dealing with theoretic data that do not conatain sequencing 
coverage bias problem, which only use the P(x) to estimate c and G. 


=head1 Version

  Author: Fan Wei, fanw@genomics.org.cn
  Version: 1.0,  Date: 2011-8-12
  Note:

=head1 Usage

  perl estimate_genome_character.pl  <species_frequency_file.stat>
  --species <string> set the prefix for result file, default="input_file"
  --is_hetero <int>  whether use the heterozygous mode, 0:no, 1:yes, default=0 
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
my ($Species_name, $LowFreq_cutoff, $Is_hetero, $Verbose,$Help);
GetOptions(
	"species:s"=>\$Species_name,
	"is_hetero:i"=>\$Is_hetero,
	"verbose"=>\$Verbose,
	"help"=>\$Help
);
$Is_hetero ||= 0;

die `pod2text $0` if (@ARGV == 0 || $Help);

my $kmerfreq_stat_file = shift;

$Species_name ||= basename($kmerfreq_stat_file);

my $output_character_file = $Species_name.".final.genomic.characters";
open OUT, ">$output_character_file" || die "fail $output_character_file";


my $lowfreq_cutoff = 0;
my $c_value = 0;
my $px_peak_depth = 0;
my $total_kmer_individuals = 0;
my $error_kmer_individuals = 0;
my $correct_kmer_individuals = 0;
my $rough_estimated_G = 0;
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
	if (/G by P\(x\):\s+(\d+)/) {
		$rough_estimated_G = $1;
	}
}
close IN;

print OUT "The hetero mode: $Is_hetero\n";

print OUT "The automatically calculated lowfreq cutoff is: $lowfreq_cutoff\n";
print OUT "The estimated c by P(x) is: $c_value\n";
print OUT "The peak depth at px curve is: $px_peak_depth\n";
print OUT "\nThe total number of kmer individuals is: $total_kmer_individuals\n";


`$Bin/estimate_repeat  -r 254 -l $lowfreq_cutoff -g 10 -m $c_value -d 0.0001 -z $Is_hetero  $kmerfreq_stat_file`;


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
open IN, "$kmerfreq_stat_file.cdd"  || die "fail open $kmerfreq_stat_file.cdd\n";
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


$error_kmer_individuals = $px_leftToPeak_kmer_individuals - $px_peak_kmer_indivduals * $theory_leftToPeak_rate / $theory_peak_rate;
$correct_kmer_individuals = $total_kmer_individuals - $error_kmer_individuals;

$final_estimated_G = int($correct_kmer_individuals / $c_value);

print OUT "\nThe total number of erroneous kmers: $error_kmer_individuals\n";
print OUT "The total number of correct kmers: $correct_kmer_individuals\n";
print OUT "The roughly estimated genome size is: $rough_estimated_G\n";
print OUT "The finally estimated genome size is: $final_estimated_G\n";

`perl $Bin/draw_kmer_real_theoretic_dist.pl  $Species_name  $kmerfreq_stat_file  $kmerfreq_stat_file.cdd  $lowfreq_cutoff`;
`perl $Bin/distribute_svg.pl  $Species_name\_real_theory_distribution.lst  $Species_name\_real_theory_distribution.svg`;


close OUT;


