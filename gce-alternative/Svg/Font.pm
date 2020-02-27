package Svg::Font;		# define a new package
require 5.000;			# needs version 5, latest version 5.00402
require Exporter;		# standard module for making functions public

@ISA = qw(Exporter);
@EXPORT = qw( 	beginFont endFont beginMGlyph endMGlyph drawMGlyph 
				beginGlyph endGlyph drawGlyph drawHkern drawVkern
				drawFontFace beginFontFace endFontFace
				drawFontFaceSrc beginFontFaceSrc endFontFaceSrc
				drawFontFaceUri beginFontFaceUri endFontFaceUri
				drawFontFaceFormat beginFontFaceFormat endFontFaceFormat
				drawFontFaceName beginFontFaceName endFontFaceName
				drawDefinitionSrc beginDefinitionSrc endDefinitionSrc
				initMetrics charWidth textWidth 
				setFontSize setFontFamily setFontColor
				setCharSpacing setWordSpacing setHorizScaling	);

use strict qw ( subs vars refs );

sub setFontSize {
	(my $self, my $fontsize) = @_;
	$self->{LineNumber}++;
	if ($fontsize =~ /^$self->{reLength}$/) {$self->{fontsize} = $fontsize}
	else {$self->message_err("\"font-size\" value not valid", $self->{LineNumber})}
}

sub setFontFamily {
	(my $self, my $fontfamily) = @_;
	$self->{LineNumber}++;
	if ($fontfamily =~ /^(Helvetica|Helvetica-Bold|Helvetica-BoldOblique|Helvetica-Oblique|Times-Bold|Times-BoldItalic|Times-Italic|Times-Roman|Courier|Symbol|ZapfDingbats|ArialNarrow|ArialNarrow-Bold|ArialNarrow-Italic|ArialNarrow-BoldItalic)$/) {
		$self->{fontfamily} = $fontfamily ;
		$self->initMetrics($fontfamily) ;
	} else {$self->message_err("\"font-family\" value not valid", $self->{LineNumber})}
}

sub setFontColor {
	(my $self, my $fontcolor) = @_;
	$self->{LineNumber}++;
	if ($fontcolor =~ /^$self->{reAnyOneOrMore}$/) {
		$self->{fontcolor} = $fontcolor
	} else {$self->message_err("\"font-color\" value not valid", $self->{LineNumber})}
}

sub setCharSpacing {
	(my $self, my $charspacing) = @_;
	$self->{LineNumber}++;
	if ($charspacing =~ /^$self->{reUnsignNumber}$/) {$self->{charspacing} = $charspacing}
	else {$self->message_err("\"charspacing\" value not valid", $self->{LineNumber})}
}

sub setWordSpacing {
	(my $self, my $wordspacing) = @_;
	$self->{LineNumber}++;
	if ($wordspacing =~ /^$self->{reUnsignNumber}$/) {$self->{wordspacing} = $wordspacing}
	else {$self->message_err("\"wordspacing\" value not valid", $self->{LineNumber})}
}

sub setHorizScaling {
	(my $self, my $hscaling) = @_;
	$self->{LineNumber}++;
	if ($hscaling =~ /^$self->{reUnsignNumber}$/) {$self->{hscaling} = $hscaling}
	else {$self->message_err("\"horizontal-scaling\" value not valid", $self->{LineNumber})}
}

