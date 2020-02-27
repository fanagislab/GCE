package Svg::Common;		# define a new package
require 5.000;			# needs version 5, latest version 5.00402
require Exporter;

@ISA = qw(Exporter);
@EXPORT_OK = qw( 	stdAttrs langSpaceAttrs	xlinkRefAttrs
					graphicsElementEvents documentEvents 
					animationEvents testAttrs geometricAttrs 	);

use strict qw ( subs vars refs );

# parses for attributes [private]
sub stdAttrs {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@arguments; $i++) {
		if ($arguments[$i] =~ /^id$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}		    
		}
	}
	return @arguments;

}

# parses for attributes [private]
# (xml:lang, xml:space)
sub langSpaceAttrs {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@arguments; $i++) {
		if ($arguments[$i] =~ /^xml:lang$/) {
		    my $succeed = 0;
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    foreach (@{$self->{iso639}}) {
			my $pattern = $_."-";
			if ($value =~ /^$_$/) {
			    $self->svgPrint(" $attrib=\"$value\"");
			    $succeed = 1;
			    last;
			} else {
			    foreach (@{$self->{iso3166}}) {
				my $country = $pattern.$_;
				if ($value =~ /^($country)$/) {
				    $self->svgPrint(" $attrib=\"$value\"");
				    $succeed = 1;
				    last;
				}
			    }
			}
			if ($succeed) {last}
		    }
		    if (!$succeed) {$self->message_err("\"xml:lang\" attribute value not valid", $self->{LineNumber})}		    
		}
		if ($arguments[$i] =~ /^xml:space$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(default|preserve)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
	}
	return @arguments;

}
		

# parses for attributes [private]
# (requiredFeatures, requiredExtensions, systemLanguage)
sub testAttrs {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@arguments; $i++) {
	    	if ($arguments[$i] =~ /^requiredFeatures$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(org.w3c.svg.static|org.w3c.dom.svg.static|org.w3c.svg.animation|org.w3c.dom.svg.animation|org.w3c.dom.svg.dynamic|org.w3c.svg.dynamic|org.w3c.svg.all|org.w3c.dom.svg.all)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
	    	if ($arguments[$i] =~ /^requiredExtensions$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
	    	if ($arguments[$i] =~ /^systemLanguages$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" systemLanguage=\"$value\"");
		    } else {$self->message_err("\"systemLanguage\" attribute value not valid", $self->{LineNumber})}
		}
	    	if ($arguments[$i] =~ /^systemLanguage$/) {
		    my $succeed = 0;
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    foreach (@{$self->{iso639}}) {
			my $pattern = $_."-";
			if ($value =~ /^$_$/) {
			    $self->svgPrint(" $attrib=\"$value\"");
			    $succeed = 1;
			    last;
			} else {
			    foreach (@{$self->{iso3166}}) {
				my $country = $pattern.$_;
				if ($value =~ /^($country)$/) {
				    $self->svgPrint(" $attrib=\"$value\"");
				    $succeed = 1;
				    last;
				}
			    }
			}
			if ($succeed) {last}
		    }
		    if (!$succeed) {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}		    
		}

	}

	return @arguments;

}

# parses for attributes
# (xmlns:xlink, xlink:type, xlink:arcrole, xlink:role, xlink:title, xlink:show, xlink:actuate)
sub xlinkRefAttrs {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@arguments; $i++) {
		if ($arguments[$i] =~ /^xlink$/) {
		    splice(@arguments, $i--, 1);
		    $self->svgPrint(" xmlns:xlink=\"$self->{XML_Link}\"");
		}
		if ($arguments[$i] =~ /^type$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(simple|extended|locator|arc)$/) {
			$self->svgPrint(" xlink:type=\"$value\"");
		    } else {$self->message_err("\"xlink:type\" attribute value not valid", $self->{LineNumber})}		    
		}
		if ($arguments[$i] =~ /^role$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" xlink:role=\"$value\"");
		    } else {$self->message_err("\"xlink:role\" attribute value not valid", $self->{LineNumber})}
		}
		if ($arguments[$i] =~ /^title$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" xlink:title=\"$value\"");
		    } else {$self->message_err("\"xlink:title\" attribute value not valid", $self->{LineNumber})}
		}
		if ($arguments[$i] =~ /^arcrole$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" xlink:title=\"$value\"");
		    } else {$self->message_err("\"xlink:arcrole\" attribute value not valid", $self->{LineNumber})}
		}
		if ($arguments[$i] =~ /^show$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(new|replace|embed)$/) {
			$self->svgPrint(" xlink:show=\"$value\"");
		    } else {$self->message_err("\"xlink:show\" attribute value not valid", $self->{LineNumber})}
		}
		if ($arguments[$i] =~ /^actuate$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(onRequest|onLoad)$/) {
			$self->svgPrint(" xlink:actuate=\"$value\"");
		    } else {$self->message_err("\"xlink:actuate\" attribute value not valid", $self->{LineNumber})}
		}
	}

	return @arguments;

}

