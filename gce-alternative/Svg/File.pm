package Svg::File;
require 5.000;

require Exporter;
@ISA = qw(Exporter);
@EXPORT_OK = qw(new header open close);

use Svg::Std qw(message_err message_out svgPrint indent newline);

use strict qw( subs vars refs );

@Svg::File::ISA = qw( Svg::Graphics );

# creates new object
# USAGE: my $FileObj = Svg::File->new();
sub new {
    my $class = shift;
    my $filename =shift;
    my $glob = shift || \*SVGOUT;
    my $self = {"filename" => $filename, "FileHandle" => $glob};
    bless $self, $class;
    $self->initGlobals();
    $self->init();
    $self;
}

# prints standard SVG document header
# N.B. only allowed when the $obj->open() method has the 'noheader' attribute set
# USAGE: $FileObj->header(OPTIONAL [public|encoding_value]);
sub header {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{header} =~ /^true$/) {$self->message_err( "Header already defined", $self->{LineNumber} )}
    elsif ($self->{header} =~ /^false$/) {

	my $type = 0;
	my @arguments = @_;
	for (my $i=0; $i<@arguments; $i++) { 
	    if ($arguments[$i] =~ /^public$/) {$type = 1;splice(@arguments, $i--, 1)}
	}
	if (@arguments[0] =~ /^iso-8859-[0-9]{1,2}$/) {
		$self->svgPrint("<?xml version=\"1.0\" encoding=\"$arguments[0]\"?>");
	} else {
		$self->svgPrint("<?xml version=\"1.0\" standalone=\"no\"?>");
	}
	$self->newline();
	if ( $type == 1 ) {$self->svgPrint("<!DOCTYPE svg PUBLIC \"$self->{Public_ID}\" \"$self->{XML_DTD}\">");$self->newline()}
 	else {$self->svgPrint("<!DOCTYPE svg SYSTEM \"svg.dtd\">");$self->newline()}
	$self->{header} = "true";

    }

}

# initialises object specific variables [private]
sub initGlobals {
    my $self = shift;
    $self->{version} = "1.0.1";
    $self->{info} = "SVG-pl " . $self->{version};
    $self->{copyright} = "Julius Mong, Copyright @ 1999";
    $self->{Public_ID} = "-//W3C//DTD SVG 20001102//EN";
    $self->{XML_DTD} = "http://www.w3.org/TR/2000/CR-SVG-20001102/DTD/svg-20001102.dtd";
    $self->{XML_Link} = "http://www.w3.org/1999/xlink";
    $self->{header} = "false";
    $self->{LineNumber} = 0;
    $self->{ErrorNumber} = 0;
    $self->{FilePath} = "";
    $self->{Debug} = "false";
    $self->{NoNags} = "false";
    $self->{InCGI} = "false";
}

# indicates status of object creation [private]
sub init {
    my $self = shift;
    $self->{LineNumber}++;
}

# opens an output stream specified by user specified filename
# USAGE: $FileObj->open("filename.svg", OPTIONAL [silent|bin|append|noheader|public|debug|encoding]);
sub open {

    my $self = shift;    
    $self->{LineNumber}++;
    my $path = $self->{filename};
    my $bin = "false"; 
    my $mode = "false";
    my $header = "true";
    my $public = "private";
    my $encoding = "empty";
    my @arguments = @_;

    
    if ($path =~ /^cgi$/) {$self->{InCGI} = "true"}

    for (my $i=0; $i<@arguments; $i++) {
	if ($arguments[$i] =~ /^silent$/) {
	    $self->{NoNags} = "true";
	    splice(@arguments, $i--, 1);
	}
    }

    $self->message_out("\n$self->{info} beta release");
    $self->message_out("$self->{copyright}\n");
    $self->message_out("File object created successfully");

    for (my $i=0; $i<@arguments; $i++) {
	if ($arguments[$i] =~ /^bin$/) {
	    $bin = "true";
	    splice(@arguments, $i--, 1);
	} elsif ($arguments[$i] =~ /^append$/) {
	    $mode = "true";
	    splice(@arguments, $i--, 1);
	} elsif ($arguments[$i] =~ /^noheader$/) {
	    $header = "false";
	    splice(@arguments, $i--, 1);
	} elsif ($arguments[$i] =~ /^public$/ && $header =~ /^true$/) {
	    $public = "public";
	    splice(@arguments, $i--, 1);
	} elsif ($arguments[$i] =~ /^encoding$/) {
		(my $attrib, $encoding) = splice(@arguments, $i--, 2);
	} elsif ( $self->{InCGI} =~ /^false$/ && $arguments[$i] =~ /^debug$/ ) {	    
	    open( __EH00, ">>Error.log" ) || $self->message_err( "Cannot open \"Error.log\" for output", $self->{LineNumber} );
	    $self->{Debug} = "true";
	    $self->{ErrorHandle} = \*__EH00;
	    $self->message_out("Error log created successfully");	    
	    my @time = localtime(time);
	    my @months = qw(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec);
	    my $filetime = "$time[2]:$time[1]:$time[0] - $time[3] $months[$time[4]] $time[5]";
	    print __EH00 "***** BEGIN $filetime *****";
	    splice(@arguments, $i--, 1);
	}
    }

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    if ($self->{InCGI} =~ /^false$/) {

    if( !ref($path) ) {
        rename($path,"$path\~") if( -w $path && $self->{pdf_make_file_backup} );
	if ($mode =~ /^true$/) {open( $self->{FileHandle}, ">>$path" ) || $self->message_err( "Cannot open svg file \"$path\" for output", $self->{LineNumber} )}
	else {open( $self->{FileHandle}, ">$path" ) || $self->message_err( "Cannot open svg file \"$path\" for output", $self->{LineNumber} )}
	if ($bin =~ /^true$/) {binmode $self->{FileHandle}}
    } else {
	$self->{FileHandle} = $path;
    }
    $self->{FilePath} = $path;

    }

    if ($header =~ /^true$/) {@arguments = $self->header($public,$encoding)}

}

# closes output stream of the current object
# USAGE: $FileObj->close();
sub close {
    my $self = shift;
    my $fh = ${$self->{FileHandle}};

    if ($self->{InCGI} =~ /^false$/) {

    foreach (@_) {

    my $other = $_;
    $other->{LineNumber}++;


    for (my $i=@{$other->{inQueue}}-1; $i>=0; $i--) {

	# if (!($other->{inBoundary} =~ /^empty$/)) {
	#    print $fh "\n</$other->{inBoundary}>";
	
	$other->message_err("closing tag for boundary \"$other->{inBoundary}\" missing", $other->{LineNumber}, "</$other->{inBoundary}> assumed");
	$other->e();

	# }
	# $other->{inBoundary} = ${$other->{inQueue}}[$i];

    }

    if ($other->{ErrorNumber} != 0) {$self->message_out(" ")}
    $self->message_out("\nExecution completed - SVG document \"$self->{FilePath}\" generated successfully");
    $self->message_out("\nTotal number of statements executed: $other->{LineNumber}");
    $self->message_out("Total number of errors encountered: $other->{ErrorNumber}");
    if ($self->{Debug} =~ /^true$/) {
	$self->message_out("Error messages appended to end of \"Error.log\"");
    }

    } # close g objects
    
    $self->newline();
    
    close $fh or $self->message_err($!);
    if ($self->{Debug} =~ /^true$/) {
	my $eh = ${$self->{ErrorHandle}};
	print $eh "\n***** END *****\n\n";
	$self->{Debug} = "false";
	close $eh or $self->message_err($!);
    }

    } # if CGI

}

1; # Perl notation to end a module