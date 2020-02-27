package Svg::Graphics;		# define a new package
require 5.000;				# needs version 5, latest version 5.00402

use Svg::Animation qw (		animElementAttrs animAttributeAttrs animTargetAttrs animTimingAttrs
						animValueAttrs animAdditionAttrs drawAnim beginAnim endAnim
						drawAnimMotion beginAnimMotion endAnimMotion drawAnimColor beginAnimColor 
						endAnimColor drawAnimTransform beginAnimTransform endAnimTransform
						drawMPath beginMPath endMPath beginCAnim endCAnim move change	);
use Svg::ClipMask qw (		drawClipPath beginClipPath endClipPath drawMask beginMask endMask	);
use Svg::Common qw (		stdAttrs langSpaceAttrs	xlinkRefAttrs graphicsElementEvents documentEvents 
						animationEvents testAttrs geometricAttrs 	);
use Svg::Custom qw (		drawCursor beginCursor endCursor drawCustom beginCustom endCustom printTxt	);
use Svg::Entities qw (		BaselineShiftValue ClipValue ClipPathValue ClipFillRule CursorValue 
						EnableBackgroundValue FilterValue FontFamilyValue FontSizeValue 
						FontSizeAdjustValue GlyphOrientationHorizontalValue  
						GlyphOrientationVerticalValue KerningValue MarkerValue MaskValue Paint
						PreserveAspectRatioSpec SpacingValue StrokeDashArrayValue StrokeDashOffsetValue 
						StrokeMiterLimitValue StrokeWidthValue TextDecorationValue ViewBoxSpec
						ClassStyle XY	);
use Svg::Extensibility qw ( 	drawForeignObj beginForeignObj endForeignObj	);
use Svg::FilterEffects qw (	filterPrimitiveAttrs filterPrimitiveAttrsWithIn componentTransferFunctionAttrs
						drawFilter beginFilter endFilter drawBlend beginBlend endBlend
						drawFlood beginFlood endFlood drawCMatrix beginCMatrix endCMatrix
						drawCompTrans beginCompTrans endCompTrans drawFuncR beginFuncR endFuncR
						drawFuncG beginFuncG endFuncG drawFuncB beginFuncB endFuncB
						drawFuncA beginFuncA endFuncA beginDLighting endDLighting
						drawDisLight beginDisLight endDisLight drawPntLight beginPntLight endPntLight
						drawSptLight beginSptLight endSptLight drawDispMap beginDispMap endDispMap
						drawGBlur beginGBlur endGBlur drawFImage beginFImage endFImage
						drawMerge beginMerge endMerge drawMergeNode beginMergeNode endMergeNode
						drawMorphology beginMorphology endMorphology drawOffset beginOffset endOffset
						drawSLighting beginSLighting endSLighting drawTile beginTile endTile
						drawTurbulence beginTurbulence endTurbulence drawConvolveMatrix 
						beginConvolveMatrix endConvolveMatrix drawComposite		);
use Svg::Font qw ( 			beginFont endFont beginMGlyph endMGlyph drawMGlyph beginGlyph endGlyph 
						drawGlyph drawHkern drawVkern drawFontFace beginFontFace endFontFace
						drawFontFaceSrc beginFontFaceSrc endFontFaceSrc drawFontFaceUri 
						beginFontFaceUri endFontFaceUri drawFontFaceFormat beginFontFaceFormat 
						endFontFaceFormat drawFontFaceName beginFontFaceName endFontFaceName
						drawDefinitionSrc beginDefinitionSrc endDefinitionSrc initMetrics charWidth 
						textWidth setFontSize setFontFamily setFontColor setCharSpacing setWordSpacing 
						setHorizScaling	);
use Svg::Linking qw ( 		beginA endA drawA beginView endView drawView );
use Svg::Path qw (			beginPath endPath drawPath beginRect endRect drawRect beginCPath endCPath 
						moveto lineto closepath hlineto vlineto curveto scurveto qcurveto tcurveto arcto
						beginCircle endCircle drawCircle beginEllipse endEllipse drawEllipse beginLine 
						endLine drawLine beginPolyline endPolyline drawPolyline beginPolygon endPolygon 
						drawPolygon	);