# parses for attributes [private]
# ( 	onfocusin, onfocusout, onactivate, onclick, onmousedown, onmouseup, 
#	onmouseover, onmousemove, onmouseout, onload	)
sub graphicsElementEvents {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@arguments; $i++) {
		if ($arguments[$i] =~ /^onfocusin$/) {
			(my $attrib, my $value) = splice(@arguments, $i--, 2);
			$self->svgPrint(" $attrib=\"$value\"");
		}
		if ($arguments[$i] =~ /^onfocusout$/) {
			(my $attrib, my $value) = splice(@arguments, $i--, 2);
			$self->svgPrint(" $attrib=\"$value\"");
		}
		if ($arguments[$i] =~ /^onactivate$/) {
			(my $attrib, my $value) = splice(@arguments, $i--, 2);
			$self->svgPrint(" $attrib=\"$value\"");
		}
		if ($arguments[$i] =~ /^onmousedown$/) {
			(my $attrib, my $value) = splice(@arguments, $i--, 2);
			$self->svgPrint(" $attrib=\"$value\"");
		}
		if ($arguments[$i] =~ /^onmouseup$/) {
			(my $attrib, my $value) = splice(@arguments, $i--, 2);
			$self->svgPrint(" $attrib=\"$value\"");
		}
		if ($arguments[$i] =~ /^onclick$/) {
			(my $attrib, my $value) = splice(@arguments, $i--, 2);
			$self->svgPrint(" $attrib=\"$value\"");
		}
		if ($arguments[$i] =~ /^onmouseover$/) {
			(my $attrib, my $value) = splice(@arguments, $i--, 2);
			$self->svgPrint(" $attrib=\"$value\"");
		}
		if ($arguments[$i] =~ /^onmousemove$/) {
			(my $attrib, my $value) = splice(@arguments, $i--, 2);
			$self->svgPrint(" $attrib=\"$value\"");
		}
		if ($arguments[$i] =~ /^onmouseout$/) {
			(my $attrib, my $value) = splice(@arguments, $i--, 2);
			$self->svgPrint(" $attrib=\"$value\"");
		}
		if ($arguments[$i] =~ /^onload$/) {
			(my $attrib, my $value) = splice(@arguments, $i--, 2);
			$self->svgPrint(" $attrib=\"$value\"");
		}
	} 

	return @arguments;

} 

# parses for attributes [private]
# ( onresize, onscroll, onunload, onzoom, onerror, onabort )
sub documentEvents {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@_; $i++) {
		if ($arguments[$i] =~ /^onresize$/) {
			(my $attrib, my $value) = splice(@arguments, $i--, 2);
			$self->svgPrint(" $attrib=\"$value\"");
		}
		if ($arguments[$i] =~ /^onscroll$/) {
			(my $attrib, my $value) = splice(@arguments, $i--, 2);
			$self->svgPrint(" $attrib=\"$value\"");
		}
		if ($arguments[$i] =~ /^onunload$/) {
			(my $attrib, my $value) = splice(@arguments, $i--, 2);
			$self->svgPrint(" $attrib=\"$value\"");
		}
		if ($arguments[$i] =~ /^onzoom$/) {
			(my $attrib, my $value) = splice(@arguments, $i--, 2);
			$self->svgPrint(" $attrib=\"$value\"");
		}
		if ($arguments[$i] =~ /^onerror$/) {
			(my $attrib, my $value) = splice(@arguments, $i--, 2);
			$self->svgPrint(" $attrib=\"$value\"");
		}
		if ($arguments[$i] =~ /^onabort$/) {
			(my $attrib, my $value) = splice(@arguments, $i--, 2);
			$self->svgPrint(" $attrib=\"$value\"");
		}
	} 

	return @arguments;

}

# parses for attributes [private]
# ( onbegin, onend, onrepeat )
sub animationEvents {

	my $self = shift;
	my @arguments = @_;

	for (my $i=0; $i<@_; $i++) {
		if ($arguments[$i] =~ /^onbegin$/) {
			(my $attrib, my $value) = splice(@arguments, $i--, 2);
			$self->svgPrint(" $attrib=\"$value\"");
		}
		if ($arguments[$i] =~ /^onend$/) {
			(my $attrib, my $value) = splice(@arguments, $i--, 2);
			$self->svgPrint(" $attrib=\"$value\"");
		}
		if ($arguments[$i] =~ /^onrepeat$/) {
			(my $attrib, my $value) = splice(@arguments, $i--, 2);
			$self->svgPrint(" $attrib=\"$value\"");
		}
	} 

	return @arguments;

}

# parses for attributes [private]
# ( xval, yval, width, height )
sub geometricAttrs {

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
	    	if ($arguments[$i] =~ /^width$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reLength}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
	    	if ($arguments[$i] =~ /^height$/) {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reLength}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		}
	}

	return @arguments;

}


1; # Perl notation to end a module