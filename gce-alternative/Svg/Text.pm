package Svg::Text;		# define a new package
require 5.000;			# needs version 5, latest version 5.00402
require Exporter;		# standard module for making functions public

@ISA = qw(Exporter);
@EXPORT = qw( 	beginTxt endTxt drawTxt
				beginTSpan endTSpan drawTSpan
				beginTRef endTRef drawTRef
				beginTxtPath endTxtPath drawTxtPath
				beginAltGlyph endAltGlyph drawAltGlyph
				beginAltGlyphDef endAltGlyphDef drawAltGlyphDef
				beginAltGlyphItem endAltGlyphItem drawAltGlyphItem
				beginGlyphRef endGlyphRef drawGlyphRef
				drawGlyphSub structuredTxt
				textCenterBottom textCenterTop textCenterMiddle
				textRightBottom textRightTop textRightMiddle
				textLeftBottom textLeftTop textLeftMiddle
				begintextCenterBottom begintextCenterTop begintextCenterMiddle
				begintextRightBottom begintextRightTop begintextRightMiddle
				begintextLeftBottom begintextLeftTop begintextLeftMiddle
				textBlockLeftTop textBlockLeftMiddle textBlockLeftBottom
				textBlockRightTop textBlockRightMiddle textBlockRightBottom
				textBlockCenterTop textBlockCenterMiddle textBlockCenterBottom		);

# use Svg::Std qw( message_out );

use strict qw ( subs vars refs );

# parses for attribute [private]
# (content)
sub structuredTxt {
	my $self = shift;
	my @arguments = @_;
	for (my $i=0; $i<@arguments; $i++) {
		if ($arguments[$i] =~ /^content$/) {
			$self->svgPrint(" content=\"structured text\"");
			splice(@arguments, $i--, 1);
		}
	}
	return @arguments;
}