# opens a 'font' boundary
sub beginFont {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^(svg|g|defs|symbol|marker|mask|pattern|a|glyph|missing-glyph)$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<font");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "font";
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
	    /^horiz-origin-x$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^horiz-origin-y$/	&& 
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	     /^horiz-adv-x$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	     /^vert-origin-x$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	     /^vert-origin-y$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	     /^vert-adv-y$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->PttnAttrsAll(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    } else {
	$self->message_err("element \"font\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'font' boundary
sub endFont {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</font>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
    $self->{Metadata} = pop(@{$self->{dtdMetadata}});
    $self->{Desc} = pop(@{$self->{dtdDesc}});
    $self->{Title} = pop(@{$self->{dtdTitle}});
}

# draws an empty 'missing-glyph' tag
sub drawMGlyph {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^font$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<missing-glyph");
    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	     /^d$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^horiz-adv-x$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	     /^vert-origin-x$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	     /^vert-origin-y$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	     /^vert-adv-y$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->PttnAttrsAll(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");

    } else {$self->message_err("element \"missing-glyph\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'missing-glyph' boundary
sub beginMGlyph {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^font$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<missing-glyph");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "missing-glyph";
    $self->{tab}+=1;
    my @arguments = @_;
    
    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	     /^d$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^horiz-adv-x$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	     /^vert-origin-x$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	     /^vert-origin-y$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	     /^vert-adv-y$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->PttnAttrsAll(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    } else {
	$self->message_err("element \"missing-glyph\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'missing-glyph' boundary
sub endMGlyph {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</missing-glyph>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
}

# draws an empty 'glyph' tag
sub drawGlyph {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^font$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<glyph");
    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	     /^unicode$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	     /^glyph-name$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute values not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	     /^d$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute values not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	     /^orientation$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(h|v)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	     /^arabic-form$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(initial|terminal|medial|isolated)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	     /^lang$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};	     /^horiz-adv-x$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	     /^vert-origin-x$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	     /^vert-origin-y$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	     /^vert-adv-y$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->PttnAttrsAll(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");

    } else {$self->message_err("element \"glyph\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'glyph' boundary
sub beginGlyph {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^font$/) {

    push(@{$self->{dtdMetadata}}, $self->{Metadata});
    push(@{$self->{dtdDesc}}, $self->{Desc});
    push(@{$self->{dtdTitle}}, $self->{Title});
    $self->{Metadata} = "empty";
    $self->{Desc} = "empty";
    $self->{Title} = "empty";
    
    $self->newline();
    $self->indent();
    $self->svgPrint("<glyph");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "glyph";
    $self->{tab}+=1;
    my @arguments = @_;
    
    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	     /^unicode$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	     /^glyph-name$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute values not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	     /^d$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute values not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	     /^orientation$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(h|v)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	     /^arabic-form$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(initial|terminal|medial|isolated)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	     /^lang$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};	     /^horiz-adv-x$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	     /^vert-origin-x$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	     /^vert-origin-y$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	     /^vert-adv-y$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->PttnAttrsAll(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    } else {
	$self->message_err("element \"glyph\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'glyph' boundary
sub endGlyph {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</glyph>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
    $self->{Metadata} = pop(@{$self->{dtdMetadata}});
    $self->{Desc} = pop(@{$self->{dtdDesc}});
    $self->{Title} = pop(@{$self->{dtdTitle}});
}

# draws an empty 'hkern' tag
sub drawHkern {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^font$/) {

    my @arguments = @_;
    my $k = "empty";

    for (my $i=0; $i<@arguments; $i++) {
	if ($arguments[$i] =~ /^k$/)	{
		(my $attrib, my $value) = splice(@arguments, $i--, 2);
		if ($value =~ /^$self->{reNumber}$/) {
			$k = $value;
	   	} else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
	}
    }

    if ($k =~ /^empty$/) {
	$self->message_err("\"k\" attribute and value required", $self->{LineNumber}, "\"hkern\" element ignored");
    } else {

    $self->newline();
    $self->indent();
    $self->svgPrint("<hkern");

    $self->svgPrint(" k=\"$k\"");

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	     /^u1$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	     /^g1$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	     /^u2$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	     /^g2$/	&&
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

    }

    } else {$self->message_err("element \"hkern\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# draws an empty 'vkern' tag
sub drawVkern {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^font$/) {

    my @arguments = @_;
    my $k = "empty";

    for (my $i=0; $i<@arguments; $i++) {
	if ($arguments[$i] =~ /^k$/)	{
		(my $attrib, my $value) = splice(@arguments, $i--, 2);
		if ($value =~ /^$self->{reNumber}$/) {
			$k = $value;
	   	} else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
	}
    }

    if ($k =~ /^empty$/) {
	$self->message_err("\"k\" attribute and value required", $self->{LineNumber}, "\"vkern\" element ignored");
    } else {

    $self->newline();
    $self->indent();
    $self->svgPrint("<vkern");

    $self->svgPrint(" k=\"$k\"");
    
    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	     /^u1$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	     /^g1$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	     /^u2$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	     /^g2$/	&&
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

    }

    } else {$self->message_err("element \"vkern\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# draws an empty 'font-face' tag
sub drawFontFace {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|mask|font|pattern|a)$/) {
    
    $self->newline();
    $self->indent();
    $self->svgPrint("<font-face");
    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^font-family$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^font-style$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(all|(normal|italic|oblique)($self->{reSpaceComma}(normal|italic|oblique))*)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^font-variant$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(normal|small-caps)($self->{reSpaceComma}(normal|small-caps))*$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^font-weight$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(all|((normal|[1-9]00)($self->{reSpaceComma}(normal|[1-9]00))*)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^font-stretch$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(all|((normal|wider|narrower|ultra-condensed|extra-condensed|condensed|semi-condensed|semi-expanded|expanded|extra-expanded|ultra-expanded|inherit)($self->{reSpaceComma}(normal|wider|narrower|ultra-condensed|extra-condensed|condensed|semi-condensed|semi-expanded|expanded|extra-expanded|ultra-expanded|inherit))*)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^font-size$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^unicode-range$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^units-per-em$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reUnsignNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^panose-1$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reUnsignNumber})(\s+$self->{reUnsignNumber}){9}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^stemv$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^stemh$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^slope$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^cap-height$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^x-height$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^accent-height$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^accent$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^descent$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^widths$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^bbox$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^ideographic$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^alphabetic$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^mathematical$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^hanging$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^v-ideographic$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^v-alphabetic$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^v-mathematical$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^v-hanging$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^underline-position$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^underline-thickness$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^strikethrough-position$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^strikethrough-thickness$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^overline-position$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^overline-thickness$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");

    } else {$self->message_err("element \"font-face\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'font-face' boundary
sub beginFontFace {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^(svg|g|defs|symbol|marker|mask|pattern|a|font|glyph|missing-glyph)$/) {
        
    push(@{$self->{dtdMetadata}}, $self->{Metadata});
    push(@{$self->{dtdDesc}}, $self->{Desc});
    push(@{$self->{dtdTitle}}, $self->{Title});
    $self->{Metadata} = "empty";
    $self->{Desc} = "empty";
    $self->{Title} = "empty";

    $self->newline();
    $self->indent();
    $self->svgPrint("<font-face");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "font-face";
    $self->{tab}+=1;
    my @arguments = @_;
    
    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^font-family$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^font-style$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(all|(normal|italic|oblique)($self->{reSpaceComma}(normal|italic|oblique))*)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^font-variant$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(normal|small-caps)($self->{reSpaceComma}(normal|small-caps))*$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^font-weight$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(all|((normal|[1-9]00)($self->{reSpaceComma}(normal|[1-9]00))*)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^font-stretch$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(all|((normal|wider|narrower|ultra-condensed|extra-condensed|condensed|semi-condensed|semi-expanded|expanded|extra-expanded|ultra-expanded|inherit)($self->{reSpaceComma}(normal|wider|narrower|ultra-condensed|extra-condensed|condensed|semi-condensed|semi-expanded|expanded|extra-expanded|ultra-expanded|inherit))*)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^font-size$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^unicode-range$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^units-per-em$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reUnsignNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^panose-1$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reUnsignNumber})(\s+$self->{reUnsignNumber}){9}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^stemv$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^stemh$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^slope$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^cap-height$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^x-height$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^accent-height$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^accent$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^descent$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^widths$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^bbox$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^ideographic$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^alphabetic$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^mathematical$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^hanging$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^v-ideographic$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^v-alphabetic$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^v-mathematical$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^v-hanging$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^underline-position$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^underline-thickness$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^strikethrough-position$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^strikethrough-thickness$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^overline-position$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^overline-thickness$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
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
	$self->message_err("element \"font-face\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'font-face' boundary
sub endFontFace {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</font-face>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
    $self->{Metadata} = pop(@{$self->{dtdMetadata}});
    $self->{Desc} = pop(@{$self->{dtdDesc}});
    $self->{Title} = pop(@{$self->{dtdTitle}});
}

# draws an empty 'font-face-src' tag
sub drawFontFaceSrc {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^font$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<font-face-src");
    my @arguments = @_;

    @arguments = $self->stdAttrs(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");

    } else {$self->message_err("element \"font-face-src\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'font-face-src' boundary
sub beginFontFaceSrc {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^font$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<font-face-src");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "font-face-src";
    $self->{tab}+=1;
    my @arguments = @_;
    
    @arguments = $self->stdAttrs(@arguments);
    
    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    } else {
	$self->message_err("element \"font-face-src\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'font-face-src' boundary
sub endFontFaceSrc {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</font-face-src>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
}

# draws an empty 'font-face-uri' tag
sub drawFontFaceUri {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^font-face-src$/) {

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
	$self->message_err("\"xlink:href\" attribute and value required", $self->{LineNumber}, "\"feImage\" element ignored");
    } else {

    $self->newline();
    $self->indent();
    $self->svgPrint("<font-face-uri");
    
    $self->svgPrint(" xlink:href=\"$href\"");
    
    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->xlinkRefAttrs(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");
    
    }

    } else {$self->message_err("element \"font-face-uri\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'font-face-uri' boundary
sub beginFontFaceUri {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^font-face-src$/) {
    
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
	$self->message_err("\"xlink:href\" attribute and value required", $self->{LineNumber}, "\"feImage\" element ignored");
    } else {

    $self->newline();
    $self->indent();
    $self->svgPrint("<font-face-uri");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "font-face-uri";
    $self->{tab}+=1;

    $self->svgPrint(" xlink:href=\"$href\"");
    
    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->xlinkRefAttrs(@arguments);
    
    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    }

    } else {
	$self->message_err("element \"font-face-uri\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'font-face-uri' boundary
sub endFontFaceUri {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</font-face-uri>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
}

# draws an empty 'font-face-format' tag
sub drawFontFaceFormat {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^font-face-uri$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<font-face-format");
    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {  
	    /^string$/ &&
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

    } else {$self->message_err("element \"font-face-format\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'font-face-format' boundary
sub beginFontFaceFormat {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^font-face-uri$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<font-face-format");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "font-face-format";
    $self->{tab}+=1;
    my @arguments = @_;
    
    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {  
	    /^string$/ &&
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
	$self->message_err("element \"font-face-format\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'font-face-format' boundary
sub endFontFaceFormat {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</font-face-format>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
}

# draws an empty 'font-face-name' tag
sub drawFontFaceName {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^font-face-src$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<font-face-name");
    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {  
	    /^name$/ &&
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

    } else {$self->message_err("element \"font-face-name\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'font-face-name' boundary
sub beginFontFaceName {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^font-face-src$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<font-face-name");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "font-face-name";
    $self->{tab}+=1;
    my @arguments = @_;
    
    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {  
	    /^name$/ &&
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
	$self->message_err("element \"font-face-name\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'font-face-name' boundary
sub endFontFaceName {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</font-face-name>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
}

# draws an empty 'definition-src' tag
sub drawDefinitionSrc {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^font-face-src$/) {

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
	$self->message_err("\"xlink:href\" attribute and value required", $self->{LineNumber}, "\"feImage\" element ignored");
    } else {

    $self->newline();
    $self->indent();
    $self->svgPrint("<definition-src");
    
    $self->svgPrint(" xlink:href=\"$href\"");
    
    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->xlinkRefAttrs(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");
    
    }

    } else {$self->message_err("element \"definition-src\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'definition-src' boundary
sub beginDefinitionSrc {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^font-face-src$/) {
    
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
	$self->message_err("\"xlink:href\" attribute and value required", $self->{LineNumber}, "\"feImage\" element ignored");
    } else {

    $self->newline();
    $self->indent();
    $self->svgPrint("<definition-src");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "definition-src";
    $self->{tab}+=1;

    $self->svgPrint(" xlink:href=\"$href\"");
    
    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->xlinkRefAttrs(@arguments);
    
    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    }

    } else {
	$self->message_err("element \"definition-src\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'definition-src' boundary
sub endDefinitionSrc {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</definition-src>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
}

# returns the width of a text string
sub textWidth {
    my $self = shift;
    my($fsize,$charspacing,$wordspacing,$hscale,$str) = @_;
    my($swidth) = 0;
    my($char);

    defined( $self->{Metrics}[32] ) ||
	message_err( "No character metrics defined for font" );
    $fsize>0 || message_err( "Font size must be greater then 0" );

    my $factor = $fsize * $hscale * 0.00001;

    $charspacing /= $factor;
    $wordspacing /= $factor;

    my $flag = 0;
    my $value = 0;
	if ($str=~/&/) {
		$str=~s/&lt;/</g;
		$str=~s/&gt;/>/g;
		$str=~s/&amp;/&/g;
		$str=~s/&quot;/"/g;
		$str=~s/&nbsp;/ /g;
		$str=~s/&#(\d+);/chr($1)/ge;
	}
    foreach $char (split( '', $str)) {
	if( !$flag && $char eq q(\\) ) {
	    ++$flag;
	    next;
	} elsif( $flag ) {
	    if( $char =~ /[0-9]/ ) {
		$value = ($value<<3) + (ord($char)-ord('0'));
	    } else {
		$swidth += $self->charWidth( $value ) + $charspacing;
		$flag = 0;
	    }
	} else {
	    $value = ord($char);
	    $swidth += $self->charWidth( $value ) + $charspacing;
	}
	$swidth += $wordspacing if $value == 32; # if space
    }
    if( $flag ) {
	$swidth += $self->charWidth( $value ) + $charspacing;
    }	
	
    return $swidth * $factor;
}

# returns character width in text space. $char is the integer value of
# the character (range 0 to 255).
sub charWidth {
    my $self = shift;
    my $char = shift;
    return $self->{Metrics}[$char];
}

# stores Adobe base14 font metrics - private function
#
# Font metrics data is built in for Base14 fonts. Uses PDFDocEncoding.
# Automatically generated from Adobe Font Metrics source files
# Non-existing characters are given width of 'space' character
sub initMetrics {
    my $self = shift;
    my $fontname = shift;

    if( $fontname eq 'Helvetica' ) {
	@{$self->{Metrics}} = 
	    (   278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 
	     278, 278, 278, 278, 278, 278, 278, 278, 333, 333, 333, 333, 333, 333, 333, 333, 
	     278, 278, 355, 556, 556, 889, 667, 191, 333, 333, 389, 584, 278, 333, 278, 278, 
	     556, 556, 556, 556, 556, 556, 556, 556, 556, 556, 278, 278, 584, 584, 584, 556, 
	     1015, 667, 667, 722, 722, 667, 611, 778, 722, 278, 500, 667, 556, 833, 722, 778, 
	     667, 778, 722, 667, 611, 722, 667, 944, 667, 667, 611, 278, 278, 278, 469, 556, 
	     333, 556, 556, 500, 556, 556, 278, 556, 556, 222, 222, 500, 222, 833, 556, 556, 
	     556, 556, 333, 500, 278, 556, 500, 722, 500, 500, 500, 334, 260, 334, 584, 278, 
	     350, 556, 556, 1000, 1000, 556, 556, 167, 333, 333, 584, 1000, 333, 333, 333, 222, 
	     222, 222, 1000, 500, 500, 556, 1000, 667, 667, 611, 278, 222, 944, 500, 500, 278, 
	     278, 333, 556, 556, 556, 556, 260, 556, 333, 737, 370, 556, 584, 278, 737, 333, 
	     400, 584, 333, 333, 333, 556, 537, 278, 333, 333, 365, 556, 834, 834, 834, 611, 
	     667, 667, 667, 667, 667, 667, 1000, 722, 667, 667, 667, 667, 278, 278, 278, 278, 
	     722, 722, 778, 778, 778, 778, 778, 584, 778, 722, 722, 722, 722, 667, 667, 611, 
	     556, 556, 556, 556, 556, 556, 889, 500, 556, 556, 556, 556, 278, 278, 278, 278, 
	     556, 556, 556, 556, 556, 556, 556, 584, 611, 556, 556, 556, 556, 500, 556, 500, 
	     );

    } elsif( $fontname eq 'Helvetica-Bold' ) {
	@{$self->{Metrics}} = 
	    (  278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 
	     278, 278, 278, 278, 278, 278, 278, 278, 333, 333, 333, 333, 333, 333, 333, 333, 
	     278, 333, 474, 556, 556, 889, 722, 238, 333, 333, 389, 584, 278, 333, 278, 278, 
	     556, 556, 556, 556, 556, 556, 556, 556, 556, 556, 333, 333, 584, 584, 584, 611, 
	     975, 722, 722, 722, 722, 667, 611, 778, 722, 278, 556, 722, 611, 833, 722, 778, 
	     667, 778, 722, 667, 611, 722, 667, 944, 667, 667, 611, 333, 278, 333, 584, 556, 
	     333, 556, 611, 556, 611, 556, 333, 611, 611, 278, 278, 556, 278, 889, 611, 611, 
	     611, 611, 389, 556, 333, 611, 556, 778, 556, 556, 500, 389, 280, 389, 584, 278, 
	     350, 556, 556, 1000, 1000, 556, 556, 167, 333, 333, 584, 1000, 500, 500, 500, 278, 
	     278, 278, 1000, 611, 611, 611, 1000, 667, 667, 611, 278, 278, 944, 556, 500, 278, 
	     278, 333, 556, 556, 556, 556, 280, 556, 333, 737, 370, 556, 584, 278, 737, 333, 
	     400, 584, 333, 333, 333, 611, 556, 278, 333, 333, 365, 556, 834, 834, 834, 611, 
	     722, 722, 722, 722, 722, 722, 1000, 722, 667, 667, 667, 667, 278, 278, 278, 278, 
	     722, 722, 778, 778, 778, 778, 778, 584, 778, 722, 722, 722, 722, 667, 667, 611, 
	     556, 556, 556, 556, 556, 556, 889, 556, 556, 556, 556, 556, 278, 278, 278, 278, 
	     611, 611, 611, 611, 611, 611, 611, 584, 611, 611, 611, 611, 611, 556, 611, 556, 
	     );

    } elsif( $fontname eq 'Helvetica-BoldOblique' ) {
	@{$self->{Metrics}} = 
	    (  278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 
	     278, 278, 278, 278, 278, 278, 278, 278, 333, 333, 333, 333, 333, 333, 333, 333, 
	     278, 333, 474, 556, 556, 889, 722, 238, 333, 333, 389, 584, 278, 333, 278, 278, 
	     556, 556, 556, 556, 556, 556, 556, 556, 556, 556, 333, 333, 584, 584, 584, 611, 
	     975, 722, 722, 722, 722, 667, 611, 778, 722, 278, 556, 722, 611, 833, 722, 778, 
	     667, 778, 722, 667, 611, 722, 667, 944, 667, 667, 611, 333, 278, 333, 584, 556, 
	     333, 556, 611, 556, 611, 556, 333, 611, 611, 278, 278, 556, 278, 889, 611, 611, 
	     611, 611, 389, 556, 333, 611, 556, 778, 556, 556, 500, 389, 280, 389, 584, 278, 
	     350, 556, 556, 1000, 1000, 556, 556, 167, 333, 333, 584, 1000, 500, 500, 500, 278, 
	     278, 278, 1000, 611, 611, 611, 1000, 667, 667, 611, 278, 278, 944, 556, 500, 278, 
	     278, 333, 556, 556, 556, 556, 280, 556, 333, 737, 370, 556, 584, 278, 737, 333, 
	     400, 584, 333, 333, 333, 611, 556, 278, 333, 333, 365, 556, 834, 834, 834, 611, 
	     722, 722, 722, 722, 722, 722, 1000, 722, 667, 667, 667, 667, 278, 278, 278, 278, 
	     722, 722, 778, 778, 778, 778, 778, 584, 778, 722, 722, 722, 722, 667, 667, 611, 
	     556, 556, 556, 556, 556, 556, 889, 556, 556, 556, 556, 556, 278, 278, 278, 278, 
	     611, 611, 611, 611, 611, 611, 611, 584, 611, 611, 611, 611, 611, 556, 611, 556, 
	     );

    } elsif( $fontname eq 'Helvetica-Oblique' ) {
	@{$self->{Metrics}} = 
	    (  278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 
	     278, 278, 278, 278, 278, 278, 278, 278, 333, 333, 333, 333, 333, 333, 333, 333, 
	     278, 278, 355, 556, 556, 889, 667, 191, 333, 333, 389, 584, 278, 333, 278, 278, 
	     556, 556, 556, 556, 556, 556, 556, 556, 556, 556, 278, 278, 584, 584, 584, 556, 
	     1015, 667, 667, 722, 722, 667, 611, 778, 722, 278, 500, 667, 556, 833, 722, 778, 
	     667, 778, 722, 667, 611, 722, 667, 944, 667, 667, 611, 278, 278, 278, 469, 556, 
	     333, 556, 556, 500, 556, 556, 278, 556, 556, 222, 222, 500, 222, 833, 556, 556, 
	     556, 556, 333, 500, 278, 556, 500, 722, 500, 500, 500, 334, 260, 334, 584, 278, 
	     350, 556, 556, 1000, 1000, 556, 556, 167, 333, 333, 584, 1000, 333, 333, 333, 222, 
	     222, 222, 1000, 500, 500, 556, 1000, 667, 667, 611, 278, 222, 944, 500, 500, 278, 
	     278, 333, 556, 556, 556, 556, 260, 556, 333, 737, 370, 556, 584, 278, 737, 333, 
	     400, 584, 333, 333, 333, 556, 537, 278, 333, 333, 365, 556, 834, 834, 834, 611, 
	     667, 667, 667, 667, 667, 667, 1000, 722, 667, 667, 667, 667, 278, 278, 278, 278, 
	     722, 722, 778, 778, 778, 778, 778, 584, 778, 722, 722, 722, 722, 667, 667, 611, 
	     556, 556, 556, 556, 556, 556, 889, 500, 556, 556, 556, 556, 278, 278, 278, 278, 
	     556, 556, 556, 556, 556, 556, 556, 584, 611, 556, 556, 556, 556, 500, 556, 500, 
	     );

    } elsif( $fontname eq 'Times-Bold' ) {
	@{$self->{Metrics}} = 
	    ( 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 
	     250, 250, 250, 250, 250, 250, 250, 250, 333, 333, 333, 333, 333, 333, 333, 333, 
	     250, 333, 555, 500, 500, 1000, 833, 278, 333, 333, 500, 570, 250, 333, 250, 278, 
	     500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 333, 333, 570, 570, 570, 500, 
	     930, 722, 667, 722, 722, 667, 611, 778, 778, 389, 500, 778, 667, 944, 722, 778, 
	     611, 778, 722, 556, 667, 722, 722, 1000, 722, 722, 667, 333, 278, 333, 581, 500, 
	     333, 500, 556, 444, 556, 444, 333, 500, 556, 278, 333, 556, 278, 833, 556, 500, 
	     556, 556, 444, 389, 333, 556, 500, 722, 500, 500, 444, 394, 220, 394, 520, 250, 
	     350, 500, 500, 1000, 1000, 500, 500, 167, 333, 333, 570, 1000, 500, 500, 500, 333, 
	     333, 333, 1000, 556, 556, 667, 1000, 556, 722, 667, 278, 278, 722, 389, 444, 250, 
	     250, 333, 500, 500, 500, 500, 220, 500, 333, 747, 300, 500, 570, 250, 747, 333, 
	     400, 570, 300, 300, 333, 556, 540, 250, 333, 300, 330, 500, 750, 750, 750, 500, 
	     722, 722, 722, 722, 722, 722, 1000, 722, 667, 667, 667, 667, 389, 389, 389, 389, 
	     722, 722, 778, 778, 778, 778, 778, 570, 778, 722, 722, 722, 722, 722, 611, 556, 
	     500, 500, 500, 500, 500, 500, 722, 444, 444, 444, 444, 444, 278, 278, 278, 278, 
	     500, 556, 500, 500, 500, 500, 500, 570, 500, 556, 556, 556, 556, 500, 556, 500, 
	     );

    } elsif( $fontname eq 'Times-BoldItalic' ) {
	@{$self->{Metrics}} = 
	    (  250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 
	     250, 250, 250, 250, 250, 250, 250, 250, 333, 333, 333, 333, 333, 333, 333, 333, 
	     250, 389, 555, 500, 500, 833, 778, 278, 333, 333, 500, 570, 250, 333, 250, 278, 
	     500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 333, 333, 570, 570, 570, 500, 
	     832, 667, 667, 667, 722, 667, 667, 722, 778, 389, 500, 667, 611, 889, 722, 722, 
	     611, 722, 667, 556, 611, 722, 667, 889, 667, 611, 611, 333, 278, 333, 570, 500, 
	     333, 500, 500, 444, 500, 444, 333, 500, 556, 278, 278, 500, 278, 778, 556, 500, 
	     500, 500, 389, 389, 278, 556, 444, 667, 500, 444, 389, 348, 220, 348, 570, 250, 
	     350, 500, 500, 1000, 1000, 500, 500, 167, 333, 333, 606, 1000, 500, 500, 500, 333, 
	     333, 333, 1000, 556, 556, 611, 944, 556, 611, 611, 278, 278, 722, 389, 389, 250, 
	     250, 389, 500, 500, 500, 500, 220, 500, 333, 747, 266, 500, 606, 250, 747, 333, 
	     400, 570, 300, 300, 333, 576, 500, 250, 333, 300, 300, 500, 750, 750, 750, 500, 
	     667, 667, 667, 667, 667, 667, 944, 667, 667, 667, 667, 667, 389, 389, 389, 389, 
	     722, 722, 722, 722, 722, 722, 722, 570, 722, 722, 722, 722, 722, 611, 611, 500, 
	     500, 500, 500, 500, 500, 500, 722, 444, 444, 444, 444, 444, 278, 278, 278, 278, 
	     500, 556, 500, 500, 500, 500, 500, 570, 500, 556, 556, 556, 556, 444, 500, 444, 
	     );

    } elsif( $fontname eq 'Times-Italic' ) {
	@{$self->{Metrics}} = 
	    ( 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 
	     250, 250, 250, 250, 250, 250, 250, 250, 333, 333, 333, 333, 333, 333, 333, 333, 
	     250, 333, 420, 500, 500, 833, 778, 214, 333, 333, 500, 675, 250, 333, 250, 278, 
	     500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 333, 333, 675, 675, 675, 500, 
	     920, 611, 611, 667, 722, 611, 611, 722, 722, 333, 444, 667, 556, 833, 667, 722, 
	     611, 722, 611, 500, 556, 722, 611, 833, 611, 556, 556, 389, 278, 389, 422, 500, 
	     333, 500, 500, 444, 500, 444, 278, 500, 500, 278, 278, 444, 278, 722, 500, 500, 
	     500, 500, 389, 389, 278, 500, 444, 667, 444, 444, 389, 400, 275, 400, 541, 250, 
	     350, 500, 500, 889, 889, 500, 500, 167, 333, 333, 675, 1000, 556, 556, 556, 333, 
	     333, 333, 980, 500, 500, 556, 944, 500, 556, 556, 278, 278, 667, 389, 389, 250, 
	     250, 389, 500, 500, 500, 500, 275, 500, 333, 760, 276, 500, 675, 250, 760, 333, 
	     400, 675, 300, 300, 333, 500, 523, 250, 333, 300, 310, 500, 750, 750, 750, 500, 
	     611, 611, 611, 611, 611, 611, 889, 667, 611, 611, 611, 611, 333, 333, 333, 333, 
	     722, 667, 722, 722, 722, 722, 722, 675, 722, 722, 722, 722, 722, 556, 611, 500, 
	     500, 500, 500, 500, 500, 500, 667, 444, 444, 444, 444, 444, 278, 278, 278, 278, 
	     500, 500, 500, 500, 500, 500, 500, 675, 500, 500, 500, 500, 500, 444, 500, 444, 
	     );

    } elsif( $fontname eq 'Times-Roman' ) {
	@{$self->{Metrics}} = 
	    ( 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 
	     250, 250, 250, 250, 250, 250, 250, 250, 333, 333, 333, 333, 333, 333, 333, 333, 
	     250, 333, 408, 500, 500, 833, 778, 180, 333, 333, 500, 564, 250, 333, 250, 278, 
	     500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 278, 278, 564, 564, 564, 444, 
	     921, 722, 667, 667, 722, 611, 556, 722, 722, 333, 389, 722, 611, 889, 722, 722, 
	     556, 722, 667, 556, 611, 722, 722, 944, 722, 722, 611, 333, 278, 333, 469, 500, 
	     333, 444, 500, 444, 500, 444, 333, 500, 500, 278, 278, 500, 278, 778, 500, 500, 
	     500, 500, 333, 389, 278, 500, 500, 722, 500, 500, 444, 480, 200, 480, 541, 250, 
	     350, 500, 500, 1000, 1000, 500, 500, 167, 333, 333, 564, 1000, 444, 444, 444, 333, 
	     333, 333, 980, 556, 556, 611, 889, 556, 722, 611, 278, 278, 722, 389, 444, 250, 
	     250, 333, 500, 500, 500, 500, 200, 500, 333, 760, 276, 500, 564, 250, 760, 333, 
	     400, 564, 300, 300, 333, 500, 453, 250, 333, 300, 310, 500, 750, 750, 750, 444, 
	     722, 722, 722, 722, 722, 722, 889, 667, 611, 611, 611, 611, 333, 333, 333, 333, 
	     722, 722, 722, 722, 722, 722, 722, 564, 722, 722, 722, 722, 722, 722, 556, 500, 
	     444, 444, 444, 444, 444, 444, 667, 444, 444, 444, 444, 444, 278, 278, 278, 278, 
	     500, 500, 500, 500, 500, 500, 500, 564, 500, 500, 500, 500, 500, 500, 500, 500, 
	     );

    } elsif( $fontname =~ /^Courier/ ) {
	@{$self->{Metrics}} =
	    ( 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600,
	     600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 
	     600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 
	     600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 
	     600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 
	     600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 
	     600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 
	     600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 
	     600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 
	     600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 
	     600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 
	     600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 
	     600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 
	     600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 
	     600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 
	     600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600, 600 );

    } elsif( $fontname eq 'Symbol' ) {
	@{$self->{Metrics}} = 
	    ( 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 
	     250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 
	     250, 333, 713, 500, 549, 833, 778, 439, 333, 333, 500, 549, 250, 549, 250, 278, 
	     500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 278, 278, 549, 549, 549, 444, 
	     549, 722, 667, 722, 612, 611, 763, 603, 722, 333, 631, 722, 686, 889, 722, 722, 
	     768, 741, 556, 592, 611, 690, 439, 768, 645, 795, 611, 333, 863, 333, 658, 500, 
	     500, 631, 549, 549, 494, 439, 521, 411, 603, 329, 603, 549, 549, 576, 521, 549, 
	     549, 521, 549, 603, 439, 576, 713, 686, 493, 686, 494, 480, 200, 480, 549, 250, 
	     250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 
	     250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 
	     250, 620, 247, 549, 167, 713, 500, 753, 753, 753, 753, 1042, 987, 603, 987, 603, 
	     400, 549, 411, 549, 549, 713, 494, 460, 549, 549, 549, 549, 1000, 603, 1000, 658, 
	     823, 686, 795, 987, 768, 768, 823, 768, 768, 713, 713, 713, 713, 713, 713, 713, 
	     768, 713, 790, 790, 890, 823, 549, 250, 713, 603, 603, 1042, 987, 603, 987, 603, 
	     494, 329, 790, 790, 786, 713, 384, 384, 384, 384, 384, 384, 494, 494, 494, 494, 
	     250, 329, 274, 686, 686, 686, 384, 384, 384, 384, 384, 384, 494, 494, 494, 250, 
	     );

    } elsif( $fontname eq 'ZapfDingbats' ) {
	@{$self->{Metrics}} = 
	    ( 278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 
	     278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 
	     278, 974, 961, 974, 980, 719, 789, 790, 791, 690, 960, 939, 549, 855, 911, 933, 
	     911, 945, 974, 755, 846, 762, 761, 571, 677, 763, 760, 759, 754, 494, 552, 537, 
	     577, 692, 786, 788, 788, 790, 793, 794, 816, 823, 789, 841, 823, 833, 816, 831, 
	     923, 744, 723, 749, 790, 792, 695, 776, 768, 792, 759, 707, 708, 682, 701, 826, 
	     815, 789, 789, 707, 687, 696, 689, 786, 787, 713, 791, 785, 791, 873, 761, 762, 
	     762, 759, 759, 892, 892, 788, 784, 438, 138, 277, 415, 392, 392, 668, 668, 278, 
	     278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 
	     278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 278, 
	     278, 732, 544, 544, 910, 667, 760, 760, 776, 595, 694, 626, 788, 788, 788, 788, 
	     788, 788, 788, 788, 788, 788, 788, 788, 788, 788, 788, 788, 788, 788, 788, 788, 
	     788, 788, 788, 788, 788, 788, 788, 788, 788, 788, 788, 788, 788, 788, 788, 788, 
	     788, 788, 788, 788, 894, 838, 1016, 458, 748, 924, 748, 918, 927, 928, 928, 834, 
	     873, 828, 924, 924, 917, 930, 931, 463, 883, 836, 836, 867, 867, 696, 696, 874, 
	     278, 874, 760, 946, 771, 865, 771, 888, 967, 888, 831, 873, 927, 970, 918, 278, 
	     );
    } elsif( $fontname eq 'ArialNarrow') {
	@{$self->{Metrics}} = 
		(# 0    1    2    3    4    5    6    7    8    9    A    B    C    D    E    F
		 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228,
		 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228,
		 228, 228, 291, 456, 456, 729, 547, 157, 273, 273, 319, 479, 228, 273, 228, 228,
		 456, 456, 456, 456, 456, 456, 456, 456, 456, 456, 228, 228, 479, 479, 479, 456,
		 832, 547, 547, 592, 592, 547, 501, 638, 592, 228, 410, 547, 456, 683, 592, 638,
		 547, 638, 592, 547, 501, 592, 547, 774, 547, 547, 501, 228, 228, 228, 385, 456,
		 273, 456, 456, 410, 456, 456, 228, 456, 456, 182, 182, 410, 182, 683, 456, 456,
		 456, 456, 273, 410, 228, 456, 410, 592, 410, 410, 410, 274, 213, 274, 479, 228,
		 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228,
		 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228,
		 228, 273, 456, 456, 456, 456, 213, 456, 273, 604, 303, 456, 479, 273, 604, 500,
		 400, 549, 273, 273, 273, 576, 440, 273, 273, 273, 299, 456, 684, 684, 684, 501,
		 547, 547, 547, 547, 547, 547, 820, 592, 547, 547, 547, 547, 228, 228, 228, 228,
		 592, 592, 638, 638, 638, 638, 638, 479, 638, 592, 592, 592, 592, 547, 547, 501,
		 456, 456, 456, 456, 456, 456, 729, 410, 456, 456, 456, 456, 228, 228, 228, 228,
		 456, 456, 456, 456, 456, 456, 456, 549, 501, 456, 456, 456, 456, 410, 456, 410,
		);
    } elsif( $fontname eq 'ArialNarrow-Bold') {
	@{$self->{Metrics}} = 
		(# 0    1    2    3    4    5    6    7    8    9    A    B    C    D    E    F
		 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228,
		 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228,
		 228, 273, 389, 456, 456, 729, 592, 195, 273, 273, 319, 479, 228, 273, 228, 228,
		 456, 456, 456, 456, 456, 456, 456, 456, 456, 456, 273, 273, 479, 479, 479, 501,
		 800, 592, 592, 592, 592, 547, 501, 638, 592, 228, 456, 592, 501, 683, 592, 638,
		 547, 638, 592, 547, 501, 592, 547, 774, 547, 547, 501, 273, 228, 273, 479, 456,
		 273, 456, 501, 456, 501, 456, 273, 501, 501, 228, 228, 456, 228, 729, 501, 501,
		 501, 501, 319, 456, 273, 501, 456, 638, 456, 456, 410, 319, 230, 319, 479, 228,
		 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228,
		 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228,
		 456, 273, 456, 456, 456, 456, 230, 456, 273, 604, 303, 456, 479, 273, 604, 500,
		 400, 549, 273, 273, 273, 576, 456, 273, 273, 273, 299, 456, 684, 684, 684, 501,
		 592, 592, 592, 592, 592, 592, 820, 592, 547, 547, 547, 547, 228, 228, 228, 228,
		 592, 592, 638, 638, 638, 638, 638, 479, 638, 592, 592, 592, 592, 547, 547, 501,
		 456, 456, 456, 456, 456, 456, 729, 456, 456, 456, 456, 456, 228, 228, 228, 228,
		 501, 501, 501, 501, 501, 501, 501, 549, 501, 501, 501, 501, 501, 456, 501, 456,
		);
    } elsif( $fontname eq 'ArialNarrow-Italic') {
	@{$self->{Metrics}} = 
		(# 0    1    2    3    4    5    6    7    8    9    A    B    C    D    E    F
		 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228,
		 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228,
		 228, 228, 291, 456, 456, 729, 547, 157, 273, 273, 319, 479, 228, 273, 228, 228,
		 456, 456, 456, 456, 456, 456, 456, 456, 456, 456, 228, 228, 479, 479, 479, 456,
		 832, 547, 547, 592, 592, 547, 501, 638, 592, 228, 410, 547, 456, 683, 592, 638,
		 547, 638, 592, 547, 501, 592, 547, 774, 547, 547, 501, 228, 228, 228, 385, 456,
		 273, 456, 456, 410, 456, 456, 228, 456, 456, 182, 182, 410, 182, 683, 456, 456,
		 456, 456, 273, 410, 228, 456, 410, 592, 410, 410, 410, 274, 213, 274, 479, 228,
		 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228,
		 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228,
		 228, 273, 456, 456, 456, 456, 213, 456, 273, 604, 303, 456, 479, 273, 604, 500,
		 400, 549, 273, 273, 273, 576, 440, 273, 273, 273, 299, 456, 684, 684, 684, 501,
		 547, 547, 547, 547, 547, 547, 820, 592, 547, 547, 547, 547, 228, 228, 228, 228,
		 592, 592, 638, 638, 638, 638, 638, 479, 638, 592, 592, 592, 592, 547, 547, 501,
		 456, 456, 456, 456, 456, 456, 729, 410, 456, 456, 456, 456, 228, 228, 228, 228,
		 456, 456, 456, 456, 456, 456, 456, 549, 501, 456, 456, 456, 456, 410, 456, 410,
		);
    } elsif( $fontname eq 'ArialNarrow-BoldItalic') {
	@{$self->{Metrics}} = 
		(# 0    1    2    3    4    5    6    7    8    9    A    B    C    D    E    F
		 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228,
		 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228,
		 228, 273, 389, 456, 456, 729, 592, 195, 273, 273, 319, 479, 228, 273, 228, 228,
		 456, 456, 456, 456, 456, 456, 456, 456, 456, 456, 273, 273, 479, 479, 479, 501,
		 800, 592, 592, 592, 592, 547, 501, 638, 592, 228, 456, 592, 501, 683, 592, 638,
		 547, 638, 592, 547, 501, 592, 547, 774, 547, 547, 501, 273, 228, 273, 479, 456,
		 273, 456, 501, 456, 501, 456, 273, 501, 501, 228, 228, 456, 228, 729, 501, 501,
		 501, 501, 319, 456, 273, 501, 456, 638, 456, 456, 410, 319, 230, 319, 479, 228,
		 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228,
		 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228, 228,
		 228, 273, 456, 456, 456, 456, 230, 456, 273, 604, 303, 456, 479, 273, 604, 500,
		 400, 549, 273, 273, 273, 576, 456, 273, 273, 273, 299, 456, 684, 684, 684, 501,
		 592, 592, 592, 592, 592, 592, 820, 592, 547, 547, 547, 547, 228, 228, 228, 228,
		 592, 592, 638, 638, 638, 638, 638, 479, 638, 592, 592, 592, 592, 547, 547, 501,
		 456, 456, 456, 456, 456, 456, 729, 456, 456, 456, 456, 456, 228, 228, 228, 228,
		 501, 501, 501, 501, 501, 501, 501, 549, 501, 501, 501, 501, 501, 456, 501, 456,
		);
    } else {
	message_err( "Internal - '$fontname' is not a base14 font" );
    }
}

1; # Perl notation to end a module