use Svg::Presentation qw (	Containers feFlood	FillStroke FontSpecification Gradients Graphics Images 
						LightingEffects Markers TextContentElements TextElements Viewports 
						PttnAttrsAll	);
use Svg::Rendering qw( 		drawLinGrad beginLinGrad endLinGrad drawRadGrad beginRadGrad endRadGrad
						drawStop beginStop endStop drawPattern beginPattern endPattern
						drawColorProfile beginColorProfile endColorProfile	);
use Svg::Scripting qw (		drawScript beginScript endScript drawStyle beginStyle endStyle	);
use Svg::Std qw ( 			message_err message_out svgPrint newline indent b e d parseStyle	 );
use Svg::Structure qw ( 		drawG beginG endG drawDefs beginDefs endDefs drawMetadata beginMetadata 
						endMetadata drawDesc beginDesc endDesc drawTitle beginTitle endTitle
				 		beginUse endUse drawUse beginImage endImage drawImage beginSymbol 
				 		endSymbol drawSymbol drawSwitch beginSwitch endSwitch 	);
use Svg::Text qw ( 			beginTxt endTxt drawTxt beginTSpan endTSpan drawTSpan
						beginTRef endTRef drawTRef beginTxtPath endTxtPath drawTxtPath
						beginAltGlyph endAltGlyph drawAltGlyph beginAltGlyphDef endAltGlyphDef 
						drawAltGlyphDef beginAltGlyphItem endAltGlyphItem drawAltGlyphItem
						beginGlyphRef endGlyphRef drawGlyphRef drawGlyphSub structuredTxt
						textCenterBottom textCenterTop textCenterMiddle textRightBottom textRightTop 
						textRightMiddle textLeftBottom textLeftTop textLeftMiddle begintextCenterBottom 
						begintextCenterTop begintextCenterMiddle begintextRightBottom begintextRightTop 
						begintextRightMiddle begintextLeftBottom begintextLeftTop begintextLeftMiddle
						textBlockLeftTop textBlockLeftMiddle textBlockLeftBottom textBlockRightTop 
						textBlockRightMiddle textBlockRightBottom textBlockCenterTop textBlockCenterMiddle 
						textBlockCenterBottom		);

# use Svg::Events qw (graphicsElementEvents documentEvents);
# use Svg::GReferencing qw (beginUse endUse drawUse beginImage endImage drawImage);
# use Svg::SymMarker qw (beginMarker endMarker drawMarker);

use strict qw ( subs vars refs );
@Svg::Graphics::ISA = qw( Svg::Std );

# creates new object [private]
sub new {
    my ($class, $self) = @_;
    $self = bless {
	"FileHandle" => $self->{FileHandle},
	"ErrorHandle" => $self->{ErrorHandle},
	"LineNumber" => $self->{LineNumber},
	"ErrorNumber" => $self->{ErrorNumber},
	"Debug" => $self->{Debug},
	"Public_ID" => $self->{Public_ID},
	"XML_DTD" => $self->{XML_DTD},
	"XML_Link" => $self->{XML_Link},
	"NoNags" => $self->{NoNags},
	"InCGI" => $self->{InCGI}
    }, $class;
    $self->init();
    $self;
}

