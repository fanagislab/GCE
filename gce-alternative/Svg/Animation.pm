package Svg::Animation;		# define a new package
require 5.000;					# needs version 5, latest version 5.00402
require Exporter;				# standard module for making functions public

@ISA = qw(Exporter);
@EXPORT = qw(	animElementAttrs animAttributeAttrs 
				animTargetAttrs animTimingAttrs
				animValueAttrs animAdditionAttrs
				drawAnim beginAnim endAnim
				drawAnimMotion beginAnimMotion endAnimMotion
				drawAnimColor beginAnimColor endAnimColor
				drawAnimTransform beginAnimTransform endAnimTransform
				drawMPath beginMPath endMPath 
				beginCAnim endCAnim move change	);

# use Svg::Std qw( message_out );

use strict qw ( subs vars refs );

# parses for attributes [private]
sub animElementAttrs {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@arguments; $i++) {
		if ($arguments[$i] =~ /^xlink:href$/) {
			(my $attrib, my $value) = splice(@arguments, $i--, 2);
			if ($value =~ /^$self->{reAnyOneOrMore}$/) { 
				$self->svgPrint(" $attrib=\"$value\"");
			} else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}	    			
		}
	} 
	
       @arguments = $self->xlinkRefAttrs(@arguments);
    
	return @arguments;

}

