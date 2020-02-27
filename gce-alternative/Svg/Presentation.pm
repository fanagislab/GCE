package Svg::Presentation;	# define a new package
require 5.000;				# needs version 5, latest version 5.00402
require Exporter;

@ISA = qw(Exporter);
@EXPORT_OK = qw( 	Containers feFlood	FillStroke FontSpecification 
					Gradients Graphics Images LightingEffects Markers 
					TextContentElements TextElements Viewports PttnAttrsAll	);

use strict qw ( subs vars refs );

# parses for attributes [private]
sub Containers {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@arguments; $i++) {
		if ($arguments[$i] =~ /^enable-background$/) {
	    		@arguments = $self->EnableBackgroundValue(@arguments);
		}
	}
	return @arguments;

}

# parses for attributes [private]
sub feFlood {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@arguments; $i++) {
		if ($arguments[$i] =~ /^flood-color$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}		    
		}
		if ($arguments[$i] =~ /^flood-opacity$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{re0to1}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}		    
		}
	}
	return @arguments;

}
		

# parses for attributes [private]
sub FillStroke {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@arguments; $i++) {
	    	if ($arguments[$i] =~ /^fill$/) {
	    		@arguments = $self->Paint(@arguments);
		}
	    	if ($arguments[$i] =~ /^stroke$/) {
	    		@arguments = $self->Paint(@arguments);
		}
		if ($arguments[$i] =~ /^fill-opacity$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{re0to1}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
	    	if ($arguments[$i] =~ /^fill-rule$/) {
	    		@arguments = $self->ClipFillRule(@arguments);
		}
	    	if ($arguments[$i] =~ /^stroke-dasharray$/) {
	    		@arguments = $self->StrokeDashArrayValue(@arguments);
		}
	    	if ($arguments[$i] =~ /^stroke-dashoffset$/) {
	    		@arguments = $self->StrokeDashOffsetValue(@arguments);
		}
		if ($arguments[$i] =~ /^stroke-linecap$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(butt|round|square|inherit)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
		if ($arguments[$i] =~ /^stroke-linejoin$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(miter|round|bevel|inherit)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
	    	if ($arguments[$i] =~ /^stroke-miterlimit$/) {
	    		@arguments = $self->StrokeMiterLimitValue(@arguments);
		}
		if ($arguments[$i] =~ /^stroke-opacity$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{re0to1}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
	    	if ($arguments[$i] =~ /^stroke-width$/) {
	    		@arguments = $self->StrokeWidthValue(@arguments);
		}
	}

	return @arguments;

}

# parses for attributes
sub FontSpecification {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@arguments; $i++) {
		if ($arguments[$i] =~ /^font-family$/) {
	    		@arguments = $self->FontFamilyValue(@arguments);
		}
		if ($arguments[$i] =~ /^font-size$/) {
	    		@arguments = $self->FontSizeValue(@arguments);
		}
		if ($arguments[$i] =~ /^font-size-adjust$/) {
	    		@arguments = $self->FontSizeAdjustValue(@arguments);
		}
		if ($arguments[$i] =~ /^font-stretch$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(normal|wider|narrower|ultra-condensed|extra-condensed|condensed|semi-condensed|semi-expanded|expanded|extra-expanded|ultra-expanded|inherit)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
		if ($arguments[$i] =~ /^font-style$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(normal|italic|oblique|inherit)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
		if ($arguments[$i] =~ /^font-variant$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(normal|small-caps|inherit)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
		if ($arguments[$i] =~ /^font-weight$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(normal|bold|bolder|lighter|[1-9]00|inherit)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
	}

	return @arguments;

}

# parses for attributes [private]
sub Gradients {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@arguments; $i++) {
		if ($arguments[$i] =~ /^stop-color$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
		if ($arguments[$i] =~ /^stop-opacity$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{re0to1}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
	} 

	return @arguments;

} 

# parses for attributes [private]
sub Graphics {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@_; $i++) {
	    	if ($arguments[$i] =~ /^clip-path$/) {
	    		@arguments = $self->ClipPathValue(@arguments);
		}
	    	if ($arguments[$i] =~ /^clip-rule$/) {
	    		@arguments = $self->ClipRuleValue(@arguments);
		}
		if ($arguments[$i] =~ /^color$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
		if ($arguments[$i] =~ /^color-interpolation$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(auto|sRGB|linearRGB|inherit)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
		if ($arguments[$i] =~ /^color-rendering$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(auto|optimizeSpeed|optimizeQuality|inherit)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
	    	if ($arguments[$i] =~ /^cursor$/) {
	    		@arguments = $self->CursorValue(@arguments);
		}
		if ($arguments[$i] =~ /^display$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(inline|block|list-item|run-in|compact|marker|table|inline-table|table-row-group|table-header-group|table-foote-group|table-row|table-column-group|table-column|table-cell|table-caption|none|inherit)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
	    	if ($arguments[$i] =~ /^filter$/) {
	    		@arguments = $self->FilterValue(@arguments);
		}
		if ($arguments[$i] =~ /^image-rendering$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(auto|optimizeSpeed|optimizeQuality|inherit)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
	    	if ($arguments[$i] =~ /^mask$/) {
	    		@arguments = $self->MaskValue(@arguments);
		}
		if ($arguments[$i] =~ /^opacity$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{re0to1}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
		if ($arguments[$i] =~ /^pointer-events$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(visiblePainted|visibleFill|visibleStroke|visible|painted|fill|stroke|all|none|inherit)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
		if ($arguments[$i] =~ /^shape-rendering$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(auto|optimizeSpeed|crispEdges|geometricPrecision|inherit)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
		if ($arguments[$i] =~ /^shape-rendering$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(auto|optimizeSpeed|optimizeLegibility|geometricPrecision|inherit)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
		if ($arguments[$i] =~ /^visibility$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(visible|hidden|inherit)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}

	} 

	return @arguments;

}

# parses for attributes [private]
sub Images {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@arguments; $i++) {
		if ($arguments[$i] =~ /^color-profile$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
	} 

	return @arguments;

} 

# parses for attributes [private]
sub LightingEffects {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@arguments; $i++) {
		if ($arguments[$i] =~ /^lighting-color$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
	} 

	return @arguments;

} 

# parses for attributes
sub Markers {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@arguments; $i++) {
		if ($arguments[$i] =~ /^marker-start$/) {
	    		@arguments = $self->MarkerValue(@arguments);
		}
		if ($arguments[$i] =~ /^marker-mid$/) {
	    		@arguments = $self->MarkerValue(@arguments);
		}
		if ($arguments[$i] =~ /^marker-end$/) {
	    		@arguments = $self->MarkerValue(@arguments);
		}
	} 

	return @arguments;

} 

# parses for attributes
sub TextContentElements {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@arguments; $i++) {
		if ($arguments[$i] =~ /^alignment-baseline$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(baseline|top|before-edge|text-top|text-before-edge|middle|bottom|after-edge|text-bottom|text-after-edge|ideographic|lower|hanging|mathematical|inherit)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
		if ($arguments[$i] =~ /^baseline-shift$/) {
	    		@arguments = $self->BaselineShiftValue(@arguments);
		}
		if ($arguments[$i] =~ /^direction$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(ltr|rtl|inherit)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
		if ($arguments[$i] =~ /^glyph-orientation-horizontal$/) {
	    		@arguments = $self->GlyphOrientationHorizontalValue(@arguments);
		}
		if ($arguments[$i] =~ /^glyph-orientation-vertical$/) {
	    		@arguments = $self->GlyphOrientationVerticalValue(@arguments);
		}
		if ($arguments[$i] =~ /^kerning$/) {
	    		@arguments = $self->KerningValue(@arguments);
		}
		if ($arguments[$i] =~ /^letter-spacing$/) {
	    		@arguments = $self->SpacingValue(@arguments);
		}
		if ($arguments[$i] =~ /^word-spacing$/) {
	    		@arguments = $self->SpacingValue(@arguments);
		}
		if ($arguments[$i] =~ /^text-decoration$/) {
	    		@arguments = $self->TextDecorationValue(@arguments);
		}
		if ($arguments[$i] =~ /^unicode-bidi$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(normal|embed|bidi-override|inherit)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
	} 

	return @arguments;

} 

# parses for attributes
sub TextElements {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@arguments; $i++) {
		if ($arguments[$i] =~ /^dominant-baseline$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(auto|autosense-script|no-change|reset|ideographic|lower|hanging|mathematical|inherit)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
		if ($arguments[$i] =~ /^text-anchor$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(start|middle|end|inherit)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
		if ($arguments[$i] =~ /^writing-mode$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(lr-tb|rl-tb|tb-rl|lr|rl|tb|inherit)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
	} 

	return @arguments;

} 

# parses for attributes
sub Viewports {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@arguments; $i++) {
		if ($arguments[$i] =~ /^clip$/) {
	    		@arguments = $self->ClipValue(@arguments);
		}
		if ($arguments[$i] =~ /^overflow$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(visible|hidden|scroll|auto|inherit)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
	} 

	return @arguments;

} 

# parses for attributes
sub PttnAttrsAll {

	my $self = shift;
	my @arguments = @_;

	@arguments = $self->Containers(@arguments);
	@arguments = $self->feFlood(@arguments);
	@arguments = $self->FillStroke(@arguments);
	@arguments = $self->FontSpecification(@arguments);
	@arguments = $self->Gradients(@arguments);
	@arguments = $self->Graphics(@arguments);
	@arguments = $self->Images(@arguments);
	@arguments = $self->LightingEffects(@arguments);
	@arguments = $self->Markers(@arguments);
	@arguments = $self->TextContentElements(@arguments);
	@arguments = $self->TextElements(@arguments);
	@arguments = $self->Viewports(@arguments);
	
	return @arguments;

} 


1; # Perl notation to end a module