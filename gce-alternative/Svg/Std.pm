package Svg::Std;		# define a new package
require 5.000;			# needs version 5, latest version 5.00402
require Exporter;

@ISA = qw(Exporter);
@EXPORT_OK = qw( 	message_err message_out svgPrint newline indent b e d parseStyle		);

use strict qw ( subs vars refs );

# outputs style values [private]
sub parseStyle {
	my $self = shift;
	$self->svgPrint(" style=\"font-size:$self->{fontsize};font-family:$self->{fontfamily};fill:$self->{fontcolor};\"")
}

# draws an empty tag
# USAGE: $GraphicObj->d(tagname, arguments);
sub d {

    my $self = shift;
    my $tag = shift;

    for ($tag) {
	/^svg$/ && do { $self->drawSvg(@_); last; };
	/^g$/ && do { $self->drawG(@_); last; };
	/^defs$/ && do { $self->drawDefs(@_); last; };	
	/^metadata$/ && do { $self->drawMetadata(@_); last; };
	/^desc$/ && do { $self->drawDesc(@_); last; };
	/^title$/ && do { $self->drawTitle(@_); last; };
	/^symbol$/ && do { $self->drawSymbol(@_); last; };
	/^use$/ && do { $self->drawUse(@_); last; };
	/^image$/ && do { $self->drawImage(@_); last; };
	/^switch$/ && do { $self->drawSwitch(@_); last; };
	/^style$/ && do { $self->drawStyle(@_); last; };
	/^path$/ && do { $self->drawPath(@_); last; };
	/^rect$/ && do { $self->drawRect(@_); last; };
	/^circle$/ && do { $self->drawCircle(@_); last; };
	/^ellipse$/ && do { $self->drawEllipse(@_); last; };
	/^line$/ && do { $self->drawLine(@_); last; };
	/^polyline$/ && do { $self->drawPolyline(@_); last; };
	/^polygon$/ && do { $self->drawPolygon(@_); last; };
	/^text$/ && do { $self->drawTxt(@_); last; };
	/^tspan$/ && do { $self->drawTSpan(@_); last; };
	/^tref$/ && do { $self->drawTRef(@_); last; };
	/^txtLT$/ && do { $self->textLeftTop(@_); last; };
	/^txtLM$/ && do { $self->textLeftMiddle(@_); last; };
	/^txtLB$/ && do { $self->textLeftBottom(@_); last; };
	/^txtRT$/ && do { $self->textRightTop(@_); last; };
	/^txtRM$/ && do { $self->textRightMiddle(@_); last; };
	/^txtRB$/ && do { $self->textRightBottom(@_); last; };
	/^txtCT$/ && do { $self->textCenterTop(@_); last; };
	/^txtCM$/ && do { $self->textCenterMiddle(@_); last; };
	/^txtCB$/ && do { $self->textCenterBottom(@_); last; };
	/^tbLT$/ && do { $self->textBlockLeftTop(@_); last; };
	/^tbLM$/ && do { $self->textBlockLeftMiddle(@_); last; };
	/^tbLB$/ && do { $self->textBlockLeftBottom(@_); last; };
	/^tbRT$/ && do { $self->textBlockRightTop(@_); last; };
	/^tbRM$/ && do { $self->textBlockRightMiddle(@_); last; };
	/^tbRB$/ && do { $self->textBlockRightBottom(@_); last; };
	/^tbCT$/ && do { $self->textBlockCenterTop(@_); last; };
	/^tbCM$/ && do { $self->textBlockCenterMiddle(@_); last; };
	/^tbCB$/ && do { $self->textBlockCenterBottom(@_); last; };
	/^textPath$/ && do { $self->drawTxtPath(@_); last; };
	/^altGlyph$/ && do { $self->drawAltGlyph(@_); last; };
	/^altGlyphDef$/ && do { $self->drawAltGlyphDef(@_); last; };
	/^altGlyphItem$/ && do { $self->drawAltGlyphItem(@_); last; };
	/^glyphRef$/ && do { $self->drawGlyphRef(@_); last; };
	/^marker$/ && do { $self->drawMarker(@_); last; };
	/^color-profile$/ && do { $self->drawColorProfile(@_); last; };
	/^linearGradient$/ && do { $self->drawLinGrad(@_); last; };
	/^radialGradient$/ && do { $self->drawRadGrad(@_); last; };
	/^stop$/ && do { $self->drawStop(@_); last; };
	/^pattern$/ && do { $self->drawPattern(@_); last; };
	/^clipPath$/ && do { $self->drawClipPath(@_); last; };
	/^mask$/ && do { $self->drawMask(@_); last; };
	/^filter$/ && do { $self->drawFilter(@_); last; };
	/^feDistantLight$/ && do { $self->drawDisLight(@_); last; };
	/^fePointLight$/ && do { $self->drawPntLight(@_); last; };
	/^feSpotLight$/ && do { $self->drawSptLight(@_); last; };
	/^feBlend$/ && do { $self->drawBlend(@_); last; };
	/^feColorMatrix$/ && do { $self->drawCMatrix(@_); last; };
	/^feFuncR$/ && do { $self->drawFuncR(@_); last; };
	/^feFuncG$/ && do { $self->drawFuncG(@_); last; };
	/^feFuncB$/ && do { $self->drawFuncB(@_); last; };
	/^feFuncA$/ && do { $self->drawFuncA(@_); last; };
	/^feComposite$/ && do { $self->drawComposite(@_); last; };
	/^feComponentTransfer$/ && do { $self->drawCompTrans(@_); last; };
	/^feConvolveMatrix$/ && do { $self->drawConvolveMatrix(@_); last; };
	/^feDiffuseLighting$/ && do { $self->drawDLighting(@_); last; };
	/^feDisplacementMap$/ && do { $self->drawDispMap(@_); last; };
	/^feFlood$/ && do { $self->drawFlood(@_); last; };
	/^feGaussianBlur$/ && do { $self->drawGBlur(@_); last; };
	/^feImage$/ && do { $self->drawFImage(@_); last; };
	/^feMerge$/ && do { $self->drawMerge(@_); last; };
	/^feMergeNode$/ && do { $self->drawMergeNode(@_); last; };
	/^feMorphology$/ && do { $self->drawMorphology(@_); last; };
	/^feOffset$/ && do { $self->drawOffset(@_); last; };
	/^feSpecularLighting$/ && do { $self->drawSLighting(@_); last; };
	/^feTile$/ && do { $self->drawTile(@_); last; };
	/^feTurbulence$/ && do { $self->drawTurbulence(@_); last; };
	/^a$/ && do { $self->drawA(@_); last; };
	/^view$/ && do { $self->drawView(@_); last; };
	/^script$/ && do { $self->drawScript(@_); last; };
	/^animate$/ && do { $self->drawAnim(@_); last; };
	/^set$/ && do { $self->drawSet(@_); last; };
	/^animateMotion$/ && do { $self->drawAnimMotion(@_); last; };
	/^animateColor$/ && do { $self->drawAnimColor(@_); last; };
	/^animateTransform$/ && do { $self->drawAnimTransform(@_); last; };
	/^mpath$/ && do { $self->drawMPath(@_); last; };
	/^font$/ && do { $self->drawFont(@_); last; };
	/^glyph$/ && do { $self->drawGlyph(@_); last; };
	/^missingGlyph$/ && do { $self->drawMGlyph(@_); last; };
	/^hkern$/ && do { $self->drawHKern(@_); last; };
	/^vkern$/ && do { $self->drawVKern(@_); last; };
	/^font-face$/ && do { $self->drawFontFace(@_); last; };
	/^font-face-src$/ && do { $self->drawFontFaceSrc(@_); last; };
	/^font-face-uri$/ && do { $self->drawFontFaceUri(@_); last; };
	/^font-face-format$/ && do { $self->drawFontFaceFormat(@_); last; };
	/^font-face-name$/ && do { $self->drawFontFaceName(@_); last; };
	/^definition-src$/ && do { $self->drawDefinitionSrc(@_); last; };
	/^cursor$/ && do { $self->drawCursor(@_); last; };
	/^foreignObject$/ && do { $self->drawForeignObj(@_); last; };
	/^custom$/ && 
	    do {
		my $custom = shift;
		$self->drawCustom($custom, @_);
		last;
	    };
    }
}