# parses for attributes [private]
sub animAttributeAttrs {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@arguments; $i++) {
		if ($arguments[$i] =~ /^attributeType$/) {
			(my $attrib, my $value) = splice(@arguments, $i--, 2);
			if ($value =~ /^(CSS|XML|auto)$/) {
				$self->svgPrint(" $attrib=\"$value\"");
			} else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
		if ($arguments[$i] =~ /^attributeName$/) {
			(my $attrib, my $value) = splice(@arguments, $i--, 2);
			if ($value =~ /^$self->{reAnyOneOrMore}$/) {
				$self->svgPrint(" $attrib=\"$value\"");
			} else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
	} 
    
	return @arguments;

}

# parses for attributes [private]
sub animTargetAttrs {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@arguments; $i++) {
		if ($arguments[$i] =~ /^xlink:href$/)	{
			(my $attrib, my $value) = splice(@arguments, $i--, 2);
			if ($value =~ /^$self->{reAnyOneOrMore}$/) {
				$self->svgPrint(" $attrib=\"$value\"");
		    	} else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
	} 

        @arguments = $self->animAttributeAttrs(@arguments);
	@arguments = $self->xlinkRefAttrs(@arguments);

	return @arguments;

} 

# parses for attributes [private]
sub animTimingAttrs {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@arguments; $i++) {
		if ($arguments[$i] =~ /^begin$/) {
			(my $attrib, my $value) = splice(@arguments, $i--, 2);
			# if ($value =~ /^(([0-9]{2}:[0-9]{2}:([0-9]{2}|00\.[0-9]+)|[0-9]+(\.[0-9]+)?(h|min|s|ms)?)|\s?[A-Za-z]+\.(begin|end)(\s?\+\s?([0-9]{2}:[0-9]{2}:([0-9]{2}|00\.[0-9]+)|[0-9]+(\.[0-9]+)?(h|min|s|ms)?))?|\s?[A-Za-z]+\.(onfocusin|onfocusout|ongainselection|onloseselection|onactivate|onmousedown|onmouseup|onmouseover|onmousemove|onmouseout|onclick|ondblclick|onkeydown|onkeypress|onkeyup|onload|onselect|onresize|onscroll|onunload|onzoom|onerror|onabort)(\s?\+\s?([0-9]{2}:[0-9]{2}:([0-9]{2}|00\.[0-9]+)|[0-9]+(\.[0-9]+)?(h|min|s|ms)?))?|indefinite)$/) {
			if ($value =~ /^$self->{reAnyOneOrMore}$/) {
				$self->svgPrint(" $attrib=\"$value\"");
			} else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
		if ($arguments[$i] =~ /^end$/) {
			(my $attrib, my $value) = splice(@arguments, $i--, 2);
			# if ($value =~ /^(([0-9]{2}:[0-9]{2}:([0-9]{2}|00\.[0-9]+)|[0-9]+(\.[0-9]+)?(h|min|s|ms)?)|\s?[A-Za-z]+\.(begin|end)(\s?\+\s?([0-9]{2}:[0-9]{2}:([0-9]{2}|00\.[0-9]+)|[0-9]+(\.[0-9]+)?(h|min|s|ms)?))?)$/) {
			if ($value =~ /^$self->{reAnyOneOrMore}$/) {
				$self->svgPrint(" $attrib=\"$value\"");
			} else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
		if ($arguments[$i] =~ /^dur$/) {
			(my $attrib, my $value) = splice(@arguments, $i--, 2);
			# if ($value =~ /^(([0-9]{2}:[0-9]{2}:([0-9]{2}|00\.[0-9]+)|[0-9]+(\.[0-9]+)?(h|min|s|ms)?)|indefinite)$/) {
			if ($value =~ /^$self->{reAnyOneOrMore}$/) {
				$self->svgPrint(" $attrib=\"$value\"");
			} else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
		if ($arguments[$i] =~ /^max$/) {
			(my $attrib, my $value) = splice(@arguments, $i--, 2);
			# if ($value =~ /^(([0-9]{2}:[0-9]{2}:([0-9]{2}|00\.[0-9]+)|[0-9]+(\.[0-9]+)?(h|min|s|ms)?)|\s?[A-Za-z]+\.(begin|end)(\s?\+\s?([0-9]{2}:[0-9]{2}:([0-9]{2}|00\.[0-9]+)|[0-9]+(\.[0-9]+)?(h|min|s|ms)?))?|\s?[A-Za-z]+\.(onfocusin|onfocusout|ongainselection|onloseselection|onactivate|onmousedown|onmouseup|onmouseover|onmousemove|onmouseout|onclick|ondblclick|onkeydown|onkeypress|onkeyup|onload|onselect|onresize|onscroll|onunload|onzoom|onerror|onabort)(\s?\+\s?([0-9]{2}:[0-9]{2}:([0-9]{2}|00\.[0-9]+)|[0-9]+(\.[0-9]+)?(h|min|s|ms)?))?|indefinite)$/) {
			if ($value =~ /^$self->{reAnyOneOrMore}$/) {
				$self->svgPrint(" $attrib=\"$value\"");
			} else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
		if ($arguments[$i] =~ /^min$/) {
			(my $attrib, my $value) = splice(@arguments, $i--, 2);
			# if ($value =~ /^(([0-9]{2}:[0-9]{2}:([0-9]{2}|00\.[0-9]+)|[0-9]+(\.[0-9]+)?(h|min|s|ms)?)|\s?[A-Za-z]+\.(begin|end)(\s?\+\s?([0-9]{2}:[0-9]{2}:([0-9]{2}|00\.[0-9]+)|[0-9]+(\.[0-9]+)?(h|min|s|ms)?))?|\s?[A-Za-z]+\.(onfocusin|onfocusout|ongainselection|onloseselection|onactivate|onmousedown|onmouseup|onmouseover|onmousemove|onmouseout|onclick|ondblclick|onkeydown|onkeypress|onkeyup|onload|onselect|onresize|onscroll|onunload|onzoom|onerror|onabort)(\s?\+\s?([0-9]{2}:[0-9]{2}:([0-9]{2}|00\.[0-9]+)|[0-9]+(\.[0-9]+)?(h|min|s|ms)?))?|indefinite)$/) {
			if ($value =~ /^$self->{reAnyOneOrMore}$/) {
				$self->svgPrint(" $attrib=\"$value\"");
			} else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
		if ($arguments[$i] =~ /^restart$/) {
			(my $attrib, my $value) = splice(@arguments, $i--, 2);
			if ($value =~ /^(always|never|whenNotActive)$/) {
				$self->svgPrint(" $attrib=\"$value\"");
			} else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}			
		}
		if ($arguments[$i] =~ /^repeatCount$/) {
			(my $attrib, my $value) = splice(@arguments, $i--, 2);
			if ($value =~ /^($self->{reUnsignNumber}|indefinite)$/) {
				$self->svgPrint(" $attrib=\"$value\"");
			} else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}			
		}
		if ($arguments[$i] =~ /^repeatDur$/) {
			(my $attrib, my $value) = splice(@arguments, $i--, 2);
			# if ($value =~ /^(([0-9]{2}:[0-9]{2}:([0-9]{2}|00\.[0-9]+)|[0-9]+(\.[0-9]+)?(h|min|s|ms)?)|indefinite)$/) {
			if ($value =~ /^$self->{reAnyOneOrMore}$/) {
				$self->svgPrint(" $attrib=\"$value\"");
			} else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
		if ($arguments[$i] =~ /^fill$/) {
			(my $attrib, my $value) = splice(@arguments, $i--, 2);
			if ($value =~ /^(remove|freeze)$/) {
				$self->svgPrint(" $attrib=\"$value\"");
			} else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}			
		}
	} 

	return @arguments;

} 

# parses for attributes [private]
sub animValueAttrs {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@arguments; $i++) {
		if ($arguments[$i] =~ /^calcMode$/) {
			(my $attrib, my $value) = splice(@arguments, $i--, 2);
			if ($value =~ /^(discrete|linear|paced|spline)$/) {
				$self->svgPrint(" $attrib=\"$value\"");
			} else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}	    			
		}
		if ($arguments[$i] =~ /^values$/) {
			(my $attrib, my $value) = splice(@arguments, $i--, 2);
			if ($value =~ /^$self->{reAnyOneOrMore}$/) {
				$self->svgPrint(" $attrib=\"$value\"");
			} else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
		if ($arguments[$i] =~ /^from$/) {
			(my $attrib, my $value) = splice(@arguments, $i--, 2);
			if ($value =~ /^$self->{reAnyOneOrMore}$/) {
				$self->svgPrint(" $attrib=\"$value\"");
			} else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}	    			
		}
		if ($arguments[$i] =~ /^to$/) {
			(my $attrib, my $value) = splice(@arguments, $i--, 2);
			if ($value =~ /^$self->{reAnyOneOrMore}$/) {
				$self->svgPrint(" $attrib=\"$value\"");
			} else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}	    			
		}
		if ($arguments[$i] =~ /^by$/) {
			(my $attrib, my $value) = splice(@arguments, $i--, 2);
			if ($value =~ /^.+$/) {
				$self->svgPrint(" by=\"$value\"");
			} else {$self->message_err("\"by\" attribute value not valid", $self->{LineNumber})}	    			
		}
		if ($arguments[$i] =~ /^keyTimes$/) {
			(my $attrib, my $value) = splice(@arguments, $i--, 2);
			if ($value =~ /^(1(\.0+)?|0(\.[0-9]+)?)(;(1(\.0+)?|0(\.[0-9]+)?))*$/) {
				$self->svgPrint(" $attrib=\"$value\"");
			} else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}	    			
		}
		if ($arguments[$i] =~ /^keySplines$/) {
			(my $attrib, my $value) = splice(@arguments, $i--, 2);
			if ($value =~ /^((1(\.0+)?|0(\.[0-9]+)?)\s(1(\.0+)?|0(\.[0-9]+)?)\s(1(\.0+)?|0(\.[0-9]+)?)\s(1(\.0+)?|0(\.[0-9]+)?))(;(1(\.0+)?|0(\.[0-9]+)?)\s(1(\.0+)?|0(\.[0-9]+)?)\s(1(\.0+)?|0(\.[0-9]+)?)\s(1(\.0+)?|0(\.[0-9]+)?))*$/) {
				$self->svgPrint(" $attrib=\"$value\"");
			} else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}	    			
		}
	} 

	return @arguments;

}

