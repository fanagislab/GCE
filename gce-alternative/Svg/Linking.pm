package Svg::Linking;		# define a new package
require 5.000;			# needs version 5, latest version 5.00402
require Exporter;		# standard module for making functions public

@ISA = qw(Exporter);
@EXPORT = qw( beginA endA drawA beginView endView drawView );

# use Svg::Std qw( message_out );

use strict qw ( subs vars refs );

# draws an empty 'a' tag
sub drawA {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^(svg|g|defs|symbol|marker|mask|pattern|switch|a|text|tspan|tref|textPath|glyph|missing-glyph)$/) {

    my @arguments = @_;
    my $href = "empty";

    for (my $i=0; $i<@arguments; $i++) {
	if ($arguments[$i] =~ /^xlink:href$/)	{
		(my $attrib, my $value) = splice(@arguments, $i--, 2);
		if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$href = $value;
	   	} 
	}
    }

    if ($href =~ /^empty$/) {
	$self->message_err("\"xlink:href\" attribute and value required", $self->{LineNumber}, "\"a\" element ignored");
    } else {

    $self->newline();
    $self->indent();
    $self->svgPrint("<a");

    $self->svgPrint(" xlink:href=\"$href\"");

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {	    
	    /^externalResourcesRequired$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reBoolean}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^transform$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^target$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);   
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->xlinkRefAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->PttnAttrsAll(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");

    }

    } else {$self->message_err("element \"a\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens an 'a' boundary
sub beginA {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^(svg|g|defs|symbol|marker|mask|pattern|switch|a|text|tspan|tref|textPath|glyph|missing-glyph)$/) {

    my @arguments = @_;
    my $href = "empty";

    for (my $i=0; $i<@arguments; $i++) {
	if ($arguments[$i] =~ /^xlink:href$/)	{
		(my $attrib, my $value) = splice(@arguments, $i--, 2);
		if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$href = $value;
	   	} 
	}
    }

    if ($href =~ /^empty$/) {
	$self->message_err("\"xlink:href\" attribute and value required", $self->{LineNumber}, "\"a\" element ignored");
	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    } else {

    $self->newline();
    $self->indent();
    $self->svgPrint("<a");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "a";
    $self->{tab}+=1;

    $self->svgPrint(" xlink:href=\"$href\"");
    
    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {	    
	    /^externalResourcesRequired$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reBoolean}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^transform$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^target$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);   
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->xlinkRefAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->PttnAttrsAll(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    }

    } else {
	$self->message_err("element \"a\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes an 'a' boundary
sub endA {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</a>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
}

# draws an empty 'view' tag
sub drawView {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^(svg|g|defs|symbol|marker|mask|pattern|a|glyph|missing-glyph)$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<view");
    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {	    
	    /^externalResourcesRequired$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reBoolean}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^zoomAndPan$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(disable|magnify|zoom)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^viewTarget$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }
    
    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->ViewBoxSpec(@arguments);
    @arguments = $self->PreserveAspectRatioSpec(@arguments);
    
    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");

    } else {$self->message_err("element \"view\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens an 'view' boundary
sub beginView {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^defs$/) {

    push(@{$self->{dtdMetadata}}, $self->{Metadata});
    push(@{$self->{dtdDesc}}, $self->{Desc});
    push(@{$self->{dtdTitle}}, $self->{Title});
    $self->{Metadata} = "empty";
    $self->{Desc} = "empty";
    $self->{Title} = "empty";

    $self->newline();
    $self->indent();
    $self->svgPrint("<view");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "view";
    $self->{tab}+=1;
    my @arguments = @_;
    
    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {	    
	    /^externalResourcesRequired$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reBoolean}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^zoomAndPan$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(disable|magnify|zoom)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^viewTarget$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }
    
    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->ViewBoxSpec(@arguments);
    @arguments = $self->PreserveAspectRatioSpec(@arguments);
    
    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    } else {
	$self->message_err("element \"view\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes an 'view' boundary
sub endView {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</view>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
    $self->{Metadata} = pop(@{$self->{dtdMetadata}});
    $self->{Desc} = pop(@{$self->{dtdDesc}});
    $self->{Title} = pop(@{$self->{dtdTitle}});
}


1; # Perl notation to end a module