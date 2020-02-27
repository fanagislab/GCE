package Svg::Custom;		# define a new package
require 5.000;				# needs version 5, latest version 5.00402
require Exporter;			# standard module for making functions public

@ISA = qw(Exporter);
@EXPORT = qw(	drawCursor beginCursor endCursor
				drawCustom beginCustom endCustom
				printTxt	);

# use Svg::Std qw( message_out );

use strict qw ( subs vars refs );

# prints raw text
# USAGE: $GraphicsObj->printTxt( ...plain text... );
sub printTxt {
    my $self = shift;
    $self->{LineNumber}++;
    # $self->newline();
    # $self->indent();
    $self->svgPrint(@_);
}

# draws an empty 'cursor' tag
sub drawCursor {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|mask|pattern|a)$/) {
    
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
	$self->message_err("\"xlink:href\" attribute and value required", $self->{LineNumber}, "\"cursor\" element ignored");
    } else {

    $self->newline();
    $self->indent();
    $self->svgPrint("<cursor");

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
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);    
    @arguments = $self->xlinkRefAttrs(@arguments);
    @arguments = $self->XY(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");

    }

    } else {$self->message_err("element \"cursor\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'cursor' boundary
sub beginCursor {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}    

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|mask|pattern|a)$/) {
    
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
	$self->message_err("\"xlink:href\" attribute and value required", $self->{LineNumber}, "\"cursor\" element ignored");
	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    } else {

    $self->newline();
    $self->indent();
    $self->svgPrint("<cursor");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "cursor";
    $self->{tab}+=1;

    push(@{$self->{dtdMetadata}}, $self->{Metadata});
    push(@{$self->{dtdDesc}}, $self->{Desc});
    push(@{$self->{dtdTitle}}, $self->{Title});
    $self->{Metadata} = "empty";
    $self->{Desc} = "empty";
    $self->{Title} = "empty";
    
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
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);    
    @arguments = $self->xlinkRefAttrs(@arguments);
    @arguments = $self->XY(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    }

    } else {
	$self->message_err("element \"cursor\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
	$self->{inBoundary} = "empty";
    }

}

# closes a 'cursor' boundary
# USAGE: $GraphicsObj->endCursor();
sub endCursor {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</cursor>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
    $self->{Metadata} = pop(@{$self->{dtdMetadata}});
    $self->{Desc} = pop(@{$self->{dtdDesc}});
    $self->{Title} = pop(@{$self->{dtdTitle}});
}

