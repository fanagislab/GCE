package Svg::FilterEffects;	# define a new package
require 5.000;				# needs version 5, latest version 5.00402
require Exporter;			# standard module for making functions public

@ISA = qw(Exporter);
@EXPORT = qw(	filterPrimitiveAttrs filterPrimitiveAttrsWithIn 
				componentTransferFunctionAttrs
				drawFilter beginFilter endFilter
				drawBlend beginBlend endBlend
				drawFlood beginFlood endFlood
				drawCMatrix beginCMatrix endCMatrix
				drawCompTrans beginCompTrans endCompTrans
				drawFuncR beginFuncR endFuncR
				drawFuncG beginFuncG endFuncG
				drawFuncB beginFuncB endFuncB
				drawFuncA beginFuncA endFuncA
				beginDLighting endDLighting
				drawDisLight beginDisLight endDisLight
				drawPntLight beginPntLight endPntLight
				drawSptLight beginSptLight endSptLight
				drawDispMap beginDispMap endDispMap
				drawGBlur beginGBlur endGBlur
				drawFImage beginFImage endFImage
				drawMerge beginMerge endMerge
				drawMergeNode beginMergeNode endMergeNode
				drawMorphology beginMorphology endMorphology
				drawOffset beginOffset endOffset
				drawSLighting beginSLighting endSLighting	
				drawTile beginTile endTile
				drawTurbulence beginTurbulence endTurbulence
				drawConvolveMatrix beginConvolveMatrix endConvolveMatrix 
				drawComposite		);
	
# use Svg::Std qw( message_out );

use strict qw ( subs vars refs );

# parses for attributes [private]
sub filterPrimitiveAttrs {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@arguments; $i++) {
		if ($arguments[$i] =~ /^result$/) {
			(my $attrib, my $value) = splice(@arguments, $i--, 2);
			if ($value =~ /^$self->{reAnyOneOrMore}$/) {
				$self->svgPrint(" $attrib=\"$value\"");
			} else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}	    			
		}
	} 

	@arguments = $self->geometricAttrs(@arguments);

	return @arguments;

} 

# parses for attributes [private]
sub filterPrimitiveAttrsWithIn {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@arguments; $i++) {
		if ($arguments[$i] =~ /^in$/) {
			(my $attrib, my $value) = splice(@arguments, $i--, 2);
			if ($value =~ /^$self->{reAnyOneOrMore}$/) {
				$self->svgPrint(" $attrib=\"$value\"");
			} else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}	    			
		}
	} 

	@arguments = $self->filterPrimitiveAttrs(@arguments);

	return @arguments;

}

