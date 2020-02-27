package Svg::Extensibility;	# define a new package
require 5.000;			# needs version 5, latest version 5.00402
require Exporter;		# standard module for making functions public

@ISA = qw(Exporter);
@EXPORT_OK = qw( drawForeignObj beginForeignObj endForeignObj );

# use Svg::Std qw( message_out );

use strict qw ( subs vars refs );

# draws an empty 'foreignObject' tag
sub drawForeignObj {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^switch$/) {

    my @arguments = @_;
    my $width = "empty";
    my $height = "empty";

    for (my $i=0; $i<@arguments; $i++) {
	if ($arguments[$i] =~ /^width$/) {
		(my $attrib, my $value) = splice(@arguments, $i--, 2);
		if ($value =~ /^$self->{reLength}$/) {
			$width = $value;
		} else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
	}
	if ($arguments[$i] =~ /^height$/) {
		(my $attrib, my $value) = splice(@arguments, $i--, 2);
		if ($value =~ /^$self->{reLength}$/) {
			$height = $value;
		} else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
	}
    }

    if ($width =~ /^empty$/ && $height =~ /^empty$/) {
	$self->message_err("\"width\" and \"height\" attributes and values required", $self->{LineNumber}, "\"foreignObject\" element ignored");
    } elsif ($width =~ /^empty$/) {
	$self->message_err("\"width\" attribute and value required", $self->{LineNumber}, "\"foreignObject\" element ignored");
    } elsif ($height =~ /^empty$/) {
	$self->message_err("\"height\" attribute and value required", $self->{LineNumber}, "\"foreignObject\" element ignored");
    } else {

    $self->newline();
    $self->indent();
    $self->svgPrint("<foreignObject");

    $self->svgPrint(" width=\"$width\"");
    $self->svgPrint(" height=\"$height\"");

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
	    /^transform$/ && 
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    $self->svgPrint(" transform=\"$value\"");
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->PttnAttrsAll(@arguments);
    @arguments = $self->XY(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);
    @arguments = $self->structuredTxt(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");

    }

    } else {$self->message_err("element \"foreignObject\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'foreignObject' boundary
sub beginForeignObj {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^switch$/) {

    my @arguments = @_;
    my $width = "empty";
    my $height = "empty";

    for (my $i=0; $i<@arguments; $i++) {
	if ($arguments[$i] =~ /^width$/) {
		(my $attrib, my $value) = splice(@arguments, $i--, 2);
		if ($value =~ /^$self->{reLength}$/) {
			$width = $value;
		} else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
	}
	if ($arguments[$i] =~ /^height$/) {
		(my $attrib, my $value) = splice(@arguments, $i--, 2);
		if ($value =~ /^$self->{reLength}$/) {
			$height = $value;
		} else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
	}
    }

    if ($width =~ /^empty$/ && $height =~ /^empty$/) {
	$self->message_err("\"width\" and \"height\" attributes and values required", $self->{LineNumber}, "\"foreignObject\" element ignored");
	push(@{$self->{inQueue}}, $self->{inBoundary});
	$self->{inBoundary} = "empty";
    } elsif ($width =~ /^empty$/) {
	$self->message_err("\"width\" attribute and value required", $self->{LineNumber}, "\"foreignObject\" element ignored");
	push(@{$self->{inQueue}}, $self->{inBoundary});
	$self->{inBoundary} = "empty";
    } elsif ($height =~ /^empty$/) {
	$self->message_err("\"height\" attribute and value required", $self->{LineNumber}, "\"foreignObject\" element ignored");
	push(@{$self->{inQueue}}, $self->{inBoundary});
	$self->{inBoundary} = "empty";
    } else {

    $self->newline();
    $self->indent();
    $self->svgPrint("<foreignObject");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "foreignObject";
    $self->{tab}+=1;

    $self->svgPrint(" width=\"$width\"");
    $self->svgPrint(" height=\"$height\"");

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
	    /^transform$/ && 
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    $self->svgPrint(" transform=\"$value\"");
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->PttnAttrsAll(@arguments);
    @arguments = $self->XY(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);
    @arguments = $self->structuredTxt(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    }

    } else {
	$self->message_err("element \"foreignObject\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
	$self->{inBoundary} = "empty";
    }

}

# closes a 'foreignObject' boundary
# USAGE: $GraphicsObj->endForeignObj();
sub endForeignObj {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</foreignObject>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
}


1; # Perl notation to end a module