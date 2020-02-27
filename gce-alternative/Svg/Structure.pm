package Svg::Structure;		# define a new package
require 5.000;				# needs version 5, latest version 5.00402
require Exporter;			# standard module for making functions public

@ISA = qw(Exporter);
@EXPORT_OK = qw( 	drawG beginG endG drawDefs beginDefs endDefs 
				 	drawMetadata beginMetadata endMetadata
		 			drawDesc beginDesc endDesc drawTitle beginTitle endTitle
				 	beginUse endUse drawUse beginImage endImage drawImage
				 	beginMarker endMarker drawMarker 
				 	beginSymbol endSymbol drawSymbol 
				 	drawSwitch beginSwitch endSwitch 	);

# use Svg::Std qw ( message_out );

use strict qw ( subs vars refs );

# draws an empty 'g' tag
sub drawG {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|mask|pattern|a|switch)$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<g");
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
	    /^transform$/ && 
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    $self->svgPrint(" $attrib=\"$value\"");
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);	
    @arguments = $self->langSpaceAttrs(@arguments); 
    @arguments = $self->PttnAttrsAll(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint("/>");

    } else {$self->message_err("element \"g\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'g' boundary
sub beginG {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|mask|pattern|a|switch)$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<g");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "g";
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
	    /^transform$/ && 
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    $self->svgPrint(" $attrib=\"$value\"");
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);	
    @arguments = $self->langSpaceAttrs(@arguments); 
    @arguments = $self->PttnAttrsAll(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    } else {
	$self->message_err("element \"g\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'g' boundary
sub endG {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</g>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
}

# draws an empty 'defs' tag
sub drawDefs {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|mask|pattern|a)$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<defs");
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
	    /^transform$/ && 
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    $self->svgPrint(" $attrib=\"$value\"");
		    last SWITCH;
		};
	}
    }
    
    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);	
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->PttnAttrsAll(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");

    } else {$self->message_err("element \"defs\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'defs' boundary
sub beginDefs{

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|mask|pattern|a)$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<defs");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "defs";
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
	    /^transform$/ && 
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    $self->svgPrint(" $attrib=\"$value\"");
		    last SWITCH;
		};
	}
    }
    
    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);	
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->PttnAttrsAll(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);
    
    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    } else {
	$self->message_err("element \"defs\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
	$self->{inBoundary} = "empty";
    }
}

# closes a 'defs' boundary
sub endDefs {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</defs>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
}