# parses for attributes [private]
sub componentTransferFunctionAttrs {

	my $self = shift;
	my @arguments = @_;
	
	for (my $i=0; $i<@arguments; $i++) {
		if ($arguments[$i] =~ /^tableValues$/) {
			(my $attrib, my $value) = splice(@arguments, $i--, 2);
			if ($value =~ /^$self->{reSpaceCommaOneOrMore}$/) {
				$self->svgPrint(" $attrib=\"$value\"");
		    	} else {$self->message_err("\"$attrib\" attribute values not valid", $self->{LineNumber})}
		}
		if ($arguments[$i] =~ /^slope$/) {
		    	(my $attrib, my $value) = splice(@arguments, $i--, 2);
		    	if ($value =~ /^$self->{reNumber}$/) {
				$self->svgPrint(" $attrib=\"$value\"");
		    	} else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
		if ($arguments[$i] =~ /^intercept$/) {
		    	(my $attrib, my $value) = splice(@arguments, $i--, 2);
		    	if ($value =~ /^$self->{reNumber}$/) {
				$self->svgPrint(" $attrib=\"$value\"");
		    	} else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
		if ($arguments[$i] =~ /^amplitude$/) {
		    	(my $attrib, my $value) = splice(@arguments, $i--, 2);
		    	if ($value =~ /^$self->{reNumber}$/) {
				$self->svgPrint(" $attrib=\"$value\"");
		    	} else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
		if ($arguments[$i] =~ /^exponent$/) {
		    	(my $attrib, my $value) = splice(@arguments, $i--, 2);
		    	if ($value =~ /^$self->{reNumber}$/) {
				$self->svgPrint(" $attrib=\"$value\"");
		    	} else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
		if ($arguments[$i] =~ /^offset$/) {
		    	(my $attrib, my $value) = splice(@arguments, $i--, 2);
		    	if ($value =~ /^$self->{reNumber}$/) {
				$self->svgPrint(" $attrib=\"$value\"");
		    	} else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
	} 	

	return @arguments;

}

# draws an empty 'filter' tag
sub drawFilter {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|mask|pattern|a)$/) {
    
    $self->newline();
    $self->indent();
    $self->svgPrint("<filter");
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
	    /^filterUnits$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(objectBoundingBox|userSpaceOnUse)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^filterUnits$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(objectBoundingBox|userSpaceOnUse)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	     /^filterRes$/ &&
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
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->PttnAttrsAll(@arguments);
    @arguments = $self->geometricAttrs(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");
    
    } else {$self->message_err("element \"filter\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'filter' boundary
sub beginFilter {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}    

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|mask|pattern|a)$/) {
    
    push(@{$self->{dtdMetadata}}, $self->{Metadata});
    push(@{$self->{dtdDesc}}, $self->{Desc});
    push(@{$self->{dtdTitle}}, $self->{Title});
    $self->{Metadata} = "empty";
    $self->{Desc} = "empty";
    $self->{Title} = "empty";
    
    $self->newline();
    $self->indent();
    $self->svgPrint("<filter");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "filter";
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
	    /^filterUnits$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(objectBoundingBox|userSpaceOnUse)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^filterUnits$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(objectBoundingBox|userSpaceOnUse)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	     /^filterRes$/ &&
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
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->PttnAttrsAll(@arguments);
    @arguments = $self->geometricAttrs(@arguments);
    
    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    } else {
	$self->message_err("element \"filter\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'filter' boundary
sub endFilter {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</filter>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
    $self->{Metadata} = pop(@{$self->{dtdMetadata}});
    $self->{Desc} = pop(@{$self->{dtdDesc}});
    $self->{Title} = pop(@{$self->{dtdTitle}});
}

# draws an empty 'feBlend' tag
sub drawBlend {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}    

    if ($self->{inBoundary} =~ /^filter$/) {

    my @arguments = @_;
    my $in2 = "empty";

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^in2$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$in2 = $value;
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    if ($in2 =~ /^empty$/) {
	$self->message_err("\"in2\" attribute and value required", $self->{LineNumber}, "\"feBlend\" element ignored");
	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    } else {

    $self->newline();
    $self->indent();
    $self->svgPrint("<feBlend");

    $self->svgPrint(" in2=\"$in2\"");

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^mode$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(normal|multiple|screen|darken|lighten)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    @arguments = $self->filterPrimitiveAttrsWithIn(@arguments);
    @arguments = $self->stdAttrs(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");

    }

    } else {$self->message_err("element \"feBlend\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'feBlend' boundary
sub beginBlend {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}    

    if ($self->{inBoundary} =~ /^filter$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<feBlend");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "feBlend";
    $self->{tab}+=1;
    my @arguments = @_;
    
    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^mode$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(normal|multiple|screen|darken|lighten)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    @arguments = $self->filterPrimitiveAttrsWithIn(@arguments);
    @arguments = $self->stdAttrs(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    } else {
	$self->message_err("element \"feBlend\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'feBlend' boundary
sub endBlend{
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</feBlend>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
}

# draws an empty 'feFlood' tag
sub drawFlood {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}    

    if ($self->{inBoundary} =~ /^filter$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<feFlood");
    my @arguments = @_;

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->feFlood(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->filterPrimitiveAttrsWithIn(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");

    } else {$self->message_err("element \"feFlood\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'feFlood' boundary
sub beginFlood {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}    

    if ($self->{inBoundary} =~ /^filter$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<feFlood");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "feFlood";
    $self->{tab}+=1;
    my @arguments = @_;

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->feFlood(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->filterPrimitiveAttrsWithIn(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    } else {
	$self->message_err("element \"feFlood\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'feFlood' boundary
sub endFlood {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</feFlood>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
}

# draws an empty 'feColorMatrix' tag
sub drawCMatrix {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^filter$/) {

    my @arguments = @_;
    my $type = "empty";

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^type$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(matrix|saturate|hueRotate|luminanceToAlpha)$/) {
			$type = $value;
		    } 
		    last SWITCH;
		};
	}
    }

    if ($type =~ /^empty$/) {
	$self->message_err("\"type\" attribute and value required", $self->{LineNumber}, "\"feColorMatrix\" element ignored");
    } else {

    $self->newline();
    $self->indent();
    $self->svgPrint("<feColorMatrix");

    $self->svgPrint(" type=\"$type\"");

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^vals$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($type =~ /^matrix$/ && $value =~ /^(1(\.0+)?|0(\.[0-9]+)?)((\s+(1(\.0+)?|0(\.[0-9]+)?)){19})$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } elsif ($type =~ /^matrix$/) {$self->message_err("\"$type\" attribute value not valid", $self->{LineNumber})}
		    if ($type =~ /^saturate$/ && $value =~ /^(((1(\.0+)?|0(\.[0-9]+)?)|((([0-9]{1,2})(\.[0-9]+)?)|100(\.0+)?)%))$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } elsif ($type =~ /^saturate$/) {$self->message_err("\"$type\" attribute value not valid", $self->{LineNumber})}
		    if ($type =~ /^hueRotate$/ && $value =~ /^(([0-9]{1,2}(\.[0-9]+)?|(1|2)([0-9]{2})(\.[0-9]+)?|3[0-5][0-9](\.[0-9]+)?|360(\.0+)?)|((([0-9]{1,2})(\.[0-9]+)?)|100(\.0+)?)%)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } elsif ($type =~ /^hueRotate$/) {$self->message_err("\"$type\" attribute value not valid", $self->{LineNumber})}
		    if ($type =~ /^luminanceToAlpha$/) {$self->message_err("\"$type\" does not require attribute values", $self->{LineNumber}, "\"values\" attribute and its value ignored")}
		    last SWITCH;
		};
	}
    }
    
    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->filterPrimitiveAttrsWithIn(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    }

    } else {$self->message_err("element \"feColorMatrix\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'feColorMatrix' boundary
sub beginCMatrix {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^filter$/) {

    my @arguments = @_;
    my $type = "empty";

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^type$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(matrix|saturate|hueRotate|luminanceToAlpha)$/) {
			$type = $value;
		    } 
		    last SWITCH;
		};
	}
    }

    if ($type =~ /^empty$/) {
	$self->message_err("\"type\" attribute and value required", $self->{LineNumber}, "\"feColorMatrix\" element ignored");
	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    } else {

    $self->newline();
    $self->indent();
    $self->svgPrint("<feColorMatrix");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "feColorMatrix";
    $self->{tab}+=1;

    $self->svgPrint(" type=\"$type\"");
    
    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^vals$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($type =~ /^matrix$/ && $value =~ /^(1(\.0+)?|0(\.[0-9]+)?)((\s+(1(\.0+)?|0(\.[0-9]+)?)){19})$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } elsif ($type =~ /^matrix$/) {$self->message_err("\"$type\" attribute value not valid", $self->{LineNumber})}
		    if ($type =~ /^saturate$/ && $value =~ /^(((1(\.0+)?|0(\.[0-9]+)?)|((([0-9]{1,2})(\.[0-9]+)?)|100(\.0+)?)%))$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } elsif ($type =~ /^saturate$/) {$self->message_err("\"$type\" attribute value not valid", $self->{LineNumber})}
		    if ($type =~ /^hueRotate$/ && $value =~ /^(([0-9]{1,2}(\.[0-9]+)?|(1|2)([0-9]{2})(\.[0-9]+)?|3[0-5][0-9](\.[0-9]+)?|360(\.0+)?)|((([0-9]{1,2})(\.[0-9]+)?)|100(\.0+)?)%)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } elsif ($type =~ /^hueRotate$/) {$self->message_err("\"$type\" attribute value not valid", $self->{LineNumber})}
		    if ($type =~ /^luminanceToAlpha$/) {$self->message_err("\"$type\" does not require attribute values", $self->{LineNumber}, "\"values\" attribute and its value ignored")}
		    last SWITCH;
		};
	}
    }
    
    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->filterPrimitiveAttrsWithIn(@arguments);
    
    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    }

    } else {
	$self->message_err("element \"feColorMatrix\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'feColorMatrix' boundary
sub endCMatrix {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</feColorMatrix>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
}

# draws an empty 'feComponentTransfer' tag
sub drawCompTrans {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^filter$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<feComponentTransfer");
    my @arguments = @_;

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->filterPrimitiveAttrsWithIn(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");

    } else {$self->message_err("element \"feComponentTransfer\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'feComponentTransfer' boundary
sub beginCompTrans {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^filter$/) {

    push(@{$self->{feFuncR}}, $self->{FuncR});
    push(@{$self->{feFuncG}}, $self->{FuncG});
    push(@{$self->{feFuncB}}, $self->{FuncB});
    push(@{$self->{feFuncA}}, $self->{FuncA});
    $self->{FuncR} = "empty";
    $self->{FuncG} = "empty";
    $self->{FuncB} = "empty";
    $self->{FuncA} = "empty";
        
    $self->newline();
    $self->indent();
    $self->svgPrint("<feComponentTransfer");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "feComponentTransfer";
    $self->{tab}+=1;
    my @arguments = @_;

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->filterPrimitiveAttrsWithIn(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    } else {
	$self->message_err("element \"feComponentTransfer\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'feComponentTransfer boundary
sub endCompTrans {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</feComponentTransfer>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
    $self->{FuncR} = pop(@{$self->{feFuncR}});
    $self->{FuncG} = pop(@{$self->{feFuncG}});
    $self->{FuncB} = pop(@{$self->{feFuncB}});
    $self->{FuncA} = pop(@{$self->{feFuncA}});
}

# draws an empty 'feFuncR' tag
sub drawFuncR {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^feComponentTransfer$/) {
    
    if ($self->{FuncR} =~ /^$self->{inBoundary}$/) {
	$self->message_err("only one \"feFuncR\" is allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    } else {

    $self->{FuncR} = $self->{inBoundary};
    
    my @arguments = @_;
    my $type = "empty";

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
		/^type$/	&&
		do {
			(my $attrib, my $value) = splice(@arguments, $i--, 2);
			if ($value =~ /^(table|linear|discrete|gamma|identity)$/) {
				$type = $value;
			} else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}	    			
		};
	}
    }

    if ($type =~ /^empty$/) {
	$self->message_err("\"type\" attribute and value required", $self->{LineNumber}, "\"feFuncR\" element ignored");
	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    } else {

    $self->newline();
    $self->indent();
    $self->svgPrint("<feFuncR");

    $self->svgPrint(" type=\"$type\"");

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->componentTransferFunctionAttrs(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");

    }
    
    }

    } else {$self->message_err("element \"feFuncR\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'feFuncR' boundary
sub beginFuncR {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^feComponentTransfer$/) {

    if ($self->{FuncR} =~ /^$self->{inBoundary}$/) {
	$self->message_err("only one \"feFuncR\" is allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    } else {

    $self->{FuncR} = $self->{inBoundary};
    
    my @arguments = @_;
    my $type = "empty";

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
		/^type$/	&&
		do {
			(my $attrib, my $value) = splice(@arguments, $i--, 2);
			if ($value =~ /^(table|linear|discrete|gamma|identity)$/) {
				$type = $value;
			} else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}	    			
		};
	}
    }

    if ($type =~ /^empty$/) {
	$self->message_err("\"type\" attribute and value required", $self->{LineNumber}, "\"feFuncR\" element ignored");
	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    } else {

    $self->newline();
    $self->indent();
    $self->svgPrint("<feFuncR");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "feFuncR";
    $self->{tab}+=1;

    $self->svgPrint(" type=\"$type\"");

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->componentTransferFunctionAttrs(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    }
    
    }

    } else {
	$self->message_err("element \"feFuncR\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'feFuncR' boundary
sub endFuncR {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</feFuncR>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
}

# draws an empty 'feFuncG' tag
sub drawFuncG {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^feComponentTransfer$/) {

    if ($self->{FuncG} =~ /^$self->{inBoundary}$/) {
	$self->message_err("only one \"feFuncG\" is allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    } else {

    $self->{FuncG} = $self->{inBoundary};
    
    my @arguments = @_;
    my $type = "empty";

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
		/^type$/	&&
		do {
			(my $attrib, my $value) = splice(@arguments, $i--, 2);
			if ($value =~ /^(table|linear|discrete|gamma|identity)$/) {
				$type = $value;
			} else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}	    			
		};
	}
    }

    if ($type =~ /^empty$/) {
	$self->message_err("\"type\" attribute and value required", $self->{LineNumber}, "\"feFuncG\" element ignored");
	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    } else {

    $self->newline();
    $self->indent();
    $self->svgPrint("<feFuncG");

    $self->svgPrint(" type=\"$type\"");

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->componentTransferFunctionAttrs(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");

    }
    
    }

    } else {$self->message_err("element \"feFuncG\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'feFuncG' boundary
sub beginFuncG {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^feComponentTransfer$/) {

    if ($self->{FuncG} =~ /^$self->{inBoundary}$/) {
	$self->message_err("only one \"feFuncG\" is allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    } else {

    $self->{FuncG} = $self->{inBoundary};
    
    my @arguments = @_;
    my $type = "empty";

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
		/^type$/	&&
		do {
			(my $attrib, my $value) = splice(@arguments, $i--, 2);
			if ($value =~ /^(table|linear|discrete|gamma|identity)$/) {
				$type = $value;
			} else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}	    			
		};
	}
    }

    if ($type =~ /^empty$/) {
	$self->message_err("\"type\" attribute and value required", $self->{LineNumber}, "\"feFuncG\" element ignored");
	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    } else {

    $self->newline();
    $self->indent();
    $self->svgPrint("<feFuncG");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "feFuncG";
    $self->{tab}+=1;

    $self->svgPrint(" type=\"$type\"");

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->componentTransferFunctionAttrs(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    }

    }

    } else {
	$self->message_err("element \"feFuncG\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'feFuncG' boundary
sub endFuncG {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</feFuncG>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
}

# draws an empty 'feFuncB' tag
sub drawFuncB {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^feComponentTransfer$/) {

    if ($self->{FuncB} =~ /^$self->{inBoundary}$/) {
	$self->message_err("only one \"feFuncB\" is allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    } else {

    $self->{FuncB} = $self->{inBoundary};
    
    my @arguments = @_;
    my $type = "empty";

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
		/^type$/	&&
		do {
			(my $attrib, my $value) = splice(@arguments, $i--, 2);
			if ($value =~ /^(table|linear|discrete|gamma|identity)$/) {
				$type = $value;
			} else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}	    			
		};
	}
    }

    if ($type =~ /^empty$/) {
	$self->message_err("\"type\" attribute and value required", $self->{LineNumber}, "\"feFuncB\" element ignored");
	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    } else {

    $self->newline();
    $self->indent();
    $self->svgPrint("<feFuncB");

    $self->svgPrint(" type=\"$type\"");

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->componentTransferFunctionAttrs(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");

    }
    
    }

    } else {$self->message_err("element \"feFuncB\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'feFuncB' boundary
sub beginFuncB {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^feComponentTransfer$/) {

    if ($self->{FuncB} =~ /^$self->{inBoundary}$/) {
	$self->message_err("only one \"feFuncB\" is allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    } else {

    $self->{FuncB} = $self->{inBoundary};
    
    my @arguments = @_;
    my $type = "empty";

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
		/^type$/	&&
		do {
			(my $attrib, my $value) = splice(@arguments, $i--, 2);
			if ($value =~ /^(table|linear|discrete|gamma|identity)$/) {
				$type = $value;
			} else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}	    			
		};
	}
    }

    if ($type =~ /^empty$/) {
	$self->message_err("\"type\" attribute and value required", $self->{LineNumber}, "\"feFuncB\" element ignored");
	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    } else {

    $self->newline();
    $self->indent();
    $self->svgPrint("<feFuncB");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "feFuncB";
    $self->{tab}+=1;

    $self->svgPrint(" type=\"$type\"");

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->componentTransferFunctionAttrs(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    }

    }
    
    } else {
	$self->message_err("element \"feFuncB\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'feFuncB' boundary
sub endFuncB {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</feFuncB>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
}

# draws an empty 'feFuncA' tag
sub drawFuncA {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^feComponentTransfer$/) {

    if ($self->{FuncA} =~ /^$self->{inBoundary}$/) {
	$self->message_err("only one \"feFuncA\" is allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    } else {

    $self->{FuncA} = $self->{inBoundary};
    
    my @arguments = @_;
    my $type = "empty";

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
		/^type$/	&&
		do {
			(my $attrib, my $value) = splice(@arguments, $i--, 2);
			if ($value =~ /^(table|linear|discrete|gamma|identity)$/) {
				$type = $value;
			} else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}	    			
		};
	}
    }

    if ($type =~ /^empty$/) {
	$self->message_err("\"type\" attribute and value required", $self->{LineNumber}, "\"feFuncA\" element ignored");
	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    } else {

    $self->newline();
    $self->indent();
    $self->svgPrint("<feFuncA");

    $self->svgPrint(" type=\"$type\"");

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->componentTransferFunctionAttrs(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");

    }

    }

    } else {$self->message_err("element \"feFuncA\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'feFuncA' boundary
sub beginFuncA {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^feComponentTransfer$/) {

    if ($self->{FuncA} =~ /^$self->{inBoundary}$/) {
	$self->message_err("only one \"feFuncA\" is allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    } else {

    $self->{FuncA} = $self->{inBoundary};
    
    my @arguments = @_;
    my $type = "empty";

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
		/^type$/	&&
		do {
			(my $attrib, my $value) = splice(@arguments, $i--, 2);
			if ($value =~ /^(table|linear|discrete|gamma|identity)$/) {
				$type = $value;
			} else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}	    			
		};
	}
    }

    if ($type =~ /^empty$/) {
	$self->message_err("\"type\" attribute and value required", $self->{LineNumber}, "\"feFuncA\" element ignored");
	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    } else {

    $self->newline();
    $self->indent();
    $self->svgPrint("<feFuncA");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "feFuncA";
    $self->{tab}+=1;

    $self->svgPrint(" type=\"$type\"");

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->componentTransferFunctionAttrs(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    }

    }

    } else {
	$self->message_err("element \"feFuncA\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'feFuncA' boundary
sub endFuncA {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</feFuncA>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
}

# draws an empty 'feComposite' tag
sub drawComposite {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^filter$/) {

    my @arguments = @_;
    my $in2 = "empty";

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^in2$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$in2 = $value;
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    if ($in2 =~ /^empty$/) {
	$self->message_err("\"in2\" attribute and value required", $self->{LineNumber}, "\"feComposite\" element ignored");
	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    } else {

    $self->newline();
    $self->indent();
    $self->svgPrint("<feComposite");

    $self->svgPrint(" in2=\"$in2\"");

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^operator$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(over|in|out|atop|xor|arithmetic)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^k1$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^k2$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^k3$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^k4$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->filterPrimitiveAttrsWithIn(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");

    }

    } else {$self->message_err("element \"feComposite\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'feComposite' boundary
sub beginComposite {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^filter$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<feComposite");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "feComposite";
    $self->{tab}+=1;
    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^operator$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(over|in|out|atop|xor|arithmetic)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^k1$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^k2$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^k3$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^k4$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->filterPrimitiveAttrsWithIn(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    } else {
	$self->message_err("element \"feComposite\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'feComposite' boundary
sub endComposite {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</feComposite>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
}

# opens a 'feDiffuseLighting' boundary
sub beginDLighting {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^filter$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<feDiffuseLighting");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "feDiffuseLighting";
    $self->{tab}+=1;
    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^surfaceScale$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^diffuseConstant$/	&&
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
    @arguments = $self->LightingEffects(@arguments);
    @arguments = $self->filterPrimitiveAttrsWithIn(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    } else {
	$self->message_err("element \"feDiffuseLighting\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'feDiffuseLighting' boundary
sub endDLighting {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</feDiffuseLighting>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
}

# draws an empty 'feDistantLight' tag
sub drawDisLight {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(feDiffuseLighting|feSpecularLighting)$/){

    $self->newline();
    $self->indent();
    $self->svgPrint("<feDistantLight");
    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^azimuth$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^elevation$/	&&
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

    } else {$self->message_err("element \"feDistantLight\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'feDistantLight' boundary
sub beginDisLight {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(feDiffuseLighting|feSpecularLighting)$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<feDistantLight");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "feDistantLight";
    $self->{tab}+=1;
    my @arguments = @_;
    
    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^azimuth$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^elevation$/	&&
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
	$self->message_err("element \"feDistantLight\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'feDistantLight' boundary
sub endDisLight {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</feDistantLight>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
}

# draws an empty 'fePointLight' tag
sub drawPntLight {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(feDiffuseLighting|feSpecularLighting)$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<fePointLight");
    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^zval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$self->svgPrint(" z=\"$value\"");
		    } else {$self->message_err("\"z\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }
    
    @arguments = $self->XY(@arguments);
    @arguments = $self->stdAttrs(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");

    } else {$self->message_err("element \"fePointLight\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'fePointLight' boundary
sub beginPntLight {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(feDiffuseLighting|feSpecularLighting)$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<fePointLight");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "fePointLight";
    $self->{tab}+=1;
    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^zval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$self->svgPrint(" z=\"$value\"");
		    } else {$self->message_err("\"z\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }
    
    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->XY(@arguments);
    
    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    } else {
	$self->message_err("element \"fePointLight\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'fePointLight' boundary
sub endPntLight {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</fePointLight>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
}

# draws an empty 'feSpotLight' tag
sub drawSptLight {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(feDiffuseLighting|feSpecularLighting)$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<feSpotLight");
    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^zval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$self->svgPrint(" z=\"$value\"");
		    } else {$self->message_err("\"z\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^pointsAtX$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^pointsAtY$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^pointsAtZ$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^specularExponent$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^limitingConeAngle$/	&&
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

    } else {$self->message_err("element \"feSpotLight\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'feSpotLight' boundary
sub beginSptLight {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(feDiffuseLighting|feSpecularLighting)$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<feSpotLight");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "feSpotLight";
    $self->{tab}+=1;
    my @arguments = @_;
    
    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^zval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$self->svgPrint(" z=\"$value\"");
		    } else {$self->message_err("\"z\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^pointsAtX$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^pointsAtY$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^pointsAtZ$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^specularExponent$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^limitingConeAngle$/	&&
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
	$self->message_err("element \"feSpotLight\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'feSpotLight' boundary
sub endSptLight {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</feSpotLight>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
}

# draws an empty 'feDisplacementMap' tag
sub drawDispMap {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^filter$/) {

    my @arguments = @_;
    my $in2 = "empty";

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^in2$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^.+$/) {
			$in2 = $value;
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    if ($in2 =~ /^empty$/) {
	$self->message_err("\"in2\" attribute and value required", $self->{LineNumber}, "\"feDisplacementMap\" element ignored");
	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    } else {

    $self->newline();
    $self->indent();
    $self->svgPrint("<feDisplacementMap");

    $self->svgPrint(" in2=\"$in2\"");

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^scale$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^xChannelSelector$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(R|G|B|A)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^yChannelSelector$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(R|G|B|A)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->filterPrimitiveAttrsWithIn(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");

    }

    } else {$self->message_err("element \"feDisplacementMap\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'feDisplacementMap' boundary
sub beginDispMap {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^filter$/) {

    my @arguments = @_;
    my $in2 = "empty";

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^in2$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^.+$/) {
			$in2 = $value;
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    if ($in2 =~ /^empty$/) {
	$self->message_err("\"in2\" attribute and value required", $self->{LineNumber}, "\"feDisplacementMap\" element ignored");
	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    } else {

    $self->newline();
    $self->indent();
    $self->svgPrint("<feDisplacementMap");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "feDisplacementMap";
    $self->{tab}+=1;

    $self->svgPrint(" in2=\"$in2\"");
    
    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^scale$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^xChannelSelector$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(R|G|B|A)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^yChannelSelector$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(R|G|B|A)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->filterPrimitiveAttrsWithIn(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    }

    } else {
	$self->message_err("element \"feDisplacementMap\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'feDisplacementMap' boundary
sub endDispMap {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</feDisplacementMap>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
}

# draws an empty 'feGaussianBlur' tag
sub drawGBlur {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^filter$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<feGaussianBlur");
    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^stdDeviation$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}(\s*\[$self->{reNumber}\])?$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};

	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->filterPrimitiveAttrsWithIn(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");

    } else {$self->message_err("element \"feGaussianBlur\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'feGaussianBlur' boundary
sub beginGBlur {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^filter$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<feGaussianBlur");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "feGaussianBlur";
    $self->{tab}+=1;
    my @arguments = @_;
    
    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^stdDeviation$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}(\s*\[$self->{reNumber}\])?$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};

	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->filterPrimitiveAttrsWithIn(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    } else {
	$self->message_err("element \"feGaussianBlur\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'feGaussianBlur' boundary
sub endGBlur {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</feGaussianBlur>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
}

# draws an empty 'feImage' tag
sub drawFImage {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^filter$/) {

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
    $self->svgPrint("<feImage");

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
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->PttnAttrsAll(@arguments);
    @arguments = $self->xlinkRefAttrs(@arguments);
    @arguments = $self->filterPrimitiveAttrs(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");

    }

    } else {$self->message_err("element \"feImage\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'feImage' boundary
sub beginFImage {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^filter$/) {

    my @arguments = @_;
    my $href = "empty";

    for (my $i=0; $i<@arguments; $i++) {
	if ($arguments[$i] =~ /^xlinkhref$/)	{
		(my $attrib, my $value) = splice(@arguments, $i--, 2);
		if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$href = $value;
	   	} 
	}
    }

    if ($href =~ /^empty$/) {
	$self->message_err("\"xlink:href\" attribute and value required", $self->{LineNumber}, "\"feImage\" element ignored");
	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    } else {

    $self->newline();
    $self->indent();
    $self->svgPrint("<feImage");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "feImage";
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
	    /^transform$/ && 
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    $self->svgPrint(" $attrib=\"$value\"");
		    last SWITCH;
		};
	}
    }
    
    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->PttnAttrsAll(@arguments);
    @arguments = $self->xlinkRefAttrs(@arguments);
    @arguments = $self->filterPrimitiveAttrs(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    }

    } else {
	$self->message_err("element \"feImage\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'feImage' boundary
sub endFImage {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</feImage>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
}

# draws an empty 'feMerge' tag
sub drawMerge {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^filter$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<feMerge");
    my @arguments = @_;

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->filterPrimitiveAttrsWithIn(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");

    } else {$self->message_err("element \"feMerge\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'feMerge' boundary
sub beginMerge {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^filter$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<feMerge");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "feMerge";
    $self->{tab}+=1;
    my @arguments = @_;

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->filterPrimitiveAttrsWithIn(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    } else {
	$self->message_err("element \"feMerge\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'feMerge' boundary
sub endMerge {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</feMerge>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
}

# draws an empty 'feMergeNode' tag
sub drawMergeNode {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^feMerge$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<feMergeNode");
    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^in$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^.+$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }
    
    @arguments = $self->stdAttrs(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");

    } else {$self->message_err("element \"feMergeNode\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'feMergeNode' boundary
sub beginMergeNode {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^filter$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<feMergeNode");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "feMergeNode";
    $self->{tab}+=1;
    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^in$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^.+$/) {
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
	$self->message_err("element \"feMergeNode\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'feMergeNode' boundary
sub endMergeNode {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</feMergeNode>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
}

# draws an empty 'feMorphology' tag
sub drawMorphology {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^filter$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<feMorphology");
    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^operator$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(erode|dilate)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	     /^radius$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reLength}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->filterPrimitiveAttrsWithIn(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");

    } else {$self->message_err("element \"feMorphology\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'feMorphology' boundary
sub beginMorphology {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^filter$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<feMorphology");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "feMorphology";
    $self->{tab}+=1;
    my @arguments = @_;
    
    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^operator$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(erode|dilate)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	     /^radius$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reLength}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->filterPrimitiveAttrsWithIn(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    } else {
	$self->message_err("element \"feMorphology\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'feMorphology' boundary
sub endMorphology {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</feMorphology>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
}

# draws an empty 'feOffset' tag
sub drawOffset {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^filter$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<feOffset");
    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	     /^dx$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reLength}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {
			$self->svgPrint(" $attrib=\"0\"");
			$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber});
		    }
		    last SWITCH;
		};
	     /^dy$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reLength}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {
			$self->svgPrint(" $attrib=\"0\"");
			$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber});
		    }
		    last SWITCH;
		};	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->filterPrimitiveAttrsWithIn(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");

    } else {$self->message_err("element \"feOffset\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'feOffset' boundary
sub beginOffset {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^filter$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<feOffset");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "feOffset";
    $self->{tab}+=1;
    my @arguments = @_;
    
    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	     /^dx$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reLength}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {
			$self->svgPrint(" $attrib=\"0\"");
			$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber});
		    }
		    last SWITCH;
		};
	     /^dy$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reLength}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {
			$self->svgPrint(" $attrib=\"0\"");
			$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber});
		    }
		    last SWITCH;
		};	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->filterPrimitiveAttrsWithIn(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    } else {
	$self->message_err("element \"feOffset\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'feOffset' boundary
sub endOffset {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</feOffset>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
}

# opens a 'feSpecularLighting' boundary
sub beginSLighting {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^filter$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<feSpecularLighting");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "feSpecularLighting";
    $self->{tab}+=1;
    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^surfaceScale$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^specularConstant$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reUnsignNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^specularExponent$/		&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^([1-9](\.[0-9]+)?|[1-9][0-9](\.[0-9]+)?|1[0-2][0-7](\.[0-9]+)?|128(\.0+)?)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->LightingEffects(@arguments);
    @arguments = $self->filterPrimitiveAttrsWithIn(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    } else {
	$self->message_err("element \"feSpecularLighting\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'feSpecularLighting' boundary
sub endSLighting {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</feSpecularLighting>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
}

# draws an empty 'feTile' tag
sub drawTile {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^filter$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<feTile");
    my @arguments = @_;

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->filterPrimitiveAttrsWithIn(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");

    } else {$self->message_err("element \"feTile\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'feTile' boundary
sub beginTile {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^filter$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<feTile");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "feTile";
    $self->{tab}+=1;
    my @arguments = @_;

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->filterPrimitiveAttrsWithIn(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    } else {
	$self->message_err("element \"feTile\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'feTile' boundary
sub endTurbulence {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</feTile>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
}

# draws an empty 'feTurbulence' tag
sub drawTurbulence {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^filter$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<feTurbulence");
    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^baseFrequency$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reUnsignNumber}(\s*\[$self->{reUnsignNumber}\])?$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^numOctaves$/		&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reUnsignNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^stitchTiles$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(stitch|noStitch)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^type$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(fractalNoise|turbulence)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^seed$/	&&
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
    @arguments = $self->filterPrimitiveAttrsWithIn(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");

    } else {$self->message_err("element \"feTurbulence\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'feTurbulence' boundary
sub beginTurbulence {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^filter$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<feTurbulence");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "feTurbulence";
    $self->{tab}+=1;
    my @arguments = @_;
    
    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^baseFrequency$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reUnsignNumber}(\s*\[$self->{reUnsignNumber}\])?$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^numOctaves$/		&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reUnsignNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^stitchTiles$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(stitch|noStitch)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^type$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(fractalNoise|turbulence)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^seed$/	&&
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
    @arguments = $self->filterPrimitiveAttrsWithIn(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    } else {
	$self->message_err("element \"feTurbulence\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'feTurbulence' boundary
sub endTurbulence {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</feTurbulence>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
}

# draws an empty 'feConvolveMatrix' tag
sub drawConvolveMatrix {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^filter$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<feConvolveMatrix");
    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^order$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reUnsignNumber}(\s*\[$self->{reUnsignNumber}\])?$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^kernelMatrix$/		&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^divisor$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reUnsignNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^bias$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reUnsignNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^targetX$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^targetY$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^edgeMode$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(duplicate|wrap|none)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^kernelUnitLength$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reLength}(\s*\[$self->{reLength}\])?$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^preserveAlpha$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reBoolean}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    @arguments = $self->filterPrimitiveAttrsWithIn(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");

    } else {$self->message_err("element \"feConvolveMatrix\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'feConvolveMatrix' boundary
sub beginConvolveMatrix {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^filter$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<feConvolveMatrix");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "feConvolveMatrix";
    $self->{tab}+=1;
    my @arguments = @_;
    
    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^order$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reUnsignNumber}(\s*\[$self->{reUnsignNumber}\])?$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^kernelMatrix$/		&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^divisor$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reUnsignNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^bias$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reUnsignNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^targetX$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^targetY$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reNumber}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^edgeMode$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(duplicate|wrap|none)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^kernelUnitLength$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reLength}(\s*\[$self->{reLength}\])?$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^preserveAlpha$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reBoolean}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    @arguments = $self->filterPrimitiveAttrsWithIn(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    } else {
	$self->message_err("element \"feConvolveMatrix\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'feConvolveMatrix' boundary
sub endConvolveMatrix {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</feConvolveMatrix>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
}

1; # Perl notation to end a module