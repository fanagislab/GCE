package Svg::Path;		# define a new package
require 5.000;			# needs version 5, latest version 5.00402
require Exporter;		# standard module for making functions public

@ISA = qw(Exporter);
@EXPORT = qw( 	beginPath endPath drawPath beginRect endRect drawRect 
				beginCPath endCPath moveto lineto closepath hlineto vlineto
				curveto scurveto qcurveto tcurveto arcto
				beginCircle endCircle drawCircle beginEllipse endEllipse drawEllipse
				beginLine endLine drawLine beginPolyline endPolyline drawPolyline
				beginPolygon endPolygon drawPolygon		);

# use Svg::Std qw ( message_out );

use strict qw ( subs vars refs );

# draws a 'd' attribute 'moveto' value in a 'path' element
# can only be used within beginCPath and endCPath
# USAGE:
# 	$GraphicsObj->moveto([rel|abs], x1, y1, x2, y2, ..., xn, yn );
sub moveto {

    my $self = shift;
    my $mode = shift;

    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^cpath$/) {

    my @arguments = @_;

    if ((@arguments%2)!=0) {$self->message_err("\"moveto\" must take pairs of x and y values", $self->{LineNumber}, "\"moveto\" command ignored")}

    else {

    if ($mode =~ /^abs$/) {$self->svgPrint("M")}
    elsif ($mode =~ /^rel$/) {$self->svgPrint("m")}    
    else {$self->message_err("\"moveto\" mode must be \"rel\" or \"abs\"", $self->{LineNumber})}

    while (@arguments>0) {

    (my $xoffset, my $yoffset) = splice(@arguments, 0, 2);
    if (($mode =~ /^(rel|abs)$/) &&
	  ($xoffset =~ /^$self->{reNumber}$/) && 
	  ($yoffset =~ /^$self->{reNumber}$/)) {	
	if (@arguments>0) {$self->svgPrint("$xoffset,$yoffset,")}
	else {$self->svgPrint("$xoffset,$yoffset")}
    } else {
	$self->message_err("\"moveto\" values missing or invalid", $self->{LineNumber});
    } 

    }

    } # check number of x and y values
    
    } else {$self->message_err("\"moveto\" is only allowed in a custom \"path\" boundary", $self->{LineNumber})}

}

# draws a 'd' attribute 'lineto' value in a 'path' element
# can only be used within beginCPath and endCPath
# USAGE:
# 	$GraphicsObj->lineto([rel|abs], x1, y1, x2, y2, ..., xn, yn );
sub lineto {

    my $self = shift;
    my $mode = shift;

    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^cpath$/) {

    my @arguments = @_;

    if ((@arguments%2)!=0) {$self->message_err("\"lineto\" must take pairs of x and y values", $self->{LineNumber}, "\"lineto\" command ignored")}

    else {

    if ($mode =~ /^abs$/) {$self->svgPrint("L")}
    elsif ($mode =~ /^rel$/) {$self->svgPrint("l")}    
    else {$self->message_err("\"lineto\" mode must be \"rel\" or \"abs\"", $self->{LineNumber})}

    while (@arguments>0) {

    (my $xoffset, my $yoffset) = splice(@arguments, 0, 2);

    if (($mode =~ /^(rel|abs)$/) &&
	  ($xoffset =~ /^$self->{reNumber}$/) && 
	  ($yoffset =~ /^$self->{reNumber}$/)) {
	if (@arguments>0) {$self->svgPrint("$xoffset,$yoffset,")}
	else {$self->svgPrint("$xoffset,$yoffset")}
    } else {
	$self->message_err("\"lineto\" values missing or invalid", $self->{LineNumber});
    } 

    }

    } # check number of x and y values
    
    } else {$self->message_err("\"lineto\" is only allowed in a custom \"path\" boundary", $self->{LineNumber})}

}

# draws a 'd' attribute 'closepath' value in a 'path' element
# can only be used within beginCPath and endCPath
# USAGE:
# 	$GraphicsObj->closepath();
sub closepath {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^cpath$/) {
	$self->svgPrint("z ")
    } else {$self->message_err("\"closepath\" is only allowed in a custom \"path\" boundary", $self->{LineNumber})}

}

# draws a 'd' attribute 'horizontal lineto' value in a 'path' element
# can only be used within beginCPath and endCPath
# USAGE:
# 	$GraphicsObj->hlineto([rel|abs], x1, x2, ..., xn);
sub hlineto {

    my $self = shift;
    my $mode = shift;

    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^cpath$/) {

    my @arguments = @_;

    if ($mode =~ /^abs$/) {$self->svgPrint("H")}
    elsif ($mode =~ /^rel$/) {$self->svgPrint("h")}
    else {$self->message_err("\"hlineto\" mode must be \"rel\" or \"abs\"", $self->{LineNumber})}

    while (@arguments>0) {

    my $xoffset = splice(@arguments, 0, 1);

    if (($mode =~ /^(rel|abs)$/) &&
	  ($xoffset =~ /^$self->{reNumber}$/)) {
	if (@arguments>0) {$self->svgPrint("$xoffset,")}
	else {$self->svgPrint("$xoffset")}
    } else {
	$self->message_err("\"hlineto\" values missing or invalid", $self->{LineNumber});
    } 

    }

    } else {$self->message_err("\"hlineto\" is only allowed in a custom \"path\" boundary", $self->{LineNumber})}

}