# parses for attributes [private]
sub animAdditionAttrs {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@arguments; $i++) {
		if ($arguments[$i] =~ /^additive$/) {
			(my $attrib, my $value) = splice(@arguments, $i--, 2);
			if ($value =~ /^(replace|sum)$/) { # (replace|sum)
				$self->svgPrint(" $attrib=\"$value\"");
			} else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}	    			
		}
		if ($arguments[$i] =~ /^accumulate$/) {
			(my $attrib, my $value) = splice(@arguments, $i--, 2);
			if ($value =~ /^(none|sum)$/) { # (none|sum)
				$self->svgPrint(" $attrib=\"$value\"");
			} else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
	} 

	return @arguments;

}

# moves an object with the provided begin time, duration and start and end points
# can only be used within beginCAnim and endCAnim
# USAGE:
# 	$GraphicsObj->move(startI, durI, xI1, yI1, xI2, yI2, startII, durII, xII1, yII1, xII2, yII2, ..., startN, durN, xN, yN, xN+1, yN+1);
sub move {

    my $self = shift;

    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^canim$/) {

    my @arguments = @_;

    if ((@arguments%6)!=0) {$self->message_err("\"move\" must take 6-tuples of x and y values", $self->{LineNumber}, "\"move\" command ignored")}

    else {

    while (@arguments>0) {

    (my $start, my $dur, my $xoffset1, my $yoffset1, my $xoffset2, my $yoffset2) = splice(@arguments, 0, 6);
    if (($start =~ /^(([0-9]{2}:[0-9]{2}:([0-9]{2}|00\.[0-9]+)|[0-9]+(\.[0-9]+)?(h|min|s|ms)?)|\s?[A-Za-z]+\.(begin|end)(\s?\+\s?([0-9]{2}:[0-9]{2}:([0-9]{2}|00\.[0-9]+)|[0-9]+(\.[0-9]+)?(h|min|s|ms)?))?|\s?[A-Za-z]+\.(onfocusin|onfocusout|ongainselection|onloseselection|onactivate|onmousedown|onmouseup|onmouseover|onmousemove|onmouseout|onclick|ondblclick|onkeydown|onkeypress|onkeyup|onload|onselect|onresize|onscroll|onunload|onzoom|onerror|onabort)(\s?\+\s?([0-9]{2}:[0-9]{2}:([0-9]{2}|00\.[0-9]+)|[0-9]+(\.[0-9]+)?(h|min|s|ms)?))?|indefinite)$/) &&
	  ($dur =~ /^(([0-9]{2}:[0-9]{2}:([0-9]{2}|00\.[0-9]+)|[0-9]+(\.[0-9]+)?(h|min|s|ms)?)|\s?[A-Za-z]+\.(begin|end)(\s?\+\s?([0-9]{2}:[0-9]{2}:([0-9]{2}|00\.[0-9]+)|[0-9]+(\.[0-9]+)?(h|min|s|ms)?))?|\s?[A-Za-z]+\.(onfocusin|onfocusout|ongainselection|onloseselection|onactivate|onmousedown|onmouseup|onmouseover|onmousemove|onmouseout|onclick|ondblclick|onkeydown|onkeypress|onkeyup|onload|onselect|onresize|onscroll|onunload|onzoom|onerror|onabort)(\s?\+\s?([0-9]{2}:[0-9]{2}:([0-9]{2}|00\.[0-9]+)|[0-9]+(\.[0-9]+)?(h|min|s|ms)?))?|indefinite)$/) &&
	  ($xoffset1 =~ /^[+-]?[0-9]+(\.[0-9]+)?$/) &&
	  ($yoffset1 =~ /^[+-]?[0-9]+(\.[0-9]+)?$/) &&
	  ($xoffset2 =~ /^[+-]?[0-9]+(\.[0-9]+)?$/) &&
	  ($yoffset2 =~ /^[+-]?[0-9]+(\.[0-9]+)?$/)) {

	$self->drawAnim("attributeName", "x", "from", $xoffset1, "to", $xoffset2, "begin", $start, "dur", $dur, @{$self->{cAnim}});
	$self->drawAnim("attributeName", "y", "from", $yoffset1, "to", $yoffset2, "begin", $start, "dur", $dur, @{$self->{cAnim}});
    } else {
	$self->message_err("\"move\" values missing or invalid", $self->{LineNumber});
    }

    }

    } # check number of x and y values
    
    } else {$self->message_err("\"move\" is only allowed in a custom \"animation\" boundary", $self->{LineNumber})}

}