# draws an empty custom tag
# USAGE: 
# 	$GraphicsObj->drawCustom( tagName, inBoundary, OPTIONAL arguments, 
#				  [std|geo|gEvts|docEvts|strTxt|xlink] );
sub drawCustom {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    my $tagname = shift;
    my $boundary = shift;

    if ($self->{inBoundary} =~ /^$boundary$/) {

    my @arguments = @_;
    $self->newline();
    $self->indent();
    $self->svgPrint("<$tagname");

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	     /^stdAttrs$/ &&
		do {
		    splice(@arguments, $i--, 1);
		    @arguments = $self->stdAttrs(@arguments);
		    last SWITCH;
		};
	     /^geometricAttrs$/ &&
		do {
		    splice(@arguments, $i--, 1);
		    @arguments = $self->geometricAttrs(@arguments);
		    last SWITCH;
		};
	     /^animEevents$/ &&
		do {
		    splice(@arguments, $i--, 1);
		    @arguments = $self->animationEvents(@arguments);
		    last SWITCH;
		};
	     /^gEvents$/ &&
		do {
		    splice(@arguments, $i--, 1);
		    @arguments = $self->graphicsElementEvents(@arguments);
		    last SWITCH;
		};
	     /^docEvts$/ &&
		do {
		    splice(@arguments, $i--, 1);
		    @arguments = $self->documentEvents(@arguments);
		    last SWITCH;
		};
	     /^structuredTxt$/ &&
		do {
		    splice(@arguments, $i--, 1);
		    @arguments = $self->structuredTxt(@arguments);
		    last SWITCH;
		};
	     /^xlinkRefAttrs$/ &&
		do {
		    splice(@arguments, $i--, 1);
		    @arguments = $self->xlinkRefAttrs(@arguments);
		    last SWITCH;
		};
	     /^langSpaceAttrs$/ &&
		do {
		    splice(@arguments, $i--, 1);
		    @arguments = $self->langSpaceAttrs(@arguments);
		    last SWITCH;
		};
	     /^ClassStyle$/ &&
		do {
		    splice(@arguments, $i--, 1);
		    @arguments = $self->ClassStyle(@arguments);
		    last SWITCH;
		};
	     /^testAttrs$/ &&
		do {
		    splice(@arguments, $i--, 1);
		    @arguments = $self->testAttrs(@arguments);
		    last SWITCH;
		};
	}
    }

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	(my $attrib, my $value) = splice(@arguments, $i--, 2);
	if ($value =~ /^$self->{reAnyOneOrMore}$/) {
	    $self->svgPrint(" $attrib=\"$value\"");
	} else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}		
    }

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");

    } else {$self->message_err("element \"$tagname\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a custom boundary
# USAGE: 
# 	$GraphicsObj->beginCustom( tagName, inBoundary, OPTIONAL arguments, 
#				   [std|geo|gEvts|docEvts|strTxt|xlink] );
sub beginCustom {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    my $tagname = shift;
    my $boundary = shift;

    if ($self->{inBoundary} =~ /^$boundary$/) {

    my @arguments = @_;
    $self->newline();
    $self->indent();
    $self->svgPrint("<$tagname");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = $tagname;
    $self->{tab}+=1;

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {	     /^stdAttrs$/ &&
		do {
		    splice(@arguments, $i--, 1);
		    @arguments = $self->stdAttrs(@arguments);
		    last SWITCH;
		};
	     /^geometricAttrs$/ &&
		do {
		    splice(@arguments, $i--, 1);
		    @arguments = $self->geometricAttrs(@arguments);
		    last SWITCH;
		};
	     /^animEevents$/ &&
		do {
		    splice(@arguments, $i--, 1);
		    @arguments = $self->animationEvents(@arguments);
		    last SWITCH;
		};
	     /^gEvents$/ &&
		do {
		    splice(@arguments, $i--, 1);
		    @arguments = $self->graphicsElementEvents(@arguments);
		    last SWITCH;
		};
	     /^docEvts$/ &&
		do {
		    splice(@arguments, $i--, 1);
		    @arguments = $self->documentEvents(@arguments);
		    last SWITCH;
		};
	     /^structuredTxt$/ &&
		do {
		    splice(@arguments, $i--, 1);
		    @arguments = $self->structuredTxt(@arguments);
		    last SWITCH;
		};
	     /^xlinkRefAttrs$/ &&
		do {
		    splice(@arguments, $i--, 1);
		    @arguments = $self->xlinkRefAttrs(@arguments);
		    last SWITCH;
		};
	     /^langSpaceAttrs$/ &&
		do {
		    splice(@arguments, $i--, 1);
		    @arguments = $self->langSpaceAttrs(@arguments);
		    last SWITCH;
		};
	     /^ClassStyle$/ &&
		do {
		    splice(@arguments, $i--, 1);
		    @arguments = $self->ClassStyle(@arguments);
		    last SWITCH;
		};
	     /^testAttrs$/ &&
		do {
		    splice(@arguments, $i--, 1);
		    @arguments = $self->testAttrs(@arguments);
		    last SWITCH;
		};
	}
    }

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	(my $attrib, my $value) = splice(@arguments, $i--, 2);
	if ($value =~ /^$self->{reAnyOneOrMore}$/) {
	    $self->svgPrint(" $attrib=\"$value\"");
	} else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}		
    }

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    } else {
	$self->message_err("element \"$tagname\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
	$self->{inBoundary} = "empty";
    }

}

# closes a custom boundary
# USAGE: $GraphicsObj->endCustom();
sub endCustom {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();
    $self->indent();
    $self->svgPrint("</$self->{inBoundary}>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
}


1; # Perl notation to end a module