# draws a 'd' attribute 'vertical lineto' value in a 'path' element
# can only be used within beginCPath and endCPath
# USAGE:
# 	$GraphicsObj->vlineto([rel|abs], y1, y2, ..., yn );
sub vlineto {

    my $self = shift;
    my $mode = shift;

    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^cpath$/) {

    my @arguments = @_;

    if ($mode =~ /^abs$/) {$self->svgPrint("V")}
    elsif ($mode =~ /^rel$/) {$self->svgPrint("v")}    
    else {$self->message_err("\"vlineto\" mode must be \"rel\" or \"abs\"", $self->{LineNumber})}

    while (@arguments>0) {

    my $yoffset = splice(@arguments, 0, 1);

    if (($mode =~ /^(rel|abs)$/) &&
	  ($yoffset =~ /^$self->{reNumber}$/)) {
	if (@arguments>0) {$self->svgPrint("$yoffset,")}
	else {$self->svgPrint("$yoffset")}
    } else {
	$self->message_err("\"vlineto\" values missing or invalid", $self->{LineNumber});
    } 

    }
    
    } else {$self->message_err("\"vlineto\" is only allowed in a custom \"path\" boundary", $self->{LineNumber})}

}

# draws a 'd' attribute 'curveto' value in a 'path' element
# can only be used within beginCPath and endCPath
# USAGE:
# 	$GraphicsObj->curveto([rel|abs], x1, y1, x2, y2, x, y, ..., xn, yn );
sub curveto {

    my $self = shift;
    my $mode = shift;

    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^cpath$/) {

    my @arguments = @_;

    if ((@arguments%6)!=0) {$self->message_err("\"curveto\" must take triple pairs of x and y values", $self->{LineNumber}, "\"curveto\" command ignored")}

    else {

    if ($mode =~ /^abs$/) {$self->svgPrint("C")}
    elsif ($mode =~ /^rel$/) {$self->svgPrint("c")}    
    else {$self->message_err("\"curveto\" mode must be \"rel\" or \"abs\"", $self->{LineNumber})}

    while (@arguments>0) {

    (my $xoffset1, my $yoffset1, my $xoffset2, my $yoffset2, my $xoffset3, my $yoffset3 ) = splice(@arguments, 0, 6);

    if (($mode =~ /^(rel|abs)$/) &&
	  ($xoffset1 =~ /^$self->{reNumber}$/) && 
	  ($yoffset1 =~ /^$self->{reNumber}$/) &&
	  ($xoffset2 =~ /^$self->{reNumber}$/) && 
	  ($yoffset2 =~ /^$self->{reNumber}$/) &&
	  ($xoffset3 =~ /^$self->{reNumber}$/) &&
	  ($yoffset3 =~ /^$self->{reNumber}$/) ) {
	if (@arguments>0) {$self->svgPrint("$xoffset1,$yoffset1,$xoffset2,$yoffset2,$xoffset3,$yoffset3,")}
	else {$self->svgPrint("$xoffset1,$yoffset1,$xoffset2,$yoffset2,$xoffset3,$yoffset3")}
    } else {
	$self->message_err("\"curveto\" values missing or invalid", $self->{LineNumber});
    } 

    }

    } # check number of x and y values
    
    } else {$self->message_err("\"curveto\" is only allowed in a custom \"path\" boundary", $self->{LineNumber})}

}

# draws a 'd' attribute 'smooth/shorthand curveto' value in a 'path' element
# can only be used within beginCPath and endCPath
# USAGE:
# 	$GraphicsObj->scurveto([rel|abs], x1, y1, x2, y2, ..., xn, yn );
sub scurveto {

    my $self = shift;
    my $mode = shift;

    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^cpath$/) {

    my @arguments = @_;

    if ((@arguments%4)!=0) {$self->message_err("\"scurveto\" must take double pairs of x and y values", $self->{LineNumber}, "\"scurveto\" command ignored")}

    else {

    if ($mode =~ /^abs$/) {$self->svgPrint("S")}
    elsif ($mode =~ /^rel$/) {$self->svgPrint("s")}    
    else {$self->message_err("\"scurveto\" mode must be \"rel\" or \"abs\"", $self->{LineNumber})}

    while (@arguments>0) {

    (my $xoffset1, my $yoffset1, my $xoffset2, my $yoffset2) = splice(@arguments, 0, 4);

    if (($mode =~ /^(rel|abs)$/) &&
	  ($xoffset1 =~ /^$self->{reNumber}$/) && 
	  ($yoffset1 =~ /^$self->{reNumber}$/) &&
	  ($xoffset2 =~ /^$self->{reNumber}$/) && 
	  ($yoffset2 =~ /^$self->{reNumber}$/)) {
	if (@arguments>0) {$self->svgPrint("$xoffset1,$yoffset1,$xoffset2,$yoffset2,")}
	else {$self->svgPrint("$xoffset1,$yoffset1,$xoffset2,$yoffset2")}
    } else {
	$self->message_err("\"scurveto\" values missing or invalid", $self->{LineNumber});
    } 

    }

    } # check number of x and y values
    
    } else {$self->message_err("\"scurveto\" is only allowed in a custom \"path\" boundary", $self->{LineNumber})}

}