# changes graphic property of an object with the provided begin time and duration
# can only be used within beginCAnim and endCAnim
# USAGE:
# 	$GraphicsObj->change(startI, durI, propertyI, valueI1, valueI2, startII, durII, propertyII, valueII1, valueII2, ..., startN, durN, propertyN, valueN1, valueN2);
sub change {

    my $self = shift;

    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^canim$/) {

    my @arguments = @_;

    if ((@arguments%5)!=0) {$self->message_err("\"change\" must take 5-tuples of x and y values", $self->{LineNumber}, "\"change\" command ignored")}

    else {

    while (@arguments>0) {

    (my $start, my $dur, my $property, my $value1, my $value2) = splice(@arguments, 0, 5);
    if (($start =~ /^(([0-9]{2}:[0-9]{2}:([0-9]{2}|00\.[0-9]+)|[0-9]+(\.[0-9]+)?(h|min|s|ms)?)|\s?[A-Za-z]+\.(begin|end)(\s?\+\s?([0-9]{2}:[0-9]{2}:([0-9]{2}|00\.[0-9]+)|[0-9]+(\.[0-9]+)?(h|min|s|ms)?))?|\s?[A-Za-z]+\.(onfocusin|onfocusout|ongainselection|onloseselection|onactivate|onmousedown|onmouseup|onmouseover|onmousemove|onmouseout|onclick|ondblclick|onkeydown|onkeypress|onkeyup|onload|onselect|onresize|onscroll|onunload|onzoom|onerror|onabort)(\s?\+\s?([0-9]{2}:[0-9]{2}:([0-9]{2}|00\.[0-9]+)|[0-9]+(\.[0-9]+)?(h|min|s|ms)?))?|indefinite)$/) &&
	  ($dur =~ /^(([0-9]{2}:[0-9]{2}:([0-9]{2}|00\.[0-9]+)|[0-9]+(\.[0-9]+)?(h|min|s|ms)?)|\s?[A-Za-z]+\.(begin|end)(\s?\+\s?([0-9]{2}:[0-9]{2}:([0-9]{2}|00\.[0-9]+)|[0-9]+(\.[0-9]+)?(h|min|s|ms)?))?|\s?[A-Za-z]+\.(onfocusin|onfocusout|ongainselection|onloseselection|onactivate|onmousedown|onmouseup|onmouseover|onmousemove|onmouseout|onclick|ondblclick|onkeydown|onkeypress|onkeyup|onload|onselect|onresize|onscroll|onunload|onzoom|onerror|onabort)(\s?\+\s?([0-9]{2}:[0-9]{2}:([0-9]{2}|00\.[0-9]+)|[0-9]+(\.[0-9]+)?(h|min|s|ms)?))?|indefinite)$/) &&
	  ($property =~ /^.+$/) &&
	  ($value1 =~ /^.+$/) &&
	  ($value2 =~ /^.+$/)) {
	$self->drawAnim("attributeName", $property, "from", $value1, "to", $value2, "begin", $start, "dur", $dur, @{$self->{cAnim}});
    } else {
	$self->message_err("\"change\" values missing or invalid", $self->{LineNumber});
    }

    }

    } # check number of x and y values
    
    } else {$self->message_err("\"change\" is only allowed in a custom \"animation\" boundary", $self->{LineNumber})}

}