# opens a boundary
# USAGE: $GraphicObj->b(tagname, arguments);
sub b {

    my $self = shift;
    my $tag = shift;

    for ($tag) {	
        /^svg$/ && do { $self->beginSvg(@_); last; };
	/^g$/ && do { $self->beginG(@_); last; };
	/^defs$/ && do { $self->beginDefs(@_); last; };	
	/^metadata$/ && do { $self->beginMetadata(@_); last; };
	/^desc$/ && do { $self->beginDesc(@_); last; };
	/^title$/ && do { $self->beginTitle(@_); last; };
	/^symbol$/ && do { $self->beginSymbol(@_); last; };
	/^use$/ && do { $self->beginUse(@_); last; };
	/^image$/ && do { $self->beginImage(@_); last; };
	/^switch$/ && do { $self->beginSwitch(@_); last; };
	/^style$/ && do { $self->beginStyle(@_); last; };
	/^path$/ && do { $self->beginPath(@_); last; };
	/^cpath$/ && do { $self->beginCPath(@_); last; };
	/^rect$/ && do { $self->beginRect(@_); last; };
	/^circle$/ && do { $self->beginCircle(@_); last; };
	/^ellipse$/ && do { $self->beginEllipse(@_); last; };
	/^line$/ && do { $self->beginLine(@_); last; };
	/^polyline$/ && do { $self->beginPolyline(@_); last; };
	/^polygon$/ && do { $self->beginPolygon(@_); last; };
	/^text$/ && do { $self->beginTxt(@_); last; };
	/^tspan$/ && do { $self->beginTSpan(@_); last; };
	/^tref$/ && do { $self->beginTRef(@_); last; };
	/^txtLT$/ && do { $self->begintextLeftTop(@_); last; };
	/^txtLM$/ && do { $self->begintextLeftMiddle(@_); last; };
	/^txtLB$/ && do { $self->begintextLeftBottom(@_); last; };
	/^txtRT$/ && do { $self->begintextRightTop(@_); last; };
	/^txtRM$/ && do { $self->begintextRightMiddle(@_); last; };
	/^txtRB$/ && do { $self->begintextRightBottom(@_); last; };
	/^txtCT$/ && do { $self->begintextCenterTop(@_); last; };
	/^txtCM$/ && do { $self->begintextCenterMiddle(@_); last; };
	/^txtCB$/ && do { $self->begintextCenterBottom(@_); last; };
	/^textPath$/ && do { $self->beginTxtPath(@_); last; };
	/^altGlyph$/ && do { $self->beginAltGlyph(@_); last; };
	/^altGlyphDef$/ && do { $self->beginAltGlyphDef(@_); last; };
	/^altGlyphItem$/ && do { $self->beginAltGlyphItem(@_); last; };
	/^glyphRef$/ && do { $self->beginGlyphRef(@_); last; };
	/^marker$/ && do { $self->beginMarker(@_); last; };
	/^color-profile$/ && do { $self->beginColorProfile(@_); last; };
	/^linearGradient$/ && do { $self->beginLinGrad(@_); last; };
	/^radialGradient$/ && do { $self->beginRadGrad(@_); last; };
	/^stop$/ && do { $self->beginStop(@_); last; };
	/^pattern$/ && do { $self->beginPattern(@_); last; };
	/^clipPath$/ && do { $self->beginClipPath(@_); last; };
	/^mask$/ && do { $self->beginMask(@_); last; };
	/^filter$/ && do { $self->beginFilter(@_); last; };
	/^feDistantLight$/ && do { $self->beginDisLight(@_); last; };
	/^fePointLight$/ && do { $self->beginPntLight(@_); last; };
	/^feSpotLight$/ && do { $self->beginSptLight(@_); last; };
	/^feBlend$/ && do { $self->beginBlend(@_); last; };
	/^feColorMatrix$/ && do { $self->beginCMatrix(@_); last; };
	/^feFuncR$/ && do { $self->beginFuncR(@_); last; };
	/^feFuncG$/ && do { $self->beginFuncG(@_); last; };
	/^feFuncB$/ && do { $self->beginFuncB(@_); last; };
	/^feFuncA$/ && do { $self->beginFuncA(@_); last; };
	/^feComposite$/ && do { $self->beginComposite(@_); last; };
	/^feComponentTransfer$/ && do { $self->beginCompTrans(@_); last; };
	/^feConvolveMatrix$/ && do { $self->beginConvolveMatrix(@_); last; };
	/^feDiffuseLighting$/ && do { $self->beginDLighting(@_); last; };
	/^feDisplacementMap$/ && do { $self->beginDispMap(@_); last; };
	/^feFlood$/ && do { $self->beginFlood(@_); last; };
	/^feGaussianBlur$/ && do { $self->beginGBlur(@_); last; };
	/^feImage$/ && do { $self->beginFImage(@_); last; };
	/^feMerge$/ && do { $self->beginMerge(@_); last; };
	/^feMergeNode$/ && do { $self->beginMergeNode(@_); last; };
	/^feMorphology$/ && do { $self->beginMorphology(@_); last; };
	/^feOffset$/ && do { $self->beginOffset(@_); last; };
	/^feSpecularLighting$/ && do { $self->beginSLighting(@_); last; };
	/^feTile$/ && do { $self->beginTile(@_); last; };
	/^feTurbulence$/ && do { $self->beginTurbulence(@_); last; };
	/^a$/ && do { $self->beginA(@_); last; };
	/^view$/ && do { $self->beginView(@_); last; };
	/^script$/ && do { $self->beginScript(@_); last; };
	/^animate$/ && do { $self->beginAnim(@_); last; };
	/^animation$/ && do { $self->beginCAnim(@_); last; };
	/^set$/ && do { $self->beginSet(@_); last; };
	/^animateMotion$/ && do { $self->beginAnimMotion(@_); last; };
	/^animateColor$/ && do { $self->beginAnimColor(@_); last; };
	/^animateTransform$/ && do { $self->beginAnimTransform(@_); last; };
	/^mpath$/ && do { $self->beginMPath(@_); last; };
	/^font$/ && do { $self->beginFont(@_); last; };
	/^glyph$/ && do { $self->beginGlyph(@_); last; };
	/^missingGlyph$/ && do { $self->beginMGlyph(@_); last; };
	/^font-face$/ && do { $self->beginFontFace(@_); last; };
	/^font-face-src$/ && do { $self->beginFontFaceSrc(@_); last; };
	/^font-face-uri$/ && do { $self->beginFontFaceUri(@_); last; };
	/^font-face-format$/ && do { $self->beginFontFaceFormat(@_); last; };
	/^font-face-name$/ && do { $self->beginFontFaceName(@_); last; };
	/^definition-src$/ && do { $self->beginDefinitionSrc(@_); last; };
	/^cursor$/ && do { $self->beginCursor(@_); last; };
	/^foreignObject$/ && do { $self->beginForeignObj(@_); last; };
	/^custom$/ && 
	    do {
		my $custom = shift;
		$self->beginCustom($custom, @_);
		last;
	    };
    }

}