# draws a 'd' attribute 'quadratic curveto' value in a 'path' element
# can only be used within beginCPath and endCPath
# USAGE:
# 	$GraphicsObj->qcurveto([rel|abs], x1, y1, x2, y2, ..., xn, yn );
sub qcurveto {

    my $self = shift;
    my $mode = shift;

    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^cpath$/) {

    my @arguments = @_;

    if ((@arguments%4)!=0) {$self->message_err("\"qcurveto\" must take double pairs of x and y values", $self->{LineNumber}, "\"qcurveto\" command ignored")}

    else {

    if ($mode =~ /^abs$/) {$self->svgPrint("Q")}
    elsif ($mode =~ /^rel$/) {$self->svgPrint("q")}    
    else {$self->message_err("\"qcurveto\" mode must be \"rel\" or \"abs\"", $self->{LineNumber})}

    while (@arguments>0) {

    (my $xoffset1, my $yoffset1, my $xoffset2, my $yoffset2) = splice(@arguments, 0, 4);

    if (($mode =~ /^(rel|abs)$/) &&
	  ($xoffset1 =~ /^$self->{reNumber}$/) && 
	  ($yoffset1 =~ /^$self->{reNumber}$/) &&
	  ($xoffset2 =~ /^$self->{reNumber}$/) && 
	  ($yoffset2 =~ /^$self->{reNumber}$/)) {
	if (@arguments>0) {$self->svgPrint("$xoffset1,$yoffset1,$xoffset2,$yoffset2,")}
	else {$self->svgPrint("$xoffset1,$yoffset1,$xoffset2,$yoffset2")}
    } else {
	$self->message_err("\"qcurveto\" values missing or invalid", $self->{LineNumber});
    } 

    }

    } # check number of x and y values
    
    } else {$self->message_err("\"qcurveto\" is only allowed in a custom \"path\" boundary", $self->{LineNumber})}

}

# draws a 'd' attribute 'smooth/shorthand quadratic curveto' value in a 'path' element
# can only be used within beginCPath and endCPath
# USAGE:
# 	$GraphicsObj->tcurveto([rel|abs], x1, y1, x2, y2, ..., xn, yn );
sub tcurveto {

    my $self = shift;
    my $mode = shift;

    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^cpath$/) {

    my @arguments = @_;

    if ((@arguments%2)!=0) {$self->message_err("\"tcurveto\" must take pairs of x and y values", $self->{LineNumber}, "\"tcurveto\" command ignored")}

    else {

    if ($mode =~ /^abs$/) {$self->svgPrint("T")}
    elsif ($mode =~ /^rel$/) {$self->svgPrint("t")}    
    else {$self->message_err("\"tcurveto\" mode must be \"rel\" or \"abs\"", $self->{LineNumber})}

    while (@arguments>0) {

    (my $xoffset, my $yoffset) = splice(@arguments, 0, 2);

    if (($mode =~ /^(rel|abs)$/) &&
	  ($xoffset =~ /^$self->{reNumber}$/) && 
	  ($yoffset =~ /^$self->{reNumber}$/)) {
	if (@arguments>0) {$self->svgPrint("$xoffset,$yoffset,")}
	else {$self->svgPrint("$xoffset,$yoffset")}
    } else {
	$self->message_err("\"tcurveto\" values missing or invalid", $self->{LineNumber});
    } 

    }

    } # check number of x and y values
    
    } else {$self->message_err("\"tcurveto\" is only allowed in a custom \"path\" boundary", $self->{LineNumber})}

}