# opens a custom animation block
sub beginCAnim {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(svg|g|defs|symbol|use|image|switch|path|rect|circle|ellipse|line|polyline|polygon|text|tref|tspan|textPath|marker|linearGradient|radialGradient|stop|pattern|clipPath|mask|filter|feDistantLight|fePointLight|feSpotLight|feBlend|feColorMatrix|feFuncR|feFuncG|feFuncB|feFuncA|feComposite|feConvolveMatrix|feDiffuseLighting|feDisplacementMap|feFlood|feGaussianBlur|feImage|feMergeNode|feMorphology|feOffset|feSpecularLighting|feTile|feTurbulence|a|glyph|missing-glyph)$/) {

    my @arguments = @_;

    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "canim";

    @{$self->{cAnim}}=@_;

    # } else {$self->message_err("\"animation\" elements not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

    } else {
	$self->message_err("\"animation\" elements not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }
}

# closes custom animation block
sub endCAnim {
    my $self = shift;

    if ($self->{inBoundary} =~ /^canim$/) {

    $self->{LineNumber}++;
    $self->{inBoundary} = pop(@{$self->{inQueue}});

    } else {
	$self->message_err("\"endCAnim\" is only to close a custom \"animation\" block", $self->{LineNumber});
    }

}

# draws an empty 'animate' tag
sub drawAnim {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(canim|svg|g|defs|symbol|use|image|switch|path|rect|circle|ellipse|line|polyline|polygon|text|tref|tspan|textPath|marker|linearGradient|radialGradient|stop|pattern|clipPath|mask|filter|feDistantLight|fePointLight|feSpotLight|feBlend|feColorMatrix|feFuncR|feFuncG|feFuncB|feFuncA|feComposite|feConvolveMatrix|feDiffuseLighting|feDisplacementMap|feFlood|feGaussianBlur|feImage|feMergeNode|feMorphology|feOffset|feSpecularLighting|feTile|feTurbulence|a|glyph|missing-glyph)$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<animate");
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

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->animationEvents(@arguments);
    @arguments = $self->animElementAttrs(@arguments);
    @arguments = $self->animAttributeAttrs(@arguments);
    @arguments = $self->animTimingAttrs(@arguments);
    @arguments = $self->animValueAttrs(@arguments);
    @arguments = $self->animAdditionAttrs(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");

    } else {$self->message_err("element \"animate\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}
}

# opens a 'animate' boundary
sub beginAnim {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^(canim|svg|g|defs|symbol|use|image|switch|path|rect|circle|ellipse|line|polyline|polygon|text|tref|tspan|textPath|marker|linearGradient|radialGradient|stop|pattern|clipPath|mask|filter|feDistantLight|fePointLight|feSpotLight|feBlend|feColorMatrix|feFuncR|feFuncG|feFuncB|feFuncA|feComposite|feConvolveMatrix|feDiffuseLighting|feDisplacementMap|feFlood|feGaussianBlur|feImage|feMergeNode|feMorphology|feOffset|feSpecularLighting|feTile|feTurbulence|a|glyph|missing-glyph)$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<animate");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "animate";
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
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->animationEvents(@arguments);
    @arguments = $self->animElementAttrs(@arguments);
    @arguments = $self->animAttributeAttrs(@arguments);
    @arguments = $self->animTimingAttrs(@arguments);
    @arguments = $self->animValueAttrs(@arguments);
    @arguments = $self->animAdditionAttrs(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    } else {
	$self->message_err("element \"animate\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
	$self->{inBoundary} = "empty";
    }

}

# closes a 'animate' boundary
sub endAnim {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</animate>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
    $self->{Metadata} = pop(@{$self->{dtdMetadata}});
    $self->{Desc} = pop(@{$self->{dtdDesc}});
    $self->{Title} = pop(@{$self->{dtdTitle}});
}

# draws an empty 'set' tag
sub drawSet {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(svg|g|defs|symbol|use|image|switch|path|rect|circle|ellipse|line|polyline|polygon|text|tref|tspan|textPath|marker|linearGradient|radialGradient|stop|pattern|clipPath|mask|filter|feDistantLight|fePointLight|feSpotLight|feBlend|feColorMatrix|feFuncR|feFuncG|feFuncB|feFuncA|feComposite|feConvolveMatrix|feDiffuseLighting|feDisplacementMap|feFlood|feGaussianBlur|feImage|feMergeNode|feMorphology|feOffset|feSpecularLighting|feTile|feTurbulence|a|glyph|missing-glyph)$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<set");
    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	     /^to$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}	    			
		    last SWITCH;
		};
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
    @arguments = $self->animationEvents(@arguments);
    @arguments = $self->animElementAttrs(@arguments);
    @arguments = $self->animAttributeAttrs(@arguments);
    @arguments = $self->animTimingAttrs(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");

    } else {$self->message_err("element \"set\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}
}

# opens a 'set' boundary
sub beginSet {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^(g|defs|path|rect|circle|ellipse|line|polyline|polygon|text|tspan|tref|textPath|use|image|clipPath|mask|linearGradient|radialGradient|stop|switch|filter|feFlood|feColorMatrix|feFuncR|feFuncG|feFuncB|feFuncA|feDiffuseLighting|feDistantLight|fePointLight|feSpotLight|feDisplacementMap|feGaussianBlur|feImage|feMorphology|feOffset|feSpecularLighting|feTurbulence)$/) {
    
    $self->newline();
    $self->indent();
    $self->svgPrint("<set");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "set";
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
	     /^to$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}	    			
		    last SWITCH;
		};
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
    @arguments = $self->animationEvents(@arguments);
    @arguments = $self->animElementAttrs(@arguments);
    @arguments = $self->animAttributeAttrs(@arguments);
    @arguments = $self->animTimingAttrs(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    } else {
	$self->message_err("element \"set\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
	$self->{inBoundary} = "empty";
    }

}

# closes a 'set' boundary
sub endSet {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</set>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
    $self->{Metadata} = pop(@{$self->{dtdMetadata}});
    $self->{Desc} = pop(@{$self->{dtdDesc}});
    $self->{Title} = pop(@{$self->{dtdTitle}});
}

# draws an empty 'animateMotion' tag
sub drawAnimMotion {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(svg|g|defs|symbol|use|image|switch|path|rect|circle|ellipse|line|polyline|polygon|text|tref|tspan|textPath|marker|linearGradient|radialGradient|stop|pattern|clipPath|mask|filter|feDistantLight|fePointLight|feSpotLight|feBlend|feColorMatrix|feFuncR|feFuncG|feFuncB|feFuncA|feComposite|feConvolveMatrix|feDiffuseLighting|feDisplacementMap|feFlood|feGaussianBlur|feImage|feMergeNode|feMorphology|feOffset|feSpecularLighting|feTile|feTurbulence|a|glyph|missing-glyph)$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<animateMotion");
    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^path$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^rotate$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{re360}|auto|auto-reverse)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^keyPoints$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	     /^origin$/ &&
		do {
		    $self->svgPrint(" origin=\"default\"");
		    splice(@arguments, $i--, 1);		    
		    last SWITCH;
		};
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
    @arguments = $self->animationEvents(@arguments);
    @arguments = $self->animElementAttrs(@arguments);
    @arguments = $self->animTimingAttrs(@arguments);
    @arguments = $self->animValueAttrs(@arguments);
    @arguments = $self->animAdditionAttrs(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");

    } else {$self->message_err("element \"animateMotion\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}
}

# opens a 'animateMotion' boundary
sub beginAnimMotion {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^(svg|g|defs|symbol|use|image|switch|path|rect|circle|ellipse|line|polyline|polygon|text|tref|tspan|textPath|marker|linearGradient|radialGradient|stop|pattern|clipPath|mask|filter|feDistantLight|fePointLight|feSpotLight|feBlend|feColorMatrix|feFuncR|feFuncG|feFuncB|feFuncA|feComposite|feConvolveMatrix|feDiffuseLighting|feDisplacementMap|feFlood|feGaussianBlur|feImage|feMergeNode|feMorphology|feOffset|feSpecularLighting|feTile|feTurbulence|a|glyph|missing-glyph)$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<animateMotion");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "animateMotion";
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
	    /^path$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^rotate$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{re360}|auto|auto-reverse)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^keyPoints$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	     /^origin$/ &&
		do {
		    $self->svgPrint(" origin=\"default\"");
		    splice(@arguments, $i--, 1);		    
		    last SWITCH;
		};
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
    @arguments = $self->animationEvents(@arguments);
    @arguments = $self->animElementAttrs(@arguments);
    @arguments = $self->animTimingAttrs(@arguments);
    @arguments = $self->animValueAttrs(@arguments);
    @arguments = $self->animAdditionAttrs(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    } else {
	$self->message_err("element \"animateMotion\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
	$self->{inBoundary} = "empty";
    }

}

# closes a 'animateMotion' boundary
sub endAnimMotion {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</animateMotion>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
    $self->{Metadata} = pop(@{$self->{dtdMetadata}});
    $self->{Desc} = pop(@{$self->{dtdDesc}});
    $self->{Title} = pop(@{$self->{dtdTitle}});
}

# draws an empty 'animateColor' tag
sub drawAnimColor {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(svg|g|defs|symbol|use|image|switch|path|rect|circle|ellipse|line|polyline|polygon|text|tref|tspan|textPath|marker|linearGradient|radialGradient|stop|pattern|clipPath|mask|filter|feDistantLight|fePointLight|feSpotLight|feBlend|feColorMatrix|feFuncR|feFuncG|feFuncB|feFuncA|feComposite|feConvolveMatrix|feDiffuseLighting|feDisplacementMap|feFlood|feGaussianBlur|feImage|feMergeNode|feMorphology|feOffset|feSpecularLighting|feTile|feTurbulence|a|glyph|missing-glyph)$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<animateColor");
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

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->animationEvents(@arguments);
    @arguments = $self->animElementAttrs(@arguments);
    @arguments = $self->animAttributeAttrs(@arguments);
    @arguments = $self->animTimingAttrs(@arguments);
    @arguments = $self->animValueAttrs(@arguments);
    @arguments = $self->animAdditionAttrs(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");

    } else {$self->message_err("element \"animateColor\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}
}

# opens a 'animateColor' boundary
sub beginAnimColor {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^(svg|g|defs|symbol|use|image|switch|path|rect|circle|ellipse|line|polyline|polygon|text|tref|tspan|textPath|marker|linearGradient|radialGradient|stop|pattern|clipPath|mask|filter|feDistantLight|fePointLight|feSpotLight|feBlend|feColorMatrix|feFuncR|feFuncG|feFuncB|feFuncA|feComposite|feConvolveMatrix|feDiffuseLighting|feDisplacementMap|feFlood|feGaussianBlur|feImage|feMergeNode|feMorphology|feOffset|feSpecularLighting|feTile|feTurbulence|a|glyph|missing-glyph)$/) {
    
    $self->newline();
    $self->indent();
    $self->svgPrint("<animateColor"); 
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "animateColor";
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
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->animationEvents(@arguments);
    @arguments = $self->animElementAttrs(@arguments);
    @arguments = $self->animAttributeAttrs(@arguments);
    @arguments = $self->animTimingAttrs(@arguments);
    @arguments = $self->animValueAttrs(@arguments);
    @arguments = $self->animAdditionAttrs(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    } else {
	$self->message_err("element \"animateColor\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
	$self->{inBoundary} = "empty";
    }

}

# closes a 'animateColor' boundary
sub endAnimColor {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</animateColor>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
    $self->{Metadata} = pop(@{$self->{dtdMetadata}});
    $self->{Desc} = pop(@{$self->{dtdDesc}});
    $self->{Title} = pop(@{$self->{dtdTitle}});
}

# draws an empty 'animateTransform' tag
sub drawAnimTransform {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^(svg|g|defs|symbol|use|image|switch|path|rect|circle|ellipse|line|polyline|polygon|text|tref|tspan|textPath|marker|linearGradient|radialGradient|stop|pattern|clipPath|mask|filter|feDistantLight|fePointLight|feSpotLight|feBlend|feColorMatrix|feFuncR|feFuncG|feFuncB|feFuncA|feComposite|feConvolveMatrix|feDiffuseLighting|feDisplacementMap|feFlood|feGaussianBlur|feImage|feMergeNode|feMorphology|feOffset|feSpecularLighting|feTile|feTurbulence|a|glyph|missing-glyph)$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<animateTransform");
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
	     /^type$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(translate|scale|rotate|skewX|skewY)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}	    			
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->animationEvents(@arguments);
    @arguments = $self->animElementAttrs(@arguments);
    @arguments = $self->animAttributeAttrs(@arguments);
    @arguments = $self->animTimingAttrs(@arguments);
    @arguments = $self->animValueAttrs(@arguments);
    @arguments = $self->animAdditionAttrs(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");

    } else {$self->message_err("element \"animateTransform\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}
}

# opens a 'animateTransform' boundary
sub beginAnimTransform {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^(svg|g|defs|symbol|use|image|switch|path|rect|circle|ellipse|line|polyline|polygon|text|tref|tspan|textPath|marker|linearGradient|radialGradient|stop|pattern|clipPath|mask|filter|feDistantLight|fePointLight|feSpotLight|feBlend|feColorMatrix|feFuncR|feFuncG|feFuncB|feFuncA|feComposite|feConvolveMatrix|feDiffuseLighting|feDisplacementMap|feFlood|feGaussianBlur|feImage|feMergeNode|feMorphology|feOffset|feSpecularLighting|feTile|feTurbulence|a|glyph|missing-glyph)$/) {
    
    $self->newline();
    $self->indent();
    $self->svgPrint("<animateTransform"); 
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "animateTransform";
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
	     /^type$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(translate|scale|rotate|skewX|skewY)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}	    			
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->animationEvents(@arguments);
    @arguments = $self->animElementAttrs(@arguments);
    @arguments = $self->animAttributeAttrs(@arguments);
    @arguments = $self->animTimingAttrs(@arguments);
    @arguments = $self->animValueAttrs(@arguments);
    @arguments = $self->animAdditionAttrs(@arguments);
    
    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    } else {
	$self->message_err("element \"animateTransform\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
	$self->{inBoundary} = "empty";
    }

}

# closes a 'animateTransform' boundary
sub endAnimTransform {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</animateTransform>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
    $self->{Metadata} = pop(@{$self->{dtdMetadata}});
    $self->{Desc} = pop(@{$self->{dtdDesc}});
    $self->{Title} = pop(@{$self->{dtdTitle}});
}

# draws an empty 'mpath' tag
sub drawMPath {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^animateMotion$/) {

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
    $self->svgPrint("<mpath");
    
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
    @arguments = $self->xlinkRefAttrs(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");

    }

    } else {$self->message_err("element \"mpath\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}
}

# opens a 'mpath' boundary
sub beginMPath {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^animateMotion$/) {
    
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

    push(@{$self->{dtdMetadata}}, $self->{Metadata});
    push(@{$self->{dtdDesc}}, $self->{Desc});
    push(@{$self->{dtdTitle}}, $self->{Title});
    $self->{Metadata} = "empty";
    $self->{Desc} = "empty";
    $self->{Title} = "empty";
    
    $self->newline();
    $self->indent();
    $self->svgPrint("<mpath"); 
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "mpath";
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
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->xlinkRefAttrs(@arguments);
    
    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");
    
    }

    } else {
	$self->message_err("element \"mpath\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
	$self->{inBoundary} = "empty";
    }

}

# closes a 'mpath' boundary
sub endMPath {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</mpath>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
    $self->{Metadata} = pop(@{$self->{dtdMetadata}});
    $self->{Desc} = pop(@{$self->{dtdDesc}});
    $self->{Title} = pop(@{$self->{dtdTitle}});
}


1; # Perl notation to end a module