# initialises object specific variables [private]
sub init {
    my $self = shift;
    $self->{tab} = 0;
    $self->{inBoundary} = "begin";
    $self->{inQueue} = [];
    $self->{dtdMetadata} = [];
    $self->{dtdDesc} = [];
    $self->{dtdTitle} = [];
    $self->{feFuncR} = [];
    $self->{feFuncG} = [];
    $self->{feFuncB} = [];
    $self->{feFuncA} = [];
    $self->{cAnim} = [];
    $self->{FuncR} = "empty";
    $self->{FuncG} = "empty";
    $self->{FuncB} = "empty";
    $self->{FuncA} = "empty";
    $self->{Metadata} = "empty";
    $self->{Desc} = "empty";
    $self->{Title} = "empty";
    $self->{fontfamily} = "Helvetica";
    $self->initMetrics("Helvetica");
    $self->{fontsize} = 12;
    $self->{fontcolor} = "black";
    $self->{charspacing} = 0;
    $self->{wordspacing} = 0;
    $self->{hscaling} = 100;
    
    # common regular expressions
    $self->{reBoolean} = '(true|false)';
    $self->{reAnyOneOrMore} = '.+';
    $self->{reAnyNoneOrMore} = '.*';
    $self->{reAnyOneOrNone} = '.?';
    $self->{reLength} = '[0-9]+(\.[0-9]+)?(em|ex|px|pt|pc|cm|mm|in|%)?';
    $self->{rePercent} = '[+-]?[0-9]+(\.[0-9]+)?%?';
    $self->{reNumber} = '[+-]?[0-9]+(\.[0-9]+)?';
    $self->{reUnsignNumber} = '[0-9]+(\.[0-9]+)?';
    $self->{re0to1} = '(0(\.[0-9]+)?|1(\.0+)?)';
    $self->{re360} = '[+-]?([0-9]{1,2}(\.[0-9]+)?|(1|2)([0-9]{2})(\.[0-9]+)?|3[0-5][0-9](\.[0-9]+)?|360(\.0+)?)';
    $self->{reSpaceCommaOneOrMore} = '[+-]?[0-9]+(\.[0-9]+)?((\s*,\s*|\s+,?\s*|\s*,?\s+)[+-]?[0-9]+(\.[0-9]+)?)*';
    $self->{reSpaceComma4} = '[+-]?[0-9]+(\.[0-9]+)?(\s*,\s*|\s+,?\s*|\s*,?\s+)[+-]?[0-9]+(\.[0-9]+)?(\s*,\s*|\s+,?\s*|\s*,?\s+)[+-]?[0-9]+(\.[0-9]+)?(\s*,\s*|\s+,?\s*|\s*,?\s+)[+-]?[0-9]+(\.[0-9]+)?';
    $self->{reSpaceComma} = '(\s*,\s*|\s+,?\s*|\s*,?\s+)';
    
    @{$self->{iso639}} = qw( 	aa ab af am ar as ay az ba be bg bh bi bn bo br 
							ca co cs cy da de dz el en eo es et eu fa fi fj 
							fo fr fy ga gd gl gn gu gv ha he hi hr hu hy ia 
							id ie ik is it iu ja jw ka kk kl km kn ko ks ku 
							kw ky la lb ln lo lt lv mg mi mk ml mn mo mr ms 
							mt my na ne nl no oc om or pa pl ps pt qu rm rn 
							ro ru rw sa sd se sg sh si sk sl sm sn so sq sr 
							ss st su sv sw ta te tg th ti tk tl tn to tr ts 
							tt tw ug uk ur uz vi vo wo xh yi yo za zh zu 	);
    @{$self->{iso3166}} = qw( 	AF AL DZ AS AD AO AI AQ AG AR AM AW AU AT AZ 
							BS BH BD BB BY BE BZ BJ BM BT BO BA BW BV BR IO
							BN BG BF BI KH CM CA CV KY CF TD CL CN CX CC CO
							KM CG CD CK CR CI HR CU CY CZ DK DJ DM DO TP EC
							EG SV GQ ER EE ET FK FO FJ FI FR GF PF TF GA GM
							GE DE GH GI GR GL GD GP GU GT GN GW GY HT HM VA
							HN HK HU IS IN ID IR IQ IE IL IT JM JP JO KZ KE
							KI KP KR KW KG LA LV LB LS LR LY LI LT LU MO MK
							MG MW MY MV ML MT MH MQ MR MU YT MX FM MD MC MN
							MS MA MZ MM NA NR NP NL AN NC NZ NI NE NG NU NF
							MP NO OM PK PW PS PA PG PY PE PH PN PL PT PR QA
							RE RO RU RW SH KN LC PM VC WS SM ST SA SN SC SL
							SG SK SI SB SO ZA GS ES LK SD SR SJ SZ SE CH SY
							TW TJ TZ TH TG TK TO TT TN TR TM TC TV UG UA AE
							GB US UM UY UZ VU VE VN VG VI WF EH YE YU ZM ZW	);
    $self->message_out("Graphics object created successfully");
}