# draws a 'd' attribute 'arcto' value in a 'path' element
# can only be used within beginCPath and endCPath
# USAGE:
# 	$GraphicsObj->arcto([rel|abs], rx, ry, axis-rotation, large-arc-flag, sweep-flag, x, y, ... );
sub arcto {

    my $self = shift;
    my $mode = shift;

    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^cpath$/) {

    my @arguments = @_;

    if ((@arguments%7)!=0) {$self->message_err("\"arcto\" must take double pairs of x and y values", $self->{LineNumber}, "\"arcto\" command ignored")}

    else {

    if ($mode =~ /^abs$/) {$self->svgPrint("A")}
    elsif ($mode =~ /^rel$/) {$self->svgPrint("a")}    
    else {$self->message_err("\"arcto\" mode must be \"rel\" or \"abs\"", $self->{LineNumber})}

    while (@arguments>0) {

    (my $xoffset1, my $yoffset1, my $axis_r, my $large_arc, my $sweep, my $xoffset2, my $yoffset2) = splice(@arguments, 0, 7);

    if (($mode =~ /^(rel|abs)$/) &&
	  ($xoffset1 =~ /^$self->{reNumber}$/) && 
	  ($yoffset1 =~ /^$self->{reNumber}$/) &&
	  ($axis_r =~ /^$self->{reNumber}$/) &&
	  ($large_arc =~ /^(1|0)$/) && 
	  ($sweep =~ /^(1|0)$/) &&
	  ($xoffset2 =~ /^$self->{reNumber}$/) &&
 	  ($yoffset2 =~ /^$self->{reNumber}$/) ) {
	if (@arguments>0) {$self->svgPrint("$xoffset1,$yoffset1,$axis_r,$large_arc,$sweep,$xoffset2,$yoffset2,")}
	else {$self->svgPrint("$xoffset1,$yoffset1,$axis_r,$large_arc,$sweep,$xoffset2,$yoffset2")}
    } else {
	$self->message_err("\"arcto\" values missing or invalid", $self->{LineNumber});
    } 

    }

    } # check number of x and y values
    
    } else {$self->message_err("\"arcto\" is only allowed in a custom \"path\" boundary", $self->{LineNumber})}

}

