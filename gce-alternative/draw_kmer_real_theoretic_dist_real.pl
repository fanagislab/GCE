#!/usr/bin/perl

=head1 Name



=head1 Description



=head1 Version

  Author: Fan Wei, fanw@genomics.org.cn
  Version: 1.0,  Date: 2006-12-6
  Note:

=head1 Usage
  
  
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
my ($Verbose,$Help);
GetOptions(
	"verbose"=>\$Verbose,
	"help"=>\$Help
);
die `pod2text $0` if (@ARGV == 0 || $Help);

my $spcies_name = shift;
my $kmer_stat_file = shift;
my $theoretic_kmer_file = shift;
my $theoretic2_kmer_file = shift;
my $lowfreq_cutoff = shift;

my $header_str = <<MYMARK;
Type: Line
LineWidth: 3
Width: 640
Height: 480
WholeScale: 0.8
MarkPos: tr
MarkScale: 0.8
MarkNoBorder: 1
FontSize: 46
FontFamily: ArialNarrow-Bold
Note: $spcies_name
X: Kmer coverage depth
Y: Percent of kmer species
Xstart: 0
Xstep: 20
Xend: 100
Xcut: 1
Ystart: 0
Ystep: 2
Yend: 10
Ycut: 1
:End
MYMARK


my $real_kmer_species_str = "\nColor: blue\nMark: Data-based\n";

my @Rates;
my $total_correct_rate = 0.0;
open IN,$kmer_stat_file || die "fail $kmer_stat_file\n";
while (<IN>) {
	next if(/^\s/ || /^\#/);
	s/^>=//;   ##freq最大边界255的也计算在内
	my @t = split /\s+/;
	my $freq = $t[0];
	my $px_rate = $t[2];
	if ($freq <= $lowfreq_cutoff) {
		push @Rates, [$freq,$px_rate];
	}else
	{	push @Rates, [$freq,$px_rate];
		$total_correct_rate += $px_rate;
	}
}
close IN;

print STDERR "\nIn drawing real and theoretic curves, total_correct_rate: $total_correct_rate\n";

for (my $i=0; $i<@Rates; $i++) {
	my $freq = $Rates[$i][0];
	my $adjusted_rate = $Rates[$i][1] / $total_correct_rate * 100;
	$real_kmer_species_str  .= "$freq: $adjusted_rate\n";
}


my $theoretic_kmer_species_str = "\nColor: red\nMark: Theoretic_z1\n";

open IN,$theoretic_kmer_file || die "fail $theoretic_kmer_file\n";
while (<IN>) {
	if (/^(\d+)\s+(\S+)/) {
		my $freq = $1;
		my $rate = $2 * 100;
		$theoretic_kmer_species_str .= "$freq: $rate\n";
	}
}
close IN;

my $theoretic2_kmer_species_str = "\nColor: purple\nMark: Theoretic_z8\n";

open IN,$theoretic2_kmer_file || die "fail $theoretic2_kmer_file\n";
while (<IN>) {
	if (/^(\d+)\s+(\S+)/) {
		my $freq = $1;
		my $rate = $2 * 100;
		$theoretic2_kmer_species_str .= "$freq: $rate\n";
	}
}
close IN;



#output the result .lst file
open OUT, ">$spcies_name\_real_theory_distribution.lst" || die "fail output";
print OUT "$header_str\n$real_kmer_species_str\n$theoretic_kmer_species_str\n$theoretic2_kmer_species_str";
close OUT;


####################################################
################### Sub Routines ###################
####################################################