# draws an empty 'text' tag
sub drawTxt {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|clipPath|mask|pattern|a|switch)$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<text");
    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	if ($arguments[$i] =~ /^doStyle$/) {
		my $temp = splice(@arguments, $i--, 1);
		$self->parseStyle();
		for (my $j=0; $j<@arguments; $j++) {
			$_ = $arguments[$j];
			SWITCH: {
				/^style$/ &&
			  	  do {
					(my $attrib, my $value) = splice(@arguments, $j--, 2);
					$self->message_err("\"$attrib\" cannot be defined when \"doStyle\" is in use", $self->{LineNumber});
					last SWITCH;
				};
			}
		}
	}
    }

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
	    /^textLength$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reLength}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^lengthAdjust$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(spacing|spacingAndGlyphs)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->FillStroke(@arguments);
    @arguments = $self->FontSpecification(@arguments);
    @arguments = $self->Graphics(@arguments);
    @arguments = $self->TextContentElements(@arguments);
    @arguments = $self->TextElements(@arguments);
    @arguments = $self->XY(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint("/>");

    } else {$self->message_err("element \"text\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'text' boundary
sub beginTxt {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|clipPath|mask|pattern|a|switch)$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<text");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "text";
    # $self->{tab}+=1;
    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	if ($arguments[$i] =~ /^doStyle$/) {
		my $temp = splice(@arguments, $i--, 1);
		$self->parseStyle();
		for (my $j=0; $j<@arguments; $j++) {
			$_ = $arguments[$j];
			SWITCH: {
				/^style$/ &&
			  	  do {
					(my $attrib, my $value) = splice(@arguments, $j--, 2);
					$self->message_err("\"$attrib\" cannot be defined when \"doStyle\" is in use", $self->{LineNumber});
					last SWITCH;
				};
			}
		}
	}
    }

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
	    /^textLength$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reLength}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^lengthAdjust$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(spacing|spacingAndGlyphs)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->FillStroke(@arguments);
    @arguments = $self->FontSpecification(@arguments);
    @arguments = $self->Graphics(@arguments);
    @arguments = $self->TextContentElements(@arguments);
    @arguments = $self->TextElements(@arguments);
    @arguments = $self->XY(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    } else {
	$self->message_err("element \"text\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'text' boundary
sub endTxt {
    my $self = shift;
    $self->{LineNumber}++;
    # $self->{tab}-=1;
    # $self->newline();
    # $self->indent();
    $self->svgPrint("</text>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
}

# draws an empty 'text' tag with the text string center-aligned
# with co-ordinates set at middle of the text box
sub textCenterMiddle {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|clipPath|mask|pattern|a|switch)$/) {

    my $txtStr = shift;
    $self->newline();
    $self->indent();
    $self->svgPrint("<text");
    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	if ($arguments[$i] =~ /^doStyle$/) {
		my $temp = splice(@arguments, $i--, 1);
		$self->parseStyle();
		for (my $j=0; $j<@arguments; $j++) {
			$_ = $arguments[$j];
			SWITCH: {
				/^style$/ &&
			  	  do {
					(my $attrib, my $value) = splice(@arguments, $j--, 2);
					$self->message_err("\"$attrib\" cannot be defined when \"doStyle\" is in use", $self->{LineNumber});
					last SWITCH;
				};
			}
		}
	}
    }

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {  
	    /^xval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$value -= ($self->textWidth($self->{fontsize}, $self->{charspacing}, $self->{wordspacing}, $self->{hscaling}, $txtStr)/2);
			$self->svgPrint(" x=\"$value\"");
		    } else {$self->message_err("\"x\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^yval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$value += ($self->{fontsize}/2);
			$self->svgPrint(" y=\"$value\"");
		    } else {$self->message_err("\"y\" attribute value not valid", $self->{LineNumber})}
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
	    /^transform$/ && 
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    $self->svgPrint(" $attrib=\"$value\"");
		    last SWITCH;
		};
	    /^textLength$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reLength}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^lengthAdjust$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(spacing|spacingAndGlyphs)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->FillStroke(@arguments);
    @arguments = $self->FontSpecification(@arguments);
    @arguments = $self->Graphics(@arguments);
    @arguments = $self->TextContentElements(@arguments);
    @arguments = $self->TextElements(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">$txtStr</text>");

    } else {$self->message_err("function \"textCenterMiddle\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# draws an opening 'text' boundary with the text string center-aligned
# with co-ordinates set at middle of the text box
sub begintextCenterMiddle {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|clipPath|mask|pattern|a|switch)$/) {

    my $txtStr = shift;
    $self->newline();
    $self->indent();
    $self->svgPrint("<text");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "text";
    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	if ($arguments[$i] =~ /^doStyle$/) {
		my $temp = splice(@arguments, $i--, 1);
		$self->parseStyle();
		for (my $j=0; $j<@arguments; $j++) {
			$_ = $arguments[$j];
			SWITCH: {
				/^style$/ &&
			  	  do {
					(my $attrib, my $value) = splice(@arguments, $j--, 2);
					$self->message_err("\"$attrib\" cannot be defined when \"doStyle\" is in use", $self->{LineNumber});
					last SWITCH;
				};
			}
		}
	}
    }
    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^xval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$value -= ($self->textWidth($self->{fontsize}, $self->{charspacing}, $self->{wordspacing}, $self->{hscaling}, $txtStr)/2);
			$self->svgPrint(" x=\"$value\"");
		    } else {$self->message_err("\"x\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^yval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$value += ($self->{fontsize}/2);
			$self->svgPrint(" y=\"$value\"");
		    } else {$self->message_err("\"y\" attribute value not valid", $self->{LineNumber})}
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
	    /^transform$/ && 
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    $self->svgPrint(" $attrib=\"$value\"");
		    last SWITCH;
		};
	    /^textLength$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reLength}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^lengthAdjust$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(spacing|spacingAndGlyphs)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->FillStroke(@arguments);
    @arguments = $self->FontSpecification(@arguments);
    @arguments = $self->Graphics(@arguments);
    @arguments = $self->TextContentElements(@arguments);
    @arguments = $self->TextElements(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">$txtStr");

    } else {
	$self->message_err("function \"begintextCenterMiddle\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# draws an empty 'text' tag with the text string center-aligned
# with co-ordinates set at bottom margin of the text box
sub textCenterBottom {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|clipPath|mask|pattern|a|switch)$/) {

    my $txtStr = shift;
    $self->newline();
    $self->indent();
    $self->svgPrint("<text");
    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	if ($arguments[$i] =~ /^doStyle$/) {
		my $temp = splice(@arguments, $i--, 1);
		$self->parseStyle();
		for (my $j=0; $j<@arguments; $j++) {
			$_ = $arguments[$j];
			SWITCH: {
				/^style$/ &&
			  	  do {
					(my $attrib, my $value) = splice(@arguments, $j--, 2);
					$self->message_err("\"$attrib\" cannot be defined when \"doStyle\" is in use", $self->{LineNumber});
					last SWITCH;
				};
			}
		}
	}
    }
    
    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {  
	    /^xval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$value -= ($self->textWidth($self->{fontsize}, $self->{charspacing}, $self->{wordspacing}, $self->{hscaling}, $txtStr)/2);
			$self->svgPrint(" x=\"$value\"");
		    } else {$self->message_err("\"x\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^yval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$self->svgPrint(" y=\"$value\"");
		    } else {$self->message_err("\"y\" attribute value not valid", $self->{LineNumber})}
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
	    /^transform$/ && 
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    $self->svgPrint(" $attrib=\"$value\"");
		    last SWITCH;
		};
	    /^textLength$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reLength}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^lengthAdjust$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(spacing|spacingAndGlyphs)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->FillStroke(@arguments);
    @arguments = $self->FontSpecification(@arguments);
    @arguments = $self->Graphics(@arguments);
    @arguments = $self->TextContentElements(@arguments);
    @arguments = $self->TextElements(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">$txtStr</text>");

    } else {$self->message_err("function \"textCenterBottom\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# draws an opening 'text' boundary with the text string center-aligned
# with co-ordinates set at bottom margin of the text box
sub begintextCenterBottom {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|clipPath|mask|pattern|a|switch)$/) {

    my $txtStr = shift;
    $self->newline();
    $self->indent();
    $self->svgPrint("<text");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "text";
    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	if ($arguments[$i] =~ /^doStyle$/) {
		my $temp = splice(@arguments, $i--, 1);
		$self->parseStyle();
		for (my $j=0; $j<@arguments; $j++) {
			$_ = $arguments[$j];
			SWITCH: {
				/^style$/ &&
			  	  do {
					(my $attrib, my $value) = splice(@arguments, $j--, 2);
					$self->message_err("\"$attrib\" cannot be defined when \"doStyle\" is in use", $self->{LineNumber});
					last SWITCH;
				};
			}
		}
	}
    }
    
    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: { 
	    /^xval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$value -= ($self->textWidth($self->{fontsize}, $self->{charspacing}, $self->{wordspacing}, $self->{hscaling}, $txtStr)/2);
			$self->svgPrint(" x=\"$value\"");
		    } else {$self->message_err("\"x\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^yval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$self->svgPrint(" y=\"$value\"");
		    } else {$self->message_err("\"y\" attribute value not valid", $self->{LineNumber})}
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
	    /^transform$/ && 
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    $self->svgPrint(" $attrib=\"$value\"");
		    last SWITCH;
		};
	    /^textLength$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reLength}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^lengthAdjust$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(spacing|spacingAndGlyphs)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->FillStroke(@arguments);
    @arguments = $self->FontSpecification(@arguments);
    @arguments = $self->Graphics(@arguments);
    @arguments = $self->TextContentElements(@arguments);
    @arguments = $self->TextElements(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">$txtStr");

    } else {
	$self->message_err("function \"begintextCenterBottom\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }
    
}

# draws an empty 'text' tag with the text string center-aligned
# with co-ordinates set at top margin of the text box
sub textCenterTop {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|clipPath|mask|pattern|a|switch)$/) {

    my $txtStr = shift;
    $self->newline();
    $self->indent();
    $self->svgPrint("<text");
    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	if ($arguments[$i] =~ /^doStyle$/) {
		my $temp = splice(@arguments, $i--, 1);
		$self->parseStyle();
		for (my $j=0; $j<@arguments; $j++) {
			$_ = $arguments[$j];
			SWITCH: {
				/^style$/ &&
			  	  do {
					(my $attrib, my $value) = splice(@arguments, $j--, 2);
					$self->message_err("\"$attrib\" cannot be defined when \"doStyle\" is in use", $self->{LineNumber});
					last SWITCH;
				};
			}
		}
	}
    }

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {  
	    /^xval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$value -= ($self->textWidth($self->{fontsize}, $self->{charspacing}, $self->{wordspacing}, $self->{hscaling}, $txtStr)/2);
			$self->svgPrint(" x=\"$value\"");
		    } else {$self->message_err("\"x\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^yval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$value += $self->{fontsize};
			$self->svgPrint(" y=\"$value\"");
		    } else {$self->message_err("\"y\" attribute value not valid", $self->{LineNumber})}
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
	    /^transform$/ && 
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    $self->svgPrint(" $attrib=\"$value\"");
		    last SWITCH;
		};
	    /^textLength$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reLength}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^lengthAdjust$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(spacing|spacingAndGlyphs)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->FillStroke(@arguments);
    @arguments = $self->FontSpecification(@arguments);
    @arguments = $self->Graphics(@arguments);
    @arguments = $self->TextContentElements(@arguments);
    @arguments = $self->TextElements(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">$txtStr</text>");

    } else {$self->message_err("function \"textCenterTop\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# draws an opening 'text' boundary with the text string center-aligned
# with co-ordinates set at top margin of the text box
sub begintextCenterTop {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|clipPath|mask|pattern|a|switch)$/) {

    my $txtStr = shift;
    $self->newline();
    $self->indent();
    $self->svgPrint("<text");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "text";
    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	if ($arguments[$i] =~ /^doStyle$/) {
		my $temp = splice(@arguments, $i--, 1);
		$self->parseStyle();
		for (my $j=0; $j<@arguments; $j++) {
			$_ = $arguments[$j];
			SWITCH: {
				/^style$/ &&
			  	  do {
					(my $attrib, my $value) = splice(@arguments, $j--, 2);
					$self->message_err("\"$attrib\" cannot be defined when \"doStyle\" is in use", $self->{LineNumber});
					last SWITCH;
				};
			}
		}
	}
    }

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {  
	    /^xval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$value -= ($self->textWidth($self->{fontsize}, $self->{charspacing}, $self->{wordspacing}, $self->{hscaling}, $txtStr)/2);
			$self->svgPrint(" x=\"$value\"");
		    } else {$self->message_err("\"x\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^yval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$value += $self->{fontsize};
			$self->svgPrint(" y=\"$value\"");
		    } else {$self->message_err("\"y\" attribute value not valid", $self->{LineNumber})}
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
	    /^transform$/ && 
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    $self->svgPrint(" $attrib=\"$value\"");
		    last SWITCH;
		};
	    /^textLength$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reLength}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^lengthAdjust$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(spacing|spacingAndGlyphs)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->FillStroke(@arguments);
    @arguments = $self->FontSpecification(@arguments);
    @arguments = $self->Graphics(@arguments);
    @arguments = $self->TextContentElements(@arguments);
    @arguments = $self->TextElements(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">$txtStr");

    } else {
	$self->message_err("function \"begintextCenterTop\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# draws an empty 'text' tag with the text string right-aligned
# with co-ordinates set at middle right of the text box
sub textRightMiddle {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|clipPath|mask|pattern|a|switch)$/) {

    my $txtStr = shift;
    $self->newline();
    $self->indent();
    $self->svgPrint("<text");
    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	if ($arguments[$i] =~ /^doStyle$/) {
		my $temp = splice(@arguments, $i--, 1);
		$self->parseStyle();
		for (my $j=0; $j<@arguments; $j++) {
			$_ = $arguments[$j];
			SWITCH: {
				/^style$/ &&
			  	  do {
					(my $attrib, my $value) = splice(@arguments, $j--, 2);
					$self->message_err("\"$attrib\" cannot be defined when \"doStyle\" is in use", $self->{LineNumber});
					last SWITCH;
				};
			}
		}
	}
    }

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {  
	    /^xval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$value -= $self->textWidth($self->{fontsize}, $self->{charspacing}, $self->{wordspacing}, $self->{hscaling}, $txtStr);
			$self->svgPrint(" x=\"$value\"");
		    } else {$self->message_err("\"x\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^yval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$value += ($self->{fontsize}/2);
			$self->svgPrint(" y=\"$value\"");
		    } else {$self->message_err("\"y\" attribute value not valid", $self->{LineNumber})}
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
	    /^transform$/ && 
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    $self->svgPrint(" $attrib=\"$value\"");
		    last SWITCH;
		};
	    /^textLength$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reLength}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^lengthAdjust$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(spacing|spacingAndGlyphs)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->FillStroke(@arguments);
    @arguments = $self->FontSpecification(@arguments);
    @arguments = $self->Graphics(@arguments);
    @arguments = $self->TextContentElements(@arguments);
    @arguments = $self->TextElements(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">$txtStr</text>");

    } else {$self->message_err("function \"textRightMiddle\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# draws an opening 'text' boundary with the text string right-aligned
# with co-ordinates set at middle right of the text box
sub begintextRightMiddle {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|clipPath|mask|pattern|a|switch)$/) {

    my $txtStr = shift;
    $self->newline();
    $self->indent();
    $self->svgPrint("<text");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "text";
    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	if ($arguments[$i] =~ /^doStyle$/) {
		my $temp = splice(@arguments, $i--, 1);
		$self->parseStyle();
		for (my $j=0; $j<@arguments; $j++) {
			$_ = $arguments[$j];
			SWITCH: {
				/^style$/ &&
			  	  do {
					(my $attrib, my $value) = splice(@arguments, $j--, 2);
					$self->message_err("\"$attrib\" cannot be defined when \"doStyle\" is in use", $self->{LineNumber});
					last SWITCH;
				};
			}
		}
	}
    }

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {  
	    /^xval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$value -= $self->textWidth($self->{fontsize}, $self->{charspacing}, $self->{wordspacing}, $self->{hscaling}, $txtStr);
			$self->svgPrint(" x=\"$value\"");
		    } else {$self->message_err("\"x\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^yval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$value += ($self->{fontsize}/2);
			$self->svgPrint(" y=\"$value\"");
		    } else {$self->message_err("\"y\" attribute value not valid", $self->{LineNumber})}
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
	    /^transform$/ && 
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    $self->svgPrint(" $attrib=\"$value\"");
		    last SWITCH;
		};
	    /^textLength$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reLength}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^lengthAdjust$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(spacing|spacingAndGlyphs)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->FillStroke(@arguments);
    @arguments = $self->FontSpecification(@arguments);
    @arguments = $self->Graphics(@arguments);
    @arguments = $self->TextContentElements(@arguments);
    @arguments = $self->TextElements(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">$txtStr");

    } else {
	$self->message_err("function \"begintextRightMiddle\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# draws an empty 'text' tag with the text string right-aligned
# with co-ordinates set at bottom right hand corner of the text box
sub textRightBottom {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|clipPath|mask|pattern|a|switch)$/) {

    my $txtStr = shift;
    $self->newline();
    $self->indent();
    $self->svgPrint("<text");
    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	if ($arguments[$i] =~ /^doStyle$/) {
		my $temp = splice(@arguments, $i--, 1);
		$self->parseStyle();
		for (my $j=0; $j<@arguments; $j++) {
			$_ = $arguments[$j];
			SWITCH: {
				/^style$/ &&
			  	  do {
					(my $attrib, my $value) = splice(@arguments, $j--, 2);
					$self->message_err("\"$attrib\" cannot be defined when \"doStyle\" is in use", $self->{LineNumber});
					last SWITCH;
				};
			}
		}
	}
    }

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {  
	    /^xval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$value -= $self->textWidth($self->{fontsize}, $self->{charspacing}, $self->{wordspacing}, $self->{hscaling}, $txtStr);
			$self->svgPrint(" x=\"$value\"");
		    } else {$self->message_err("\"x\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^yval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$self->svgPrint(" y=\"$value\"");
		    } else {$self->message_err("\"y\" attribute value not valid", $self->{LineNumber})}
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
	    /^transform$/ && 
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    $self->svgPrint(" $attrib=\"$value\"");
		    last SWITCH;
		};
	    /^textLength$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reLength}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^lengthAdjust$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(spacing|spacingAndGlyphs)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->FillStroke(@arguments);
    @arguments = $self->FontSpecification(@arguments);
    @arguments = $self->Graphics(@arguments);
    @arguments = $self->TextContentElements(@arguments);
    @arguments = $self->TextElements(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">$txtStr</text>");

    } else {$self->message_err("function \"textRightBottom\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# draws an opening 'text' boundary with the text string right-aligned
# with co-ordinates set at bottom right hand corner of the text box
sub begintextRightBottom {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|clipPath|mask|pattern|a|switch)$/) {

    my $txtStr = shift;
    $self->newline();
    $self->indent();
    $self->svgPrint("<text");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "text";
    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	if ($arguments[$i] =~ /^doStyle$/) {
		my $temp = splice(@arguments, $i--, 1);
		$self->parseStyle();
		for (my $j=0; $j<@arguments; $j++) {
			$_ = $arguments[$j];
			SWITCH: {
				/^style$/ &&
			  	  do {
					(my $attrib, my $value) = splice(@arguments, $j--, 2);
					$self->message_err("\"$attrib\" cannot be defined when \"doStyle\" is in use", $self->{LineNumber});
					last SWITCH;
				};
			}
		}
	}
    }

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {  
	    /^xval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$value -= $self->textWidth($self->{fontsize}, $self->{charspacing}, $self->{wordspacing}, $self->{hscaling}, $txtStr);
			$self->svgPrint(" x=\"$value\"");
		    } else {$self->message_err("\"x\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^yval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$self->svgPrint(" y=\"$value\"");
		    } else {$self->message_err("\"y\" attribute value not valid", $self->{LineNumber})}
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
	    /^transform$/ && 
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    $self->svgPrint(" $attrib=\"$value\"");
		    last SWITCH;
		};
	    /^textLength$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reLength}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^lengthAdjust$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(spacing|spacingAndGlyphs)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->FillStroke(@arguments);
    @arguments = $self->FontSpecification(@arguments);
    @arguments = $self->Graphics(@arguments);
    @arguments = $self->TextContentElements(@arguments);
    @arguments = $self->TextElements(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">$txtStr");

    } else {
	$self->message_err("function \"begintextRightBottom\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# draws an empty 'text' tag with the text string right-aligned
# with co-ordinates set at top right hand corner of the text box
sub textRightTop {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|clipPath|mask|pattern|a|switch)$/) {

    my $txtStr = shift;
    $self->newline();
    $self->indent();
    $self->svgPrint("<text");
    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	if ($arguments[$i] =~ /^doStyle$/) {
		my $temp = splice(@arguments, $i--, 1);
		$self->parseStyle();
		for (my $j=0; $j<@arguments; $j++) {
			$_ = $arguments[$j];
			SWITCH: {
				/^style$/ &&
			  	  do {
					(my $attrib, my $value) = splice(@arguments, $j--, 2);
					$self->message_err("\"$attrib\" cannot be defined when \"doStyle\" is in use", $self->{LineNumber});
					last SWITCH;
				};
			}
		}
	}
    }

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {  
	    /^xval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$value -= $self->textWidth($self->{fontsize}, $self->{charspacing}, $self->{wordspacing}, $self->{hscaling}, $txtStr);
			$self->svgPrint(" x=\"$value\"");
		    } else {$self->message_err("\"x\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^yval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$value += $self->{fontsize};
			$self->svgPrint(" y=\"$value\"");
		    } else {$self->message_err("\"y\" attribute value not valid", $self->{LineNumber})}
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
	    /^transform$/ && 
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    $self->svgPrint(" $attrib=\"$value\"");
		    last SWITCH;
		};
	    /^textLength$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reLength}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^lengthAdjust$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(spacing|spacingAndGlyphs)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->FillStroke(@arguments);
    @arguments = $self->FontSpecification(@arguments);
    @arguments = $self->Graphics(@arguments);
    @arguments = $self->TextContentElements(@arguments);
    @arguments = $self->TextElements(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">$txtStr</text>");

    } else {$self->message_err("function \"textRightTop\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# draws an opening 'text' boundary with the text string right-aligned
# with co-ordinates set at top right hand corner of the text box
sub begintextRightTop {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|clipPath|mask|pattern|a|switch)$/) {

    my $txtStr = shift;
    $self->newline();
    $self->indent();
    $self->svgPrint("<text");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "text";
    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	if ($arguments[$i] =~ /^doStyle$/) {
		my $temp = splice(@arguments, $i--, 1);
		$self->parseStyle();
		for (my $j=0; $j<@arguments; $j++) {
			$_ = $arguments[$j];
			SWITCH: {
				/^style$/ &&
			  	  do {
					(my $attrib, my $value) = splice(@arguments, $j--, 2);
					$self->message_err("\"$attrib\" cannot be defined when \"doStyle\" is in use", $self->{LineNumber});
					last SWITCH;
				};
			}
		}
	}
    }

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {  
	    /^xval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$value -= $self->textWidth($self->{fontsize}, $self->{charspacing}, $self->{wordspacing}, $self->{hscaling}, $txtStr);
			$self->svgPrint(" x=\"$value\"");
		    } else {$self->message_err("\"x\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^yval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$value += $self->{fontsize};
			$self->svgPrint(" y=\"$value\"");
		    } else {$self->message_err("\"y\" attribute value not valid", $self->{LineNumber})}
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
	    /^transform$/ && 
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    $self->svgPrint(" $attrib=\"$value\"");
		    last SWITCH;
		};
	    /^textLength$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reLength}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^lengthAdjust$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(spacing|spacingAndGlyphs)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->FillStroke(@arguments);
    @arguments = $self->FontSpecification(@arguments);
    @arguments = $self->Graphics(@arguments);
    @arguments = $self->TextContentElements(@arguments);
    @arguments = $self->TextElements(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">$txtStr");

    } else {
	$self->message_err("function \"begintextRightTop\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# draws an empty 'text' tag with the text string left-aligned
# with co-ordinates set at middle left of the text box
sub textLeftMiddle {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|clipPath|mask|pattern|a|switch)$/) {

    my $txtStr = shift;
    $self->newline();
    $self->indent();
    $self->svgPrint("<text");
    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	if ($arguments[$i] =~ /^doStyle$/) {
		my $temp = splice(@arguments, $i--, 1);
		$self->parseStyle();
		for (my $j=0; $j<@arguments; $j++) {
			$_ = $arguments[$j];
			SWITCH: {
				/^style$/ &&
			  	  do {
					(my $attrib, my $value) = splice(@arguments, $j--, 2);
					$self->message_err("\"$attrib\" cannot be defined when \"doStyle\" is in use", $self->{LineNumber});
					last SWITCH;
				};
			}
		}
	}
    }

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {  
	    /^xval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$self->svgPrint(" x=\"$value\"");
		    } else {$self->message_err("\"x\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^yval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$value += ($self->{fontsize}/2);
			$self->svgPrint(" y=\"$value\"");
		    } else {$self->message_err("\"y\" attribute value not valid", $self->{LineNumber})}
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
	    /^transform$/ && 
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    $self->svgPrint(" $attrib=\"$value\"");
		    last SWITCH;
		};
	    /^textLength$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reLength}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^lengthAdjust$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(spacing|spacingAndGlyphs)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->FillStroke(@arguments);
    @arguments = $self->FontSpecification(@arguments);
    @arguments = $self->Graphics(@arguments);
    @arguments = $self->TextContentElements(@arguments);
    @arguments = $self->TextElements(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">$txtStr</text>");

    } else {$self->message_err("function \"textLeftMiddle\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# draws an opening 'text' boundary with the text string left-aligned
# with co-ordinates set at middle left of the text box
sub begintextLeftMiddle {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|clipPath|mask|pattern|a|switch)$/) {

    my $txtStr = shift;
    $self->newline();
    $self->indent();
    $self->svgPrint("<text");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "text";
    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	if ($arguments[$i] =~ /^doStyle$/) {
		my $temp = splice(@arguments, $i--, 1);
		$self->parseStyle();
		for (my $j=0; $j<@arguments; $j++) {
			$_ = $arguments[$j];
			SWITCH: {
				/^style$/ &&
			  	  do {
					(my $attrib, my $value) = splice(@arguments, $j--, 2);
					$self->message_err("\"$attrib\" cannot be defined when \"doStyle\" is in use", $self->{LineNumber});
					last SWITCH;
				};
			}
		}
	}
    }

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {  
	    /^xval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$self->svgPrint(" x=\"$value\"");
		    } else {$self->message_err("\"x\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^yval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$value += ($self->{fontsize}/2);
			$self->svgPrint(" y=\"$value\"");
		    } else {$self->message_err("\"y\" attribute value not valid", $self->{LineNumber})}
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
	    /^transform$/ && 
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    $self->svgPrint(" $attrib=\"$value\"");
		    last SWITCH;
		};
	    /^textLength$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reLength}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^lengthAdjust$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(spacing|spacingAndGlyphs)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->FillStroke(@arguments);
    @arguments = $self->FontSpecification(@arguments);
    @arguments = $self->Graphics(@arguments);
    @arguments = $self->TextContentElements(@arguments);
    @arguments = $self->TextElements(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">$txtStr");

    } else {
	$self->message_err("function \"begintextLeftMiddle\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# draws an empty 'text' tag with the text string left-aligned
# with co-ordinates set at bottom left hand corner of the text box
sub textLeftBottom {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|clipPath|mask|pattern|a|switch)$/) {

    my $txtStr = shift;
    $self->newline();
    $self->indent();
    $self->svgPrint("<text");
    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	if ($arguments[$i] =~ /^doStyle$/) {
		my $temp = splice(@arguments, $i--, 1);
		$self->parseStyle();
		for (my $j=0; $j<@arguments; $j++) {
			$_ = $arguments[$j];
			SWITCH: {
				/^style$/ &&
			  	  do {
					(my $attrib, my $value) = splice(@arguments, $j--, 2);
					$self->message_err("\"$attrib\" cannot be defined when \"doStyle\" is in use", $self->{LineNumber});
					last SWITCH;
				};
			}
		}
	}
    }

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {  
	    /^xval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$self->svgPrint(" x=\"$value\"");
		    } else {$self->message_err("\"x\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^yval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$self->svgPrint(" y=\"$value\"");
		    } else {$self->message_err("\"y\" attribute value not valid", $self->{LineNumber})}
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
	    /^transform$/ && 
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    $self->svgPrint(" $attrib=\"$value\"");
		    last SWITCH;
		};
	    /^textLength$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reLength}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^lengthAdjust$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(spacing|spacingAndGlyphs)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->FillStroke(@arguments);
    @arguments = $self->FontSpecification(@arguments);
    @arguments = $self->Graphics(@arguments);
    @arguments = $self->TextContentElements(@arguments);
    @arguments = $self->TextElements(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">$txtStr</text>");

    } else {$self->message_err("function \"textLeftBottom\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# draws an opening 'text' boundary with the text string left-aligned
# with co-ordinates set at bottom left hand corner of the text box
sub begintextLeftBottom {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|clipPath|mask|pattern|a|switch)$/) {

    my $txtStr = shift;
    $self->newline();
    $self->indent();
    $self->svgPrint("<text");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "text";
    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	if ($arguments[$i] =~ /^doStyle$/) {
		my $temp = splice(@arguments, $i--, 1);
		$self->parseStyle();
		for (my $j=0; $j<@arguments; $j++) {
			$_ = $arguments[$j];
			SWITCH: {
				/^style$/ &&
			  	  do {
					(my $attrib, my $value) = splice(@arguments, $j--, 2);
					$self->message_err("\"$attrib\" cannot be defined when \"doStyle\" is in use", $self->{LineNumber});
					last SWITCH;
				};
			}
		}
	}
    }

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^xval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$self->svgPrint(" x=\"$value\"");
		    } else {$self->message_err("\"x\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^yval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$self->svgPrint(" y=\"$value\"");
		    } else {$self->message_err("\"y\" attribute value not valid", $self->{LineNumber})}
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
	    /^transform$/ && 
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    $self->svgPrint(" $attrib=\"$value\"");
		    last SWITCH;
		};
	    /^textLength$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reLength}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^lengthAdjust$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(spacing|spacingAndGlyphs)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->FillStroke(@arguments);
    @arguments = $self->FontSpecification(@arguments);
    @arguments = $self->Graphics(@arguments);
    @arguments = $self->TextContentElements(@arguments);
    @arguments = $self->TextElements(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">$txtStr");

    } else {
	$self->message_err("function \"begintextLeftBottom\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# draws an empty 'text' tag with the text string left-aligned
# with co-ordinates set at top left hand corner of the text box
sub textLeftTop {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|clipPath|mask|pattern|a|switch)$/) {

    my $txtStr = shift;
    $self->newline();
    $self->indent();
    $self->svgPrint("<text");
    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	if ($arguments[$i] =~ /^doStyle$/) {
		my $temp = splice(@arguments, $i--, 1);
		$self->parseStyle();
		for (my $j=0; $j<@arguments; $j++) {
			$_ = $arguments[$j];
			SWITCH: {
				/^style$/ &&
			  	  do {
					(my $attrib, my $value) = splice(@arguments, $j--, 2);
					$self->message_err("\"$attrib\" cannot be defined when \"doStyle\" is in use", $self->{LineNumber});
					last SWITCH;
				};
			}
		}
	}
    }

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^xval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$self->svgPrint(" x=\"$value\"");
		    } else {$self->message_err("\"x\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^yval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$value += $self->{fontsize};
			$self->svgPrint(" y=\"$value\"");
		    } else {$self->message_err("\"y\" attribute value not valid", $self->{LineNumber})}
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
	    /^transform$/ && 
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    $self->svgPrint(" $attrib=\"$value\"");
		    last SWITCH;
		};
	    /^textLength$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reLength}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^lengthAdjust$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(spacing|spacingAndGlyphs)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->FillStroke(@arguments);
    @arguments = $self->FontSpecification(@arguments);
    @arguments = $self->Graphics(@arguments);
    @arguments = $self->TextContentElements(@arguments);
    @arguments = $self->TextElements(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">$txtStr</text>");

    } else {$self->message_err("function \"textLeftTop\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# draws an opening 'text' boundary with the text string left-aligned
# with co-ordinates set at top left hand corner of the text box
sub begintextLeftTop {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|clipPath|mask|pattern|a|switch)$/) {

    my $txtStr = shift;
    $self->newline();
    $self->indent();
    $self->svgPrint("<text");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "text";
    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	if ($arguments[$i] =~ /^doStyle$/) {
		my $temp = splice(@arguments, $i--, 1);
		$self->parseStyle();
		for (my $j=0; $j<@arguments; $j++) {
			$_ = $arguments[$j];
			SWITCH: {
				/^style$/ &&
			  	  do {
					(my $attrib, my $value) = splice(@arguments, $j--, 2);
					$self->message_err("\"$attrib\" cannot be defined when \"doStyle\" is in use", $self->{LineNumber});
					last SWITCH;
				};
			}
		}
	}
    }

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: { 
	    /^xval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$self->svgPrint(" x=\"$value\"");
		    } else {$self->message_err("\"x\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^yval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$value += $self->{fontsize};
			$self->svgPrint(" y=\"$value\"");
		    } else {$self->message_err("\"y\" attribute value not valid", $self->{LineNumber})}
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
	    /^transform$/ && 
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    $self->svgPrint(" $attrib=\"$value\"");
		    last SWITCH;
		};
	    /^textLength$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reLength}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^lengthAdjust$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(spacing|spacingAndGlyphs)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->FillStroke(@arguments);
    @arguments = $self->FontSpecification(@arguments);
    @arguments = $self->Graphics(@arguments);
    @arguments = $self->TextContentElements(@arguments);
    @arguments = $self->TextElements(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">$txtStr");

    } else {
	$self->message_err("function \"begintextLeftTop\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# draws a text block with the text strings left-aligned
# with co-ordinates set at top left hand corner of the text box
# USAGE: $GraphicsObj->textBlockLeftTop( x, y, leading, textStringArray );
sub textBlockLeftTop {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|clipPath|mask|pattern|a|switch)$/) {
    
    my $xoffset="empty";
    my $yoffset="empty";
    my $style="empty";
    my $doStyle="empty";
    my $leading=0;
    my @textstrs;

    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^style$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    $style=$value;
		    last SWITCH;
		};
	    /^doStyle$/ &&
		do {
		    my $value = splice(@arguments, $i--, 1);
		    $doStyle=$value;		    
		    last SWITCH;
		};
	    /^leading$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    $leading=$value;
		    last SWITCH;
		};
	    /^xval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$xoffset=$value;
		    } else {$self->message_err("\"x\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^yval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$yoffset=$value;
		    } else {$self->message_err("\"y\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    if (!($doStyle =~ /^empty$/)) {$style="empty"}
    if ($xoffset =~ /^empty$/ || $yoffset =~ /^empty$/) {
	$self->message_err("\"x\" and \"y\" attribute values required", $self->{LineNumber}, "\"textBlockLeftTop\" function ignored");
    } else {
    
    my @args;
    
    for (my $i; $i<@arguments; $i++) {
    	if ($arguments[$i] =~ /^textStrs$/) {
    		my $temp=splice(@arguments, $i--, 1);
    		last
    	} else {
    		push(@args,$arguments[$i]);
    	        my $temp=splice(@arguments, $i--, 1);
    	}    	
    }
   
    @textstrs = @arguments;

    foreach $_ (@textstrs) {
	if ($doStyle =~ /^empty$/) {
		if ($style =~/^empty$/) {
		  	$self->textLeftTop($_, "xval", $xoffset, "yval", $yoffset, @args);
		} else {
			$self->textLeftTop($_, "xval", $xoffset, "yval", $yoffset, "style", $style, @args);
		}		
	} else {
		$self->textLeftTop($_, "xval", $xoffset, "yval", $yoffset, "doStyle", @args);
	}
	$yoffset += ($leading + $self->{fontsize});
    }

    }

    } else {$self->message_err("function \"textBlockLeftTop\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# draws a text block with the text strings left-aligned
# with co-ordinates set at left hand side of the text box
# USAGE: $GraphicsObj->textBlockLeftMiddle( x, y, leading, textStringArray );
sub textBlockLeftMiddle {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|clipPath|mask|pattern|a|switch)$/) {
    
    my $xoffset="empty";
    my $yoffset="empty";
    my $style="empty";
    my $doStyle="empty";
    my $leading=0;
    my @textstrs;

    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^style$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    $style=$value;
		    last SWITCH;
		};
	    /^doStyle$/ &&
		do {
		    my $value = splice(@arguments, $i--, 1);
		    $doStyle=$value;		    
		    last SWITCH;
		};
	    /^leading$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    $leading=$value;
		    last SWITCH;
		};
	    /^xval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$xoffset=$value;
		    } else {$self->message_err("\"x\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^yval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$yoffset=$value;
		    } else {$self->message_err("\"y\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    if (!($doStyle =~ /^empty$/)) {$style="empty"}
    if ($xoffset =~ /^empty$/ || $yoffset =~ /^empty$/) {
	$self->message_err("\"x\" and \"y\" attribute values required", $self->{LineNumber}, "\"textBlockLeftMiddle\" function ignored");
    } else {
    
    my @args;
    
    for (my $i; $i<@arguments; $i++) {
    	if ($arguments[$i] =~ /^textStrs$/) {
    		my $temp=splice(@arguments, $i--, 1);
    		last
    	} else {
    		push(@args,$arguments[$i]);
    	        my $temp=splice(@arguments, $i--, 1);
    	}    	
    }
    
    @textstrs = @arguments;

    if (@textstrs>0 && @textstrs%2!=0) {$yoffset-=((@textstrs/2-(@textstrs%2/2))*($leading+$self->{fontsize}))}
    else {$yoffset-=((@textstrs/2-(@textstrs%2/2))*($leading+$self->{fontsize}/2))}

    foreach $_ (@textstrs) {
	if ($doStyle =~ /^empty$/) {
		if ($style =~/^empty$/) {
		  	$self->textLeftMiddle($_, "xval", $xoffset, "yval", $yoffset, @args);
		} else {
			$self->textLeftMiddle($_, "xval", $xoffset, "yval", $yoffset, "style", $style, @args);
		}
	} else {
	  	$self->textLeftMiddle($_, "xval", $xoffset, "yval", $yoffset, "doStyle", @args);
	}
	$yoffset += ($leading + $self->{fontsize});
    }

    }

    } else {$self->message_err("function \"textBlockLeftMiddle\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# draws a text block with the text strings left-aligned
# with co-ordinates set at bottom left hand corner of the text box
# USAGE: $GraphicsObj->textBlockLeftBottom( x, y, leading, textStringArray );
sub textBlockLeftBottom {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|clipPath|mask|pattern|a|switch)$/) {
    
    my $xoffset="empty";
    my $yoffset="empty";
    my $style="empty";
    my $doStyle="empty";
    my $leading=0;
    my @textstrs;

    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^style$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    $style=$value;
		    last SWITCH;
		};
	    /^doStyle$/ &&
		do {
		    my $value = splice(@arguments, $i--, 1);
		    $doStyle=$value;		    
		    last SWITCH;
		};
	    /^leading$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    $leading=$value;
		    last SWITCH;
		};
	    /^xval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^[+-]?[0-9]+(\.[0-9]+)?\%?$/) {
			$xoffset=$value;
		    } else {$self->message_err("\"x\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^yval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^[+-]?[0-9]+(\.[0-9]+)?\%?$/) {
			$yoffset=$value;
		    } else {$self->message_err("\"y\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    if (!($doStyle =~ /^empty$/)) {$style="empty"}
    if ($xoffset =~ /^empty$/ || $yoffset =~ /^empty$/) {
	$self->message_err("\"x\" and \"y\" attribute values required", $self->{LineNumber}, "\"textBlockLeftBottom\" function ignored");
    } else {

    my @args;
    
    for (my $i; $i<@arguments; $i++) {
    	if ($arguments[$i] =~ /^textStrs$/) {
    		my $temp=splice(@arguments, $i--, 1);
    		last
    	} else {
    		push(@args,$arguments[$i]);
    	        my $temp=splice(@arguments, $i--, 1);
    	}    	
    }
    
    @textstrs = @arguments;

    if (@textstrs>0) {$yoffset-=((@textstrs-1)*($leading+$self->{fontsize}))}

    foreach $_ (@textstrs) {
	if ($doStyle =~ /^empty$/) {
		if ($style =~/^empty$/) {
		  	$self->textLeftBottom($_, "xval", $xoffset, "yval", $yoffset, @args);
		} else {
			$self->textLeftBottom($_, "xval", $xoffset, "yval", $yoffset, "style", $style, @args);
		}
	} else {
	  	$self->textLeftBottom($_, "xval", $xoffset, "yval", $yoffset, "doStyle", @args);
	}
	$yoffset += ($leading + $self->{fontsize});
    }

    }

    } else {$self->message_err("function \"textBlockLeftBottom\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# draws a text block with the text strings right-aligned
# with co-ordinates set at top right hand corner of the text box
# USAGE: $GraphicsObj->textBlockRightTop( x, y, leading, textStringArray );
sub textBlockRightTop {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|clipPath|mask|pattern|a|switch)$/) {
    
    my $xoffset="empty";
    my $yoffset="empty";
    my $style="empty";
    my $doStyle="empty";
    my $leading=0;
    my @textstrs;

    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^style$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    $style=$value;
		    last SWITCH;
		};
	    /^doStyle$/ &&
		do {
		    my $value = splice(@arguments, $i--, 1);
		    $doStyle=$value;		    
		    last SWITCH;
		};
	    /^leading$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    $leading=$value;
		    last SWITCH;
		};
	    /^xval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^[+-]?[0-9]+(\.[0-9]+)?\%?$/) {
			$xoffset=$value;
		    } else {$self->message_err("\"x\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^yval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^[+-]?[0-9]+(\.[0-9]+)?\%?$/) {
			$yoffset=$value;
		    } else {$self->message_err("\"y\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    if (!($doStyle =~ /^empty$/)) {$style="empty"}
    if ($xoffset =~ /^empty$/ || $yoffset =~ /^empty$/) {
	$self->message_err("\"x\" and \"y\" attribute values required", $self->{LineNumber}, "\"textBlockRightTop\" function ignored");
    } else {

    my @args;
    
    for (my $i; $i<@arguments; $i++) {
    	if ($arguments[$i] =~ /^textStrs$/) {
    		my $temp=splice(@arguments, $i--, 1);
    		last
    	} else {
    		push(@args,$arguments[$i]);
    	        my $temp=splice(@arguments, $i--, 1);
    	}    	
    }

    @textstrs = @arguments;

    foreach $_ (@textstrs) {
	if ($doStyle =~ /^empty$/) {
		if ($style =~/^empty$/) {
		  	$self->textRightTop($_, "xval", $xoffset, "yval", $yoffset, @args);
		} else {
			$self->textRightTop($_, "xval", $xoffset, "yval", $yoffset, "style", $style, @args);
		}
	} else {
	  	$self->textRightTop($_, "xval", $xoffset, "yval", $yoffset, "doStyle", @args);
	}
	$yoffset += ($leading + $self->{fontsize});
    }

    }

    } else {$self->message_err("function \"textBlockRightTop\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# draws a text block with the text strings right-aligned
# with co-ordinates set at right hand side of the text box
# USAGE: $GraphicsObj->textBlockRightMiddle( x, y, leading, textStringArray );
sub textBlockRightMiddle {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|clipPath|mask|pattern|a|switch)$/) {
    
    my $xoffset="empty";
    my $yoffset="empty";
    my $style="empty";
    my $doStyle="empty";
    my $leading=0;
    my @textstrs;

    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^style$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    $style=$value;
		    last SWITCH;
		};
	    /^doStyle$/ &&
		do {
		    my $value = splice(@arguments, $i--, 1);
		    $doStyle=$value;		    
		    last SWITCH;
		};
	    /^leading$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    $leading=$value;
		    last SWITCH;
		};
	    /^xval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^[+-]?[0-9]+(\.[0-9]+)?\%?$/) {
			$xoffset=$value;
		    } else {$self->message_err("\"x\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^yval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^[+-]?[0-9]+(\.[0-9]+)?\%?$/) {
			$yoffset=$value;
		    } else {$self->message_err("\"y\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    if (!($doStyle =~ /^empty$/)) {$style="empty"}
    if ($xoffset =~ /^empty$/ || $yoffset =~ /^empty$/) {
	$self->message_err("\"x\" and \"y\" attribute values required", $self->{LineNumber}, "\"textBlockRightMiddle\" function ignored");
    } else {

    my @args;
    
    for (my $i; $i<@arguments; $i++) {
    	if ($arguments[$i] =~ /^textStrs$/) {
    		my $temp=splice(@arguments, $i--, 1);
    		last
    	} else {
    		push(@args,$arguments[$i]);
    	        my $temp=splice(@arguments, $i--, 1);
    	}    	
    }

    @textstrs = @arguments;

    if (@textstrs>0 && @textstrs%2!=0) {$yoffset-=((@textstrs/2-(@textstrs%2/2))*($leading+$self->{fontsize}))}
    else {$yoffset-=((@textstrs/2-(@textstrs%2/2))*($leading+$self->{fontsize}/2))}

    foreach $_ (@textstrs) {
	if ($doStyle =~ /^empty$/) {
		if ($style =~/^empty$/) {
		  	$self->textRightMiddle($_, "xval", $xoffset, "yval", $yoffset, @args);
		} else {
			$self->textRightMiddle($_, "xval", $xoffset, "yval", $yoffset, "style", $style, @args);
		}
	} else {
	  	$self->textRightMiddle($_, "xval", $xoffset, "yval", $yoffset, "doStyle", @args);
	}
	$yoffset += ($leading + $self->{fontsize});
    }

    }

    } else {$self->message_err("function \"textBlockRightMiddle\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# draws a text block with the text strings right-aligned
# with co-ordinates set at bottom right hand corner of the text box
# USAGE: $GraphicsObj->textBlockRightBottom( x, y, leading, textStringArray );
sub textBlockRightBottom {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|clipPath|mask|pattern|a|switch)$/) {
    
    my $xoffset="empty";
    my $yoffset="empty";    
    my $style="empty";
    my $doStyle="empty";
    my $leading=0;
    my @textstrs;

    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^style$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    $style=$value;
		    last SWITCH;
		};
	    /^doStyle$/ &&
		do {
		    my $value = splice(@arguments, $i--, 1);
		    $doStyle=$value;		    
		    last SWITCH;
		};
	    /^leading$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    $leading=$value;
		    last SWITCH;
		};
	    /^xval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^[+-]?[0-9]+(\.[0-9]+)?\%?$/) {
			$xoffset=$value;
		    } else {$self->message_err("\"x\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^yval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^[+-]?[0-9]+(\.[0-9]+)?\%?$/) {
			$yoffset=$value;
		    } else {$self->message_err("\"y\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    if (!($doStyle =~ /^empty$/)) {$style="empty"}
    if ($xoffset =~ /^empty$/ || $yoffset =~ /^empty$/) {
	$self->message_err("\"x\" and \"y\" attribute values required", $self->{LineNumber}, "\"textBlockRightBottom\" function ignored");
    } else {

    my @args;
    
    for (my $i; $i<@arguments; $i++) {
    	if ($arguments[$i] =~ /^textStrs$/) {
    		my $temp=splice(@arguments, $i--, 1);
    		last
    	} else {
    		push(@args,$arguments[$i]);
    	        my $temp=splice(@arguments, $i--, 1);
    	}    	
    }

    @textstrs = @arguments;

    if (@textstrs>0) {$yoffset-=((@textstrs-1)*($leading+$self->{fontsize}))}

    foreach $_ (@textstrs) {
	if ($doStyle =~ /^empty$/) {
		if ($style =~/^empty$/) {
		  	$self->textRightBottom($_, "xval", $xoffset, "yval", $yoffset, @args);
		} else {
			$self->textRightBottom($_, "xval", $xoffset, "yval", $yoffset, "style", $style, @args);
		}
	} else {
	  	$self->textRightBottom($_, "xval", $xoffset, "yval", $yoffset, "doStyle", @args);
	}
	$yoffset += ($leading + $self->{fontsize});
    }

    }

    } else {$self->message_err("function \"textBlockRightBottom\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# draws a text block with the text strings right-aligned
# with co-ordinates set at top margin of the text box
# USAGE: $GraphicsObj->textBlockCenterTop( x, y, leading, textStringArray );
sub textBlockCenterTop {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|clipPath|mask|pattern|a|switch)$/) {
    
    my $xoffset="empty";
    my $yoffset="empty";
    my $style="empty";
    my $doStyle="empty";
    my $leading=0;
    my @textstrs;

    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^style$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    $style=$value;
		    last SWITCH;
		};
	    /^doStyle$/ &&
		do {
		    my $value = splice(@arguments, $i--, 1);
		    $doStyle=$value;		    
		    last SWITCH;
		};
	    /^leading$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    $leading=$value;
		    last SWITCH;
		};
	    /^xval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^[+-]?[0-9]+(\.[0-9]+)?\%?$/) {
			$xoffset=$value;
		    } else {$self->message_err("\"x\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^yval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^[+-]?[0-9]+(\.[0-9]+)?\%?$/) {
			$yoffset=$value;
		    } else {$self->message_err("\"y\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    if (!($doStyle =~ /^empty$/)) {$style="empty"}
    if ($xoffset =~ /^empty$/ || $yoffset =~ /^empty$/) {
	$self->message_err("\"x\" and \"y\" attribute values required", $self->{LineNumber}, "\"textBlockCenterTop\" function ignored");
    } else {

    my @args;
    
    for (my $i; $i<@arguments; $i++) {
    	if ($arguments[$i] =~ /^textStrs$/) {
    		my $temp=splice(@arguments, $i--, 1);
    		last
    	} else {
    		push(@args,$arguments[$i]);
    	        my $temp=splice(@arguments, $i--, 1);
    	}    	
    }

    @textstrs = @arguments;

    foreach $_ (@textstrs) {
	if ($doStyle =~ /^empty$/) {
		if ($style =~/^empty$/) {
		  	$self->textCenterTop($_, "xval", $xoffset, "yval", $yoffset, @args);
		} else {
			$self->textCenterTop($_, "xval", $xoffset, "yval", $yoffset, "style", $style, @args);
		}
	} else {
	  	$self->textCenterTop($_, "xval", $xoffset, "yval", $yoffset, "doStyle", @args);
	}
	$yoffset += ($leading + $self->{fontsize});
    }

    }

    } else {$self->message_err("function \"textBlockCenterTop\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# draws a text block with the text strings right-aligned
# with co-ordinates set at middle of the text box
# USAGE: $GraphicsObj->textBlockCenterMiddle( x, y, leading, textStringArray );
sub textBlockCenterMiddle {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|clipPath|mask|pattern|a|switch)$/) {
    
    my $xoffset="empty";
    my $yoffset="empty";
    my $style="empty";
    my $doStyle="empty";
    my $leading=0;
    my @textstrs;

    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^style$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    $style=$value;
		    last SWITCH;
		};
	    /^doStyle$/ &&
		do {
		    my $value = splice(@arguments, $i--, 1);
		    $doStyle=$value;		    
		    last SWITCH;
		};
	    /^leading$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    $leading=$value;
		    last SWITCH;
		};
	    /^xval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^[+-]?[0-9]+(\.[0-9]+)?\%?$/) {
			$xoffset=$value;
		    } else {$self->message_err("\"x\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^yval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^[+-]?[0-9]+(\.[0-9]+)?\%?$/) {
			$yoffset=$value;
		    } else {$self->message_err("\"y\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    if (!($doStyle =~ /^empty$/)) {$style="empty"}
    if ($xoffset =~ /^empty$/ || $yoffset =~ /^empty$/) {
	$self->message_err("\"x\" and \"y\" attribute values required", $self->{LineNumber}, "\"textBlockCenterMiddle\" function ignored");
    } else {

    my @args;
    
    for (my $i; $i<@arguments; $i++) {
    	if ($arguments[$i] =~ /^textStrs$/) {
    		my $temp=splice(@arguments, $i--, 1);
    		last
    	} else {
    		push(@args,$arguments[$i]);
    	        my $temp=splice(@arguments, $i--, 1);
    	}    	
    }

    @textstrs = @arguments;

    if (@textstrs>0 && @textstrs%2!=0) {$yoffset-=((@textstrs/2-(@textstrs%2/2))*($leading+$self->{fontsize}))}
    else {$yoffset-=((@textstrs/2-(@textstrs%2/2))*($leading+$self->{fontsize}/2))}

    foreach $_ (@textstrs) {
	if ($doStyle =~ /^empty$/) {
		if ($style =~/^empty$/) {
		  	$self->textCenterMiddle($_, "xval", $xoffset, "yval", $yoffset, @args);
		} else {
			$self->textCenterMiddle($_, "xval", $xoffset, "yval", $yoffset, "style", $style, @args);
		}
	} else {
	  	$self->textCenterMiddle($_, "xval", $xoffset, "yval", $yoffset, "doStyle", @args);
	}
	$yoffset += ($leading + $self->{fontsize});
    }

    }

    } else {$self->message_err("function \"textBlockCenterMiddle\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# draws a text block with the text strings right-aligned
# with co-ordinates set at bottom margin of the text box
# USAGE: $GraphicsObj->textBlockCenterBottom( x, y, leading, textStringArray );
sub textBlockCenterBottom {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|clipPath|mask|pattern|a|switch)$/) {
    
    (my $xoffset, my $yoffset, my $leading, my @textstrs) = @_;

    my $xoffset="empty";
    my $yoffset="empty";
    my $style="empty";
    my $doStyle="empty";
    my $leading=0;
    my @textstrs;

    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^style$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    $style=$value;
		    last SWITCH;
		};
	    /^doStyle$/ &&
		do {
		    my $value = splice(@arguments, $i--, 1);
		    $doStyle=$value;		    
		    last SWITCH;
		};
	    /^leading$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    $leading=$value;
		    last SWITCH;
		};
	    /^xval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^[+-]?[0-9]+(\.[0-9]+)?\%?$/) {
			$xoffset=$value;
		    } else {$self->message_err("\"x\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^yval$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^[+-]?[0-9]+(\.[0-9]+)?\%?$/) {
			$yoffset=$value;
		    } else {$self->message_err("\"y\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    if (!($doStyle =~ /^empty$/)) {$style="empty"}
    if ($xoffset =~ /^empty$/ || $yoffset =~ /^empty$/) {
	$self->message_err("\"x\" and \"y\" attribute values required", $self->{LineNumber}, "\"textBlockCenterBottom\" function ignored");
    } else {

    my @args;
    
    for (my $i; $i<@arguments; $i++) {
    	if ($arguments[$i] =~ /^textStrs$/) {
    		my $temp=splice(@arguments, $i--, 1);
    		last
    	} else {
    		push(@args,$arguments[$i]);
    	        my $temp=splice(@arguments, $i--, 1);
    	}    	
    }
    
    @textstrs = @arguments;

    if (@textstrs>0) {$yoffset-=((@textstrs-1)*($leading+$self->{fontsize}))}

    foreach $_ (@textstrs) {
	if ($doStyle =~ /^empty$/) {
		if ($style =~/^empty$/) {
		  	$self->textCenterBottom($_, "xval", $xoffset, "yval", $yoffset, @args);
		} else {
			$self->textCenterBottom($_, "xval", $xoffset, "yval", $yoffset, "style", $style, @args);
		}
	} else {
	  	$self->textCenterBottom($_, "xval", $xoffset, "yval", $yoffset, "doStyle", @args);
	}
	$yoffset += ($leading + $self->{fontsize});
    }

    }

    } else {$self->message_err("function \"textBlockCenterBottom\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# draws an empty 'tspan' tag
sub drawTSpan {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(text|tspan|textPath)$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<tspan");
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
	    /^dx$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}($self->{reSpaceComma}$self->{rePercent})*$/) {
		    	$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^dy$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}($self->{reSpaceComma}$self->{rePercent})*$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^rotate$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reSpaceCommaOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^textLength$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reLength}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^lengthAdjust$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(spacing|spacingAndGlyphs)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->FillStroke(@arguments);
    @arguments = $self->FontSpecification(@arguments);
    @arguments = $self->Graphics(@arguments);
    @arguments = $self->TextContentElements(@arguments);
    @arguments = $self->XY(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");

    } else {$self->message_err("element \"tspan\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'tspan' boundary
sub beginTSpan {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(text|tspan|textPath)$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<tspan");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "tspan";
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
	    /^dx$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}($self->{reSpaceComma}$self->{rePercent})*$/) {
		    	$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^dy$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}($self->{reSpaceComma}$self->{rePercent})*$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^rotate$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reSpaceCommaOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^textLength$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reLength}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^lengthAdjust$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(spacing|spacingAndGlyphs)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->FillStroke(@arguments);
    @arguments = $self->FontSpecification(@arguments);
    @arguments = $self->Graphics(@arguments);
    @arguments = $self->TextContentElements(@arguments);
    @arguments = $self->XY(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    } else {
	$self->message_err("element \"tspan\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'tspan' boundary
sub endTSpan {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();
    $self->indent();
    $self->svgPrint("</tspan>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
}

# draws an empty 'tref' tag
sub drawTref {
    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(text|tspan|textPath)$/) {

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
	$self->message_err("\"xlink:href\" attribute and value required", $self->{LineNumber}, "\"tref\" element ignored");
    } else {

    $self->newline();
    $self->indent();
    $self->svgPrint("<tref");

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
	    /^dx$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}($self->{reSpaceComma}$self->{rePercent})*$/) {
		    	$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^dy$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}($self->{reSpaceComma}$self->{rePercent})*$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^rotate$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reSpaceCommaOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^textLength$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reLength}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^lengthAdjust$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(spacing|spacingAndGlyphs)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->FillStroke(@arguments);
    @arguments = $self->FontSpecification(@arguments);
    @arguments = $self->Graphics(@arguments);
    @arguments = $self->TextContentElements(@arguments);
    @arguments = $self->xlinkRefAttrs(@arguments);    
    @arguments = $self->XY(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");

    }

    } else {$self->message_err("element \"tref\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'tref' boundary
sub beginTref {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(text|tspan|textPath)$/) {

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
	$self->message_err("\"xlink:href\" attribute and value required", $self->{LineNumber}, "\"tref\" element ignored");
	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    } else {

    $self->newline();
    $self->indent();
    $self->svgPrint("<tref");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "tref";
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
	    /^dx$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}($self->{reSpaceComma}$self->{rePercent})*$/) {
		    	$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^dy$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}($self->{reSpaceComma}$self->{rePercent})*$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^rotate$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reSpaceCommaOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^textLength$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reLength}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^lengthAdjust$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(spacing|spacingAndGlyphs)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->FillStroke(@arguments);
    @arguments = $self->FontSpecification(@arguments);
    @arguments = $self->Graphics(@arguments);
    @arguments = $self->TextContentElements(@arguments);
    @arguments = $self->xlinkRefAttrs(@arguments);    
    @arguments = $self->XY(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    }

    } else {
	$self->message_err("element \"tref\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'tref' boundary
sub endTrefPath {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();
    $self->indent();
    $self->svgPrint("</tref>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
}

# draws an empty 'textPath' tag
sub drawTxtPath {
    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^text$/) {

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
	$self->message_err("\"xlink:href\" attribute and value required", $self->{LineNumber}, "\"textPath\" element ignored");
    } else {

    $self->newline();
    $self->indent();
    $self->svgPrint("<textPath");

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
	    /^startOffset$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^method$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(align|stretch)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^spacing$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(auto|exact)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^textLength$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reLength}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^lengthAdjust$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(spacing|spacingAndGlyphs)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->FillStroke(@arguments);
    @arguments = $self->FontSpecification(@arguments);
    @arguments = $self->Graphics(@arguments);
    @arguments = $self->TextContentElements(@arguments);
    @arguments = $self->xlinkRefAttrs(@arguments);    
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");

    }

    } else {$self->message_err("element \"textPath\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'textPath' boundary
sub beginTxtPath {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^text$/) {

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
	$self->message_err("\"xlink:href\" attribute and value required", $self->{LineNumber}, "\"textPath\" element ignored");
	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    } else {

    $self->newline();
    $self->indent();
    $self->svgPrint("<textPath");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "textPath";
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
	    /^startOffset$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^method$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(align|stretch)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^spacing$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(auto|exact)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^textLength$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reLength}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^lengthAdjust$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(spacing|spacingAndGlyphs)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->FillStroke(@arguments);
    @arguments = $self->FontSpecification(@arguments);
    @arguments = $self->Graphics(@arguments);
    @arguments = $self->TextContentElements(@arguments);
    @arguments = $self->xlinkRefAttrs(@arguments);    
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    }

    } else {
	$self->message_err("element \"textPath\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'textpath' boundary
sub endTxtPath {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();
    $self->indent();
    $self->svgPrint("</textPath>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
}

# draws an empty 'altGlyph' tag
sub drawAltGlyph {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(text|tspan|textPath)$/) {

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
	$self->message_err("\"xlink:href\" attribute and value required", $self->{LineNumber}, "\"altGlyph\" element ignored");
    } else {

    $self->newline();
    $self->indent();
    $self->svgPrint("<altGlyph");

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
	    /^dx$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}($self->{reSpaceComma}$self->{rePercent})*$/) {
		    	$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^dy$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}($self->{reSpaceComma}$self->{rePercent})*$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^rotate$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reSpaceCommaOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^glyphRef$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^format$/ &&
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
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->FillStroke(@arguments);
    @arguments = $self->FontSpecification(@arguments);
    @arguments = $self->Graphics(@arguments);
    @arguments = $self->TextContentElements(@arguments);
    @arguments = $self->xlinkRefAttrs(@arguments);    
    @arguments = $self->XY(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint("/>");

    }

    } else {$self->message_err("element \"altGlyph\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'altGlyph' boundary
sub beginAltGlyph {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(text|tspan|textPath)$/) {

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
	$self->message_err("\"xlink:href\" attribute and value required", $self->{LineNumber}, "\"altGlyph\" element ignored");
	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    } else {

    $self->newline();
    $self->indent();
    $self->svgPrint("<altGlyph");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "altGlyph";
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
	    /^dx$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}($self->{reSpaceComma}$self->{rePercent})*$/) {
		    	$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^dy$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}($self->{reSpaceComma}$self->{rePercent})*$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^rotate$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reSpaceCommaOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^glyphRef$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^format$/ &&
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
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->FillStroke(@arguments);
    @arguments = $self->FontSpecification(@arguments);
    @arguments = $self->Graphics(@arguments);
    @arguments = $self->TextContentElements(@arguments);
    @arguments = $self->xlinkRefAttrs(@arguments);    
    @arguments = $self->XY(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    }

    } else {
	$self->message_err("element \"altGlyph\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'altGlyph' boundary
sub endAltGlyph {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();
    $self->indent();
    $self->svgPrint("</altGlyph>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
}

# draws an empty 'altGlyphDef' tag
sub drawAltGlyphDef {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|mask|pattern|a)$/) {
    $self->newline();
    $self->indent();
    $self->svgPrint("<altGlyphDef");
    my @arguments = @_;

    @arguments = $self->stdAttrs(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint("/>");

    } else {$self->message_err("element \"altGlyphDef\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'altGlyphDef' boundary
sub beginAltGlyphDef {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|mask|pattern|a)$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<altGlyphDef");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "altGlyphDef";
    $self->{tab}+=1;
    my @arguments = @_;

    @arguments = $self->stdAttrs(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    } else {
	$self->message_err("element \"altGlyphDef\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'altGlyphDef' boundary
sub endAltGlyphDef {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();
    $self->indent();
    $self->svgPrint("</altGlyphDef>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
}

# draws an empty 'altGlyphItem' tag
sub drawAltGlyphItem {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^altGlyphDef$/) {
    $self->newline();
    $self->indent();
    $self->svgPrint("<altGlyphItem");
    my @arguments = @_;

    @arguments = $self->stdAttrs(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint("/>");

    } else {$self->message_err("element \"altGlyphItem\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'altGlyphItem' boundary
sub beginAltGlyphItem {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^altGlyphDef$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<altGlyphItem");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "altGlyphItem";
    $self->{tab}+=1;
    my @arguments = @_;

    @arguments = $self->stdAttrs(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    } else {
	$self->message_err("element \"altGlyphItem\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'altGlyphItem' boundary
sub endAltGlyphItem {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();
    $self->indent();
    $self->svgPrint("</altGlyphItem>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
}

# draws an empty 'glyphRef' tag
sub drawGlyphRef {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^altGlyphDef$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<glyphRef");
    my @arguments = @_;
    
    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^xlink:href$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^dx$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}($self->{reSpaceComma}$self->{rePercent})*$/) {
		    	$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^dy$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}($self->{reSpaceComma}$self->{rePercent})*$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^glyphRef$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^format$/ &&
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
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->FontSpecification(@arguments);
    @arguments = $self->xlinkRefAttrs(@arguments);    
    @arguments = $self->XY(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint("/>");

    } else {$self->message_err("element \"glyphRef\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'glyphRef' boundary
sub beginGlyphRef {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^altGlyphDef$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<glyphRef");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "glyphRef";
    $self->{tab}+=1;
    my @arguments = @_;
    
    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^xlink:href$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^dx$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}($self->{reSpaceComma}$self->{rePercent})*$/) {
		    	$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^dy$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}($self->{reSpaceComma}$self->{rePercent})*$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^glyphRef$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^format$/ &&
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
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->FontSpecification(@arguments);
    @arguments = $self->xlinkRefAttrs(@arguments);    
    @arguments = $self->XY(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    } else {
	$self->message_err("element \"glyphRef\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'glyphRef' boundary
sub endGlyphRef {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();
    $self->indent();
    $self->svgPrint("</glyphRef>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
}

1; # Perl notation to end a module