# begins a custom boundary for current point changing functions
# when the boundary is closed a single 'path' element is produced
sub beginCPath {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|text|marker|clipPath|mask|pattern|a|switch)$/) {

    my @arguments = @_;

    $self->newline();
    $self->indent();
    $self->svgPrint("<path");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "path";
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "cpath";
    $self->{tab}+=1;

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
	    /^pathLength$/ && 
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
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->FillStroke(@arguments);
    @arguments = $self->Graphics(@arguments);
    @arguments = $self->Markers(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    $self->svgPrint(" d=\"");

    # if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    # $self->svgPrint(">");

    } else {
	$self->message_err("element \"path\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, "path");
    	$self->{inBoundary} = "empty";
    }

}

# closes the custom boundary for current point changing functions
# closing it does not end a 'path' boundary, it only finishes
# the currently open custom 'path' opening tag
# to close the 'path' boundary, use the normal endPath() or e()
# N.B. to close it as an empty tag set the mode to 'boundary' otherwise
# 	 set it to 'empty' or simply leave it blank
# USAGE: $GraphicsObj->endCPath(OPTIONAL [mode]);
sub endCPath {
    my $self = shift;
    my $mode = shift;

    if ($self->{inBoundary} =~ /^cpath$/) {

    $self->{LineNumber}++;
    if ($mode =~ /^boundary$/) {
	  $self->svgPrint("\">");
	  $self->{inBoundary} = pop(@{$self->{inQueue}});
    } else {
	  $self->svgPrint("\" />");
	  $self->{tab}-=1;
  	  $self->indent();
	  $self->{inBoundary} = pop(@{$self->{inQueue}});
	  $self->{inBoundary} = pop(@{$self->{inQueue}});
    }

    } else {
	$self->message_err("\"endCPath\" is only to close a custom \"path\" element", $self->{LineNumber});
    }

}

# draws an empty 'path' tag
sub drawPath {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|text|marker|clipPath|mask|pattern|a|switch)$/) {

    my @arguments = @_;
    my $d = "empty";

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	     /^d$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$d = $value;
		    } else {$self->message_err("\"d\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    if ($d =~ /^empty$/) {
	$self->message_err("\"d\" attribute and value required", $self->{LineNumber}, \"path\" element ignored");
    } else {

    $self->newline();
    $self->indent();
    $self->svgPrint("<path");

    $self->svgPrint(" d=\"$d\"");

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
	    /^pathLength$/ && 
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
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->FillStroke(@arguments);
    @arguments = $self->Graphics(@arguments);
    @arguments = $self->Markers(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");

    }

    } else {$self->message_err("element \"path\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'path' boundary
sub beginPath {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|text|marker|clipPath|mask|pattern|a|switch)$/) {

    my @arguments = @_;
    my $d = "empty";

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	     /^d$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$d = $value;
		    } else {$self->message_err("\"d\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    if ($d =~ /^empty$/) {
	$self->message_err("\"d\" attribute and value required", $self->{LineNumber}, "\"path\" element ignored");
	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    } else {

    $self->newline();
    $self->indent();
    $self->svgPrint("<path");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "path";
    $self->{tab}+=1;

    push(@{$self->{dtdMetadata}}, $self->{Metadata});
    push(@{$self->{dtdDesc}}, $self->{Desc});
    push(@{$self->{dtdTitle}}, $self->{Title});
    $self->{Metadata} = "empty";
    $self->{Desc} = "empty";
    $self->{Title} = "empty";

    $self->svgPrint(" d=\"$d\"");

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
	    /^pathLength$/ && 
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
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->FillStroke(@arguments);
    @arguments = $self->Graphics(@arguments);
    @arguments = $self->Markers(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    }

    } else {
	$self->message_err("element \"path\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'path' boundary
sub endPath {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();
    $self->indent();
    $self->svgPrint("</path>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
    $self->{Metadata} = pop(@{$self->{dtdMetadata}});
    $self->{Desc} = pop(@{$self->{dtdDesc}});
    $self->{Title} = pop(@{$self->{dtdTitle}});
}

# draws an empty 'rect' tag
sub drawRect {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|clipPath|mask|pattern|a|switch)$/) {

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
	$self->message_err("\"width\" and \"height\" attributes and values required", $self->{LineNumber}, "\"rect\" element ignored");
    } elsif ($width =~ /^empty$/) {
	$self->message_err("\"width\" attribute and value required", $self->{LineNumber}, "\"rect\" element ignored");
    } elsif ($height =~ /^empty$/) {
	$self->message_err("\"height\" attribute and value required", $self->{LineNumber}, "\"rect\" element ignored");
    } else {

    $self->newline();
    $self->indent();
    $self->svgPrint("<rect");

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
		    $self->svgPrint(" $attrib=\"$value\"");
		    last SWITCH;
		};
	     /^rx$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reLength}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	     /^ry$/ &&
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
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->FillStroke(@arguments);
    @arguments = $self->Graphics(@arguments);
    @arguments = $self->XY(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);
    
    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");

    }

    } else {$self->message_err("element \"rect\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'rect' boundary
sub beginRect {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|clipPath|mask|pattern|a|switch)$/) {

    my @arguments = @_;
    my $width = "empty";
    my $height = "empty";

    for (my $i=0; $i<@arguments; $i++) {
	if ($arguments[$i] =~ /^width$/) {
		(my $attrib, my $value) = splice(@arguments, $i--, 2);
		if ($value =~ /^[+-]?[0-9]+(\.[0-9]+)?(em|ex|px|pt|pc|cm|mm|in|%)?$/) {
			$width = $value;
		} else {$self->message_err("\"width\" attribute value not valid", $self->{LineNumber})}
	}
	if ($arguments[$i] =~ /^height$/) {
		(my $attrib, my $value) = splice(@arguments, $i--, 2);
		if ($value =~ /^[+-]?[0-9]+(\.[0-9]+)?(em|ex|px|pt|pc|cm|mm|in|%)?$/) {
			$height = $value;
		} else {$self->message_err("\"height\" attribute value not valid", $self->{LineNumber})}
	}
    }

    if ($width =~ /^empty$/ && $height =~ /^empty$/) {
	$self->message_err("\"width\" and \"height\" attributes and values required", $self->{LineNumber}, "\"rect\" element ignored");
	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    } elsif ($width =~ /^empty$/) {
	$self->message_err("\"width\" attribute and value required", $self->{LineNumber}, "\"rect\" element ignored");
	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    } elsif ($height =~ /^empty$/) {
	$self->message_err("\"height\" attribute and value required", $self->{LineNumber}, "\"rect\" element ignored");
	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    } else {

    $self->newline();
    $self->indent();
    $self->svgPrint("<rect");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "rect";
    $self->{tab}+=1;

    push(@{$self->{dtdMetadata}}, $self->{Metadata});
    push(@{$self->{dtdDesc}}, $self->{Desc});
    push(@{$self->{dtdTitle}}, $self->{Title});
    $self->{Metadata} = "empty";
    $self->{Desc} = "empty";
    $self->{Title} = "empty";

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
		    $self->svgPrint(" $attrib=\"$value\"");
		    last SWITCH;
		};
	     /^rx$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reLength}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	     /^ry$/ &&
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
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->FillStroke(@arguments);
    @arguments = $self->Graphics(@arguments);
    @arguments = $self->XY(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    }

    } else {
	$self->message_err("element \"rect\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'rect' boundary
sub endRect {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();
    $self->indent();
    $self->svgPrint("</rect>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
    $self->{Metadata} = pop(@{$self->{dtdMetadata}});
    $self->{Desc} = pop(@{$self->{dtdDesc}});
    $self->{Title} = pop(@{$self->{dtdTitle}});
}

# draws an empty 'circle' tag
sub drawCircle {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|clipPath|mask|pattern|a|switch)$/) {

    my @arguments = @_;
    my $r = "empty";

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	     /^r$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reLength}$/) {
			$r = $value;
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    if ($r =~ /^empty$/) {
	$self->message_err("\"r\" attribute and value required", $self->{LineNumber}, "\"circle\" element ignored");
    } else {

    $self->newline();
    $self->indent();
    $self->svgPrint("<circle");

    $self->svgPrint(" r=\"$r\"");

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
	    /^cx$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$self->svgPrint(" cx=\"$value\"");
		    } else {
			$self->svgPrint(" $attrib=\"0\"");
			$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber});
		    }
		    last SWITCH;
		};
	     /^cy$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$self->svgPrint(" cy=\"$value\"");
		    } else {
			$self->svgPrint(" $attrib=\"0\"");
			$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber});
		    }
		    last SWITCH;
		};
	}
    }
    
    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->FillStroke(@arguments);
    @arguments = $self->Graphics(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");

    }

    } else {$self->message_err("element \"circle\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'circle' boundary
sub beginCircle {
    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|clipPath|mask|pattern|a|switch)$/) {

    my @arguments = @_;
    my $r = "empty";

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	     /^r$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reLength}$/) {
			$r = $value;
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    if ($r =~ /^empty$/) {
	$self->message_err("\"r\" attribute and value required", $self->{LineNumber}, "\"circle\" element ignored");
	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    } else {

    $self->newline();
    $self->indent();
    $self->svgPrint("<circle");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "circle";
    $self->{tab}+=1;

    push(@{$self->{dtdMetadata}}, $self->{Metadata});
    push(@{$self->{dtdDesc}}, $self->{Desc});
    push(@{$self->{dtdTitle}}, $self->{Title});
    $self->{Metadata} = "empty";
    $self->{Desc} = "empty";
    $self->{Title} = "empty";

    $self->svgPrint(" r=\"$r\"");

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
	    /^cx$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$self->svgPrint(" cx=\"$value\"");
		    } else {
			$self->svgPrint(" $attrib=\"0\"");
			$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber});
		    }
		    last SWITCH;
		};
	     /^cy$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$self->svgPrint(" cy=\"$value\"");
		    } else {
			$self->svgPrint(" $attrib=\"0\"");
			$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber});
		    }
		    last SWITCH;
		};
	}
    }
    
    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->FillStroke(@arguments);
    @arguments = $self->Graphics(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    }

    } else {
	$self->message_err("element \"circle\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'circle' boundary
sub endCircle {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();
    $self->indent();
    $self->svgPrint("</circle>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
    $self->{Metadata} = pop(@{$self->{dtdMetadata}});
    $self->{Desc} = pop(@{$self->{dtdDesc}});
    $self->{Title} = pop(@{$self->{dtdTitle}});
}

# draws an empty 'ellipse' tag
sub drawEllipse {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|clipPath|mask|pattern|a|switch)$/) {

    my @arguments = @_;
    my $rx = "empty";
    my $ry = "empty";

    for (my $i=0; $i<@arguments; $i++) {
	if ($arguments[$i] =~ /^rx$/) {
		(my $attrib, my $value) = splice(@arguments, $i--, 2);
		if ($value =~ /^[+-]?[0-9]+(\.[0-9]+)?$/) {
			$rx = $value;
		} else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
	}
	if ($arguments[$i] =~ /^ry$/) {
		(my $attrib, my $value) = splice(@arguments, $i--, 2);
		if ($value =~ /^[+-]?[0-9]+(\.[0-9]+)?$/) {
			$ry = $value;
		} else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
	}
    }

    if ($rx =~ /^empty$/ && $ry =~ /^empty$/) {
	$self->message_err("\"rx\" and \"ry\" attributes and values required", $self->{LineNumber}, "\"ellipse\" element ignored");
    } elsif ($rx =~ /^empty$/) {
	$self->message_err("\"rx\" attribute and value required", $self->{LineNumber}, "\"ellipse\" element ignored");
    } elsif ($ry =~ /^empty$/) {
	$self->message_err("\"ry\" attribute and value required", $self->{LineNumber}, "\"ellipse\" element ignored");
    } else {

    $self->newline();
    $self->indent();
    $self->svgPrint("<ellipse");

    $self->svgPrint(" rx=\"$rx\"");
    $self->svgPrint(" ry=\"$ry\"");

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
	    /^cx$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$self->svgPrint(" cx=\"$value\"");
		    } else {
			$self->svgPrint(" $attrib=\"0\"");
			$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber});
		    }
		    last SWITCH;
		};
	     /^cy$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$self->svgPrint(" cy=\"$value\"");
		    } else {
			$self->svgPrint(" $attrib=\"0\"");
			$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber});
		    }
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->FillStroke(@arguments);
    @arguments = $self->Graphics(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");

    }

    } else {$self->message_err("element \"ellipse\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens an 'ellipse' boundary
sub beginEllipse {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|clipPath|mask|pattern|a|switch)$/) {

    my @arguments = @_;
    my $rx = "empty";
    my $ry = "empty";

    for (my $i=0; $i<@arguments; $i++) {
	if ($arguments[$i] =~ /^rx$/) {
		(my $attrib, my $value) = splice(@arguments, $i--, 2);
		if ($value =~ /^[+-]?[0-9]+(\.[0-9]+)?$/) {
			$rx = $value;
		} else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
	}
	if ($arguments[$i] =~ /^ry$/) {
		(my $attrib, my $value) = splice(@arguments, $i--, 2);
		if ($value =~ /^[+-]?[0-9]+(\.[0-9]+)?$/) {
			$ry = $value;
		} else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
	}
    }

    if ($rx =~ /^empty$/ && $ry =~ /^empty$/) {
	$self->message_err("\"rx\" and \"ry\" attributes and values required", $self->{LineNumber}, "\"ellipse\" element ignored");
	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    } elsif ($rx =~ /^empty$/) {
	$self->message_err("\"rx\" attribute and value required", $self->{LineNumber}, "\"ellipse\" element ignored");
	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    } elsif ($ry =~ /^empty$/) {
	$self->message_err("\"ry\" attribute and value required", $self->{LineNumber}, "\"ellipse\" element ignored");
	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    } else {

    $self->newline();
    $self->indent();
    $self->svgPrint("<ellipse");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "ellipse";
    $self->{tab}+=1;

    push(@{$self->{dtdMetadata}}, $self->{Metadata});
    push(@{$self->{dtdDesc}}, $self->{Desc});
    push(@{$self->{dtdTitle}}, $self->{Title});
    $self->{Metadata} = "empty";
    $self->{Desc} = "empty";
    $self->{Title} = "empty";

    $self->svgPrint(" rx=\"$rx\"");
    $self->svgPrint(" ry=\"$ry\"");
    
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
	    /^cx$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$self->svgPrint(" cx=\"$value\"");
		    } else {
			$self->svgPrint(" $attrib=\"0\"");
			$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber});
		    }
		    last SWITCH;
		};
	     /^cy$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$self->svgPrint(" cy=\"$value\"");
		    } else {
			$self->svgPrint(" $attrib=\"0\"");
			$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber});
		    }
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->FillStroke(@arguments);
    @arguments = $self->Graphics(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    }

    } else {
	$self->message_err("element \"ellipse\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes an 'ellipse' boundary
sub endEllipse {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();
    $self->indent();
    $self->svgPrint("</ellipse>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
    $self->{Metadata} = pop(@{$self->{dtdMetadata}});
    $self->{Desc} = pop(@{$self->{dtdDesc}});
    $self->{Title} = pop(@{$self->{dtdTitle}});
}

# draws an emtpy 'line' tag
sub drawLine {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|clipPath|mask|pattern|a|switch)$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<line");
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
	     /^x1$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$self->svgPrint(" x1=\"$value\"");
		    } else {
			$self->svgPrint(" x1=\"0\"");
			$self->message_err("\"x1\" attribute value not valid", $self->{LineNumber});
		    }
		    last SWITCH;
		};
	     /^y1$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$self->svgPrint(" y1=\"$value\"");
		    } else {
			$self->svgPrint(" y1=\"0\"");
			$self->message_err("\"y1\" attribute value not valid", $self->{LineNumber});
		    }
		    last SWITCH;
		};
	     /^x2$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$self->svgPrint(" x2=\"$value\"");
		    } else {
			$self->svgPrint(" x2=\"0\"");
			$self->message_err("\"x2\" attribute value not valid", $self->{LineNumber});
		    }
		    last SWITCH;
		};
	     /^y2$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$self->svgPrint(" y2=\"$value\"");
		    } else {
			$self->svgPrint(" y2=\"0\"");
			$self->message_err("\"y2\" attribute value not valid", $self->{LineNumber});
		    }
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->FillStroke(@arguments);
    @arguments = $self->Graphics(@arguments);
    @arguments = $self->Markers(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");

    } else {$self->message_err("element \"line\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'line' boundary
sub beginLine {
    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|clipPath|mask|pattern|a|switch)$/) {

    $self->newline();
    $self->indent();
    $self->svgPrint("<line");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "line";
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
	     /^x1$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$self->svgPrint(" x1=\"$value\"");
		    } else {
			$self->svgPrint(" x1=\"0\"");
			$self->message_err("\"x1\" attribute value not valid", $self->{LineNumber});
		    }
		    last SWITCH;
		};
	     /^y1$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$self->svgPrint(" y1=\"$value\"");
		    } else {
			$self->svgPrint(" y1=\"0\"");
			$self->message_err("\"y1\" attribute value not valid", $self->{LineNumber});
		    }
		    last SWITCH;
		};
	     /^x2$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$self->svgPrint(" x2=\"$value\"");
		    } else {
			$self->svgPrint(" x2=\"0\"");
			$self->message_err("\"x2\" attribute value not valid", $self->{LineNumber});
		    }
		    last SWITCH;
		};
	     /^y2$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{rePercent}$/) {
			$self->svgPrint(" y2=\"$value\"");
		    } else {
			$self->svgPrint(" y2=\"0\"");
			$self->message_err("\"y2\" attribute value not valid", $self->{LineNumber});
		    }
		    last SWITCH;
		};
	}
    }

    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->FillStroke(@arguments);
    @arguments = $self->Graphics(@arguments);
    @arguments = $self->Markers(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    } else {
	$self->message_err("element \"line\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'line' boundary
sub endLine {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();
    $self->indent();
    $self->svgPrint("</line>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
    $self->{Metadata} = pop(@{$self->{dtdMetadata}});
    $self->{Desc} = pop(@{$self->{dtdDesc}});
    $self->{Title} = pop(@{$self->{dtdTitle}});
}

# draws an empty 'polyline' tag
sub drawPolyline {
    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|clipPath|mask|pattern|a|switch)$/) {

    my @arguments = @_;
    my $points = "empty";

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	     /^points$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reSpaceCommaOneOrMore}$/) {
			$points = $value;
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    if ($points =~ /^empty$/) {
	$self->message_err("\"points\" attribute and value required", $self->{LineNumber}, "\"polyline\" element ignored");
    } else {

    $self->newline();
    $self->indent();
    $self->svgPrint("<polyline");

    $self->svgPrint(" points=\"$points\"");

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
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->FillStroke(@arguments);
    @arguments = $self->Graphics(@arguments);
    @arguments = $self->Markers(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");

    }

    } else {$self->message_err("element \"polyline\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'polyline' boundary
sub beginPolyline {
    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|clipPath|mask|pattern|a|switch)$/) {

    my @arguments = @_;
    my $points = "empty";

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	     /^points$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reSpaceCommaOneOrMore}$/) {
			$points = $value;
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    if ($points =~ /^empty$/) {
	$self->message_err("\"points\" attribute and value required", $self->{LineNumber}, "\"polyline\" element ignored");
	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    } else {

    $self->newline();
    $self->indent();
    $self->svgPrint("<polyline");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "polyline";
    $self->{tab}+=1;

    push(@{$self->{dtdMetadata}}, $self->{Metadata});
    push(@{$self->{dtdDesc}}, $self->{Desc});
    push(@{$self->{dtdTitle}}, $self->{Title});
    $self->{Metadata} = "empty";
    $self->{Desc} = "empty";
    $self->{Title} = "empty";

    $self->svgPrint(" points=\"$points\"");

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
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->FillStroke(@arguments);
    @arguments = $self->Graphics(@arguments);
    @arguments = $self->Markers(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    }

    } else {
	$self->message_err("element \"polyline\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'polyline' boundary
sub endPolyline {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();
    $self->indent();
    $self->svgPrint("</polyline>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
    $self->{Metadata} = pop(@{$self->{dtdMetadata}});
    $self->{Desc} = pop(@{$self->{dtdDesc}});
    $self->{Title} = pop(@{$self->{dtdTitle}});
}

# draws an empty 'polygon' tag
sub drawPolygon {
    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|clipPath|mask|pattern|a|switch)$/) {

    my @arguments = @_;
    my $points = "empty";

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	     /^points$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reSpaceCommaOneOrMore}$/) {
			$points = $value;
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    if ($points =~ /^empty$/) {
	$self->message_err("\"points\" attribute and value required", $self->{LineNumber}, "\"polygon\" element ignored");
    } else {

    $self->newline();
    $self->indent();
    $self->svgPrint("<polygon");

    $self->svgPrint(" points=\"$points\"");

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
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->FillStroke(@arguments);
    @arguments = $self->Graphics(@arguments);
    @arguments = $self->Markers(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(" />");

    }

    } else {$self->message_err("element \"polygon\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber})}

}

# opens a 'polygon' boundary
sub beginPolygon {
    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})}

    if ($self->{inBoundary} =~ /^(svg|g|defs|glyph|missing-glyph|symbol|marker|clipPath|mask|pattern|a|switch)$/) {

    my @arguments = @_;
    my $points = "empty";

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	     /^points$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reSpaceCommaOneOrMore}$/) {
			$points = $value;
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    if ($points =~ /^empty$/) {
	$self->message_err("\"points\" attribute and value required", $self->{LineNumber}, "\"polygon\" element ignored");
	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    } else {

    $self->newline();
    $self->indent();
    $self->svgPrint("<polygon");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "polygon";
    $self->{tab}+=1;

    push(@{$self->{dtdMetadata}}, $self->{Metadata});
    push(@{$self->{dtdDesc}}, $self->{Desc});
    push(@{$self->{dtdTitle}}, $self->{Title});
    $self->{Metadata} = "empty";
    $self->{Desc} = "empty";
    $self->{Title} = "empty";

    $self->svgPrint(" points=\"$points\"");
    
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
    @arguments = $self->ClassStyle(@arguments);
    @arguments = $self->FillStroke(@arguments);
    @arguments = $self->Graphics(@arguments);
    @arguments = $self->Markers(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    }

    } else {
	$self->message_err("element \"polygon\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes a 'polygon' boundary
sub endPolygon {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();
    $self->indent();
    $self->svgPrint("</polygon>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
    $self->{Metadata} = pop(@{$self->{dtdMetadata}});
    $self->{Desc} = pop(@{$self->{dtdDesc}});
    $self->{Title} = pop(@{$self->{dtdTitle}});
}


1; # Perl notation to end a module