# draws an empty 'metadata' tag
sub drawMetadata {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^(svg|g|defs|symbol|use|image|switch|path|rect|circle|ellipse|line|polyline|polygon|text|tspan|tref|textPath|marker|color-profile|linearGradient|radialGradient|pattern|clipPath|mask|filter|cursor|a|view|animate|set|animateMotion|mpath|animateColor|animateTransform|font|glyph|missing-glyph|font-face)$/) {

    if ($self->{Metadata} =~ /^$self->{inBoundary}$/) {
	$self->message_err("only one \"metadata\" is allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    } else {

	$self->{Metadata} = $self->{inBoundary};
    	$self->newline();
    	$self->indent();
	$self->svgPrint("<metadata");
    
    	my @arguments = @_;

    	@arguments = $self->stdAttrs(@arguments);

    	if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    	$self->svgPrint("/>");

    }

    } else {$self->message_err("element \"metadata\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'metadata' boundary
sub beginMetadata {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^(svg|g|defs|symbol|use|image|switch|path|rect|circle|ellipse|line|polyline|polygon|text|tspan|tref|textPath|marker|color-profile|linearGradient|radialGradient|pattern|clipPath|mask|filter|cursor|a|view|animate|set|animateMotion|mpath|animateColor|animateTransform|font|glyph|missing-glyph|font-face)$/) {

    if ($self->{Metadata} =~ /^$self->{inBoundary}$/) {
	$self->message_err("only one \"metadata\" is allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    } else {

	$self->{Metadata} = $self->{inBoundary};
	$self->newline();
    	$self->indent();
    	$self->svgPrint("<metadata");
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "metadata";
    	$self->{tab}+=1;
    	my @arguments = @_;

    	@arguments = $self->stdAttrs(@arguments);

    	if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    	$self->svgPrint(">");

    }

    } else {
	$self->message_err("element \"metadata\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'metadata' boundary
sub endMetadata {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</metadata>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
}

# draws an empty 'desc' tag
sub drawDesc {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^(svg|g|defs|symbol|use|image|switch|path|rect|circle|ellipse|line|polyline|polygon|text|tspan|tref|textPath|marker|color-profile|linearGradient|radialGradient|pattern|clipPath|mask|filter|cursor|a|view|animate|set|animateMotion|mpath|animateColor|animateTransform|font|glyph|missing-glyph|font-face)$/) {

    if ($self->{Desc} =~ /^$self->{inBoundary}$/) {
	$self->message_err("only one \"desc\" is allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    } else {

	$self->{Desc} = $self->{inBoundary};
    	$self->newline();
    	$self->indent();
    	$self->svgPrint("<desc");
    	my @arguments = @_;

    	@arguments = $self->stdAttrs(@arguments);
	@arguments = $self->langSpaceAttrs(@arguments);
	@arguments = $self->ClassStyle(@arguments);
    	@arguments = $self->structuredTxt(@arguments);

    	if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    	$self->svgPrint("/>");

    }

    } else {$self->message_err("element \"desc\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'desc' boundary
sub beginDesc {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^(svg|g|defs|symbol|use|image|switch|path|rect|circle|ellipse|line|polyline|polygon|text|tspan|tref|textPath|marker|color-profile|linearGradient|radialGradient|pattern|clipPath|mask|filter|cursor|a|view|animate|set|animateMotion|mpath|animateColor|animateTransform|font|glyph|missing-glyph|font-face)$/) {

    if ($self->{Desc} =~ /^$self->{inBoundary}$/) {
	$self->message_err("only one \"desc\" is allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    } else {

	$self->{Desc} = $self->{inBoundary};
    	$self->newline();
    	$self->indent();
    	$self->svgPrint("<desc");
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "desc";
    	$self->{tab}+=1;
    	my @arguments = @_;

    	@arguments = $self->stdAttrs(@arguments);
	@arguments = $self->langSpaceAttrs(@arguments);
	@arguments = $self->ClassStyle(@arguments);
    	@arguments = $self->structuredTxt(@arguments);

    	if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    	$self->svgPrint(">");

    }

    } else {
	$self->message_err("element \"desc\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'desc' boundary
sub endDesc {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</desc>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
}

# draws an empty 'title' tag
sub drawTitle {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^(svg|g|defs|symbol|use|image|switch|path|rect|circle|ellipse|line|polyline|polygon|text|tspan|tref|textPath|marker|color-profile|linearGradient|radialGradient|pattern|clipPath|mask|filter|cursor|a|view|animate|set|animateMotion|mpath|animateColor|animateTransform|font|glyph|missing-glyph|font-face)$/) {

    if ($self->{Title} =~ /^$self->{inBoundary}$/) {
	$self->message_err("only one \"title\" is allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    } else {

	$self->{Title} = $self->{inBoundary};
   	$self->newline();
    	$self->indent();
    	$self->svgPrint("<title");
    	my @arguments = @_;
   	
    	@arguments = $self->stdAttrs(@arguments);
	@arguments = $self->langSpaceAttrs(@arguments);
	@arguments = $self->ClassStyle(@arguments);
    	@arguments = $self->structuredTxt(@arguments);

    	if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    	$self->svgPrint("/>");

    }

    } else {$self->message_err("element \"title\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'title' boundary
sub beginTitle {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^(svg|g|defs|symbol|use|image|switch|path|rect|circle|ellipse|line|polyline|polygon|text|tspan|tref|textPath|marker|color-profile|linearGradient|radialGradient|pattern|clipPath|mask|filter|cursor|a|view|animate|set|animateMotion|mpath|animateColor|animateTransform|font|glyph|missing-glyph|font-face)$/) {

    if ($self->{Title} =~ /^$self->{inBoundary}$/) {
	$self->message_err("only one \"title\" is allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    } else {

	$self->{Title} = $self->{inBoundary};
   	$self->newline();
    	$self->indent();
    	$self->svgPrint("<title");
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "title";
    	$self->{tab}+=1;
    	my @arguments = @_;

    	@arguments = $self->stdAttrs(@arguments);
	@arguments = $self->langSpaceAttrs(@arguments);
	@arguments = $self->ClassStyle(@arguments);
    	@arguments = $self->structuredTxt(@arguments);

    	if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    	$self->svgPrint(">");

    }

    } else {
	$self->message_err("element \"title\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'title' boundary
sub endTitle {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</title>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
}

# draws an empty 'use' tag
sub drawUse {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^(svg|g|defs|symbol|switch|marker|pattern|clipPath|mask|a|glyph|missing-glyph)$/) {

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
	$self->message_err("\"xlink:href\" attribute and value required", $self->{LineNumber}, "\"use\" element ignored");
    } else {

    $self->newline();
    $self->indent();
    $self->svgPrint("<use");

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
	    /^transform$/ && 
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    $self->svgPrint(" $attrib=\"$value\"");
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->xlinkRefAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->PttnAttrsAll(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->geometricAttrs(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");

    }

    } else {$self->message_err("element \"use\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'use' boundary
sub beginUse {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^(svg|g|defs|symbol|switch|marker|pattern|clipPath|mask|a|glyph|missing-glyph)$/) {

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
	$self->message_err("\"xlink:href\" attribute and value required", $self->{LineNumber}, "\"use\" element ignored");
	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    } else {

    $self->newline();
    $self->indent();
    $self->svgPrint("<use");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "use";
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
	    /^transform$/ && 
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    $self->svgPrint(" $attrib=\"$value\"");
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->xlinkRefAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->PttnAttrsAll(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->geometricAttrs(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    }

    } else {
	$self->message_err("element \"use\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'use' boundary
sub endUse {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</use>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
    $self->{Metadata} = pop(@{$self->{dtdMetadata}});
    $self->{Desc} = pop(@{$self->{dtdDesc}});
    $self->{Title} = pop(@{$self->{dtdTitle}});
}

# draws an empty 'image' tag
sub drawImage {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|mask|pattern|filter|a|switch)$/) {

    my @arguments = @_;
    my $width = "empty";
    my $height = "empty";
    my $href = "empty";

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
	if ($arguments[$i] =~ /^xlink:href$/)	{
		(my $attrib, my $value) = splice(@arguments, $i--, 2);
		if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$href = $value;
	   	} 
	}
    }

    if ($width =~ /^empty$/ && $height =~ /^empty$/ && $href =~ /^empty$/) {
	$self->message_err("\"width\", \"height\" and \"xlink:href\" attributes and values required", $self->{LineNumber}, "\"image\" element ignored");
    } elsif ($width =~ /^empty$/ && $height =~ /^empty$/) {
	$self->message_err("\"width\" and \"height\" attributes and values required", $self->{LineNumber}, "\"image\" element ignored");
    } elsif ($width =~ /^empty$/ && $href =~ /^empty$/) {
	$self->message_err("\"width\" and \"xlink:href\" attributes and values required", $self->{LineNumber}, "\"image\" element ignored");
    } elsif ($height =~ /^empty$/ && $href =~ /^empty$/) {
	$self->message_err("\"height\" and \"xlink:href\" attributes and values required", $self->{LineNumber}, "\"image\" element ignored");
    } elsif ($width =~ /^empty$/) {
	$self->message_err("\"width\" attribute and value required", $self->{LineNumber}, "\"image\" element ignored");
    } elsif ($height =~ /^empty$/) {
	$self->message_err("\"height\" attribute and value required", $self->{LineNumber}, "\"image\" element ignored");
    } elsif ($href =~ /^empty$/) {
	$self->message_err("\"xlink:href\" attribute and value required", $self->{LineNumber}, "\"image\" element ignored");
    } else {

    $self->newline();
    $self->indent();
    $self->svgPrint("<image");

    $self->svgPrint(" width=\"$width\"");
    $self->svgPrint(" height=\"$height\"");
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
	    /^transform$/ && 
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    $self->svgPrint(" $attrib=\"$value\"");
		    last SWITCH;
		};
	}
    }
    
    @arguments = $self->PreserveAspectRatioSpec(@arguments);
    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->xlinkRefAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->Graphics(@arguments);
    @arguments = $self->Images(@arguments);
    @arguments = $self->Viewports(@arguments); 
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->XY(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");

    }

    } else {$self->message_err("element \"image\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'image' boundary
sub beginImage {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|mask|pattern|filter|a|switch)$/) {

    my @arguments = @_;
    my $width = "empty";
    my $height = "empty";
    my $href = "empty";

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
	if ($arguments[$i] =~ /^xlink:href$/)	{
		(my $attrib, my $value) = splice(@arguments, $i--, 2);
		if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$href = $value;
	   	} 
	}
    }

    if ($width =~ /^empty$/ && $height =~ /^empty$/ && $href =~ /^empty$/) {
	$self->message_err("\"width\", \"height\" and \"xlink:href\" attributes and values required", $self->{LineNumber}, "\"image\" element ignored");
	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    } elsif ($width =~ /^empty$/ && $height =~ /^empty$/) {
	$self->message_err("\"width\" and \"height\" attributes and values required", $self->{LineNumber}, "\"image\" element ignored");
	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    } elsif ($width =~ /^empty$/ && $href =~ /^empty$/) {
	$self->message_err("\"width\" and \"xlink:href\" attributes and values required", $self->{LineNumber}, "\"image\" element ignored");
	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    } elsif ($height =~ /^empty$/ && $href =~ /^empty$/) {
	$self->message_err("\"height\" and \"xlink:href\" attributes and values required", $self->{LineNumber}, "\"image\" element ignored");
	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    } elsif ($width =~ /^empty$/) {
	$self->message_err("\"width\" attribute and value required", $self->{LineNumber}, "\"image\" element ignored");
	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    } elsif ($height =~ /^empty$/) {
	$self->message_err("\"height\" attribute and value required", $self->{LineNumber}, "\"image\" element ignored");
	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    } elsif ($href =~ /^empty$/) {
	$self->message_err("\"xlink:href\" attribute and value required", $self->{LineNumber}, "\"image\" element ignored");
	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    } else {

    $self->newline();
    $self->indent();
    $self->svgPrint("<image");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "image";
    $self->{tab}+=1;

    push(@{$self->{dtdMetadata}}, $self->{Metadata});
    push(@{$self->{dtdDesc}}, $self->{Desc});
    push(@{$self->{dtdTitle}}, $self->{Title});
    $self->{Metadata} = "empty";
    $self->{Desc} = "empty";
    $self->{Title} = "empty";

    $self->svgPrint(" width=\"$width\"");
    $self->svgPrint(" height=\"$height\"");
    $self->svgPrint(" xlink:href=\"$href\"");

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^transform$/ && 
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    $self->svgPrint(" $attrib=\"$value\"");
		    last SWITCH;
		};
	}
    }

    @arguments = $self->PreserveAspectRatioSpec(@arguments);
    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->xlinkRefAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->Graphics(@arguments);
    @arguments = $self->Images(@arguments);
    @arguments = $self->Viewports(@arguments); 
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->XY(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    }

    } else {
	$self->message_err("element \"image\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'image' boundary
sub endImage {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</image>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
    $self->{Metadata} = pop(@{$self->{dtdMetadata}});
    $self->{Desc} = pop(@{$self->{dtdDesc}});
    $self->{Title} = pop(@{$self->{dtdTitle}});
}

# draws an empty 'symbol' tag
sub drawSymbol {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^(svg|g|defs|symbol|marker|pattern|mask|a|glyph|missing-glyph)$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<symbol");
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
	}
    }

    @arguments = $self->PreserveAspectRatioSpec(@arguments);
    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->PttnAttrsAll(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->ViewBoxSpec(@arguments);    
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");

    } else {$self->message_err("element \"symbol\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'symbol' boundary
sub beginSymbol {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^(svg|g|defs|symbol|marker|pattern|mask|a|glyph|missing-glyph)$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<symbol");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "symbol";
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
	}
    }

    @arguments = $self->PreserveAspectRatioSpec(@arguments);
    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->PttnAttrsAll(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->ViewBoxSpec(@arguments);    
    @arguments = $self->graphicsElementEvents(@arguments);
    
    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    } else {
	$self->message_err("element \"symbol\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'symbol' boundary
sub endSymbol {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</symbol>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
}

# draws an empty 'switch' tag
sub drawSwitch {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|mask|pattern|a|switch)$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<switch");
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
	    /^transform$/ && 
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    $self->svgPrint(" $attrib=\"$value\"");
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->PttnAttrsAll(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");

    } else {$self->message_err("element \"switch\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'switch' boundary
sub beginSwitch {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}    

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|mask|pattern|a|switch)$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<switch");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "switch";
    $self->{tab}+=1;
    my @arguments = @_;

    push(@{$self->{dtdMetadata}}, $self->{Metadata});
    push(@{$self->{dtdDesc}}, $self->{Desc});
    push(@{$self->{dtdTitle}}, $self->{Title});
    $self->{Metadata} = "empty";
    $self->{Desc} = "empty";
    $self->{Title} = "empty";

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
		    $self->svgPrint(" $attrib=\"$value\"");
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->PttnAttrsAll(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    } else {
	$self->message_err("element \"switch\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
	$self->{inBoundary} = "empty";
    }

}

# closes a 'switch' boundary
sub endSwitch {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</switch>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
    $self->{Metadata} = pop(@{$self->{dtdMetadata}});
    $self->{Desc} = pop(@{$self->{dtdDesc}});
    $self->{Title} = pop(@{$self->{dtdTitle}});
}

use strict qw ( subs vars refs );
sub drawMarker {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|mask|pattern|a)$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<marker");
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
	    /^refX$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^[+-]?[0-9]+(\.[0-9]+)?\%?$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^refY$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^[+-]?[0-9]+(\.[0-9]+)?\%?$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^markerUnits$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(strokeWidth|userSpaceOnUse)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	     /^markerWidth$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reLength}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	     /^markerHeight$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reLength}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	     /^orient$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(auto|$self->{re360}|$self->{reNumber}(deg|rad|grad)?)$/) {
			$self->svgPrint(" orient=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->PttnAttrsAll(@arguments);
    @arguments = $self->ViewBoxSpec(@arguments);
    @arguments = $self->PreserveAspectRatioSpec(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");

    } else {$self->message_err("element \"marker\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'marker' boundary
sub beginMarker {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^defs$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<marker");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "marker";
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
	    /^refX$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^[+-]?[0-9]+(\.[0-9]+)?\%?$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^refY$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^[+-]?[0-9]+(\.[0-9]+)?\%?$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^markerUnits$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(strokeWidth|userSpaceOnUse)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	     /^markerWidth$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reLength}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	     /^markerHeight$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reLength}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	     /^orient$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(auto|$self->{re360}|$self->{reNumber}(deg|rad|grad)?)$/) {
			$self->svgPrint(" orient=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->PttnAttrsAll(@arguments);
    @arguments = $self->ViewBoxSpec(@arguments);
    @arguments = $self->PreserveAspectRatioSpec(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    } else {
	$self->message_err("element \"marker\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'marker' boundary
sub endMarker {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</marker>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
}

1; # Perl notation to end a module