# creates a Graphics object from a File object
sub beginGraphics {
    my $self = shift;
    my $graphics = Svg::Graphics->new($self);
    $graphics;
}

# draws an user info comment
# USAGE: 
# 	$GraphicsObj->info( OPTIONAL [title|author|creator|subject]);
sub info {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    $self->newline();
    $self->indent();
    $self->svgPrint("<!--");
    $self->{tab}+=1;
    my @arguments = @_;

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^title$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->newline();
			$self->indent();
			$self->svgPrint("$attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^author$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->newline();
			$self->indent();
			$self->svgPrint("$attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^creator$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->newline();
			$self->indent();
			$self->svgPrint("$attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^subject$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->newline();
			$self->indent();
			$self->svgPrint("$attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^copyright$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->newline();
			$self->indent();
			$self->svgPrint("$attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }

    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->{tab}-=1;
    $self->newline();
    $self->indent();
    $self->svgPrint("-->");

}

# opens an 'svg' boundary
sub beginSvg {

    my $self = shift;
    $self->{LineNumber}++;

    if ($self->{inBoundary} =~ /^empty$/) {$self->{inBoundary} = pop(@{$self->{inQueue}})} 

    if ($self->{inBoundary} =~ /^(begin|svg|g|defs|symbol|marker|mask|pattern|a|switch|glyph|missing-glyph)$/) {

    my @arguments = @_;

    $self->newline();
    $self->indent();
    $self->svgPrint("<svg");
    push(@{$self->{inQueue}}, $self->{inBoundary});
    $self->{inBoundary} = "svg";
    $self->{tab}+=1;

    for (my $i=0; $i<@arguments; $i++) {
	$_ = $arguments[$i];
	SWITCH: {
	    /^xmlns$/ && 
		do {
		    splice(@arguments, $i--, 1);
		    $self->svgPrint(" xmlns=\"$self->{XML_DTD}\"");
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
	    /^zoomAndPan$/ &&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^(disable|magnify|zoom)$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^contentScriptType$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	    /^contentStyleType$/	&&
		do {
		    (my $attrib, my $value) = splice(@arguments, $i--, 2);
		    if ($value =~ /^$self->{reAnyOneOrMore}$/) {
			$self->svgPrint(" $attrib=\"$value\"");
		    } else {$self->message_err("\"$attrib\" attribute value not valid", $self->{LineNumber})}
		    last SWITCH;
		};
	}
    }
    
    @arguments = $self->geometricAttrs(@arguments);
    @arguments = $self->ViewBoxSpec(@arguments);
    @arguments = $self->PreserveAspectRatioSpec(@arguments);
    @arguments = $self->stdAttrs(@arguments);
    @arguments = $self->testAttrs(@arguments);
    @arguments = $self->langSpaceAttrs(@arguments);
    @arguments = $self->PttnAttrsAll(@arguments);
    @arguments = $self->documentEvents(@arguments);
    @arguments = $self->graphicsElementEvents(@arguments);
    @arguments = $self->ClassStyle(@arguments);
    
    if (@arguments > 0) {$self->message_err("unrecognised argument(s) or value(s) - @arguments", $self->{LineNumber})}

    $self->svgPrint(">");

    } else {
	$self->message_err("element \"svg\" not allowed in the \"$self->{inBoundary}\" boundary", $self->{LineNumber});
    	push(@{$self->{inQueue}}, $self->{inBoundary});
    	$self->{inBoundary} = "empty";
    }

}

# closes an 'svg' boundary
sub endSvg {
    my $self = shift;
    $self->{LineNumber}++;
    $self->{tab}-=1;
    $self->newline();    
    $self->indent();
    $self->svgPrint("</svg>");
    $self->{inBoundary} = pop(@{$self->{inQueue}});
}

1; # Perl notation to end a module