package Svg::Entities;	# define a new package
require 5.000;			# needs version 5, latest version 5.00402
require Exporter;

@ISA = qw(Exporter);
@EXPORT_OK = qw(	BaselineShiftValue ClipValue ClipPathValue ClipFillRule
					CursorValue EnableBackgroundValue FilterValue 
					FontFamilyValue FontSizeValue FontSizeAdjustValue
					GlyphOrientationHorizontalValue  GlyphOrientationVerticalValue  
					KerningValue MarkerValue MaskValue Paint PreserveAspectRatioSpec
					SpacingValue StrokeDashArrayValue StrokeDashOffsetValue 
					StrokeMiterLimitValue StrokeWidthValue TextDecorationValue 
					ViewBoxSpec ClassStyle XY	);

use strict qw ( subs vars refs );

# parses for attributes [private]
sub BaselineShiftValue {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@arguments; $i++) {
	    	if ($arguments[$i] =~ /^baseline-shift$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(baseline|sub|super|inherit|$self->{reLength})$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
	}

	return @arguments;

}

# parses for attributes [private]
sub ClipValue {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@arguments; $i++) {
	    	if ($arguments[$i] =~ /^clip$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(rect|circle|ellipse|line|polyline|polygon|auto|inherit)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
	}

	return @arguments;

}

# parses for attributes [private]
sub ClipPathValue {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@arguments; $i++) {
	    	if ($arguments[$i] =~ /^clip-path$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(none|inherit|$self->{reAnyOneOrMore})$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
	}

	return @arguments;

}

# parses for attributes [private]
sub ClipFillRule {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@arguments; $i++) {
	    	if ($arguments[$i] =~ /^(clip-rule|fill-rule)$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(nonzero|evenodd|inherit)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
	}

	return @arguments;

}

# parses for attributes [private]
sub CursorValue {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@arguments; $i++) {
	    	if ($arguments[$i] =~ /^cursor$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(auto|crosshair|default|pointer|move|e-resize|ne-resize|nw-resize|n-resize|se-resize|sw-resize|s-resize|w-resize|text|wait|help|inherit|$self->{reAnyOneOrMore})$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
	}

	return @arguments;

}

# parses for attributes [private]
sub EnableBackgroundValue {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@arguments; $i++) {
	    	if ($arguments[$i] =~ /^enable-background$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(accumulate|inherit|new(\[($self->{rePercent}$self->{reSpaceComma}){2}$self->{reLength}$self->{reSpaceComma}$self->{reLength}\])?)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
	}

	return @arguments;

}

# parses for attributes [private]
sub FilterValue {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@arguments; $i++) {
	    	if ($arguments[$i] =~ /^filter$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(none|inherit|$self->{reAnyOneOrMore})$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
	}

	return @arguments;

}

# parses for attributes [private]
sub FontFamilyValue {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@arguments; $i++) {
	    	if ($arguments[$i] =~ /^font-family$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
	}

	return @arguments;

}

# parses for attributes [private]
sub FontSizeValue {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@arguments; $i++) {
	    	if ($arguments[$i] =~ /^font-size$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(inherit|larger|smaller|$self->{reLength})$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
	}

	return @arguments;

}

# parses for attributes [private]
sub FontSizeAdjustValue {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@arguments; $i++) {
	    	if ($arguments[$i] =~ /^font-size-adjust$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(inherit|none|$self->{reNumber})$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
	}

	return @arguments;

}

# parses for attributes [private]
sub GlyphOrientationHorizontalValue {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@arguments; $i++) {
	    	if ($arguments[$i] =~ /^glyph-orientation-horizontal$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{re360}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
	}

	return @arguments;

}

# parses for attributes [private]
sub GlyphOrientationVerticalValue {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@arguments; $i++) {
	    	if ($arguments[$i] =~ /^glyph-orientation-vertical$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{re360}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
	}

	return @arguments;

}

# parses for attributes [private]
sub KerningValue {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@arguments; $i++) {
	    	if ($arguments[$i] =~ /^kerning$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(auto|inherit|$self->{reLength})$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
	}

	return @arguments;

}

# parses for attributes [private]
sub MarkerValue {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@arguments; $i++) {
	    	if ($arguments[$i] =~ /^marker(-(start|end|mid))?$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(none|inherit|$self->{reAnyOneOrMore})$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
	}

	return @arguments;

}

# parses for attributes [private]
sub MaskValue {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@arguments; $i++) {
	    	if ($arguments[$i] =~ /^mask$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(none|inherit|$self->{reAnyOneOrMore})$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
	}

	return @arguments;

}

# parses for attributes [private]
sub Paint {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@arguments; $i++) {
	    	if ($arguments[$i] =~ /^(fill|stroke)$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(none|currentColor|inherit|$self->{reAnyOneOrMore})$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
	}

	return @arguments;

}

# parses for attributes [private]
sub PreserveAspectRatioSpec {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@arguments; $i++) {
	    	if ($arguments[$i] =~ /^preserveAspectRatio$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(none|(xMinYMin|xMidYMin|xMaxYMin|xMinYMid|xMidYMid|xMaxYMid|xMinYMax|xMidYMax|xMaxYMax)(\s(meet|slice))?)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
	}

	return @arguments;

}

# parses for attributes [private]
sub SpacingValue {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@arguments; $i++) {
	    	if ($arguments[$i] =~ /^(letter-spacing|word-spacing)$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(normal|inherit|$self->{reLength})$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
	}

	return @arguments;

}

# parses for attributes [private]
sub StrokeDashArrayValue {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@arguments; $i++) {
	    	if ($arguments[$i] =~ /^stroke-dasharray$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(none|inherit|$self->{reSpaceCommaOneOrMore})$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
	}

	return @arguments;

}

# parses for attributes [private]
sub StrokeDashOffsetValue {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@arguments; $i++) {
	    	if ($arguments[$i] =~ /^stroke-dashoffset$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(inherit|$self->{reLength})$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
	}

	return @arguments;

}

# parses for attributes [private]
sub StrokeMiterLimitValue {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@arguments; $i++) {
	    	if ($arguments[$i] =~ /^stroke-miterlimit$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(inherit|$self->{reUnsignNumber})$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
	}

	return @arguments;

}

# parses for attributes [private]
sub StrokeWidthValue {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@arguments; $i++) {
	    	if ($arguments[$i] =~ /^stroke-width$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(inherit|$self->{rePercent})$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
	}

	return @arguments;

}

# parses for attributes [private]
sub TextDecorationValue {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@arguments; $i++) {
	    	if ($arguments[$i] =~ /^text-decoration$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(none|underline|overline|line-through|blink|inherit)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
	}

	return @arguments;

}

# parses for attributes [private]
sub ViewBoxSpec {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@arguments; $i++) {
	    	if ($arguments[$i] =~ /^viewBox$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reSpaceComma4}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
	}

	return @arguments;

}

# parses for attributes [private]
sub ClassStyle {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@arguments; $i++) {
		if ($arguments[$i] =~ /^class$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
		if ($arguments[$i] =~ /^style$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
	}

	return @arguments;

}

# parses for attributes [private]
sub XY {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@arguments; $i++) {
	    	if ($arguments[$i] =~ /^xval$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$self->svgPrint(" x=\"$value\"");
		    } else {$self->message_err("\"x\" attribute value not valid", $self->{LineNumber})}
		}
	    	if ($arguments[$i] =~ /^yval$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$self->svgPrint(" y=\"$value\"");
		    } else {$self->message_err("\"y\" attribute value not valid", $self->{LineNumber})}
		}
	}

	return @arguments;

}


1; # Perl notation to end a module