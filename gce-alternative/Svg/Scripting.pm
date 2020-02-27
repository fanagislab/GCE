package Svg::Scripting;		# define a new package
require 5.000;			# needs version 5, latest version 5.00402
require Exporter;		# standard module for making functions public

@ISA = qw(Exporter);
@EXPORT = qw(	drawScript beginScript endScript
				drawStyle beginStyle endStyle	);

# use Svg::Std qw( message_out );

use strict qw ( subs vars refs );

# draws an empty 'script' tag
sub drawScript {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|mask|pattern|a)$/) {
    
    $self->newline();
    $self->indent();
    $self->svgPrint("<script");
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
	    /^type$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	     /^xlink:href$/	&&
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
    @arguments = $self->xlinkRefAttrs(@arguments);
    
    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");

    } else {$self->message_err("element \"script\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'script' boundary
sub beginScript {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|mask|pattern|a)$/) {
    
    $self->newline();
    $self->indent();
    $self->svgPrint("<script");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "script";
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
	    /^type$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	     /^xlink:href$/	&&
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
    @arguments = $self->xlinkRefAttrs(@arguments);
    
    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    } else {
	$self->message_err("element \"script\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'script' boundary
sub endScript {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</script>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
}

# draws an empty 'style' tag
sub drawStyle {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|mask|pattern|a)$/) {
    
    $self->newline();
    $self->indent();
    $self->svgPrint("<style");
    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^type$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^xml:space$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(default|preserve)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^media$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^title$/	&&
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

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");

    } else {$self->message_err("element \"style\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'style' boundary
sub beginStyle {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|mask|pattern|a)$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<style");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "style";
    $self->{tab}+=1;
    my @arguments = @_;
    
    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^type$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^xml:space$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(default|preserve)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^media$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^title$/	&&
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

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    } else {
	$self->message_err("element \"style\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'style' boundary
sub endStyle {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</style>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
}


1; # Perl notation to end a module