# closes a boundary
# USAGE: $GraphicsObj->e(OPTIONAL tagname);
sub e {

    my $self = shift;    
    # $self->{LineNumber}++;

    if (!($self->{inBoundary} =~ /^(empty|text)$/)) {

    # $self->{tab}-=1;
    # $self->newline();
    # $self->indent();

    if (@_ > 0) {
	my $tag = shift;
	if ($tag =~ /^$self->{inBoundary}$/) {
	    # $self->svgPrint("</$tag>");
	    for ($tag) {
	/^svg$/ && do { $self->endSvg(@_); last; };
	/^g$/ && do { $self->endG(@_); last; };
	/^defs$/ && do { $self->endDefs(@_); last; };	
	/^metadata$/ && do { $self->endMetadata(@_); last; };
	/^desc$/ && do { $self->endDesc(@_); last; };
	/^title$/ && do { $self->endTitle(@_); last; };
	/^symbol$/ && do { $self->endSymbol(@_); last; };
	/^use$/ && do { $self->endUse(@_); last; };
	/^image$/ && do { $self->endImage(@_); last; };
	/^switch$/ && do { $self->endSwitch(@_); last; };
	/^style$/ && do { $self->endStyle(@_); last; };
	/^path$/ && do { $self->endPath(@_); last; };
	/^cpath$/ && do { $self->endCPath(@_); last; };
	/^rect$/ && do { $self->endRect(@_); last; };
	/^circle$/ && do { $self->endCircle(@_); last; };
	/^ellipse$/ && do { $self->endEllipse(@_); last; };
	/^line$/ && do { $self->endLine(@_); last; };
	/^polyline$/ && do { $self->endPolyline(@_); last; };
	/^polygon$/ && do { $self->endPolygon(@_); last; };
	/^text$/ && do { $self->endTxt(@_); last; };
	/^tspan$/ && do { $self->endTSpan(@_); last; };
	/^tref$/ && do { $self->endTRef(@_); last; };
	/^textPath$/ && do { $self->endTxtPath(@_); last; };
	/^altGlyph$/ && do { $self->endAltGlyph(@_); last; };
	/^altGlyphDef$/ && do { $self->endAltGlyphDef(@_); last; };
	/^altGlyphItem$/ && do { $self->endAltGlyphItem(@_); last; };
	/^glyphRef$/ && do { $self->endGlyphRef(@_); last; };
	/^marker$/ && do { $self->endMarker(@_); last; };
	/^color-profile$/ && do { $self->endColorProfile(@_); last; };
	/^linearGradient$/ && do { $self->endLinGrad(@_); last; };
	/^radialGradient$/ && do { $self->endRadGrad(@_); last; };
	/^stop$/ && do { $self->endStop(@_); last; };
	/^pattern$/ && do { $self->endPattern(@_); last; };
	/^clipPath$/ && do { $self->endClipPath(@_); last; };
	/^mask$/ && do { $self->endMask(@_); last; };
	/^filter$/ && do { $self->endFilter(@_); last; };
	/^feDistantLight$/ && do { $self->endDisLight(@_); last; };
	/^fePointLight$/ && do { $self->endPntLight(@_); last; };
	/^feSpotLight$/ && do { $self->endSptLight(@_); last; };
	/^feBlend$/ && do { $self->endBlend(@_); last; };
	/^feColorMatrix$/ && do { $self->endCMatrix(@_); last; };
	/^feFuncR$/ && do { $self->endFuncR(@_); last; };
	/^feFuncG$/ && do { $self->endFuncG(@_); last; };
	/^feFuncB$/ && do { $self->endFuncB(@_); last; };
	/^feFuncA$/ && do { $self->endFuncA(@_); last; };
	/^feComposite$/ && do { $self->endComposite(@_); last; };
	/^feComponentTransfer$/ && do { $self->endCompTrans(@_); last; };
	/^feConvolveMatrix$/ && do { $self->endConvolveMatrix(@_); last; };
	/^feDiffuseLighting$/ && do { $self->endDLighting(@_); last; };
	/^feDisplacementMap$/ && do { $self->endDispMap(@_); last; };
	/^feFlood$/ && do { $self->endFlood(@_); last; };
	/^feGaussianBlur$/ && do { $self->endGBlur(@_); last; };
	/^feImage$/ && do { $self->endFImage(@_); last; };
	/^feMerge$/ && do { $self->endMerge(@_); last; };
	/^feMergeNode$/ && do { $self->endMergeNode(@_); last; };
	/^feMorphology$/ && do { $self->endMorphology(@_); last; };
	/^feOffset$/ && do { $self->endOffset(@_); last; };
	/^feSpecularLighting$/ && do { $self->endSLighting(@_); last; };
	/^feTile$/ && do { $self->endTile(@_); last; };
	/^feTurbulence$/ && do { $self->endTurbulence(@_); last; };
	/^a$/ && do { $self->endA(@_); last; };
	/^view$/ && do { $self->endView(@_); last; };
	/^script$/ && do { $self->endScript(@_); last; };
	/^animate$/ && do { $self->endAnim(@_); last; };
	/^canim$/ && do { $self->endCAnim(@_); last; };
	/^set$/ && do { $self->endSet(@_); last; };
	/^animateMotion$/ && do { $self->endAnimMotion(@_); last; };
	/^animateColor$/ && do { $self->endAnimColor(@_); last; };
	/^animateTransform$/ && do { $self->endAnimTransform(@_); last; };
	/^mpath$/ && do { $self->endMPath(@_); last; };
	/^font$/ && do { $self->endFont(@_); last; };
	/^glyph$/ && do { $self->endGlyph(@_); last; };
	/^missingGlyph$/ && do { $self->endMGlyph(@_); last; };
	/^font-face$/ && do { $self->endFontFace(@_); last; };
	/^font-face-src$/ && do { $self->endFontFaceSrc(@_); last; };
	/^font-face-uri$/ && do { $self->endFontFaceUri(@_); last; };
	/^font-face-format$/ && do { $self->endFontFaceFormat(@_); last; };
	/^font-face-name$/ && do { $self->endFontFaceName(@_); last; };
	/^definition-src$/ && do { $self->endDefinitionSrc(@_); last; };
	/^cursor$/ && do { $self->endCursor(@_); last; };
	/^foreignObject$/ && do { $self->endForeignObj(@_); last; };
	/^custom$/ && do { $self->endCustom(); last; };
	    }
        } else {
	    $self->message_err("non-matching closing tag for \"<$self->{inBoundary}>\"", $self->{LineNumber}, "\"</$self->{inBoundary}>\" assumed" );
	    # $self->svgPrint("</$self->{inBoundary}>");

	    for ($self->{inBoundary}) {
	/^svg$/ && do { $self->endSvg(@_); last; };
	/^g$/ && do { $self->endG(@_); last; };
	/^defs$/ && do { $self->endDefs(@_); last; };	
	/^metadata$/ && do { $self->endMetadata(@_); last; };
	/^desc$/ && do { $self->endDesc(@_); last; };
	/^title$/ && do { $self->endTitle(@_); last; };
	/^symbol$/ && do { $self->endSymbol(@_); last; };
	/^use$/ && do { $self->endUse(@_); last; };
	/^image$/ && do { $self->endImage(@_); last; };
	/^switch$/ && do { $self->endSwitch(@_); last; };
	/^style$/ && do { $self->endStyle(@_); last; };
	/^path$/ && do { $self->endPath(@_); last; };
	/^cpath$/ && do { $self->endCPath(@_); last; };
	/^rect$/ && do { $self->endRect(@_); last; };
	/^circle$/ && do { $self->endCircle(@_); last; };
	/^ellipse$/ && do { $self->endEllipse(@_); last; };
	/^line$/ && do { $self->endLine(@_); last; };
	/^polyline$/ && do { $self->endPolyline(@_); last; };
	/^polygon$/ && do { $self->endPolygon(@_); last; };
	/^text$/ && do { $self->endTxt(@_); last; };
	/^tspan$/ && do { $self->endTSpan(@_); last; };
	/^tref$/ && do { $self->endTRef(@_); last; };
	/^textPath$/ && do { $self->endTxtPath(@_); last; };
	/^altGlyph$/ && do { $self->endAltGlyph(@_); last; };
	/^altGlyphDef$/ && do { $self->endAltGlyphDef(@_); last; };
	/^altGlyphItem$/ && do { $self->endAltGlyphItem(@_); last; };
	/^glyphRef$/ && do { $self->endGlyphRef(@_); last; };
	/^marker$/ && do { $self->endMarker(@_); last; };
	/^color-profile$/ && do { $self->endColorProfile(@_); last; };
	/^linearGradient$/ && do { $self->endLinGrad(@_); last; };
	/^radialGradient$/ && do { $self->endRadGrad(@_); last; };
	/^stop$/ && do { $self->endStop(@_); last; };
	/^pattern$/ && do { $self->endPattern(@_); last; };
	/^clipPath$/ && do { $self->endClipPath(@_); last; };
	/^mask$/ && do { $self->endMask(@_); last; };
	/^filter$/ && do { $self->endFilter(@_); last; };
	/^feDistantLight$/ && do { $self->endDisLight(@_); last; };
	/^fePointLight$/ && do { $self->endPntLight(@_); last; };
	/^feSpotLight$/ && do { $self->endSptLight(@_); last; };
	/^feBlend$/ && do { $self->endBlend(@_); last; };
	/^feColorMatrix$/ && do { $self->endCMatrix(@_); last; };
	/^feFuncR$/ && do { $self->endFuncR(@_); last; };
	/^feFuncG$/ && do { $self->endFuncG(@_); last; };
	/^feFuncB$/ && do { $self->endFuncB(@_); last; };
	/^feFuncA$/ && do { $self->endFuncA(@_); last; };
	/^feComposite$/ && do { $self->endComposite(@_); last; };
	/^feComponentTransfer$/ && do { $self->endCompTrans(@_); last; };
	/^feConvolveMatrix$/ && do { $self->endConvolveMatrix(@_); last; };
	/^feDiffuseLighting$/ && do { $self->endDLighting(@_); last; };
	/^feDisplacementMap$/ && do { $self->endDispMap(@_); last; };
	/^feFlood$/ && do { $self->endFlood(@_); last; };
	/^feGaussianBlur$/ && do { $self->endGBlur(@_); last; };
	/^feImage$/ && do { $self->endFImage(@_); last; };
	/^feMerge$/ && do { $self->endMerge(@_); last; };
	/^feMergeNode$/ && do { $self->endMergeNode(@_); last; };
	/^feMorphology$/ && do { $self->endMorphology(@_); last; };
	/^feOffset$/ && do { $self->endOffset(@_); last; };
	/^feSpecularLighting$/ && do { $self->endSLighting(@_); last; };
	/^feTile$/ && do { $self->endTile(@_); last; };
	/^feTurbulence$/ && do { $self->endTurbulence(@_); last; };
	/^a$/ && do { $self->endA(@_); last; };
	/^view$/ && do { $self->endView(@_); last; };
	/^script$/ && do { $self->endScript(@_); last; };
	/^animate$/ && do { $self->endAnim(@_); last; };
	/^canim$/ && do { $self->endCAnim(@_); last; };
	/^set$/ && do { $self->endSet(@_); last; };
	/^animateMotion$/ && do { $self->endAnimMotion(@_); last; };
	/^animateColor$/ && do { $self->endAnimColor(@_); last; };
	/^animateTransform$/ && do { $self->endAnimTransform(@_); last; };
	/^mpath$/ && do { $self->endMPath(@_); last; };
	/^font$/ && do { $self->endFont(@_); last; };
	/^glyph$/ && do { $self->endGlyph(@_); last; };
	/^missingGlyph$/ && do { $self->endMGlyph(@_); last; };
	/^font-face$/ && do { $self->endFontFace(@_); last; };
	/^font-face-src$/ && do { $self->endFontFaceSrc(@_); last; };
	/^font-face-uri$/ && do { $self->endFontFaceUri(@_); last; };
	/^font-face-format$/ && do { $self->endFontFaceFormat(@_); last; };
	/^font-face-name$/ && do { $self->endFontFaceName(@_); last; };
	/^definition-src$/ && do { $self->endDefinitionSrc(@_); last; };
	/^cursor$/ && do { $self->endCursor(@_); last; };
	/^foreignObject$/ && do { $self->endForeignObj(@_); last; };
	/^custom$/ && do { $self->endCustom(); last; };
	    }

	}
    } else {
	# $self->svgPrint("</$self->{inBoundary}>");

	    for ($self->{inBoundary}) {
	/^svg$/ && do { $self->endSvg(@_); last; };
	/^g$/ && do { $self->endG(@_); last; };
	/^defs$/ && do { $self->endDefs(@_); last; };	
	/^metadata$/ && do { $self->endMetadata(@_); last; };
	/^desc$/ && do { $self->endDesc(@_); last; };
	/^title$/ && do { $self->endTitle(@_); last; };
	/^symbol$/ && do { $self->endSymbol(@_); last; };
	/^use$/ && do { $self->endUse(@_); last; };
	/^image$/ && do { $self->endImage(@_); last; };
	/^switch$/ && do { $self->endSwitch(@_); last; };
	/^style$/ && do { $self->endStyle(@_); last; };
	/^path$/ && do { $self->endPath(@_); last; };
	/^cpath$/ && do { $self->endCPath(@_); last; };
	/^rect$/ && do { $self->endRect(@_); last; };
	/^circle$/ && do { $self->endCircle(@_); last; };
	/^ellipse$/ && do { $self->endEllipse(@_); last; };
	/^line$/ && do { $self->endLine(@_); last; };
	/^polyline$/ && do { $self->endPolyline(@_); last; };
	/^polygon$/ && do { $self->endPolygon(@_); last; };
	/^text$/ && do { $self->endTxt(@_); last; };
	/^tspan$/ && do { $self->endTSpan(@_); last; };
	/^tref$/ && do { $self->endTRef(@_); last; };
	/^textPath$/ && do { $self->endTxtPath(@_); last; };
	/^altGlyph$/ && do { $self->endAltGlyph(@_); last; };
	/^altGlyphDef$/ && do { $self->endAltGlyphDef(@_); last; };
	/^altGlyphItem$/ && do { $self->endAltGlyphItem(@_); last; };
	/^glyphRef$/ && do { $self->endGlyphRef(@_); last; };
	/^marker$/ && do { $self->endMarker(@_); last; };
	/^color-profile$/ && do { $self->endColorProfile(@_); last; };
	/^linearGradient$/ && do { $self->endLinGrad(@_); last; };
	/^radialGradient$/ && do { $self->endRadGrad(@_); last; };
	/^stop$/ && do { $self->endStop(@_); last; };
	/^pattern$/ && do { $self->endPattern(@_); last; };
	/^clipPath$/ && do { $self->endClipPath(@_); last; };
	/^mask$/ && do { $self->endMask(@_); last; };
	/^filter$/ && do { $self->endFilter(@_); last; };
	/^feDistantLight$/ && do { $self->endDisLight(@_); last; };
	/^fePointLight$/ && do { $self->endPntLight(@_); last; };
	/^feSpotLight$/ && do { $self->endSptLight(@_); last; };
	/^feBlend$/ && do { $self->endBlend(@_); last; };
	/^feColorMatrix$/ && do { $self->endCMatrix(@_); last; };
	/^feFuncR$/ && do { $self->endFuncR(@_); last; };
	/^feFuncG$/ && do { $self->endFuncG(@_); last; };
	/^feFuncB$/ && do { $self->endFuncB(@_); last; };
	/^feFuncA$/ && do { $self->endFuncA(@_); last; };
	/^feComposite$/ && do { $self->endComposite(@_); last; };
	/^feComponentTransfer$/ && do { $self->endCompTrans(@_); last; };
	/^feConvolveMatrix$/ && do { $self->endConvolveMatrix(@_); last; };
	/^feDiffuseLighting$/ && do { $self->endDLighting(@_); last; };
	/^feDisplacementMap$/ && do { $self->endDispMap(@_); last; };
	/^feFlood$/ && do { $self->endFlood(@_); last; };
	/^feGaussianBlur$/ && do { $self->endGBlur(@_); last; };
	/^feImage$/ && do { $self->endFImage(@_); last; };
	/^feMerge$/ && do { $self->endMerge(@_); last; };
	/^feMergeNode$/ && do { $self->endMergeNode(@_); last; };
	/^feMorphology$/ && do { $self->endMorphology(@_); last; };
	/^feOffset$/ && do { $self->endOffset(@_); last; };
	/^feSpecularLighting$/ && do { $self->endSLighting(@_); last; };
	/^feTile$/ && do { $self->endTile(@_); last; };
	/^feTurbulence$/ && do { $self->endTurbulence(@_); last; };
	/^a$/ && do { $self->endA(@_); last; };
	/^view$/ && do { $self->endView(@_); last; };
	/^script$/ && do { $self->endScript(@_); last; };
	/^animate$/ && do { $self->endAnim(@_); last; };
	/^canim$/ && do { $self->endCAnim(@_); last; };
	/^set$/ && do { $self->endSet(@_); last; };
	/^animateMotion$/ && do { $self->endAnimMotion(@_); last; };
	/^animateColor$/ && do { $self->endAnimColor(@_); last; };
	/^animateTransform$/ && do { $self->endAnimTransform(@_); last; };
	/^mpath$/ && do { $self->endMPath(@_); last; };
	/^font$/ && do { $self->endFont(@_); last; };
	/^glyph$/ && do { $self->endGlyph(@_); last; };
	/^missingGlyph$/ && do { $self->endMGlyph(@_); last; };
	/^font-face$/ && do { $self->endFontFace(@_); last; };
	/^font-face-src$/ && do { $self->endFontFaceSrc(@_); last; };
	/^font-face-uri$/ && do { $self->endFontFaceUri(@_); last; };
	/^font-face-format$/ && do { $self->endFontFaceFormat(@_); last; };
	/^font-face-name$/ && do { $self->endFontFaceName(@_); last; };
	/^definition-src$/ && do { $self->endDefinitionSrc(@_); last; };
	/^cursor$/ && do { $self->endCursor(@_); last; };
	/^foreignObject$/ && do { $self->endForeignObj(@_); last; };
	/^custom$/ && do { $self->endCustom(); last; };
	    }
    }

    } elsif ($self->{inBoundary} =~ /^text$/) {
    	if (@_ > 0) {
		my $tag = shift;
		if ($tag =~ /^$self->{inBoundary}$/) {
		    # $self->svgPrint("</$tag>");
		    $self->endTxt();
        	} else {
		    $self->message_err("non-matching closing tag for \"<$self->{inBoundary}>\"", $self->{LineNumber}, "\"</$self->{inBoundary}>\" assumed" );
		    # $self->svgPrint("</$self->{inBoundary}>");
		    $self->endTxt();
		}
	} else {
		# $self->svgPrint("</$self->{inBoundary}>");
		$self->endTxt();
	}
    } else {$self->message_err("non-matching closing tag for invalid opening tag", $self->{LineNumber})}

    if ($self->{inBoundary} =~ /^begin$/) {$self->{inBoundary} = "empty"}

}

