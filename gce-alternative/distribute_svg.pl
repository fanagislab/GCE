#!/usr/bin/perl
#Author:Li Shengting
#E-mail:lishengting@genomics.org.cn
#Program Date:2002-7-10 11:31
#Last Update:2006-10-18 20:08
#Describe:画各种类型的分布图
my $ver=2.2;#可以更改字体字号
$ver=3.00;#画线状图
$ver=3.20;#修改一些bug
$ver=3.40;#增强错开功能以及控制坐标显示
$ver=3.60;#纠正字体大小的bug，线改为圆端；
		  #加入大段注释功能
$ver=3.62;#修改坐标错误
$ver=3.63;#增加横坐标显示
$ver=3.64;#修改纵坐标为小数时的错误
$ver=3.65;#提高横坐标显示精确度
$ver=3.70;#增加点图绘制
		  #对数坐标的指数显示
		  #标注的位置选择;
		  #多坐标点设置
$ver=3.71;#修改坐标显示
$ver=3.72;#纠正标题里面Html字符的显示问题
$ver=3.73;#增加powerpoint色彩
$ver=3.74;#改正零点偏差问题
$ver=3.75;#2002-9-20 13:55 增加纠错能力
$ver=3.76;#2002-9-20 13:58 增加强制类型参数
$ver=3.77;#2002-9-24 10:34 增加有效数字的四舍五入
$ver=3.80;#2002-9-28 10:41 增加右端坐标显示
$ver=3.81;#2002-9-30 19:01 加入autofit
$ver=3.82;#2002-10-1 11:28 放宽坐标格式要求
$ver=3.83;#2002-10-11 16:57 不区分大小写;x y轴可缩放;可改变线宽
$ver=3.84;#2002-10-12 22:52 增加注释
$ver=3.85;#2002-10-18 11:16 修整一堆bug
$ver=3.86;#2002-10-20 14:40 增加局部类型
$ver=3.90;#2002-10-20 16:46 y轴加强显示功能
$ver=3.91;#2002-10-21 0:59 增加自动取log功能
$ver=3.92;#2002-10-22 13:46 修正bug
$ver=4.00;#2002-10-23 20:23 增加文字坐标显示
$ver=4.01;#2002-10-24 22:30 增加垂直点线图
$ver=4.02;#2002-10-25 0:45 修改一对多的bug(修改散列表结构)
$ver=4.03;#2002-10-26 23:56 修改YNeedLog!=0,YLog=0时bug
$ver=4.04;#2002-10-27 23:55 增加颜色渐变
$ver=4.05;#2002-10-28 14:13 矩形指定下界
$ver=4.06;#2002-10-28 14:37 坐标与图形分开设定 YAxis,YMark
$ver=4.07;#2002-10-30 16:48 增加边框矩形
$ver=4.08;#2002-11-2 13:05 修正bug
$ver=4.10;#2002-11-5 11:50 增加透明参数
$ver=4.11;#2002-11-5 20:07 增加两种注释位置
$ver=4.12;#2002-11-7 4:10 增加坐标与图分开功能
$ver=4.13;#2002-11-7 14:51 允许尾部空格
$ver=4.14;#2002-11-8 15:17 增加虚线设置
$ver=4.15;#2002-11-8 22:41 增加健壮性
$ver=4.16;#2002-11-9 1:07 增加文字纵坐标
$ver=4.17;#2002-11-9 4:53 增加分组框和标识
$ver=4.18;#2002-11-12 11:22 修正bug
$ver=4.19;#2002-11-18 14:24 修正bug
$ver=4.20;#2002-11-26 15:33 纠正画点图的缺陷,ColorStep改为正向
$ver=4.21;#2002-11-30 16:41 增加Y轴刻度
$ver=4.22;#2002-12-10 14:58 增加缺省参数
$ver=4.23;#2002-12-20 22:34 修改autofit的bug
$ver=4.24;#2003-1-2 23:14 添加局部点大小,可设置图像置顶
$ver=4.25;#2003-1-13 22:08 增强颜色变化功能
$ver=4.26;#2003-2-9 16:52 点类型重复利用
$ver=4.27;#2003-4-8 16:27 Mark中<&>符号的处理
$ver=4.28;#2003-4-10 15:59 修改HaveMore/HaveLess的bug
$ver=4.29;#2003-4-12 22:21 修改LineBar(XUnit!=0)的bug
$ver=4.30;#2003-4-25 11:53 FreeText
$ver=4.31;#2003-4-29 22:02 FreeText bug
$ver=4.32;#2003-5-8 23:49 Fix XDispStep bug
$ver=4.33;#2003-5-8 23:49 Change PointShape Func
$ver=4.34;#2003-07-12 14:53 允许缺省为两列坐标
$ver=4.35;#2003-08-29 14:24 Mark标在框外
$ver=4.36;#2003-09-04 19:33 修正bug
$ver=4.37;#2003-09-05 22:34 添加弹出注释
$ver=4.38;#2003-09-10 15:05 修改文字注释
$ver=4.39;#2003-09-16 16:47 修正bug
$ver=4.40;#2003-10-09 18:03 重新兼容Simple类型
$ver=4.41;#2004-2-18 16:42 对^M兼容
$ver=4.42;#2004-3-11 22:12 修改bug
$ver=4.43;#2004-3-11 22:51 增加位移功能XMove
$ver=4.44;#2004-3-25 11:53 修改bug
$ver=4.45;#2004-4-12 17:33 修改柱状图y2功能
$ver=4.45;#2004-4-12 18:38 fx,fy->f
$ver=4.46;#2004-4-13 11:31 修改柱状图偏移bug
$ver=4.47;#2004-6-15 16:20 修改Color Point的bug
$ver=4.48;#2004-7-12 20:02 添加#注释
$ver=4.51;#2004-8-17 11:47 添加形状 整理部分代码 修改bug
$ver=4.52;#2005-01-08 22:19 增强健壮性 添加功能
$ver=4.60;#2005-01-11 15:58 添加继承属性 添加线形渐变
$ver=4.62;#2005-01-14 9:26 小bug Mark:0 Mark里面icon的大小
$ver=4.64;#2006-07-17 12:03 添加ExtendLine,OnlyLine for Point (x2|y2连线)
		  #添加NoFrame,NoScaleLine,NoXScale,NoYScale
$ver=4.65;#2006-08-08 14:01 修改bug in Point，点数加错了
$ver=4.70;#2006-10-17 10:48 
		  #修正字体大小不能正常变化的bug
		  #独立改变刻度字体大小 ScaleFontSize
		  #添加点的形状：多边形Polygon
$ver=4.71;#2006-10-18 20:08 Align:C
$ver=4.72;#2006-12-01 09:02 修改 Transparence 透明模式为单元素透明
$ver=4.73;#2007-06-06 13:02 修正对Simple支持不完整的bug；
		  #对于非[直方图]|[折线图]，$wOff和$w清零；
		  #修正多Type角标显示不正常的bug

use strict;
use Getopt::Long;
use FindBin qw($Bin);
use lib $Bin;
use Svg::File;
use Svg::Graphics;

my %opts;
GetOptions(\%opts,"p!","t:s","imagetop!","fixwidth!");
die "#$ver Usage: $0 <list_file> <svg_file> [-p] [-t type] [-imagetop] [-fixwidth]\n" if (@ARGV<2);
#Constant
sub error;
my $XOFFSET=10;
my $YOFFSET=10;
my $CHRH=1.2;
my $XSPACE=2;
my $YSPACE=2;
my $SCALELEN=5;
my $STROKE_WIDTH=3;
my $MARK_SCALE=3/4;
my $MARK2_SCALE=3/4;
my $EXP_SCALE=0.3;
my $MARK_POINT_SIZE=5;
my $PI=3.1415926;
my $SPECIAL_CHAR='<&>';
my $DEFAULT_FONT_SIZE=46;

my $svg = Svg::File->new($ARGV[1],\*OUT);
$svg->open("public","encoding","iso-8859-1");
my $g = $svg->beginGraphics();

#Globe Variable
#print map {"$_<-->$opts{$_}\n"} sort keys %opts;
my $pp=$opts{p};
my $type=$opts{t};
my $autofit=!$opts{fixwidth};
my $imagetop=$opts{imagetop};
my (%param,%rect,$ch,$realCh,$scaleCh,$realScaleCh,$vbW,$vbH,$xZero,$yZero,$ryZero);
my ($xDiv,$yDiv,$ryDiv,$x,$y,$ry,$colWidth,$xDDigits,$yDDigits,$ryDDigits,
$mark,$part,$offset,$unitPer,$tmp,$noConnect,$yMlen,$ryMlen,
$maxXScale,$maxYScale,$maxRYScale,$step,$LGNum,$xFontSpace,$yFontSpace,
@mark,@tmp,@note,@mark2,@xScale,@yScale,@ryScale,@y,@ry,%raw,@group,@gxy,@errhis,@oShape,
@fontSizeStack,%point);
my %d=(
	path=>{
		'stroke'=>"#000000",
		'fill'=>"none",
		'stroke-width'=>$STROKE_WIDTH,
		'stroke-linecap'=>'round'
	},
	font=>{
		'fill'=>"#000000",
		'font-size'=>$DEFAULT_FONT_SIZE,
		#'font-weight'=>'bold',
		'font-family'=>"ArialNarrow-Bold"
	},
	rect=>{
		'fill'=>"none",
		'stroke'=>"black",
		'stroke-width'=>$STROKE_WIDTH
	},
	point=>{
		'fill'=>"black",
		'stroke'=>"none"
	},
	polygon=>{
		'fill'=>"black",
		'stroke'=>"black",
		'stroke-width'=>1
	},
);

my @shape=(
	'circle','square',
	'triangle1','triangle2',
	'lozenge','polygon5','polygon6'
);

my @type=(
	'rect',
	'double',
	'line',
	'point',
	'bar',
	'text',
);

my %type=(
	'rect'=>1,
	'double'=>1,
	'line'=>1,
	'point'=>1,
	'bar'=>1,
	'text'=>1,
);

%param=();
@note=();
@fontSizeStack=();
%point=();
my @keys=(
"Type","Width","Height","WholeScale","BothYAxis","ScaleLen",
"MarkPos","MarkStyle","MarkNoBorder","MarkScale",
"Mark2Pos","Mark2Border","Mark2Scale",
"HaveMore","HaveLess","RightAngle","Part","OffsetPer","UnitPer","MovePer",
"FontSize","FontFamily","FontBold","ScaleFontSize",
"XScalePos","XScaleLinePos","XUnit","XScaleRoate","XCut","YCut",
"XStart","XEnd","XStep","XLog","X","XDispStep","XDDigits",
"XDiv","XScaleDiv","XZeroPos","XZeroVal","XExp","XNeedLog","XMove",
"YStart","YEnd","YStep","YLog","Y","YDispStep","YDDigits","YScalePos",
"YDiv","YNum","YScaleDiv","YZeroPos","YZeroVal","YExp","YNeedLog","YMove",
"RYStart","RYEnd","RYStep","RYLog","RY","RYDispStep","RYDDigits","RYScalePos",
"RYDiv","RYNum","RYScaleDiv","RYZeroPos","RYZeroVal","RYExp","RYNeedLog","RYMove",
"MultiY","MultiRY","Transparence",
"Note","AvailDigit","VerticalLine",
"NoLine","NoConnect","NoFillZero","NoFrame","NoScaleLine","NoXScale","NoYScale",
#Line
"Fill","LineDash","LineWidth",
#Rect
"NoFill","StrokeWidth","Rounded","LinearGradient","Align",##"Fill"
#Point
"PointSize","PointShape","ExtendLine","OnlyLine",##"NoFill","Fill","StrokeWidth",
#Text
'AlignPos',
);

my %noTrim=(
"Note"=>1,"X"=>1,"Y"=>1,"RY"=>1,"Mark"=>1,
);

