The followings are modification to the original SVG package by Fan Wei.

1. add in XML.pm, xmlescp()

## convert one tab to 4 spaces
my $tab = "\t";
my $spaces = " " x 4;
$s=~s/$tab/$spaces/g; ## add by fanwei

2. add in Element.pm text()

$attrs{"xml:space"} = "preserve"; # add by fanw


3. make Font.pm

sub textWidth();

sub initMetrics();

4. delete 2 lines in XML.pm xmlescp()

$s=~s/([\x00-\x1f])/sprintf('&#x%02X;',chr($1))/eg; #delete by fanw
$s=~s/([\200-\377])/'&#'.ord($1).';'/ge; #delete by fanw