# prints error message on standard display  [private]
sub message_err {
    my $self = shift;
    my $err;
    my $line;
    my $action;
    $self->{ErrorNumber}++;
    if (@_>2) {
	($err,$line,$action) = @_;
    } else {
	($err,$line) = @_;
	$action = "command ignored";
    }
    if ($self->{Debug} =~ /^true$/) {
	my $fh = $self->{ErrorHandle};
	print $fh "\nERROR at statement $line: $err\n ACTION carried out : $action";
    }
    if ($self->{NoNags} =~ /^false$/) {
	print STDERR "\nERROR at statement $line : $err\n ACTION carried out : $action";
    }
}

# prints system message on standard display [private]
sub message_out {
    my $self = shift;
    my($msg) = @_;
    if ( $self->{InCGI} =~ /^false$/ && $self->{NoNags} =~ /^false$/) {
	print STDOUT "$msg\n";
    }
}

# writes text to SVG document output [private]
sub svgPrint {
    my $self = shift;
    foreach (@_) {
	if ($self->{InCGI} =~ /^false$/) {
		my $fh = $self->{FileHandle};
		print $fh  $_;
	} else {print STDOUT $_}
    }
}

# prints a new line [private]
sub newline {
	my $self = shift;		# get current object
	my $numline = shift;		# number of lines
	if ($numline =~ /^0$/ || !$numline =~ /^[0-9]+$/) {$numline=1}
	# print an empty line
	for (my $i=0;$i<$numline;$i++) {
		if ($self->{InCGI} =~ /^false$/) {
			my $fh = $self->{FileHandle};	
			print $fh "\n";
		} else {print STDOUT "\n"}
	} 
} # end newline

# automatic indentation [private]
sub indent {
	my $self = shift;		# get current object
	# work out the suitable indentation
	for (my $i=0;$i<$self->{tab};$i++) {
		if ($self->{InCGI} =~ /^false$/) {
			my $fh = $self->{FileHandle};
			print $fh "\t";
		} else {print STDOUT "\t"}
	}
} # end indentation

1; # Perl notation to end a module