$LGNum=1;
$maxRYScale=$maxYScale=$maxXScale='';
open(F,$ARGV[0]) || die "Can't open $ARGV[0]!\n";
while (<F>) {
	last if ($_!~/\S/);
	next if (/^\s*\#/);
	if ($_=~/^\s*[\+-]?\d/) {
		seek(F,-length,1);
		last;
	}
	s/\cM*$//;
	chomp;
	if (/^\s*Note2:/i) {
		while (<F>) {
			s/\cM*$//;
			last if ($_=~/^\s*:End\s*$/i);
			chomp;
			#$_=~ s/([$SPECIAL_CHAR])/sprintf("&#%d;", ord($1))/ge;
			push(@note,$_);
		}
	}
	if (/^\s*Group:/i) {
		while (<F>) {
			s/\cM*$//;
			last if ($_=~/^\s*:End\s*$/i);
			chomp;
			$_=~/^\s*(\d+)\s*:(.+)/;
			$#group++;
			$group[$#group]{len}=$1;
			$group[$#group]{mark}=$2;
		}
	}
	if (/^\s*Mark2:/i) {
		while (<F>) {
			s/\cM*$//;
			last if ($_=~/^\s*:End\s*$/i);
			chomp;
			#$_=~ s/([$SPECIAL_CHAR])/sprintf("&#%d;", ord($1))/ge;
			push(@mark2,$_);
		}
	}
	if ($_=~/^\s*Scale:/i || $_=~/^\s*XScale:/i) {
		while (<F>) {
			s/\cM*$//;
			last if ($_=~/^\s*:End\s*$/i);
			chomp;
			#$_=~ s/([$SPECIAL_CHAR])/sprintf("&#%d;", ord($1))/ge;
			push(@xScale,$_);
			$maxXScale=$_ if (length($maxXScale)<length($_));
		}
	}
	if (/^\s*YScale:/i) {
		while (<F>) {
			s/\cM*$//;
			last if ($_=~/^\s*:End\s*$/i);
			chomp;
			#$_=~ s/([$SPECIAL_CHAR])/sprintf("&#%d;", ord($1))/ge;
			push(@{$yScale[0]},$_);
			$maxYScale=$_ if (length($maxYScale)<length($_));
		}
	}
	if (/^\s*RYScale:/i) {
		while (<F>) {
			s/\cM*$//;
			last if ($_=~/^\s*:End\s*$/i);
			chomp;
			#$_=~ s/([$SPECIAL_CHAR])/sprintf("&#%d;", ord($1))/ge;
			push(@{$ryScale[0]},$_);
			$maxRYScale=$_ if (length($maxRYScale)<length($_));
		}
	}
	if (/(\S+?):(.+)/) {
		$param{lc($1)}=$2;
	}
}
foreach (@keys) {
	if (exists($param{lc($_)})) {
		if (exists($noTrim{$_})) {
			$param{$_}=$param{lc($_)};
		}else{
			$param{$_}=trim($param{lc($_)});
		}
	}
}
%raw=%param;

$param{Type}=$type if ($type ne '');
$param{Type}=~/\S+/;
$type=lc($&);
#$type=$type[0] if (!defined($type) || $type eq '' || $type eq 'rect' || $type eq 'rectangle' || $type eq 'simple');
$type=$type[0] if (!defined($type) || !$type{$type});
$param{Type}=$type;

my @stict_keys=("XStart","YStart","XEnd","YEnd","XStep","YStep");
{
	my ($ok,$fpos,$x,$y,$XStart,$YStart,$XEnd,$YEnd,$XStep,$YStep,$XUnit,$lastx);
	my (@line);
	$XStart=$YStart=$XEnd=$YEnd=$XStep=$YStep=$XUnit='x';
	$lastx='x';
	$ok=1;
	foreach (@stict_keys) {
		if (!exists($param{$_})) {
			error("$_ isn't defined!\nWill use calculation instead!",1);
			$ok=0;
		}
	}
	if (!$ok) {
		$fpos=tell(F);
		while (<F>) {
			s/\cM*$//;
			next if (/^\s*\#/);
			next if ($_!~/^\s*[\+-]?\d/);
			chomp;
			@line=split /:/;
			if ($line[0]=~/\d/) {
				$x=$line[0];
				$x=~s/\s//g;
				$XStart=$x if ($XStart>$x || $XStart eq 'x');
				$XEnd=$x if ($XEnd<$x || $XEnd eq 'x');
				if ($lastx ne 'x' && ($XUnit>abs($x-$lastx) || $XUnit eq 'x') && ($x-$lastx)!=0) {
					$XUnit=abs($x-$lastx);
				}
				$lastx=$x;
			}
			if ($line[1]=~/\d/) {
				$y=$line[1];
				$y=~s/\s//g;
				$YStart=$y if ($YStart>$y || $YStart eq 'x');
				$YEnd=$y if ($YEnd<$y || $YEnd eq 'x');
			}
			if ($line[2]=~/\d/) {
				$y=$line[2];
				$y=~s/\s//g;
				$YStart=$y if ($YStart>$y || $YStart eq 'x');
				$YEnd=$y if ($YEnd<$y || $YEnd eq 'x');
			}
		}
		error "Can't calculate XStart!" if ($XStart eq 'x');
		error "Can't calculate XEnd!" if ($XEnd eq 'x');
		error "Can't calculate YStart!" if ($YStart eq 'x');
		error "Can't calculate YEnd!" if ($YEnd eq 'x');
		$XStart=availDigit($XStart,2,0);
		$XEnd=availDigit($XEnd,2,2);
		$YStart=availDigit($YStart,2,0);
		$YEnd=availDigit($YEnd,2,2);
		$XUnit=availDigit($XUnit,2,1);
		$param{XStart}=$XStart if (!defined($param{XStart}));
		$param{YStart}=$YStart if (!defined($param{YStart}));
		$param{XEnd}=$XEnd if (!defined($param{XEnd}));
		$param{YEnd}=$YEnd if (!defined($param{YEnd}));
		$XStep=availDigit(abs($param{XEnd}-$param{XStart})/4,2,1);
		$YStep=availDigit(abs($param{YEnd}-$param{YStart})/4,2,1);
		$param{XStep}=$XStep if (!defined($param{XStep}));
		$param{YStep}=$YStep if (!defined($param{YStep}));
		$param{XUnit}=$XUnit if (!defined($param{XUnit}) && ($type eq $type[0]));
		seek(F,$fpos,0);
	}
}
#####################################################################################################################
#	SET param
#####################################################################################################################
$param{BothYAxis} = 1 if ($param{RYStart}||$param{RYEnd}||$param{RYStep});
error "XStart can't equal with XEnd!" if ($param{XStart}==$param{XEnd});
error "XStep must bigger than 0!" if ($param{XStep}<=0);
error "YStart can't equal with YEnd!" if ($param{YStart}==$param{YEnd});
error "YStep must bigger than 0!" if ($param{YStep}<=0);
if ($param{BothYAxis}) {
	error "RYStart can't equal with RYEnd!" if ($param{RYStart}==$param{RYEnd});
	error "RYStep must bigger than 0!" if ($param{RYStep}<=0);
}
$param{Width}=600 if (!$param{Width});
$param{Height}=400 if (!$param{Height});
$param{XLog}=10 if ($param{XLog}==1);
$param{YLog}=10 if ($param{YLog}==1);
$param{XExp}=10 if ($param{XExp}==1);
$param{YExp}=10 if ($param{YExp}==1);
$param{XExp}= ($param{XExp} ? $param{XExp} : 1);
$param{YExp}= ($param{YExp} ? $param{YExp} : 1);
$param{XNeedLog}=10  if ($param{XNeedLog}==1);
$param{YNeedLog}=10  if ($param{YNeedLog}==1);
$param{XLog}=$param{XNeedLog} if ($param{XNeedLog} && !exists($param{XLog}));
$param{YLog}=$param{YNeedLog} if ($param{YNeedLog} && !exists($param{YLog}));
error("XExp without XLog!\tError may occur!",1) if ($param{XExp}!=1 && !$param{XLog});
error("YExp without YLog!\tError may occur!",1) if ($param{YExp}!=1 && !$param{YLog});
if ($param{BothYAxis}) {
	@stict_keys=("RYStart","RYEnd","RYStep");
	foreach (@stict_keys) {
		if (!exists($param{$_})) {
			if ($param{MultiRY}) {
			}else{
				error "$_ must be defined!";
			}
		}
	}
	$param{RYLog}=10 if ($param{RYLog}==1);
	$param{RYExp}=10 if ($param{RYExp}==1);
	$param{RYExp}= ($param{RYExp} ? $param{RYExp} : 1);
	$param{RYNeedLog}=10  if ($param{RYNeedLog}==1);
	$param{RYLog}=$param{RYNeedLog} if ($param{RYNeedLog} && !exists($param{RYLog}));
	error("RYExp without RYLog!\tError may occur!",1) if ($param{RYExp}!=1 && !$param{RYLog});
}
###X
if ($param{XDiv}) {
	if ($param{XLog} && !$param{XNeedLog}) {
		$param{XStart}-=log($param{XDiv})/log($param{XLog});
		$param{XEnd}-=log($param{XDiv})/log($param{XLog});
	}else{
		$param{XStart}/=$param{XDiv};
		$param{XEnd}/=$param{XDiv};
		$param{XStep}/=$param{XDiv};
		$param{XUnit}/=$param{XDiv};
		#print "$param{XStart}\t$param{XEnd}\n";
	}
}
if ($param{XNeedLog}) {
	$step = rint(($param{XEnd}-$param{XStart})/$param{XStep});
	error("XStart and XEnd must bigger than 0!") if ($param{XStart}<=0 || $param{XEnd}<=0);
	$param{XStart}=log($param{XStart})/log($param{XNeedLog});
	$param{XEnd}=log($param{XEnd})/log($param{XNeedLog});
	$param{XStep}=availDigit(($param{XEnd}-$param{XStart})/$step,$param{AvailDigit},1,$param{XLog});
	$param{XUnit}=log($param{XUnit})/log($param{XNeedLog}) if ($param{XUnit});
	#print "$param{XStart}\t$param{XEnd}\n";
}
if (exists($param{XMove}) && !exists($param{XZeroPos})) {
	$param{XZeroPos}=(-$param{XStart}+$param{XStep}*$param{XMove})/($param{XEnd}-$param{XStart});
}
if ($param{XStart}!=0 && !exists($param{XZeroPos}) && !exists($param{XZeroVal})) {
	$param{XZeroVal}=$param{XStart};
}
###Y
if ($param{YDiv}) {
	if ($param{YLog} && !$param{YNeedLog}) {
		$param{YStart}-=log($param{YDiv})/log($param{YLog});
		$param{YEnd}-=log($param{YDiv})/log($param{YLog});
	}else{
		$param{YStart}/=$param{YDiv};
		$param{YEnd}/=$param{YDiv};
		$param{YStep}/=$param{YDiv};
	}
}
if ($param{YNeedLog}) {
	if ($param{YStart}<=0 || $param{YEnd}<=0 || $param{YStep}<=0) {
		if ($param{MultiY}) {
		}else{
			error("YStart,YEnd and YStep must bigger than 0!") ;
		}
	}else{
		$step = rint(($param{YEnd}-$param{YStart})/$param{YStep});
		$param{YStart}=log($param{YStart})/log($param{YNeedLog});
		$param{YEnd}=log($param{YEnd})/log($param{YNeedLog});
		$param{YStep}=availDigit(($param{YEnd}-$param{YStart})/$step,$param{AvailDigit},1,$param{YLog});
	}
}
if (exists($param{YMove}) && !exists($param{YZeroPos})) {
	$param{YZeroPos}=(-$param{YStart}+$param{YStep}*$param{YMove})/($param{YEnd}-$param{YStart});
}
if ($param{YStart}!=0 && !exists($param{YZeroPos}) && !exists($param{YZeroVal})) {
	$param{YZeroVal}=$param{YStart};
}
###RY
if ($param{BothYAxis}) {
	if ($param{RYDiv}) {
		if ($param{RYLog} && !$param{RYNeedLog}) {
			$param{RYStart}-=log($param{RYDiv})/log($param{RYLog});
			$param{RYEnd}-=log($param{RYDiv})/log($param{RYLog});
		}else{
			$param{RYStart}/=$param{RYDiv};
			$param{RYEnd}/=$param{RYDiv};
			$param{RYStep}/=$param{RYDiv};
		}
	}
	if ($param{RYNeedLog}) {
		if ($param{RYStart}<=0 || $param{RYEnd}<=0 || $param{YStep}<=0) {
			if ($param{MultiRY}) {
			}else{
				error ("RYStart,RYEnd and RYStep must bigger than 0!");
			}
		}else{
			$step = rint(($param{RYEnd}-$param{RYStart})/$param{RYStep});
			$param{RYStart}=log($param{RYStart})/log($param{RYNeedLog});
			$param{RYEnd}=log($param{RYEnd})/log($param{RYNeedLog});
			$param{RYStep}=availDigit(($param{RYEnd}-$param{RYStart})/$step,$param{AvailDigit},1,$param{RYLog});
		}
	}
	if (exists($param{RYMove}) && !exists($param{RYZeroPos})) {
		$param{RYZeroPos}=(-$param{RYStart}+$param{RYStep}*$param{RYMove})/($param{RYEnd}-$param{RYStart});
	}
	if ($param{RYStart}!=0 && !exists($param{RYZeroPos}) && !exists($param{RYZeroVal})) {
		$param{RYZeroVal}=$param{RYStart};
	}
}
###
if ($param{FontBold}) {
	$d{font}{'font-weight'}='bold';
}

$param{XZeroPos}=f($param{XZeroPos}) if (exists($param{XZeroPos}));
$param{YZeroPos}=f($param{YZeroPos}) if (exists($param{YZeroPos}));
$param{MarkPos}= ($param{MarkPos} ? $param{MarkPos} : 'right');
$param{MarkStyle}= ($param{MarkStyle} ? $param{MarkStyle} : 'v');
$param{MarkNoBorder}= ($param{MarkNoBorder} ? $param{MarkNoBorder} : 0);
$param{Mark2Pos}= ($param{Mark2Pos} ? $param{Mark2Pos} : 'left');
$param{Mark2Border}= ($param{Mark2Border} ? $param{Mark2Border} : 0);
$param{PointSize}= ($param{PointSize} ? $param{PointSize} : 5);
$param{XScaleDiv}= ($param{XScaleDiv} ? $param{XScaleDiv} : 1);
$param{YScaleDiv}= ($param{YScaleDiv} ? $param{YScaleDiv} : 1);
$param{XDispStep}= ($param{XDispStep} ? $param{XDispStep} : 1);
$param{YDispStep}= ($param{YDispStep} ? $param{YDispStep} : 1);
$param{WholeScale}= ($param{WholeScale} ? $param{WholeScale} : 1);
$param{Align}= ($param{Align} ? $param{Align} : 'C');
$param{Y}=~ s/([$SPECIAL_CHAR])/sprintf("&#%d;", ord($1))/ge; 
$param{X}=~ s/([$SPECIAL_CHAR])/sprintf("&#%d;", ord($1))/ge; 
$param{Note}=~ s/([$SPECIAL_CHAR])/sprintf("&#%d;", ord($1))/ge;
if ($param{BothYAxis}) {
	$param{RY}=~ s/([$SPECIAL_CHAR])/sprintf("&#%d;", ord($1))/ge;
	$param{RYZeroPos}=f($param{RYZeroPos}) if (exists($param{RYZeroPos}));
	$param{RYScaleDiv}= ($param{RYScaleDiv} ? $param{RYScaleDiv} : 1);
	$param{RYDispStep}= ($param{RYDispStep} ? $param{RYDispStep} : 1);
}
#####################################################################################################################
#	SET
#####################################################################################################################
if ($pp) {
	$d{font}{fill}='#F0F000';
}
$MARK_SCALE=$param{MarkScale} if ($param{MarkScale} ne '' && $param{MarkScale}>0);
$MARK2_SCALE=$param{Mark2Scale} if ($param{Mark2Scale} ne '' && $param{Mark2Scale}>0);
$SCALELEN=$param{ScaleLen} if ($param{ScaleLen});
$noConnect=(($param{NoLine} || $param{NoConnect})? 1 : 0);

setFontSize(sprintf("%.2f",$param{FontSize})) if ($param{FontSize} != 0);
if ($param{FontFamily} ne '') {
	$param{FontFamily}=~/^\s*(.+?)\s*$/;
	$d{font}{'font-family'}=$1;
	#print "\"$d{font}{'font-family'}\"\n";
}
$g->setFontSize($d{font}{'font-size'});
$g->setFontFamily($d{font}{'font-family'});
$g->setFontColor($d{font}{fill});
$g->setCharSpacing(0);
$g->setWordSpacing(0);

$param{XEnd}+=$param{XUnit}*uint($param{XScaleLinePos},1);	###???
$xDiv=($param{XEnd}-$param{XStart})/($param{XStep} ? $param{XStep}:($param{XUnit} ? $param{XUnit}:1));
$yDiv=($param{YEnd}-$param{YStart})/($param{YStep} ? $param{YStep}:1);
if ($param{BothYAxis}) {
	$ryDiv=($param{RYEnd}-$param{RYStart})/($param{RYStep} ? $param{RYStep}:1);
}
$realCh=$d{font}{'font-size'};
$ch=$CHRH*$realCh;
$realScaleCh=$param{ScaleFontSize} ? sprintf("%.2f",$param{ScaleFontSize}) : $d{font}{'font-size'};
$scaleCh=$CHRH*$realScaleCh;
$xFontSpace=$XSPACE/$DEFAULT_FONT_SIZE*$realCh;
$yFontSpace=$YSPACE/$DEFAULT_FONT_SIZE*$realCh;
$rect{top}=$YOFFSET+$ch+$yFontSpace*7;
$rect{width}=int($param{Width});
$rect{height}=int($param{Height});

$colWidth=$rect{width}/($param{XEnd}-$param{XStart})*$param{XUnit};		#单位宽度
$xZero=$rect{width}*$param{XZeroPos}+$colWidth*$param{XScaleLinePos};
$yZero=$rect{height}*$param{YZeroPos};
$xDDigits=10**$param{XDDigits};
$yDDigits=10**$param{YDDigits};
if ($param{BothYAxis}) {
	$ryZero=$rect{height}*$param{RYZeroPos};
	$ryDDigits=10**$param{RYDDigits};
}

$yMlen=$ryMlen=0;
setFontSize($realScaleCh);
$tmp=max(txtWidth(int($param{YEnd})),txtWidth(int($param{YStart})));
if ($maxYScale ne '') {
	$yMlen=txtWidth($maxYScale);
}elsif ($param{YNum} && $param{YExp}==1) {
	$yMlen=txtWidth(d($param{YNum}));
	#print "$yMlen\n";
}elsif ($param{YExp}!=1) {
	$yMlen=txtWidth(d($param{YExp}))+txtWidth(d($param{YNum}) ? d($param{YNum}) : '9')*5/9;
}elsif ($param{YLog}) {
	$yMlen=txtWidth(int($param{YLog}**$param{YEnd}));
#}elsif ($param{YNeedLog}) {
#	$yMlen=($tmp>txtWidth(d($param{YStep})) ? $tmp : txtWidth(d($param{YStep})));
}else{
	$yMlen=($tmp>txtWidth(d($param{YStep})) ? $tmp : txtWidth(d($param{YStep})));
}

$tmp=max(txtWidth(int($param{RYEnd})),txtWidth(int($param{RYStart})));
if ($param{BothYAxis}) {
	if ($maxRYScale ne '') {
		$ryMlen=txtWidth($maxRYScale);
	}elsif ($param{RYNum} && $param{RYExp}==1) {
		$ryMlen=txtWidth($param{RYNum});
	}elsif ($param{RYExp}!=1) {
		$ryMlen=txtWidth($param{RYExp})+txtWidth($param{RYNum} ? $param{RYNum} : '9')*5/9;
	}elsif ($param{RYLog}) {
		$ryMlen=txtWidth(int($param{RYLog}**$param{RYEnd}));
	}else{
		$ryMlen=($tmp>txtWidth($param{RYStep}) ? $tmp : txtWidth($param{RYStep}));
	}
}
#revFontSize();

if ($autofit) {
	$rect{left}=$XOFFSET+$ch+$xFontSpace*5;
	$rect{left}+=$yMlen;
	$rect{left}+=max((txtWidth($param{Note}) < ($rect{width}+$rect{left}*2) ? 0 : ((txtWidth($param{Note})-$rect{width})/2-$rect{left})),
				 (txtWidth($param{X}) < ($rect{width}+$rect{left}*2) ? 0 : ((txtWidth($param{X})-$rect{width})/2-$rect{left})));
	#print "$yMlen\t$rect{left}\n";
}else{
	$rect{left}=$XOFFSET*5+$ch+$xFontSpace*20;
}
if ($autofit) {
	my ($tmp1,$tmp2,$maxx,$xmk);
	$rect{blank}=$rect{right}=$XOFFSET+$xFontSpace*5;
	$tmp1=max((txtWidth($param{Note}) < ($rect{width}+$rect{right}*2) ? 0 : ((txtWidth($param{Note})-$rect{width})/2-($rect{right}-$XOFFSET))),
				  (txtWidth($param{X}) < ($rect{width}+$rect{right}*2) ? 0 : ((txtWidth($param{X})-$rect{width})/2-($rect{right}-$XOFFSET))));
	#print "$rect{right}\t";
	$maxx=0;
	for (my $i=0;$i<=4*$xDiv;$i++) {
		foreach (($i,-$i)) {
			$x = $xZero+$_*($rect{width}/$xDiv);
			$xmk=$_*$param{XStep}+$param{XZeroVal};
			if ($param{XLog}) {
				$xmk=availDigit($param{XLog}**$xmk,$param{AvailDigit},1,$param{XLog});
			}
			if (!($i % $param{XDispStep})) {
				if ($param{XExp}!=1) {
					if ($xmk) {
						$tmp=log($xmk)/log($param{XExp});
					}else{
						$tmp=0;
					}
					$xmk=rint($tmp,1/$xDDigits);# if (exists($param{XDDigits}));
					if ($param{XLog}) {
						$x=$xZero
							+((log($param{XExp}**$xmk)/log($param{XLog}))-$param{XZeroVal})/$param{XStep}
							*($rect{width}/$xDiv);
					}else{
						$x=$xZero
							+($param{XExp}**$xmk-$param{XZeroVal})/$param{XStep}
							*($rect{width}/$xDiv);
					}
				}else{
					if ($param{XLog}) {
						$xmk=rint($xmk,1/$xDDigits) if (exists($param{XDDigits}));
						next if (!$xmk);
						$x=$xZero
							+((log($xmk)/log($param{XLog}))-$param{XZeroVal})/$param{XStep}
							*($rect{width}/$xDiv);
					}elsif (exists($param{XDDigits})) {
						$xmk=rint($xmk,1/$xDDigits);
						$x=$xZero
							+($xmk-$param{XZeroVal})/$param{XStep}
							*($rect{width}/$xDiv);
					}
				}
				$x=cut($x);
				next if ($x<0);
				next if ($x>$rect{width}-$param{MovePer}*$colWidth);
				$maxx=$x if ($maxx<$x);
			}
		}
	}
	if ($param{XExp}) {
		$tmp2=(txtWidth($xmk)*5/9+txtWidth($param{XExp}))/2+txtWidth('+');
	}else{
		$tmp2=txtWidth($xmk)/2+txtWidth('+');
	}
	$tmp2=$maxx+$tmp2-$rect{width};
	$tmp=max($tmp1,$tmp2);
	if ($param{BothYAxis}) {
		$rect{right}+=max($tmp,$ryMlen+$ch+$xFontSpace);
		$rect{blank}=$ryMlen+$ch+$xFontSpace;
		#print "$ryMlen\n";
	}else{
		$rect{right}+=$tmp;
	}
	#print "$raw{XEnd}\t$param{XEnd}\t$rect{right}\n";
}else{
	$rect{blank}=$rect{right}=$XOFFSET*10;
	if ($param{BothYAxis}) {
		$rect{right}+=$rect{left}-$XOFFSET*6;
	}
}
$vbW=$rect{width}+$rect{left}+$rect{right};
if ($param{MarkPos}=~/o/i) {	#图示放外面
	my ($fpos,$ww,$chNum,$tmp,$tmp2);
	$fpos=tell(F);
	$ww=0;
	$chNum=5;
	while (<F>) {
		s/\cM*$//;
		chomp;
		if (/^\s*Mark:(.+)$/) {
			$tmp=$1;
			if ($tmp ne '') {
				if ($param{MarkStyle}=~/^[hH]/) {
					$ww+=txtWidth($tmp)+txtWidth(' ' x ($chNum+2));
				}else{
					$tmp2=txtWidth($tmp)+txtWidth(' ' x ($chNum+1));
					$ww=$tmp2 if ($ww < $tmp2);
				}
			}
		}
	}
	$ww+=$xFontSpace*6;
	$ww*=$MARK_SCALE;
 	seek(F,$fpos,0);
	$vbW+=$ww+2*($SCALELEN+$xFontSpace);
}
$maxXScale=$param{XEnd} if ($maxXScale eq '');
#setFontSize($realScaleCh);
$vbH=$rect{height}+$rect{top}+$ch
		+($param{XScaleRoate} ? $scaleCh/2*cos($param{XScaleRoate}/180*$PI) : $scaleCh)
		+txtWidth($maxXScale)*sin($param{XScaleRoate}/180*$PI);#+$YOFFSET;
if (@group) {
	$vbH+=txtWidth('  ')*sin($param{XScaleRoate}/180*$PI)+$scaleCh+$yFontSpace*4;
}
revFontSize();

#	反赋值小写参数
foreach (@keys) {
	if (exists($param{$_})) {
		$param{lc($_)}=$param{$_};
	}
}
#####################################################################################################################
#	画图
#####################################################################################################################

$g->b("svg","viewBox",
	  "0 0 ".($vbW*$param{WholeScale})." ".(($vbH+$ch*@note)*$param{WholeScale}),
	  "width",$vbW*$param{WholeScale},
	  "height",($vbH+($ch+$yFontSpace)*@note+$yFontSpace*15)*$param{WholeScale});
$g->svgPrint("\n<Author>Li Shengting</Author>");
$g->svgPrint("\n<E-mail>lishengting\@genomics.org.cn</E-mail>");
$g->svgPrint("\n<Version>$ver</Version>");
my $drawer=getlogin()."@".(`hostname`);
chomp $drawer;
$g->svgPrint("\n<Drawer>$drawer</Drawer>");
$g->svgPrint("\n<Date>".(localtime())."</Date>");
$g->b("g","transform","scale($param{WholeScale})",'xml:space',"preserve");

$g->b("g","transform","translate(".$rect{left}.",".$rect{top}.")");

if ($pp) {
	$d{rect}{fill}='#DDDDDD';
	$d{rect}{stroke}='none';
	$g->d("rect","xval",0,"yval",0,"width",$rect{width},"height",$rect{height},"style",style($d{rect}));
}
#$g->b('clipPath', 'id', 'RectClip');
	#$g->d("rect","xval",0,"yval",0,"width",$rect{width},"height",$rect{height});
#$g->e();  
if ($param{LinearGradient}) {
	my (@tmp1,@tmp2,$horizontal);
	@tmp1=split(/\|/,$param{LinearGradient});
	@tmp2=split(/;/,$tmp1[1]);
	if (@tmp2<2) {
		error("LinearGradient must have more than two stops!",1);
	}else{
		$g->b("defs");
		$horizontal=0;
		if ($tmp1[0]=~/^H/) {
			$horizontal=1;
		}
			$g->b("linearGradient","id","LG","x1",0,"y1",0,"x2",$horizontal,"y2",1-$horizontal);
				foreach (@tmp2) {
					@tmp1=split(/:/,$_);
					$g->d("stop","offset",($tmp1[0]<1 ? $tmp1[0] : $tmp1[0]."%"),"style","stop-color:".$tmp1[1]);
				}
			$g->e();
		$g->e();
		$param{LG}="LG";
	}
}
if (!$imagetop) {
	drawImage();
}

#####################################################################################################################
#	画横纵坐标
#####################################################################################################################
#print "Ok2!\n";
$d{path}{stroke}='#000000';
$d{path}{fill}='none';
$d{path}{'stroke-width'}=$STROKE_WIDTH;

my ($xMark,$yMark,$ryMark,$num,$sNum);
my ($tmp1,$tmp2,$mvOff,$yZeroVal,$yStep,$ryZeroVal,$ryStep);
setFontSize($realScaleCh);
#############
#	Y
#############
$x= - $xFontSpace*2 - $STROKE_WIDTH/2;
$yZeroVal=$param{YZeroVal};
$yStep=$param{YStep};
$sNum=@y;
$num=0;
while (1) {
	if ($param{MultiY}) {
		$yStep=$y[0]{Step};
		$yZeroVal=$y[0]{ZeroVal};
		$yDiv=($y[0]{End}-$yZeroVal)/($yStep ? $yStep:1);
		error ("MultiY usage wrong!") if (!$yDiv);
	}
	for (my $i=0;$i<=4*$yDiv*$param{YScaleDiv};$i++) {
		foreach (($i/$param{YScaleDiv},-$i/$param{YScaleDiv})) {
			$y = $yZero+$_*($rect{height}/$yDiv);
			#print "$y\n";
			if (!($i % $param{YScaleDiv})) {	#大坐标
				$yMark=$_*$yStep+$yZeroVal;
				if ($param{YLog}) {
					$yMark=availDigit($param{YLog}**$yMark,$param{AvailDigit},1,$param{YLog});
				}
				if (!($i % $param{YDispStep})) {
					if ($param{YExp}!=1) {
						#print "$yMark\t$param{YExp}\n";
						if ($yMark) {
							$tmp=log($yMark)/log($param{YExp});
						}else{
							$tmp=0;
						}
						$yMark=rint($tmp,1/$yDDigits);# if (exists($param{YDDigits}));
						if ($param{YLog}) {
							$y=$yZero
								+((log($param{YExp}**$yMark)/log($param{YLog}))-$yZeroVal)/$yStep
								*($rect{height}/$yDiv);
						}else{
							$y=$yZero
								+($param{YExp}**$yMark-$yZeroVal)/$yStep
								*($rect{height}/$yDiv);
						}
						$y=cut($y);
						next if ($y<0);
						next if ($y>$rect{height});
						$y=$rect{height}-$y;
						#$yMark=$param{YExp}."<tspan dy=-$scaleCh transform=\"scale($EXP_SCALE)\" >".$yMark."</tspan>";
						if (!$param{NoYScale}) {
							setFontSize($d{font}{'font-size'}*5/9);
							$mvOff=txtWidth($yMark);
							$g->d("txtRB",($yMark),
								  "xval",$x,"yval",$y,"style",style($d{font}));#,"onclick","alert('y:$tmp')");
							#$y+=$scaleCh*$EXP_SCALE;
							revFontSize();
							#print ";;;$y+$mvOff\n";
							$g->d("txtRM",$param{YExp},
								"xval",$x-$mvOff,"yval",$y,"style",style($d{font}));#,"onclick","alert('y:$tmp')");
						}
					}else{
						if ($param{YLog}) {
							$yMark=rint($yMark,1/$yDDigits) if (exists($param{YDDigits}));
							next if (!$yMark);
							$y=$yZero
								+((log($yMark)/log($param{YLog}))-$yZeroVal)/$yStep
								*($rect{height}/$yDiv);
						}elsif (exists($param{YDDigits})) {
							$yMark=rint($yMark,1/$yDDigits);
							$y=$yZero
								+($yMark-$yZeroVal)/$yStep
								*($rect{height}/$yDiv);
						}
						$y=cut($y);
						next if ($y<0);
						next if ($y>$rect{height});
						$y=$rect{height}-$y;
						if (@yScale && @{$yScale[0]}) {
							#$yMark=$yScale[0][$i / $param{YScaleDiv}];
							$yMark=shift(@{$yScale[0]});
							push @{$yScale[0]}, $yMark;
							$yMark=~ s/([$SPECIAL_CHAR])/sprintf("&#%d;", ord($1))/ge;
						}
						if (!$param{NoYScale}) {
							if ($param{MultiY}) {
								$tmp=$d{font}{fill};
								$d{font}{fill}=$y[0]{Color};
								$g->d("txtRM",($yMark),
									  "xval",$x,"yval",$y-$param{YScalePos}*($rect{height}/$yDiv)+($num-$sNum/2+0.5)*($realScaleCh)-$yFontSpace*3,"style",style($d{font}));#,"onclick","alert('y:$tmp')");
								$d{font}{fill}=$tmp;
							}else{
								$g->d("txtRM",($yMark),
									  "xval",$x,"yval",$y-$param{YScalePos}*($rect{height}/$yDiv)-$yFontSpace*3,"style",style($d{font}));#,"onclick","alert('y:$tmp')");
							}
						}
					}
				}else{
					$y=$rect{height}-$y;
					$y=cut($y);
					next if ($y<0);
					next if ($y>$rect{height});
				}
				if (!$param{NoScaleLine} && !$param{NoYScale}) {
					$g->d("line","x1",0,"y1",f($y),"x2",$SCALELEN,"y2",f($y),"style",style($d{path}));
					if (!$param{BothYAxis}) {
						$g->d("line","x1",$rect{width},"y1",f($y),"x2",$rect{width}-$SCALELEN,"y2",f($y),"style",style($d{path}));
					}
				}
			}else{								#小坐标
				if ($param{YLog}) {
					$tmp1=uint($_-1)*$yStep+$yZeroVal;
					$tmp1=availDigit($param{YLog}**$tmp1,$param{AvailDigit},1,$param{YLog});
					$tmp2=uint($_)*$yStep+$yZeroVal;
					$tmp2=availDigit($param{YLog}**$tmp2,$param{AvailDigit},1,$param{YLog});
					$tmp=($tmp2-$tmp1)/$param{YScaleDiv};
					$yMark=$tmp1+$tmp*($i % $param{YScaleDiv});
					if ($param{YExp}!=1) {
						$tmp1=rint(log($tmp1)/log($param{YExp}),1/$yDDigits);
						$tmp2=rint(log($tmp2)/log($param{YExp}),1/$yDDigits);
						$tmp=($param{YExp}**$tmp2-$param{YExp}**$tmp1)/$param{YScaleDiv};
						$yMark=$param{YExp}**$tmp1+$tmp*($i % $param{YScaleDiv});
					}
					#$tmp=$_*$yStep+$yZeroVal;
					#$y-=($tmp-log($yMark)/log(10))/$yStep*($rect{width}/$yDiv); #单位宽 ($rect{width}/$yDiv)/$yStep
					$y=$yZero
						+((log($yMark)/log($param{YLog}))-$yZeroVal)/$yStep
						*($rect{height}/$yDiv);
				}else{
					if ($param{YExp}!=1) {
						$tmp1=uint($_-1)*$yStep+$yZeroVal;
						$tmp2=uint($_)*$yStep+$yZeroVal;
						$tmp1=rint(log($tmp1)/log($param{YExp}),1/$yDDigits);
						$tmp2=rint(log($tmp2)/log($param{YExp}),1/$yDDigits);
						$tmp=($param{YExp}**$tmp2-$param{YExp}**$tmp1)/$param{YScaleDiv};
						$yMark=$param{YExp}**$tmp1+$tmp*($i % $param{YScaleDiv});
					}
				}
				$y=cut($y);
				next if ($y<0);
				next if ($y>$rect{height});
				$y=$rect{height}-$y;
				if (!$param{NoScaleLine} && !$param{NoYScale}) {
					$g->d("line","x1",0,"y1",f($y),"x2",$SCALELEN/2,"y2",f($y),"style",style($d{path}));
					if (!$param{BothYAxis}) {
						$g->d("line","x1",$rect{width},"y1",f($y),"x2",$rect{width}-$SCALELEN/2,"y2",f($y),"style",style($d{path}));
					}
				}
			}
			last if ($_==0);
		}
	}
	shift (@y);
	shift (@yScale);
	last if (@y==0);
	$num++;
}
#############
#	RY
#############
$x= $rect{width} + $xFontSpace*2 + $STROKE_WIDTH/2;
$ryZeroVal=$param{RYZeroVal};
$ryStep=$param{RYStep};
$sNum=@ry;
$num=0;
if ($param{BothYAxis}) {
	while (1) {
		if ($param{MultiRY}) {
			$ryStep=$ry[0]{Step};
			$ryZeroVal=$ry[0]{ZeroVal};
			$ryDiv=($ry[0]{End}-$ry[0]{Start})/($ryStep ? $ryStep:1);
			#print"$ryStep\t$ryZeroVal\t$ryDiv\n";
			error ("MultiRY usage wrong!") if (!$ryDiv);
		}
		for (my $i=0;$i<=4*$ryDiv*$param{RYScaleDiv};$i++) {
			foreach (($i/$param{RYScaleDiv},-$i/$param{RYScaleDiv})) {
				$ry = $ryZero+$_*($rect{height}/$ryDiv);
				#print "$ry\n";
				if (!($i % $param{RYScaleDiv})) {	#大坐标
					$ryMark=$_*$ryStep+$ryZeroVal;
					if ($param{RYLog}) {
						$ryMark=availDigit($param{RYLog}**$ryMark,$param{AvailDigit},1,$param{RYLog});
					}
					#print "$ryMark\n";
					if (!($i % $param{RYDispStep})) {
						if ($param{RYExp}!=1) {
							if ($ryMark) {
								$tmp=log($ryMark)/log($param{RYExp});
							}else{
								$tmp=0;
							}
							$ryMark=rint($tmp,1/$ryDDigits);# if (exists($param{RYDDigits}));
							if ($param{RYLog}) {
								$ry=$ryZero
									+((log($param{RYExp}**$ryMark)/log($param{RYLog}))-$ryZeroVal)/$ryStep
									*($rect{height}/$ryDiv);
							}else{
								$ry=$ryZero
									+($param{RYExp}**$ryMark-$ryZeroVal)/$ryStep
									*($rect{height}/$ryDiv);
							}
							$ry=cut($ry);
							next if ($ry<0);
							next if ($ry>$rect{height});
							$ry=$rect{height}-$ry;
							#$ryMark=$param{RYExp}."<tspan dy=-$scaleCh transform=\"scale($EXP_SCALE)\" >".$ryMark."</tspan>";
							$mvOff=txtWidth($param{RYExp});
							setFontSize($d{font}{'font-size'}*5/9);
							$g->d("txtLB",($ryMark),
								  "xval",$x+$mvOff,"yval",$ry,"style",style($d{font}));#,"onclick","alert('y:$tmp')");
							#$ry+=$scaleCh*$EXP_SCALE;
							revFontSize();
							#print ";;;$ry+$mvOff\n";
							$g->d("txtLM",$param{RYExp},
								"xval",$x,"yval",$ry,"style",style($d{font}));#,"onclick","alert('y:$tmp')");
						}else{
							if ($param{RYLog}) {
								$ryMark=rint($ryMark,1/$ryDDigits) if (exists($param{RYDDigits}));
								next if (!$ryMark);
								$ry=$ryZero
									+((log($ryMark)/log($param{RYLog}))-$ryZeroVal)/$ryStep
									*($rect{height}/$ryDiv);
							}elsif (exists($param{RYDDigits})) {
								$ryMark=rint($ryMark,1/$ryDDigits);
								$ry=$ryZero
									+($ryMark-$ryZeroVal)/$ryStep
									*($rect{height}/$ryDiv);
							}
							$ry=cut($ry);
							next if ($ry<0);
							next if ($ry>$rect{height});
							$ry=$rect{height}-$ry;
							if (@ryScale && @{$ryScale[0]}) {
								#$ryMark=$ryScale[0][$i / $param{RYScaleDiv}];
								$ryMark=shift(@{$ryScale[0]});
								push @{$ryScale[0]}, $ryMark;
								$ryMark=~ s/([$SPECIAL_CHAR])/sprintf("&#%d;", ord($1))/ge;
							}
							if ($param{MultiRY}) {
								$tmp=$d{font}{fill};
								$d{font}{fill}=$ry[0]{Color};
								$g->d("txtLM",($ryMark),
									  "xval",$x,"yval",$ry-$param{RYScalePos}*($rect{height}/$ryDiv)+($num-$sNum/2+0.5)*($realScaleCh)-$yFontSpace*3,"style",style($d{font}));#,"onclick","alert('y:$tmp')");
								$d{font}{fill}=$tmp;
							}else{
								$g->d("txtLM",($ryMark),
									  "xval",$x,"yval",$ry-$param{RYScalePos}*($rect{height}/$ryDiv)-$yFontSpace*3,"style",style($d{font}));#,"onclick","alert('y:$tmp')");
							}
						}
					}else{
						$ry=$rect{height}-$ry;
						$ry=cut($ry);
						next if ($ry<0);
						next if ($ry>$rect{height});
					}
					$g->d("line","x1",$rect{width},"y1",f($ry),"x2",$rect{width}-$SCALELEN,"y2",f($ry),"style",style($d{path})) if !$param{NoScaleLine};
				}else{								#小坐标
					if ($param{RYLog}) {
						$tmp1=uint($_-1)*$ryStep+$ryZeroVal;
						$tmp1=availDigit($param{RYLog}**$tmp1,$param{AvailDigit},1,$param{RYLog});
						$tmp2=uint($_)*$ryStep+$ryZeroVal;
						$tmp2=availDigit($param{RYLog}**$tmp2,$param{AvailDigit},1,$param{RYLog});
						$tmp=($tmp2-$tmp1)/$param{RYScaleDiv};
						$ryMark=$tmp1+$tmp*($i % $param{RYScaleDiv});
						if ($param{RYExp}!=1) {
							$tmp1=rint(log($tmp1)/log($param{RYExp}),1/$ryDDigits);
							$tmp2=rint(log($tmp2)/log($param{RYExp}),1/$ryDDigits);
							$tmp=($param{RYExp}**$tmp2-$param{RYExp}**$tmp1)/$param{RYScaleDiv};
							$ryMark=$param{RYExp}**$tmp1+$tmp*($i % $param{RYScaleDiv});
						}
						#$tmp=$_*$ryStep+$ryZeroVal;
						#$ry-=($tmp-log($ryMark)/log(10))/$ryStep*($rect{width}/$ryDiv); #单位宽 ($rect{width}/$ryDiv)/$ryStep
						$ry=$ryZero
							+((log($ryMark)/log($param{RYLog}))-$ryZeroVal)/$ryStep
							*($rect{height}/$ryDiv);
					}else{
						if ($param{RYExp}!=1) {
							$tmp1=uint($_-1)*$ryStep+$ryZeroVal;
							$tmp2=uint($_)*$ryStep+$ryZeroVal;
							$tmp1=rint(log($tmp1)/log($param{RYExp}),1/$ryDDigits);
							$tmp2=rint(log($tmp2)/log($param{RYExp}),1/$ryDDigits);
							$tmp=($param{RYExp}**$tmp2-$param{RYExp}**$tmp1)/$param{RYScaleDiv};
							$ryMark=$param{RYExp}**$tmp1+$tmp*($i % $param{RYScaleDiv});
						}
					}
					$ry=cut($ry);
					next if ($ry<0);
					next if ($ry>$rect{height});
					$ry=$rect{height}-$ry;
					$g->d("line","x1",$rect{width},"y1",f($ry),"x2",$rect{width}-$SCALELEN/2,"y2",f($ry),"style",style($d{path})) if !$param{NoScaleLine};
				}
				last if ($_==0);
			}
		}
		shift (@ry);
		shift (@ryScale);
		last if (@ry==0);
		$num++;
	}
}

#############
#	X
#############
$y=$rect{height} + $yFontSpace*2 + $STROKE_WIDTH/2;
for (my $i=0;$i<=4*$xDiv*$param{XScaleDiv};$i++) {
	foreach (($i/$param{XScaleDiv},-$i/$param{XScaleDiv})) {
		$x = $xZero+$_*($rect{width}/$xDiv);
		#print "$_\t$x\n";
		if (!($i % $param{XScaleDiv})) {	#大坐标
			$xMark=$_*$param{XStep}+$param{XZeroVal};
			if ($param{XLog}) {
				$xMark=availDigit($param{XLog}**$xMark,$param{AvailDigit},1,$param{XLog});
			}
			if (!($i % $param{XDispStep})) {
				if ($param{XExp}!=1) {
					if ($xMark) {
						$tmp=log($xMark)/log($param{XExp});
					}else{
						$tmp=0;
					}
					$xMark=rint($tmp,1/$xDDigits);# if (exists($param{XDDigits}));
					if ($param{XLog}) {
						$x=$xZero
							+((log($param{XExp}**$xMark)/log($param{XLog}))-$param{XZeroVal})/$param{XStep}
							*($rect{width}/$xDiv);
					}else{
						$x=$xZero
							+($param{XExp}**$xMark-$param{XZeroVal})/$param{XStep}
							*($rect{width}/$xDiv);
					}
					$x=cut($x);
					next if ($x<0);
					next if ($x>$rect{width}-$param{MovePer}*$colWidth);
					#print "$xMark\n";
					#$xMark=$param{XExp}."<tspan dy=-$scaleCh transform=\"scale($EXP_SCALE)\" >".$xMark."</tspan>";
					if (!$param{NoXScale}) {
						$mvOff=txtWidth('10');
						setFontSize($d{font}{'font-size'}*5/9);
						$mvOff-=txtWidth($xMark);
						$mvOff/=2;
						$g->d("txtLT",($xMark)
									 .((!$param{XZeroPos} && $param{HaveLess} && 
									   ($xZero+($_-1)*($rect{width}/$xDiv)) < 0) ? '-' : '')
									 .((!$param{XZeroPos} && $param{HaveMore} && 
									   ($xZero+($_+1)*($rect{width}/$xDiv)) > $rect{width}-$param{MovePer}*$colWidth) ? '+' : ''),
							"xval",$x+$mvOff+$param{XScalePos}*($rect{width}/$xDiv),"yval",$y,"style",style($d{font}));#,"onclick","alert('x:$tmp')");
						#$y+=$scaleCh*$EXP_SCALE;
						revFontSize();
						#print ";;;$x+$mvOff\n";
						$g->d("txtRT",$param{XExp},
							"xval",$x+$mvOff+$param{XScalePos}*($rect{width}/$xDiv),"yval",$y,"style",style($d{font}));#,"onclick","alert('x:$tmp')");
					}
				}else{
					#print "$xMark\t";
					if ($param{XLog}) {
						$xMark=rint($xMark,1/$xDDigits) if (exists($param{XDDigits}));
						next if (!$xMark);
						$x=$xZero
							+((log($xMark)/log($param{XLog}))-$param{XZeroVal})/$param{XStep}
							*($rect{width}/$xDiv);
					}elsif (exists($param{XDDigits})) {
						$xMark=rint($xMark,1/$xDDigits);
						$x=$xZero
							+($xMark-$param{XZeroVal})/$param{XStep}
							*($rect{width}/$xDiv);
					}
					$x=cut($x);
					next if ($x<0);
					next if ($x>$rect{width}-$param{MovePer}*$colWidth);
					if (@xScale) {
						$xMark=$xScale[$i / $param{XScaleDiv}];
						$xMark=shift(@xScale);
						push @xScale, $xMark;
						$xMark=~ s/([$SPECIAL_CHAR])/sprintf("&#%d;", ord($1))/ge;
					}
					#print "$xMark\n";
					if (!$param{NoXScale}) {
						if ($param{XScaleRoate}) {
							$g->d("txtRM",($xMark)
										 .((!$param{XZeroPos} && $param{HaveLess} && 
										   ($xZero+($_-1)*($rect{width}/$xDiv)) < 0) ? '-' : '')
										 .((!$param{XZeroPos} && $param{HaveMore} && 
										   ($xZero+($_+1)*($rect{width}/$xDiv)) > $rect{width}-$param{MovePer}*$colWidth) ? '+' : ''),
								"xval",0,"yval",0,"transform","translate(".($x+$param{XScalePos}*($rect{width}/$xDiv)).",$y) rotate(-$param{XScaleRoate})","style",style($d{font}));#,"onclick","alert('x:$tmp')");
							if (@group) {
								#print int($i / $param{XScaleDiv})."\t$xMark\n";
								$gxy[$i / $param{XScaleDiv}]{x}=($x+$param{XScalePos}*($rect{width}/$xDiv))-txtWidth("  ".$xMark)*cos($param{XScaleRoate}/180*$PI)+$scaleCh/5*sin($param{XScaleRoate}/180*$PI);
								$gxy[$i / $param{XScaleDiv}]{y}=$y+txtWidth("  ".$xMark)*sin($param{XScaleRoate}/180*$PI)+$scaleCh/5*cos($param{XScaleRoate}/180*$PI);
							}
						}else{
							#print $xZero+($_+1)*($rect{width}/$xDiv),"\t",$rect{width},"\n";
							$g->d("txtCT",($xMark)
										 .((!$param{XZeroPos} && $param{HaveLess} && 
										   cut($xZero+($_-1)*($rect{width}/$xDiv)) < 0) ? '-' : '')
										 .((!$param{XZeroPos} && $param{HaveMore} && 
										   cut($xZero+($_+1)*($rect{width}/$xDiv)) > $rect{width}-$param{MovePer}*$colWidth) ? '+' : ''),
								"xval",$x+$param{XScalePos}*($rect{width}/$xDiv),"yval",$y,"style",style($d{font}));#,"onclick","alert('x:$tmp')");
							if (@group) {
								$gxy[$i / $param{XScaleDiv}]{x}=($x+$param{XScalePos}*($rect{width}/$xDiv));
								$gxy[$i / $param{XScaleDiv}]{y}=$y+$scaleCh+$yFontSpace*2+txtWidth(' ');
							}
						}
					}
				}
			}else{
				$x=cut($x);
				next if ($x<0);
				next if ($x>$rect{width}-$param{MovePer}*$colWidth);
			}
			if (!$param{NoScaleLine} && !$param{NoXScale}) {
				$g->d("line","x1",$x,"y1",$rect{height},"x2",$x,"y2",$rect{height}-$SCALELEN,"style",style($d{path}));#,"onclick","alert('x:$tmp')");
				$g->d("line","x1",$x,"y1",0,"x2",$x,"y2",$SCALELEN,"style",style($d{path}));#,"onclick","alert('x:$tmp')");
			}
		}else{								#小坐标
			if ($param{XLog}) {
				$tmp1=uint($_-1)*$param{XStep}+$param{XZeroVal};
				$tmp1=availDigit($param{XLog}**$tmp1,$param{AvailDigit},1,$param{XLog});
				$tmp2=uint($_)*$param{XStep}+$param{XZeroVal};
				$tmp2=availDigit($param{XLog}**$tmp2,$param{AvailDigit},1,$param{XLog});
				$tmp=($tmp2-$tmp1)/$param{XScaleDiv};
				$xMark=$tmp1+$tmp*($i % $param{XScaleDiv});
				if ($param{XExp}!=1) {
					$tmp1=rint(log($tmp1)/log($param{XExp}),1/$xDDigits);
					$tmp2=rint(log($tmp2)/log($param{XExp}),1/$xDDigits);
					$tmp=($param{XExp}**$tmp2-$param{XExp}**$tmp1)/$param{XScaleDiv};
					$xMark=$param{XExp}**$tmp1+$tmp*($i % $param{XScaleDiv});
				}
				#$tmp=$_*$param{XStep}+$param{XZeroVal};
				#$x-=($tmp-log($xMark)/log(10))/$param{XStep}*($rect{width}/$xDiv); #单位宽 ($rect{width}/$xDiv)/$param{XStep}
				$x=$xZero
					+((log($xMark)/log($param{XLog}))-$param{XZeroVal})/$param{XStep}
					*($rect{width}/$xDiv);
			}else{
				if ($param{XExp}!=1 && $_>0) {
					$tmp1=uint($_-1)*$param{XStep}+$param{XZeroVal};
					$tmp2=uint($_)*$param{XStep}+$param{XZeroVal};
					$tmp1=rint(log($tmp1)/log($param{XExp}),1/$xDDigits);
					$tmp2=rint(log($tmp2)/log($param{XExp}),1/$xDDigits);
					$tmp=($param{XExp}**$tmp2-$param{XExp}**$tmp1)/$param{XScaleDiv};
					$xMark=$param{XExp}**$tmp1+$tmp*($i % $param{XScaleDiv});
				}
			}
			$x=cut($x);
			next if ($x<0);
			next if ($x>$rect{width});
			if (!$param{NoScaleLine} && !$param{NoXScale}) {
				$g->d("line","x1",$x,"y1",$rect{height},"x2",$x,"y2",$rect{height}-$SCALELEN/2,"style",style($d{path}));#,"onclick","alert('x:$tmp')");
				$g->d("line","x1",$x,"y1",0,"x2",$x,"y2",$SCALELEN/2,"style",style($d{path}));#,"onclick","alert('x:$tmp')");
			}
		}
		last if ($_==0);
	}
}
###################
#	Group线
###################
if (@group) {
	my (@tmp,$angle,$maxY,$x,$y,$lastx,$lasty,$i);
	$angle=$param{XScaleRoate} ? $param{XScaleRoate} : 90;
	@tmp=sort {$a->{y}<=>$b->{y}} @gxy;
	$maxY=$tmp[$#tmp]{y}+$scaleCh/2*cos($angle/180*$PI);
	if ($pp) {
		$d{path}{stroke}='#F0F000';
	}
	$d{path}{'stroke-width'}=min($STROKE_WIDTH,$realScaleCh/3);
	#print map {"=>$_->{x}\t$_->{y}<=\n"} @gxy;
	foreach (@group) {
		$lastx=$gxy[0]{x}-($maxY-$gxy[0]{y})/sin($angle/180*$PI)*cos($angle/180*$PI);#左下角x
		$lasty=$maxY;#左下角y
		$g->d("line","x1",f($gxy[0]{x}+txtWidth(' ')*cos($angle/180*$PI)),"y1",f($gxy[0]{y}-txtWidth(' ')*sin($angle/180*$PI)),"x2",f($lastx),"y2",f($lasty),"style",style($d{path}));
		for ($i=0;$i<$_->{len}-1;$i++) {
			last if ($#gxy<=0);
			shift(@gxy);
		}
		$x=$gxy[0]{x}-($maxY-$gxy[0]{y})/sin($angle/180*$PI)*cos($angle/180*$PI);#右下角x
		$y=$maxY;#右下角y
		$g->d("line","x1",f($gxy[0]{x}+txtWidth(' ')*cos($angle/180*$PI)),"y1",f($gxy[0]{y}-txtWidth(' ')*sin($angle/180*$PI)),"x2",f($x),"y2",f($y),"style",style($d{path}));
		$g->d("line","x1",f($lastx),"y1",f($lasty),"x2",f($x),"y2",f($y),"style",style($d{path}));
		$g->d("txtCT",$_->{mark},
			  "xval",f(($lastx+$x)/2),
			  "yval",f($maxY+$yFontSpace),
			  "style",style($d{font}),
			 );
		shift(@gxy) if ($#gxy>0);
	}
	$d{rect}{'stroke-width'}=$STROKE_WIDTH;
}
revFontSize();
###################
#	边框线
###################
$d{rect}{fill}='none';
if (!$param{NoFrame}) {
	$d{rect}{stroke}='black';
	$d{rect}{'stroke-width'}=$STROKE_WIDTH;
}else{
	$d{rect}{stroke}='none';
}
$g->d("rect","xval",0,"yval",0,"width",$rect{width},"height",$rect{height},"style",style($d{rect}));
$g->e();
###################
#	注释2
###################
if (@note) {
	$g->b("g","transform","translate(".$XOFFSET.",".($vbH+$YOFFSET).") scale(1,1)");
	$d{font}{'font-family'}='ArialNarrow-Bold';
	for (my $i=0;$i<@note;$i++) {
		$note[$i]=~ s/([$SPECIAL_CHAR])/sprintf("&#%d;", ord($1))/ge;
		$g->d('txtLT',$note[$i],'xval',0,'yval',$i*($ch+$yFontSpace),"style",style($d{font}));
	}
	$g->e();
	$d{font}{'font-family'}='ArialNarrow-Bold';
}
###################
#	轴标
###################
my $font_space_scale=$d{font}{'font-size'}/$DEFAULT_FONT_SIZE;
$x=$rect{left}-$xFontSpace*8-$realCh-$STROKE_WIDTH;
$x-=$yMlen;
$y=$rect{height}/2+$rect{top};
$g->d("txtCT",$param{Y},"xval",0,"yval",0,"transform",
	"translate(".$x.",".$y.") rotate(-90)", "style",style($d{font}));
$g->d("txtCT",$param{X},"xval",($rect{width}/2+$rect{left}),"yval",$vbH-$ch*4/3+$yFontSpace*6+$STROKE_WIDTH/2,"style",style($d{font}));
$g->d("txtCT",$param{Note},"xval",($rect{width}/2+$rect{left}),"yval",$YOFFSET-$STROKE_WIDTH/2, "style",style($d{font}));
if ($param{BothYAxis}) {
	$g->d("txtCT",$param{RY},"xval",0,"yval",0,"transform",
		"translate("
		.($rect{left}+$rect{width}+$ryMlen+$xFontSpace+$STROKE_WIDTH)
		.",".($rect{height}/2+$rect{top})
		.") rotate(-90)", "style",style($d{font}));
}
if ($imagetop) {
	$g->b("g","transform","translate(".$rect{left}.",".$rect{top}.")");
	drawImage();
	$g->e();
}
#print "($x,$y)\t$yMlen\t$ryMlen\n";
$g->e();
$g->e();
#revFontSize();
$svg->close($g);
close(F);

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#绘图结束
#_________________________________________

#####################################################################################################################
#	画右上角注释
#####################################################################################################################
sub drawMark{
	my ($tmpx,$iscale,$ipointSize,$ltype);
	if ($pp) {
		$d{font}{fill}='#000000';
	}
	$iscale=$MARK_SCALE;
	if (@mark2) {
		@tmp=sort {txtWidth($a)<=>txtWidth($b)} @mark2;
		my ($xx,$yy,$i,$ww);
		$tmp=txtWidth($tmp[$#tmp]);
		$ww=$tmp+$xFontSpace*6;
		if ($param{Mark2Pos}=~/r/i) {
			$xx = $rect{width}-$SCALELEN-$ww*$MARK2_SCALE-$xFontSpace;
		}else{
			$xx = $SCALELEN+$xFontSpace;
		}
		if ($param{Mark2Pos}=~/b/i) {
			$yy = $rect{height} - (@tmp*($realCh+$yFontSpace)+$yFontSpace*6)*$MARK2_SCALE - $SCALELEN - $yFontSpace;
		}else{
			$yy = $SCALELEN+$yFontSpace;
		}
		$g->b("g","transform","translate(".$xx.",".$yy.") scale($MARK2_SCALE)");
		if ($param{Mark2Border}) {
			$d{rect}{fill}='none';
			$d{rect}{stroke}='black';
			$d{rect}{'stroke-width'}=min($STROKE_WIDTH*$iscale,$realCh/3);
			$g->d("rect","xval",0,"yval",0,"width",$ww,"height",@tmp*($realCh+$yFontSpace)+$yFontSpace*6,"style",style($d{rect}));
		}

		$x=$xFontSpace*3;
		for ($i=0;$i<@mark2;$i++) {
			$mark2[$i]=~ s/([$SPECIAL_CHAR])/sprintf("&#%d;", ord($1))/ge;
			$g->d("txtLM",$mark2[$i],"xval",txtWidth(' '),"yval",($i+0.5)*($realCh),"style",style($d{font}));
		}
		$g->e();
	}

	@tmp=sort {txtWidth($a->{name})<=>txtWidth($b->{name})} @mark;
	if ($tmp[$#tmp]{name} ne '') {
		shift @tmp until ($tmp[0] ne '');
		my ($xx,$yy,$ybase,$i,$j,$ww,$chNum);
		for ($i=$#mark;$i>=0;$i--) {
			if ($mark[$i]{name} eq '') {
				for ($j=$i;$j<$#mark;$j++) {
					$mark[$j]=$mark[$j+1];
				}
				$#mark--;
			}
		}
		$chNum=5;
		$tmp=txtWidth($tmp[$#tmp]{name});
		if ($param{MarkStyle}=~/^[hH]/) {
			$ww=0;
			foreach (@mark) {
				$ww +=txtWidth($_->{name})+txtWidth(' ' x ($chNum+2));
			}
			$ww+=$xFontSpace*6;
		}else{
			$ww=$tmp+txtWidth(' ' x ($chNum+1))+$xFontSpace*6;
		}
		if ($param{MarkPos}=~/o/i) {
			$xx = $rect{width}+$rect{blank}+$SCALELEN+$xFontSpace;
		}else{
			if ($param{MarkPos}=~/r/i) {
				$xx = $rect{width}-$ww*$MARK_SCALE-$SCALELEN-$xFontSpace;
			}else{
				$xx = $SCALELEN+$xFontSpace;
			}
		}
		if ($param{MarkPos}=~/o/i) {
			$ybase=0;
		}else{
			$ybase=$SCALELEN+$yFontSpace;
		}
		if ($param{MarkPos}=~/b/i) {
			if ($param{MarkStyle}=~/^[hH]/) {
				$yy = $rect{height} - ($realCh+$yFontSpace+$yFontSpace*6)*$MARK_SCALE - $ybase;
			}else{
				$yy = $rect{height} - (@mark*($realCh+$yFontSpace)+$yFontSpace*6)*$MARK_SCALE - $ybase;
			}
		}else{
			$yy = $ybase;
		}
		$g->b("g","transform","translate(".$xx.",".$yy.") scale($MARK_SCALE)");
		if (!$param{MarkNoBorder}) {
			$d{rect}{fill}='none';
			$d{rect}{stroke}='black';
			$d{rect}{'stroke-width'}=min($STROKE_WIDTH*$iscale,$realCh/3);
			#$y=$realCh+$yFontSpace;
			if ($param{MarkStyle}=~/^[hH]/) {
				$g->d("rect","xval",0,"yval",0,"width",$ww,"height",$realCh+$yFontSpace*6,"style",style($d{rect}));
			}else{
				$g->d("rect","xval",0,"yval",0,"width",$ww,"height",@mark*($realCh+$yFontSpace)+$yFontSpace*6,"style",style($d{rect}));
			}
		}

		$x=$xFontSpace*3;
		$ipointSize=min($MARK_POINT_SIZE/$iscale,$realCh/4);
		for ($i=0;$i<@mark;$i++) {
			next if ($mark[$i]{name} eq '');
			$ltype=$mark[$i]{type};
			$d{path}{'stroke-dasharray'}=$mark[$i]{line_dash} if ($mark[$i]{line_dash} ne '');
			$d{path}{stroke}=$mark[$i]{color};
			$d{path}{'stroke-width'}=min($mark[$i]{line_width}/$iscale,$realCh/5);
			if ($mark[$i]{stroke}) {
				$d{rect}{fill}=$mark[$i]{fill};
				$d{rect}{stroke}=$mark[$i]{color};
				$d{rect}{'stroke-width'}=min($mark[$i]{stroke_width}/$iscale,$realCh/3);
			}else{
				$d{rect}{fill}=$mark[$i]{color};
				$d{rect}{stroke}='none';
			}
			if ($mark[$i]{LG}) {
				$d{rect}{fill}="url(#".$mark[$i]{LG}.")";
			}
			if ($param{MarkStyle}=~/^[hH]/) {
				$y=$realCh/2;
				#print "$x\t$y\n";
				$g->d("txtLM",$mark[$i]{name},"xval",txtWidth(' ' x ($chNum+1))+$x,"yval",$y,"style",style($d{font}));
				$y+=$yFontSpace*5;
				$tmpx=$x+txtWidth(' ' x $chNum)/2;
				if ($ltype =~ /$type[2]/) { #Line
					$g->d("line","x1",$x+txtWidth(' ')/2,"y1",$y,"x2",$x+txtWidth(' ' x $chNum),"y2",$y,"style",style($d{path}));
				}elsif ($ltype =~ /$type[3]/) { #Point
					if (!$noConnect) {
						$g->d("line","x1",$x+txtWidth(' ')/2,"y1",$y,"x2",$x+txtWidth(' ' x $chNum),"y2",$y,"style",style($d{path}));
					}
					drawPoint(shift @oShape,$tmpx,$y,$ipointSize,$mark[$i]{color},$mark[$i]{stroke},$mark[$i]{stroke_width}/$iscale,$mark[$i]{fill});
				}else{
					$g->d("rect","xval",$tmpx-$realCh*3/8,"yval",$y-$realCh*3/8,"width",$realCh*3/4,"height",$realCh*3/4,"style",style($d{rect}));
				}
				$x+=txtWidth(' ' x ($chNum+2))+txtWidth($mark[$i]{name});
			}else{
				$y=($i+0.5)*$realCh;
				$g->d("txtLM",$mark[$i]{name},"xval",txtWidth(' ' x ($chNum+1)),"yval",$y,"style",style($d{font}));
				$y+=$yFontSpace*5;
				$tmpx=$x+txtWidth(' ' x $chNum)/2;
				if ($ltype =~ /$type[2]/ && !$param{Fill}) { #Line
					$g->d("line","x1",$x+txtWidth(' ')/2,"y1",$y,"x2",txtWidth(' ' x $chNum),"y2",$y,"style",style($d{path}));
				}elsif ($ltype =~ /$type[3]/) { #Point
					if (!$noConnect) {
						$g->d("line","x1",$x+txtWidth(' ')/2,"y1",$y,"x2",txtWidth(' ' x $chNum),"y2",$y,"style",style($d{path}));
					}
					drawPoint(shift @oShape,$tmpx,$y,$ipointSize,$mark[$i]{color},$mark[$i]{stroke},$mark[$i]{stroke_width}/$iscale,$mark[$i]{fill});
				}else{
					$g->d("rect","xval",$tmpx-$realCh*3/8,"yval",$y-$realCh*3/8,"width",$realCh*3/4,"height",$realCh*3/4,"style",style($d{rect}));
				}
			}
			delete($d{path}{'stroke-dasharray'});
		}
		$g->e();
	}
	if ($pp) {
		$d{font}{fill}='#F0F000';
	}
}
#####################################################################################################################
#	画图
#####################################################################################################################
sub drawImage{
	my($drawType);
	$offset=$param{OffsetPer} >0 ? $param{OffsetPer} :0;
	$unitPer=$param{UnitPer} >0 ? $param{UnitPer} :1;

	if ($param{Part}>0) {
		$part=$param{Part};
		$offset=$unitPer/$part if (!$offset);
	}elsif ($type =~ /$type[0]/) {
		$part=1;
	}elsif ($type =~ /$type[1]/) {
		$part=2;
		$offset=0.3;
		$unitPer=0.8
	}else{
		$part=1;
	}

	#print "$part $offset\n";
	my $i=0;
	while (!eof(F)) {
		while (<F>) {
			if (/\S/) {
				seek(F,-length,1);
				last;
			}
		}
		$drawType=draw(($i*$offset+$param{MovePer})*$colWidth,$colWidth*($unitPer-$offset*($part-1)));
		if ($drawType =~ /$type[0]|$type[1]/) { #Rectangle
			$i++;	
		}		
	}
	drawMark();
}
#####################################################################################################################
#	画
#####################################################################################################################
sub draw{
	my($wOff,$w)=@_;
	my($color,$h,$lst,$x,$y,$ry,$x2,$y2,$tmpx,$tmpy,$tmpx2,$tmpy2,$lcolor,$endX,$startX,$oks,$stroke,$stroke_width,$fill,
	   $i,$tmp,$tmp1,$tmp2,$tmp3,$tmpu,$step1,$step2,$step3,$zeroy,$dotNum,$maxDotNum,$maxDot,$return,
	   $shape,$ryAxis,$ryMark,$tmpScale,$maxLenScale,$log,$hasMore,$hasLess,$popNote,$statusNote,
	   #$lpopNote,$lstatusNote,$lastx,$lasty,$lastn,$ltmpx,$ltmpy,
	   @other,@tmp,%draw,%xy,@x,%y,%ry,@ys,%dots,%lastPoint,$dot,$overflow,$pointSize,$alignPos,
	   $drawType,$noconnect,$xunit,$order,@opacity);
	my ($hexStep1,$hexStep2,$hexStep3);
	my @lkeys=(
		"Color","Mark","YAxis","YMark",
		"Start","End","Step","ZeroVal","ZeroPos",
		"ColorStep","LightColor","SmoothColor",
	);
	my %tpos=(
		LT=>1,
		LM=>1,
		LB=>1,
		CT=>1,
		CM=>1,
		CB=>1,
		RT=>1,
		RM=>1,
		RB=>1,
	);

	%draw=%param;

	$tmpScale=[];
	$return=0;
	while (<F>) {
		if ($_!~/\S/) {
			$return=1;
			last;
		}
		if ($_=~/^\s*[\+-]?\d/) {
			seek(F,-length,1);
			last;
		}
		next if (/^\s*\#/);
		s/\cM*$//;
		chomp;
		if (/^\s*Scale:/i) {
			while (<F>) {
				s/\cM*$//;
				last if ($_=~/^\s*:End\s*$/i);
				chomp;
				push(@{$tmpScale},$_);
				$maxLenScale=$_ if (length($maxLenScale)<length($_));
			}
		}
		if (/^\s*LinearGradient:(.*)/i) {
			$draw{LinearGradient}=trim($1);
			my (@tmp1,@tmp2,$horizontal);
			@tmp1=split(/\|/,$draw{LinearGradient});
			@tmp2=split(/;/,$tmp1[1]);
			if (@tmp2<2) {
				error("LinearGradient must have more than two stops!",1);
			}else{
				$g->b("defs");
				$horizontal=0;
				if ($tmp1[0]=~/^H/) {
					$horizontal=1;
				}
					$g->b("linearGradient","id","LG".$LGNum,"x1",0,"y1",0,"x2",$horizontal,"y2",1-$horizontal);
						foreach (@tmp2) {
							@tmp1=split(/:/,$_);
							$g->d("stop","offset",($tmp1[0]<1 ? $tmp1[0] : $tmp1[0]."%"),"style","stop-color:".$tmp1[1]);
						}
					$g->e();
				$g->e();
				$draw{LG}="LG".$LGNum++;
			}
		}
		if (/(\S+?):(.+)/) {
			$draw{lc($1)}=$2;
		}
	}
	foreach (@lkeys,@keys) {
		if (exists($draw{lc($_)})) {
			if (exists($noTrim{$_})) {
				$draw{$_}=$draw{lc($_)};
			}else{
				$draw{$_}=trim($draw{lc($_)});
			}
		}
	}

	$drawType=$draw{Type} ? lc($draw{Type}) : $type ;
	$color=$draw{Color} ? $draw{Color} : '#000000' ;
	$alignPos=$tpos{uc($draw{AlignPos})} ? uc($draw{AlignPos}) : 'CM';
	$hasMore=$draw{HaveMore};
	$hasLess=$draw{HaveLess};
	$noconnect=defined($draw{NoLine}) ? $draw{NoLine} : defined($draw{NoConnect}) ? $draw{NoConnect} : $noConnect;
	if ($drawType =~ /$type[4]/){
		$noconnect=0;
		$xunit=0;
	}else{
		$xunit=$draw{XUnit};
	}
	$pointSize=$draw{PointSize};
	$#mark++;
	$mark[$#mark]{name}=$draw{Mark};
	$mark[$#mark]{type}=$drawType;
	$mark[$#mark]{color}=$color;
	$mark[$#mark]{line_dash}=$draw{LineDash};
	$mark[$#mark]{line_width} = $draw{LineWidth} ? $draw{LineWidth} : $STROKE_WIDTH;
	$stroke=$draw{NoFill} || $draw{Fill};
	$stroke_width=$draw{StrokeWidth} ? $draw{StrokeWidth} 
				:($draw{LineWidth} ? $draw{LineWidth}
				:1);
	$fill=$draw{Fill} ? $draw{Fill} : 'none';
	$mark[$#mark]{stroke} = $stroke;
	$mark[$#mark]{stroke_width} = $stroke_width;
	$mark[$#mark]{fill} = $fill;
	$mark[$#mark]{LG}=$draw{LG} if ($draw{LG});
	if (!exists($draw{YMark})) {
		$draw{YMark} = $draw{YAxis};
	}
	$ryAxis=($draw{YAxis}=~/r/i) ? 1 : 0;
	$ryMark=($draw{YMark}=~/r/i) ? 1 : 0;

	$log=0;
	setFontSize($realScaleCh);
	if ($draw{MultiY} && !$ryMark) {
		$y{Start}=exists($draw{Start}) ? $draw{Start} : $raw{YStart};
		$y{End}=exists($draw{End}) ? $draw{End} : $raw{YEnd};
		$y{Step}=exists($draw{Step}) ? $draw{Step} : $raw{YStep};
		$y{Color}=$color;
		error ("YStart can't equal with YEnd!") if ($y{Start}==$y{End});
		error ("YStep must bigger than 0!") if ($y{Step}<=0);
		if ($draw{YDiv}) {
			if ($draw{YLog} && !$draw{YNeedLog}) {
				$y{Start}-=log($draw{YDiv})/log($draw{YLog});
				$y{End}-=log($draw{YDiv})/log($draw{YLog});
				#$log=$draw{YLog};
			}else{
				$y{Start}/=$draw{YDiv};
				$y{End}/=$draw{YDiv};
				$y{Step}/=$draw{YDiv};
			}
		}
		if ($draw{YNeedLog}) {
			error ("YStart,YEnd and YStep must bigger than 0!") if ($y{Start}<=0 || $y{End}<=0 || $y{Step}<=0);
			$step = rint(($y{End}-$y{Start})/$y{Step});
			$y{Start}=log($y{Start})/log($draw{YNeedLog});
			$y{End}=log($y{End})/log($draw{YNeedLog});
			$y{Step}=availDigit(($y{End}-$y{Start})/$step,$draw{AvailDigit},1,$draw{YLog});
			#$log=$draw{YNeedLog};
		}
		if ($y{Start}!=0 && !exists($draw{ZeroPos}) && !exists($raw{YZeroPos}) 
						 && !exists($draw{ZeroVal}) && !exists($raw{YZeroVal})) {
			$y{ZeroVal}=$y{Start};
		}else{
			$y{ZeroVal}=exists($draw{ZeroVal}) ? $draw{ZeroVal} : $raw{YZeroVal};
		}
		$y{ZeroPos}=exists($draw{ZeroPos}) ? $draw{ZeroPos} : $raw{YZeroPos};
		push(@y,\%y);
		push(@yScale,$tmpScale) ;#if (@{$tmpScale});
		$yMlen=txtWidth($maxLenScale) if ($yMlen<txtWidth($maxLenScale));
	}
	if ($draw{MultiRY} && $ryMark) {
		$ry{Start}=exists($draw{Start}) ? $draw{Start} : $raw{RYStart};
		$ry{End}=exists($draw{End}) ? $draw{End} : $raw{RYEnd};
		$ry{Step}=exists($draw{Step}) ? $draw{Step} : $raw{RYStep};
		$ry{Color}=$color;
		error ("RYStart can't equal with RYEnd!") if ($ry{Start}==$ry{End});
		error ("RYStep must bigger than 0!") if ($ry{Step}<=0);
		if ($draw{RYDiv}) {
			if ($draw{RYLog} && !$draw{RYNeedLog}) {
				$ry{Start}-=log($draw{RYDiv})/log($draw{RYLog});
				$ry{End}-=log($draw{RYDiv})/log($draw{RYLog});
				#$log=$draw{RYLog};
			}else{
				$ry{Start}/=$draw{RYDiv};
				$ry{End}/=$draw{RYDiv};
				$ry{Step}/=$draw{RYDiv};
			}
		}
		if ($draw{RYNeedLog}) {
			error ("RYStart,RYEnd and RYStep must bigger than 0!") if ($ry{Start}<=0 || $ry{End}<=0 || $ry{Step}<=0);
			$step = rint(($ry{End}-$ry{Start})/$ry{Step});
			$ry{Start}=log($ry{Start})/log($draw{RYNeedLog});
			$ry{End}=log($ry{End})/log($draw{RYNeedLog});
			$ry{Step}=availDigit(($ry{End}-$ry{Start})/$step,$draw{AvailDigit},1,$draw{RYLog});
			#print "$step\t$ry{Start}\t$ry{End}\n";
			#$log=$draw{RYNeedLog};
		}
		if ($ry{Start}!=0 && !exists($draw{ZeroPos}) && !exists($raw{RYZeroPos})
						  && !exists($draw{ZeroVal}) && !exists($raw{RYZeroVal})) {
			$ry{ZeroVal}=$ry{Start};
		}else{
			$ry{ZeroVal}=exists($draw{ZeroVal}) ? $draw{ZeroVal} : $raw{RYZeroVal};
		}
		$ry{ZeroPos}=exists($draw{ZeroPos}) ? $draw{ZeroPos} : $raw{RYZeroPos};
		push(@ry,\%ry);
		push(@ryScale,$tmpScale) ;#if (@{$tmpScale});
		$ryMlen=txtWidth($maxLenScale) if ($ryMlen<txtWidth($maxLenScale));
	}
	revFontSize();

	$d{path}{fill}='none';
	$d{path}{'stroke-width'}=$draw{LineWidth} ? $draw{LineWidth} : $STROKE_WIDTH;
	$d{path}{'stroke-linecap'}='round';
	$d{path}{'stroke-dasharray'}=$draw{LineDash} if ($draw{LineDash} ne '');
	if ($drawType =~ /$type[2]/) {	#Line
	}elsif ($drawType =~ /$type[3]/) {	#Point
		$shape=shift(@shape);
		push(@shape,$shape);
		$shape=$draw{PointShape} ? $draw{PointShape} : $shape;
		push(@oShape,$shape);
	}else{
		if ($stroke) {
			$d{rect}{fill}=$fill;
			$d{rect}{'stroke-width'}=$stroke_width;
		}else{
			$d{rect}{stroke}='none';
		}
	}

	return if ($return || eof(F));
	%xy=();
	$tmpx=$tmpy=0;
	$endX=$startX=0;
	$oks=0;
	$order=0;
	while (<F>) {
		s/\cM*$//;
		last if ($_!~/\S/);
		next if (/^\s*\#/);
		#$_=~s/\s//g;
		chomp;
		if (/^([^:]+):([^:]+):?(.*)$/) {
			$x=$1;	$y=$2;	@other=split(/:/,$3);
			####
			$x=~s/\s//g;
			$y=~s/\s//g;
			#print "$x,$y\n";
			#print "$xy{$x}{$y}{note}\n";
			$other[0]=~s/\s//g;
			$other[1]=~s/\s//g;
			if ($drawType =~ /$type[3]/) { #Point
				($x2,$y2)=split(/\|/,$other[0]);
				$x2=$x if $x2 eq '';
			}else{
				$y2=$other[0];
			}
			#print @other;
			#print "\n";
			if ($draw{XDiv}) {
				if ($draw{XLog} && !$draw{XNeedLog}) {
					$x-=log($draw{XDiv})/log($draw{XLog});
					$x2-=log($draw{XDiv})/log($draw{XLog}) if $x2;
				}else{
					$x/=$draw{XDiv};
					$x2/=$draw{XDiv} if $x2;
				}
			}
			if ($draw{XNeedLog}) {
				if ($x) {
					$x=log($x)/log($draw{XNeedLog});
				}else{
					error("Log(X) with X=0!");
					#error("Log(X) with X=0!\nIgnore line(s)!",1);
					#next;
				}
				$x2=log($x2)/log($draw{XNeedLog}) if $x2;
			}
			#print "$x:$y\n";
			if ($ryAxis) {
				if ($draw{RYDiv}) {
					if ($draw{RYLog} && !$draw{RYNeedLog}) {
						$y-=log($draw{RYDiv})/log($draw{RYLog});
						$y2-=log($draw{RYDiv})/log($draw{RYLog}) if ($y2);
						$log=$draw{RYLog};
					}else{
						$y/=$draw{RYDiv};
						$y2/=$draw{RYDiv} if ($y2);
					}
				}
				if ($draw{RYNeedLog}) {
					if ($y) {
						$y=log($y)/log($draw{RYNeedLog});
					}else{
						error("Log(RY) with RY=0!");
					}
					$y2=log($y2)/log($draw{RYNeedLog}) if ($y2);
					$log=$draw{RYNeedLog};
				}
				$zeroy=$draw{RYZeroVal};
			}else{
				if ($draw{YDiv}) {
					if ($draw{YLog} && !$draw{YNeedLog}) {
						$y-=log($draw{YDiv})/log($draw{YLog});
						$y2-=log($draw{YDiv})/log($draw{YLog}) if ($y2);
						$log=$draw{YLog};
					}else{
						$y/=$draw{YDiv};
						$y2/=$draw{YDiv} if ($y2);
					}
				}
				if ($draw{YNeedLog}) {
					if ($y) {
						$y=log($y)/log($draw{YNeedLog});
					}else{
						error("Log(Y) with Y=0!");
					}
					$y2=log($y2)/log($draw{YNeedLog}) if ($y2);
					$log=$draw{YNeedLog};
				}
				$zeroy=$draw{YZeroVal};
			}
			$x=cut($x);
			$y=cut($y);
			if (defined($x2)) {
				$xy{$x}{$y}{x2}=cut($x2);
			}
			if (defined($y2)) {
				($y,$y2)=($y2,$y) if ($y<$y2 && $drawType !~ /$type[3]/);
				$xy{$x}{$y}{y2}=$zeroy=cut($y2);
			}
			#print "$x\t$y\t$draw{XZeroPos}\n";
			#大(小)于$draw{XEnd}($draw{XStart})的数据处理
			$xy{$x}{$y}{note}=$other[2];
			$xy{$x}{$y}{pop}=$other[3];
			$xy{$x}{$y}{order}=$order++;
			$tmpu=$xunit*uint($draw{XScaleLinePos},1);  ###???
			$tmp1=cut($draw{XEnd})-($draw{XLog} ? 0 : ($tmpu?$tmpu:$xunit));
			if (($drawType =~ /$type[0]|$type[1]/) && $draw{Align}=~/C/i) {
				$tmp1+=$xunit;
			}
			#print "$x>$tmp1\n" if (cut($x)>cut($tmp1));
			if (cut($x)>=cut($draw{XStart}) && !$oks) {
				$startX=cut($x);
				$oks=1;
			}
			if (cut($x)<=cut($tmp1)) {
				$endX=cut($x);
			}
			if ($draw{XZeroPos} && !exists($draw{XMove})) {
				if ($other[1] > 0) {
					$xy{$x}{$y}{n}+=$other[1];
				}elsif (length($other[1])>0) {
					$xy{$x}{$y}{color}=$other[1];
					$xy{$x}{$y}{n}++;
				}else{
					$xy{$x}{$y}{n}++;
				}
				$xy{$x}{$y}{low}=$zeroy;
				if (cut($x)>cut($tmp1)) {
					error("Overflow Right!",1);
				}
				if (cut($x)<cut($draw{XStart})) {
					error("Overflow Left!",1);
				}
			}elsif (cut($x)>cut($tmp1)) {
				#print "$x\t$draw{XEnd}\t$tmpu?$tmpu:$xunit\t";
				#print cut($draw{XEnd})."\n";
				if ($log) {
					$tmpy+=$log**$y;
				}else{
					$tmpy+=$y;
				}
				if ($x>cut($draw{XEnd}) && !$draw{XCut}) {
					$hasMore=1;
				}
				delete($xy{$x});
				#print "$x++++++$y---$tmpy\n";
			}elsif (cut($x)<cut($draw{XStart})) {
				if ($log) {
					$tmpx+=$log**$y;
				}else{
					$tmpx+=$y;
				}
				if (!$draw{XCut}) {
					$hasLess=1;
				}
				delete($xy{$x});
			}else{
				if ($other[1] > 0) {
					$xy{$x}{$y}{n}+=$other[1];
				}elsif (length($other[1])>0) {
					$xy{$x}{$y}{color}=$other[1];
					$xy{$x}{$y}{n}++;
				}else{
					$xy{$x}{$y}{n}++;
				}
				$xy{$x}{$y}{low}=$zeroy;
				#print "$x\t$y\n";
			}
		}
	}


	foreach $x (keys %xy) {
		foreach $y (keys %{$xy{$x}}) {
			$maxDotNum=$xy{$x}{$y}{n} if ($maxDotNum < $xy{$x}{$y}{n});
			$dots{$xy{$x}{$y}{n}}=1;
		}
	}
	$maxDot=0;
	foreach (keys %dots) {
		$maxDot++;
	}
	if ($draw{SmoothColor} eq '') {
		$maxDot=$maxDotNum;
	}
	
	if ($draw{ColorStep} eq 'auto') {
		$draw{LightColor}='#FFFFFF';
	}
	if ($draw{LightColor} ne '' && $maxDot>1) {
		$hexStep1=(hex(substr($draw{LightColor},1,2))-hex(substr($color,1,2)));
		$hexStep2=(hex(substr($draw{LightColor},3,2))-hex(substr($color,3,2)));
		$hexStep3=(hex(substr($draw{LightColor},5,2))-hex(substr($color,5,2)));
		$hexStep1=$hexStep1/($maxDot-1);
		$hexStep2=$hexStep2/($maxDot-1);
		$hexStep3=$hexStep3/($maxDot-1);
		$draw{ColorStep}='auto';
		#print "$maxDot\t$hexStep1\t$hexStep2\t$hexStep3\n";
	}

	if ($draw{ColorStep} ne '' && $draw{ColorStep} ne 'auto') {
		$overflow=0;
		$tmp=(hex(substr($color,1))+hex(substr($draw{ColorStep},1))*($maxDot-1));
		if ($tmp>=hex('FFFFFF')) {
			error("Dot color too light!",1);
			$overflow=1;
		}
	}
	
	if ($hasMore) {
		if ($log) {
			#print "$tmpy\t$log\n";
			$tmpy=log($tmpy)/log($log) if ($tmpy);
		}
		#$tmp=cut($draw{XEnd})-($tmpu?$tmpu:$xunit);
		$tmp=$endX;
		@ys=sort {$a<=>$b} keys %{$xy{$tmp}};
		#print "$tmp\n";
		delete($xy{$tmp});
		$xy{$tmp}{$tmpy+$ys[$#ys]}{n}++;
		$xy{$tmp}{$tmpy+$ys[$#ys]}{low}=$zeroy;
		#print "$ys[$#ys]\t$tmpy\n";
		$param{HaveMore}=$draw{HaveMore}=1;
	}
	if ($hasLess) {
		if ($log) {
			$tmpx=log($tmpx)/log($log) if ($tmpx);
		}
		#$tmp=cut($draw{XStart});
		$tmp=$startX;
		@ys=sort {$a<=>$b} keys %{$xy{$tmp}};
		delete($xy{$draw{XStart}});
		$xy{$tmp}{$tmpx+$ys[0]}{n}++;
		$xy{$tmp}{$tmpx+$ys[0]}{low}=$zeroy;
		$param{HaveLess}=$draw{HaveLess}=1;
	}

	$lst=1;
	$tmpx=$tmpy=$tmpx2=$tmpy2=0;
	if ($draw{Transparence}) {
		@opacity=("opacity",1-$draw{Transparence});
		###$g->b("g","opacity",1-$draw{Transparence});
	}
	@x=sort {$a<=>$b} keys %xy;
	$dot=0;
	%lastPoint=();

	if ($drawType !~ /$type[0]/ && $drawType !~ /$type[1]/ && $drawType !~ /$type[2]/){	#对于非[直方图]|[折线图]，$wOff和$w清零
		$wOff=0;
		$w=0;
	}
	for ($dotNum=1;$dotNum<=$maxDotNum;$dotNum++) {
		last if ($drawType =~ /$type[3]/ && !$noconnect && $dotNum>1); #需要连线时重叠点已经考虑过（）
		next if (!$dots{$dotNum});
		if ($draw{SmoothColor}) {
			$dot++;
		}else{
			$dot=$dotNum;
		}
		#print "$dotNum\t$dot\n";
		foreach (@x) {
			$x = $rect{width}*($_-$draw{XZeroVal})/($draw{XEnd}-$draw{XStart})+$rect{width}*$draw{XZeroPos};
			if ($drawType !~ /$type[4]/){	#Bar不偏移
				$x += $wOff;
			}
			#print "$_\t$x\n";
			#@ys=sort {$xy{$_}{$a}{n}<=>$xy{$_}{$b}{n}} keys %{$xy{$_}};
			foreach $i (sort {$xy{$_}{$a}{order}<=>$xy{$_}{$b}{order}} keys %{$xy{$_}}) {
				#print $xy{$_}{$i}{note},"\t[",$xy{$_}{$i}{n},"]\t",$dotNum,"\n";
				if ($xy{$_}{$i}{n}!=$dotNum) {
					if ($drawType =~ /$type[3]/ && !$noconnect) { #重叠点
					}else{
						next;
					}
				}
				if (exists($xy{$_}{$i}{x2})) {
					$x2 = $rect{width}*($xy{$_}{$i}{x2}-$draw{XZeroVal})/($draw{XEnd}-$draw{XStart})+$rect{width}*$draw{XZeroPos};
					if ($drawType !~ /$type[4]/){	#Bar不偏移
						$x2 += $wOff;
					}
				}
				if (($drawType =~ /$type[0]|$type[1]/) && $draw{Align}=~/C/i) { #Rect=> L: Left; C: Center; R: Right
					$x -= $w/2;
					$x2-= $w/2 if exists($xy{$_}{$i}{x2});
				}
				$popNote=defined($xy{$_}{$i}{pop}) ? "\\n$xy{$_}{$i}{pop}" : '';
				$statusNote=defined($xy{$_}{$i}{pop}) ? "\\t$xy{$_}{$i}{pop}" : '';
				#print $xy{$_}{$i}{note},"\n";
				$lcolor=$color;
				if ($draw{ColorStep} ne '') {
					if ($draw{ColorStep} eq 'auto') {
						$step1=rint($hexStep1*($maxDot-$dot));
						$step2=rint($hexStep2*($maxDot-$dot));
						$step3=rint($hexStep3*($maxDot-$dot));
						$tmp1=hex(substr($color,1,2));
						$tmp2=hex(substr($color,3,2));
						$tmp3=hex(substr($color,5,2));
						$tmp=($tmp1+$step1)%hex('100')*hex('10000')+($tmp2+$step2)%hex('100')*hex('100')+($tmp3+$step3)%hex('100');
					}else{
						$step1=hex(substr($draw{ColorStep},1,2))*($maxDot-$dot);
						$step2=hex(substr($draw{ColorStep},3,2))*($maxDot-$dot);
						$step3=hex(substr($draw{ColorStep},5,2))*($maxDot-$dot);
						$tmp1=hex(substr($color,1,2));
						$tmp2=hex(substr($color,3,2));
						$tmp3=hex(substr($color,5,2));
						$tmp=($tmp1+$step1)%hex('100')*hex('10000')+($tmp2+$step2)%hex('100')*hex('100')+($tmp3+$step3)%hex('100');
					}
					#print substr($color,1)."\n";
					#print sprintf("%X",$tmp>=0 ? $tmp : 0);
					$lcolor='#'.sprintf("%06X",$tmp>=0 ? ($tmp<=hex('FFFFFF')?$tmp:hex('FFFFFF')) : 0);
				}
				$lcolor=$xy{$_}{$i}{color} if ($xy{$_}{$i}{color});
				$d{path}{stroke}=$lcolor;
				if ($drawType =~ /$type[2]/) {	#Line
					$d{polygon}{fill}=$lcolor;
					$d{polygon}{stroke}=$lcolor;
				}elsif ($drawType =~ /$type[3]/) {	#Point
					#$d{point}{fill}=$lcolor;
				}else{
					if ($stroke) {
						$d{rect}{stroke}=$lcolor;
					}else{
						$d{rect}{fill}=$lcolor;
					}
					if ($draw{LG}) {
						$d{rect}{fill}="url(#".$draw{LG}.")";
					}
				}

				#print "$x = $rect{width}*$_/($draw{XEnd}-$draw{XStart})+$rect{width}*$draw{XZeroPos}+$wOff\n";
				if ($ryAxis) {
					if ($draw{MultiRY} && $ryMark) {
						$tmp = $rect{height}*($i-$ry{ZeroVal})/($ry{End}-$ry{Start})+$rect{height}*$ry{ZeroPos};
						$h = $rect{height}*(($i-$xy{$_}{$i}{low}))/($ry{End}-$ry{Start})+$rect{height}*$ry{ZeroPos};
					}else{
						$tmp = $rect{height}*($i-$draw{RYZeroVal})/($draw{RYEnd}-$draw{RYStart})+$rect{height}*$draw{RYZeroPos};
						$h = $rect{height}*(($i-$xy{$_}{$i}{low}))/($draw{RYEnd}-$draw{RYStart})+$rect{height}*$draw{RYZeroPos};
					}
				}else{
					if ($draw{MultiY} && !$ryMark) {
						$tmp = $rect{height}*($i-$y{ZeroVal})/($y{End}-$y{Start})+$rect{height}*$y{ZeroPos};
						$h = $rect{height}*(($i-$xy{$_}{$i}{low}))/($y{End}-$y{Start})+$rect{height}*$y{ZeroPos};
					}else{
						$tmp = $rect{height}*($i-$draw{YZeroVal})/($draw{YEnd}-$draw{YStart})+$rect{height}*$draw{YZeroPos};
						$h = $rect{height}*(($i-$xy{$_}{$i}{low}))/($draw{YEnd}-$draw{YStart})+$rect{height}*$draw{YZeroPos};
					}
					#print "\n$h = $rect{height}*(($i-$xy{$_}{$i}{low})-$draw{RYZeroVal})/($draw{RYEnd}-$draw{RYStart})+$rect{height}*$draw{RYZeroPos}\n";
				}
				#print "$tmp\t$h\n= $rect{height}*($i-$draw{YZeroVal})/($draw{YEnd}-$draw{YStart})+$rect{height}*$draw{YZeroPos}\n";
				#next if ($h==0);
				$y = $rect{height}-$tmp;#-$d{rect}{'stroke-width'}/2;
				if (exists($xy{$_}{$i}{y2})) {
					$y2 = $rect{height}-$tmp+$h;
				}
				if ($draw{YCut}) {
					#next if ($y<0 || $y>$rect{height} || $h<0 || $h>$rect{height});
					$y=0 if ($y<0);
					$y=$rect{height} if ($y>$rect{height});
					$h=0 if ($h<0);
					$h=$rect{height} if ($h>$rect{height});
					if (exists($xy{$_}{$i}{y2})) {
						$y2=0 if ($y2<0);
						$y2=$rect{height} if ($y2>$rect{height});
					}
				}
				$tmpx= ($draw{XLog} ? $draw{XLog}**$_ : $_);
				if (exists($xy{$_}{$i}{x2})) {
					$tmpx2= ($draw{XLog} ? $draw{XLog}**$xy{$_}{$i}{x2} : $xy{$_}{$i}{x2});
				}
				if ($ryAxis) {
					$tmpy= ($draw{RYLog} ? $draw{RYLog}**$i : $i);
					$tmpy2= ($draw{RYLog} ? $draw{RYLog}**$xy{$_}{$i}{low} : $xy{$_}{$i}{low});
				}else{
					$tmpy= ($draw{YLog} ? $draw{YLog}**$i : $i);
					$tmpy2= ($draw{YLog} ? $draw{YLog}**$xy{$_}{$i}{low} : $xy{$_}{$i}{low});
				}
				if ($tmpx eq 'INF') {
					error('X too big!');
				}
				if ($tmpx2 eq 'INF') {
					error('X2 too big!');
				}
				if ($tmpy eq 'INF') {
					error('Y too big!');
				}
				if ($tmpy2 eq 'INF') {
					error('Y2 too big!');
				}
				#print "$tmpx,$tmpy\n";
				if ($drawType =~ /$type[2]/) { #Line
					if ($lst) {
						$lst=0;
					}else{
						if ($xunit && !$draw{NoFillZero} && (cut($x)-cut($lastPoint{'x'})>0)) {
							#print ($x-$lastPoint{'x'})."\t$lastPoint{'x'}\t$x\n";
							$g->d("line","x1",f($lastPoint{'x'}),"y1",f($lastPoint{'y'}),"x2",f($lastPoint{'x'}),"y2",f($rect{height}),@opacity,"style",style($d{path}));
							$g->d("line","x1",f($x),"y1",f($rect{height}),"x2",f($x),"y2",f($y),@opacity,"style",style($d{path}));
							#print "$lastPoint{'x'}\t$x\n";
						}elsif ($draw{RightAngle}) {	#连线
							#print "$lastPoint{'x'} = $x\n" if ($lastPoint{'x'} = $x);
							#print "$lastPoint{'x'} eq $x\n" if ($lastPoint{'x'} eq $x);
							if ($lastPoint{'x'} ne $x) {
								$g->d("line","x1",f($lastPoint{'x'}),"y1",f($lastPoint{'y'}),"x2",f($x),"y2",f($lastPoint{'y'}),@opacity,"style",style($d{path}),
									"onclick","alert('x:$lastPoint{dispX}\\ny:$lastPoint{dispY}$lastPoint{popNote}')",
									"onmousemove","window.status='x:$lastPoint{dispX}\\ty:$lastPoint{dispY}$lastPoint{statusNote}'"
								);
							}
							if (!$noconnect && ($lastPoint{'y'} ne $y)) {
								$g->d("line","x1",f($x),"y1",f($lastPoint{'y'}),"x2",f($x),"y2",f($y),@opacity,"style",style($d{path}));
							}
						}elsif ($draw{Fill}) {
							$g->d("polygon","points",f($lastPoint{'x'})." ".f($lastPoint{'y'}).",".f($x)." ".f($y).",".f($x)." ".f($rect{height}).",".f($lastPoint{'x'})." ".f($rect{height}),
								@opacity,"style",style($d{polygon}));#,"onclick","alert('".$msg."');");
						}else{
							if (!$noconnect && (($lastPoint{'x'} ne $x) || ($lastPoint{'y'} ne $y))) {
								$g->d("line","x1",f($lastPoint{'x'}),"y1",f($lastPoint{'y'}),"x2",f($x),"y2",f($y),@opacity,"style",style($d{path}));
							}
						}
					}
					#print "$x\t$y\n";
					if (!$xunit || $drawType =~ /$type[4]/) {		#Bar
						#print "$x,$lastPoint{'x'}\n";
						$lastPoint{'x'}=$x;
						#$y+=$d{rect}{'stroke-width'}/2;
					}else{
						if ($draw{Fill}) {
							$g->d("rect","xval",f($x),"yval",f($y),"width",f($w),"height",f($h),@opacity,"style",style($d{rect}),
								"onclick","alert('x:$tmpx\\ny:$tmpy$popNote')",
								"onmousemove","window.status='x:$tmpx\\ty:$tmpy$statusNote'"
							);
						}else{
							$g->d("line","x1",f($x),"y1",f($y),"x2",f($x+$w),"y2",f($y),@opacity,"style",style($d{path}),
								"onclick","alert('x:$tmpx\\ny:$tmpy$popNote')",
								"onmousemove","window.status='x:$tmpx\\ty:$tmpy$statusNote'"
							);
						}
						$lastPoint{'x'}=$x+$w;
					}
					$lastPoint{'y'}=$y;
					$lastPoint{dispX}=$tmpx;
					$lastPoint{dispY}=$tmpy;
					$lastPoint{popNote}=$popNote;
					$lastPoint{statusNote}=$statusNote;
					#print "------>$lastPoint{'x'}\t$lastPoint{'y'}\n";
				}elsif ($drawType =~ /$type[3]/) { #Point
					if ($lst) {
						$lst=0;
					}else{
						if ($draw{VerticalLine}) {
							#print "$lastPoint{'x'}\t$x\n";
							if ($lastPoint{'x'}==$x) {
								$g->d("line","x1",f($lastPoint{'x'}),"y1",f($lastPoint{'y'}),"x2",f($x),"y2",f($y),@opacity,"style",style($d{path})); #连线
							}
						}elsif (!$noconnect) {
							$g->d("line","x1",f($lastPoint{'x'}),"y1",f($lastPoint{'y'}),"x2",f($x),"y2",f($y),@opacity,"style",style($d{path})); #连线
						}
						if ($draw{OnlyLine}) {
							if ($lastPoint{'x2'} ne $lastPoint{'x'} || $lastPoint{'y2'} ne $lastPoint{'y'}) {
								$d{path}{stroke}=$lastPoint{color};
								$g->d("line","x1",f($lastPoint{'x'}),"y1",f($lastPoint{'y'}),"x2",f($lastPoint{'x2'}),"y2",f($lastPoint{'y2'}),@opacity,"style",style($d{path}),
										"onclick","alert('x:$lastPoint{dispX}\\ny:$lastPoint{dispY}\\nx2:$lastPoint{dispX2}\\ny2:$lastPoint{dispY2}".$lastPoint{nn}."$lastPoint{popNote}')",
										"onmousemove","window.status='x:$lastPoint{dispX}\\ty:$lastPoint{dispY}\\tx2:$lastPoint{dispX2}\\ty2:$lastPoint{dispY2}".$lastPoint{tn}."$lastPoint{statusNote}'"
								); #连线
							}
						}else{
							if ($draw{ExtendLine} && ($lastPoint{'x2'} ne $lastPoint{'x'} || $lastPoint{'y2'} ne $lastPoint{'y'})) {
								$d{path}{stroke}=$lastPoint{color};
								$g->d("line","x1",f($lastPoint{'x'}),"y1",f($lastPoint{'y'}),"x2",f($lastPoint{'x2'}),"y2",f($lastPoint{'y2'}),@opacity,"style",style($d{path})); #连线
								drawPoint($shape,$lastPoint{'x2'},$lastPoint{'y2'},$pointSize,$lastPoint{color},$stroke,$stroke_width,$fill,
									"alert('x2:$lastPoint{dispX2}\\ny2:$lastPoint{dispY2}".$lastPoint{nn}."$lastPoint{popNote}')",
									"window.status='x2:$lastPoint{dispX2}\\ty2:$lastPoint{dispY2}".$lastPoint{tn}."$lastPoint{statusNote}'",@opacity);
							}
							drawPoint($shape,$lastPoint{'x'},$lastPoint{'y'},$pointSize,$lastPoint{color},$stroke,$stroke_width,$fill,
								"alert('x:$lastPoint{dispX}\\ny:$lastPoint{dispY}".$lastPoint{nn}."$lastPoint{popNote}')",
								"window.status='x:$lastPoint{dispX}\\ty:$lastPoint{dispY}".$lastPoint{tn}."$lastPoint{statusNote}'",@opacity);
						}
					}
					#$d{point}{'fill'}=$lcolor;

					$lastPoint{'x'}=$x;
					$lastPoint{'y'}=$y;
					if (exists($xy{$_}{$i}{x2})) {
						$lastPoint{'x2'}=$x2;
						$lastPoint{dispX2}=$tmpx2;
					}else{
						$lastPoint{'x2'}=$x;
						$lastPoint{dispX2}=$tmpx;
					}
					if (exists($xy{$_}{$i}{y2})) {
						$lastPoint{'y2'}=$y2;
						$lastPoint{dispY2}=$tmpy2;
					}else{
						$lastPoint{'y2'}=$y;
						$lastPoint{dispY2}=$tmpy;
					}
					$lastPoint{dispX}=$tmpx;
					$lastPoint{dispY}=$tmpy;
					$lastPoint{popNote}=$popNote;
					$lastPoint{statusNote}=$statusNote;
					$lastPoint{nn}=$maxDot>1 ? "\\ndot:$xy{$_}{$i}{n}" : '';
					$lastPoint{tn}=$maxDot>1 ? "\\tdot:$xy{$_}{$i}{n}" : '';
					$lastPoint{color}=$lcolor;
					#print "------>$lastPoint{'x'}\t$lastPoint{'y'}\n";
				}elsif ($drawType =~ /$type[0]|$type[1]/) {	#Rectangle
					#print "$x\t$w\n";
					#print "\n$x,$y,$w,$h\n";
					if ($h<0) {
						error("Overflow Below!",1);
						$y=$rect{height};
						$h=-$h;
					}
					my @rounded=();
					if ($draw{Rounded}) {
						@rounded=("rx",$w/2);
					}
					my ($xTmp,$wTmp);
					$xTmp=$x;
					$wTmp=$w;
					if (!$draw{XZeroPos}) {
						if ($x<0){
							$wTmp+=$x;
							$xTmp=0;
						}
						$wTmp=$rect{width}-$x if $x+$w>$rect{width};
					}
					$g->d("rect","xval",f($xTmp),"yval",f($y),"width",f($wTmp),"height",f($h),@rounded,@opacity,"style",style($d{rect}),
						"onclick","alert('x:$tmpx\\ny:$tmpy".(defined($xy{$_}{$i}{y2}) ? "\\ny2:$tmpy2" :"")."$popNote')",
						"onmousemove","window.status='x:$tmpx\\ty:$tmpy".(defined($xy{$_}{$i}{y2}) ? "\\ty2:$tmpy2" :"")."$statusNote'"
					) if $wTmp>0;
				}
				
				if ($xy{$_}{$i}{note} ne '') { #Text $drawType =~ /$type[5]/
					#print "[$xy{$_}{$i}{note}]\n";
					$tmp=(split(/\|/,$xy{$_}{$i}{note}))[0];
					$xy{$_}{$i}{note}=~s/\s//g;
					my @lnote=split(/\|/,$xy{$_}{$i}{note});
					$lnote[0]=$tmp;
					$lnote[0]=~s/_\\/|/g;
					$lnote[0]=~s/_;/:/g;
					$lnote[0]=~s/_-/_/g;
					$lnote[0]=~s/([$SPECIAL_CHAR])/sprintf("&#%d;", ord($1))/ge;
					my $tmpcolor=$d{font}{fill};
					my $tmpfamily=$d{font}{'font-family'};
					my $tmpalign=$tpos{uc($lnote[3])} ? uc($lnote[3]) : (($drawType =~ /$type[5]/) ? $alignPos : 'CB');
					$d{font}{fill}= $lnote[4] ? $lnote[4] : (($drawType =~ /$type[5]/) ? $lcolor : 'black');
					setFontSize($d{font}{'font-size'}*$lnote[1]) if ($lnote[1] > 0);
					$d{font}{'font-family'}=$lnote[2] if ($lnote[2]);
					$g->setFontFamily($d{font}{'font-family'});
					$g->d('txt'.$tmpalign,$lnote[0],'xval',f($x+$w/2),'yval',f($y),@opacity,"style",style($d{font}));
					$d{font}{fill}=$tmpcolor;
					revFontSize() if ($lnote[1] > 0);
					$d{font}{'font-family'}=$tmpfamily;
					$g->setFontFamily($d{font}{'font-family'});
				}
			}#end of %{$xy{$_}}
		}#end of @x
	}#$dotNum
	if ($drawType =~ /$type[3]/) { #Point
		if ($draw{OnlyLine} && ($lastPoint{'x2'} ne $lastPoint{'x'} || $lastPoint{'y2'} ne $lastPoint{'y'})) {
			$d{path}{stroke}=$lastPoint{color};
			$g->d("line","x1",f($lastPoint{'x'}),"y1",f($lastPoint{'y'}),"x2",f($lastPoint{'x2'}),"y2",f($lastPoint{'y2'}),@opacity,"style",style($d{path}),
					"onclick","alert('x:$lastPoint{dispX}\\ny:$lastPoint{dispY}\\nx2:$lastPoint{dispX2}\\ny2:$lastPoint{dispY2}".$lastPoint{nn}."$lastPoint{popNote}')",
					"onmousemove","window.status='x:$lastPoint{dispX}\\ty:$lastPoint{dispY}\\tx2:$lastPoint{dispX2}\\ty2:$lastPoint{dispY2}".$lastPoint{tn}."$lastPoint{statusNote}'"
			); #连线
		}else{
			if ($draw{ExtendLine} && ($lastPoint{'x2'} ne $lastPoint{'x'} || $lastPoint{'y2'} ne $lastPoint{'y'})) {
				$d{path}{stroke}=$lastPoint{color};
				$g->d("line","x1",f($lastPoint{'x'}),"y1",f($lastPoint{'y'}),"x2",f($lastPoint{'x2'}),"y2",f($lastPoint{'y2'}),@opacity,"style",style($d{path})); #连线
				drawPoint($shape,$lastPoint{'x2'},$lastPoint{'y2'},$pointSize,$lastPoint{color},$stroke,$stroke_width,$fill,
					"alert('x2:$lastPoint{dispX2}\\ny2:$lastPoint{dispY2}".$lastPoint{nn}."$lastPoint{popNote}')",
					"window.status='x2:$lastPoint{dispX2}\\ty2:$lastPoint{dispY2}".$lastPoint{tn}."$lastPoint{statusNote}'",@opacity);
			}
			drawPoint($shape,$lastPoint{'x'},$lastPoint{'y'},$pointSize,$lastPoint{color},$stroke,$stroke_width,$fill,
				"alert('x:$lastPoint{dispX}\\ny:$lastPoint{dispY}".$lastPoint{nn}."$lastPoint{popNote}')",
				"window.status='x:$lastPoint{dispX}\\ty:$lastPoint{dispY}".$lastPoint{tn}."$lastPoint{statusNote}'",@opacity);
		}
	}

	###if ($draw{Transparence}) {
	###	$g->e();
	###}
	delete($d{path}{'stroke-dasharray'});
	$drawType;
}

sub drawPoint{
	my ($shape,$x,$y,$pointSize,$color,$stroke,$stroke_width,$fill,$onclick,$onmousemove,@opacity)=@_;
	my %status=();
	if (defined($onclick) && $onclick ne '') {
		$status{'onclick'}=$onclick;
	}
	if (defined($onmousemove) && $onmousemove ne '') {
		$status{'onmousemove'}=$onmousemove;
	}
	if ($stroke) {
		$d{point}{stroke}=$color;
		$d{point}{'stroke-width'}=$stroke_width;
		$d{point}{fill}=$fill;
	}else{
		$d{point}{fill}=$color;
		$d{point}{stroke}='none';
	}

	if ($shape =~ /^circle$/i) {
		$g->d("circle","cx",f($x),'cy',f($y),'r',$pointSize,@opacity,"style",style($d{point}),%status);
	}elsif ($shape =~ /^triangle1$/i) {
		$g->d("polygon","points",
					f($x)." ".f($y-$pointSize).",".
					f($x-$pointSize)." ".f($y+$pointSize).",".
					f($x+$pointSize)." ".f($y+$pointSize),
					@opacity,"style",style($d{point}),%status);
	}elsif ($shape =~ /^triangle2$/i) {
		$g->d("polygon","points",
					f($x)." ".f($y+$pointSize).",".
					f($x-$pointSize)." ".f($y-$pointSize).",".
					f($x+$pointSize)." ".f($y-$pointSize),
					@opacity,"style",style($d{point}),%status);
	}elsif ($shape =~ /^lozenge$/i) {
		$g->d("polygon","points",
					f($x-$pointSize)." ".f($y).",".
					f($x)." ".f($y+$pointSize).",".
					f($x+$pointSize)." ".f($y).",".
					f($x)." ".f($y-$pointSize),
					@opacity,"style",style($d{point}),%status);
	}elsif ($shape =~ /^square$/i) {
		$g->d("rect","xval",f($x-$pointSize),
					 "yval",f($y-$pointSize),
					 "width",f($pointSize*2),
					 "height",f($pointSize*2),
					 @opacity,"style",style($d{point}),%status);
	}elsif ($shape =~ /^polygon(\d+)(.*)/i) {
		my ($n,$angle,$fixAngle,$i,$xDelta,$yDelta,$angleDelta,$pstr,$ptmp);
		$n=$1 > 2 ? $1 : 3;
		$angle=0;
		my $r=$pointSize;#*sqrt(2);
		$fixAngle=360/$n;
		if ($2=~/.(\d+)/) {
			$angle=$1;
			while ($angle>=$fixAngle) {
				$angle-=$fixAngle;
			}
			$angle=360-$angle;
		}
		$ptmp="$n\_$angle\_$r";
		if (!$point{$ptmp}) {
			$angleDelta=$angle;
			for ($i=0;$i<$n;$i++) {
				$xDelta=$r*sin(($angleDelta/180-1)*$PI);
				$yDelta=$r*cos(($angleDelta/180-1)*$PI);
				push @{$point{$ptmp}{xDelta}},$xDelta;
				push @{$point{$ptmp}{yDelta}},$yDelta;
				$angleDelta+=$fixAngle;
			}
		}
		$pstr='';
		for ($i=0;$i<$n ;$i++) {
			$pstr.=f($x+$point{$ptmp}{xDelta}[$i])." ".f($y+$point{$ptmp}{yDelta}[$i]).",";
		}
		chop $pstr;
		$g->d("polygon","points",$pstr,@opacity,"style",style($d{point}),%status);
	}elsif ($shape ne '') {
		my $tmpTxt=$shape;
		my $tmp = $d{font}{fill};
		#setFontSize($d{font}{'font-size'}*$pointSize*2/txtWidth($tmpTxt));
		setFontSize($pointSize*2);
		$d{font}{fill} = $color;
		$d{font}{'baseline-shift'} = '20%';
		$g->d("txtCM",$tmpTxt,
					"xval",f($x),"yval",f($y),@opacity,"style",style($d{font}),%status);
		delete $d{font}{'baseline-shift'};
		$d{font}{fill} = $tmp;
		revFontSize();
	}else{
		error("Point shape is null!",1);
	}
}

sub setFontSize{
	my ($fontSize)=@_;
	push @fontSizeStack,$d{font}{'font-size'};
	$d{font}{'font-size'}=$fontSize;
	$g->setFontSize($fontSize);
	$xFontSpace=$XSPACE/$DEFAULT_FONT_SIZE*$fontSize;
	$yFontSpace=$YSPACE/$DEFAULT_FONT_SIZE*$fontSize;
}

sub revFontSize{
	my $fontSize=pop @fontSizeStack;
	$d{font}{'font-size'}=$fontSize;
	$g->setFontSize($fontSize);
	$xFontSpace=$XSPACE/$DEFAULT_FONT_SIZE*$fontSize;
	$yFontSpace=$YSPACE/$DEFAULT_FONT_SIZE*$fontSize;
}

sub error{
	my($str,$ret)=@_;
	foreach (@errhis) {
		return if ($_ eq $str);
	}
	push(@errhis,$str);
	warn "\n|~|~|~|~|~|~|~|~|~|~|~|~|~|~|\n";
	warn "$ARGV[0]:\n";
	warn "$str\n";
	warn "|_|_|_|_|_|_|_|_|_|_|_|_|_|_|\n";
	die "\n" if (!$ret);
	print "\n";
	return $str;
}

sub style{
	my($style)=@_;
	my $str="";
	for (keys %$style) {
		$str.="$_:$style->{$_};";
	}
	chop($str);
	return $str;
}

sub availDigit{
	my ($num,$n,$rounding,$exp)=@_;
	my ($sign);
	$exp=10 if (!$exp);
	#print "$num\n";
	$sign=$num > 0 ? 1 : -1;
	$num=abs($num);
	return 0 if (!$num);
	my $log10=log($num)/log($exp);
	$n=1 if (!$n);
	$log10 = $log10 >0 ? int($log10) : int($log10)==$log10 ? $log10 : int($log10-1);
	return int($num*$exp**($n-1)/$exp**$log10+0.5*$rounding-0.0000000001)*$exp**$log10/$exp**($n-1)*$sign;
}

sub uint{
	my($num,$div)=@_;
	$div = 1 if (!$div);
	my $tmp=$num/$div;
	if ($tmp!=oint($tmp)) {
		$tmp=oint($tmp+1);
	}
	$tmp*=$div;
	return $tmp;
}

sub rint{
	my($num,$dot)=@_;
	if ($dot) {
		$num/=$dot;
		return oint($num+0.5)*$dot;
	}else{
		return oint($num+0.5);
	}
}

sub oint{
	my($num)=@_;
	if ($num>0) {
		return int($num);
	}else{
		return int($num)==$num ? $num : int($num)-1;
	}
}

sub f{
	my ($num)=@_;
	#return uint($num,1);
	return sprintf("%f",$num);
}

sub max{
	my($m1,$m2)=@_;
	$m1 > $m2 ? $m1 : $m2;
}

sub min{
	my($m1,$m2)=@_;
	$m1 < $m2 ? $m1 : $m2;
}

sub cut{
	my ($num)=@_;
	#return sprintf("%f",$num);
	return oint($num*100000000+0.5)/100000000;
}

sub d{
	my ($num)=@_;
	return $num*1;
}

sub trim {	#trim spaces
    my $string = shift;
    for ($string) {
        s/^\s+//;
        s/\s+$//;
    }
    return $string;
}

sub txtWidth{
	my($str)=@_;
	return $g->textWidth($d{font}{'font-size'},$g->{charspacing},$g->{wordspacing},$g->{hscaling},$str);
}


=pod
基本参数
Type:Point <-类型：目前有Rect、Point、Line等等，区分大小写
Width:600 <-图宽
Height:400 <-图高
WholeScale:0.9 <-整体缩放比例
MarkPos:r <-注释位置 r or l (左或者右)
MarkScale:0.8 <-注释缩放比例
MarkStyle:v <-注释类型 v or h (水平或垂直)
MarkNoBorder:1 <-指明注释不要边框
FontSize:46 <-字体大小
FontFamily:ArialNarrow-Bold <-字体
Note:图顶说明
X:x轴说明
Y:y轴说明
XStep:250 <-x轴刻度步长
YStep:5 <-y轴刻度步长
XStart:0 <-x起始
YStart:75 <-y起始
XEnd:1000 <-x终止
YEnd:100 <-y终止
<-空一行
Color:red <-颜色1
Mark:Intron <-图例1（可空）
x1:y1
x2:y2
.
.
.
<-空一行
Color:blue <-颜色1
Mark:Exon <-图例2（可空）
x1:y1
x2:y2
.
.
.

================================================================================

基本框架
全局参数

局部参数
X轴:Y轴[:Y轴下限[<:颜色|:色深>[:局部注释|字号|字体|对齐方式(CB|CT|LM|...)||颜色[:弹出注释]]]]
X轴:Y轴[:Y轴下限[<:颜色|:色深>[:局部注释|字号|字体|对齐方式|颜色[:弹出注释]]]]
.
.
.

局部参数
X轴:Y轴[:Y轴下限[<:颜色|:色深>[:局部注释|字号|字体|对齐方式|颜色[:弹出注释]]]]
X轴:Y轴[:Y轴下限[<:颜色|:色深>[:局部注释|字号|字体|对齐方式|颜色[:弹出注释]]]]
.
.
.

.
.
.

<a|b> 表示a或者b
单独的|作为分隔符

================================================================================

全局参数：
AvailDigit <-坐标取值的有效数字
Align <-[[直方图]|[折线图]]的对齐方式
BothYAxis <-是否两边都有坐标轴
Fill <-[折线图]填充线与横坐标之间的部分
FontBold <-使用粗体字
FontFamily <-字体
FontSize <-字号
HaveLess <-左边有数据超出范围
HaveMore <-右边有数据超出范围
Height <-图高（边框高度）
LineDash <-[折线图]使用点划线（值表示点划比例）
LineWidth <-[折线图]线宽
Mark2Border <-自由标记是否有边框
Mark2Pos <-自由标记位置（l：左边；r：右边；lb：左下；rb：右下）
Mark2Scale <-自由标记比例
MarkNoBorder <-标记是否有边框
MarkPos <-标记位置（l：左边；r：右边；lb：左下；rb：右下）
MarkScale <-标记比例
MarkStyle <-标记类型（h：水平；v：垂直）
MultiRY <-右边采用多重坐标
MultiY <-左边采用多重坐标
NoConnect <-[点状图]点间不连线；[折线图][XUnit>0]平折线间不连线
NoFillZero <-[折线图][XUnit>0]连线时无数据的地方不连。
NoLine <-同 NoConnect
Note <-顶部说明
Part <-[[直方图]|[折线图]][XUnit>0]柱状交错图分成几部分
PointSize <-[点状图]点的大小
RightAngle <-[折线图]连线时采用直角
ScaleLen <-刻度线长度
Transparence <-透明度[0-1]
Type <-类型：目前有Rect、Point、Line、Text等等，区分大小写
OffsetPer <-[[直方图]|[折线图]][XUnit>0]柱状交错图每部分的偏移量，OffsetPer个单位宽度
UnitPer <-[[直方图]|[折线图]][XUnit>0]柱状交错图每部分的宽度，UnitPer个单位宽度
MovePer <-[[直方图]|[折线图]][XUnit>0]整体移动 MovePer个单位宽度
VerticalLine <-[点状图]连线时只保留垂直线（暂时无法只连接水平线）
WholeScale <-整体缩放比例
Width <-图宽
X <-x轴说明
Y <-y轴说明
RY <-右边y轴说明 （以下用ry表示右边y轴）
XDDigits <-x轴坐标取值小数点后保留的位数
YDDigits <-y轴坐标取值小数点后保留的位数
RYDDigits <-ry轴坐标取值小数点后保留的位数
XDispStep <-x轴隔 XDispStep个XStep 显示一个坐标值
YDispStep <-y轴隔 YDispStep个YStep 显示一个坐标值
RYDispStep <-ry轴隔 RYDispStep个RYStep 显示一个坐标值
XDiv <-x轴坐标缩小 XDiv 倍
YDiv <-y轴坐标缩小 YDiv 倍
RYDiv <-ry轴坐标缩小 RYUDiv 倍
XEnd <-x轴终点坐标
YEnd <-y轴终点坐标
RYEnd <-ry轴终点坐标
XExp <-x轴采用指数形式表示 XExp
YExp <-y轴采用指数形式表示
RYExp <-ry轴采用指数形式表示
XLog <-x轴坐标已经取过对数
YLog <-y轴坐标已经取过对数
RYLog <-ry轴坐标已经取过对数
XNeedLog <-x轴坐标需要取对数
YNeedLog <-y轴坐标需要取对数
RYNeedLog <-ry轴坐标需要取对数
XScaleDiv <-x轴每个XStep中细分的子刻度个数
YScaleDiv <-y轴每个YStep中细分的子刻度个数
RYScaleDiv <-ry轴每个RYStep中细分的子刻度个数
XScalePos <-x轴刻度偏移 XScalePos个XStep宽度
YScalePos <-y轴刻度偏移 YScalePos个YStep宽度
RYScalePos <-ry轴刻度偏移 RYScalePos个RYStep宽度
XStart <-x轴起点坐标
YStart <-y轴起点坐标
RYStart <-ry轴起点坐标
XStep <-x轴打印坐标值的步长
YStep <-y轴打印坐标值的步长
RYStep <-ry轴打印坐标值的步长
XZeroPos <-x轴零点移动 XZeroPos个图宽
YZeroPos <-y轴零点移动 YZeroPos个图宽
RYZeroPos <-ry轴零点移动 RYZeroPos个图宽
XZeroVal <-x轴绝对零点实际坐标值
YZeroVal <-y轴绝对零点实际坐标值
RYZeroVal <-ry轴绝对零点实际坐标值
XScaleRoate <-x轴坐标值旋转角度
XScaleLinePos <-[XUnit>0]x轴刻度线偏移 XScaleLinePos个单位宽度
XUnit <-单位宽度
XCut <-[XZeroPos!=0]截断超出x轴范围的数据
YCut <-[YZeroPos!=0]截断超出y轴范围的数据
YHasLow <-[直方图]y轴有下界值
YNum <-强制y轴坐标值以 YNum 作参考对齐
RYNum <-强制ry轴坐标值以 RYNum 作参考对齐
LinearGradient <-线形渐变 格式：[H|V]|0:#EEEEEE;0.8:gray
XMove <-x轴偏移 XMove个XStep宽度
YMove <-y轴偏移 YMove个YStep宽度
RYMove <-ry轴偏移 RYMove个RYStep宽度
ExtendLine:1 <-[点状图] 增加到x2|y2的连线
OnlyLine:1 <-[点状图] 用到x2|y2的连线代替点
NoFrame:1 <-不画边框
NoScaleLine:1 <-不画刻度线
NoXScale:1 <-不显示x轴刻度及刻度线
NoYScale:1 <-不显示y轴刻度及刻度线

全局多值参数：
Note2: <-在最下面加上注释
:End
Group: <-x轴坐标值分组显示
组名1:坐标值个数
组名2:坐标值个数
.
.
.
:End
Mark2: <-自由标记
:End
XScale: <-自定义x轴坐标值
:End
YScale: <-自定义y轴坐标值
:End
RYScale: <-自定义ry轴坐标值
:End

局部参数：
Type <-局部类型：目前有Rect、Point、Line、LineBar等等，区分大小写
Color <-颜色，名称或#rrggbb
Mark <-标记值
YAxis <-y轴度量采用的标准 y|ry
YMark <-y轴坐标值标记位置 y|ry
YHasLow <-[直方图]y轴有下界值
XCut <-[XZeroPos!=0]截断超出x轴范围的数据
Start <-y轴起点坐标
End <-y轴终点坐标
Step <-y轴打印坐标值的步长
ZeroVal <-y轴绝对零点实际坐标值
ZeroPos <-y轴零点移动 ZeroPos个图宽
ColorStep <-颜色递增步长，Color为最浅色
LightColor <-颜色从LightColor过渡到Color，Color为最深色
SmoothColor <-点深差距过大时，平滑色深
Transparence <-透明度[0-1]
NoLine <-[点状图]点间不连线；[折线图][XUnit>0]平折线间不连线
NoConnect <-同 NoLine
LineDash <-[折线图]使用点划线（值表示点划比例）
LineWidth <-[折线图]线宽
NoFillZero <-[折线图][XUnit>0]连线时无数据的地方不连。
Fill <-[折线图]填充线与横坐标之间的部分
NoFill <-[直方图]无填充
PointSize <-[点状图]电的大小
AlignPos <-[自由文字]对齐方式 LT,LM,LB,CT,CM,CB,RT,RM,RB
TextScale <-[自由文字]缩放比例
Rounded <-[直方图]圆头

局部多值参数：
Scale: <-自定义y轴坐标值
:End

[注：多值参数格式为
参数名:
参数值1
参数值2
.
.
.
:End
]
=cut
