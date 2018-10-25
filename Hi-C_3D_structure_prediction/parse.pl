#!/usr/bin/perl

use strict;
use warnings;

my @x;
my @y;
my @z;
open IN,"<","output-3D.txt" or die "$!";
<IN>;
while(<IN>){
	chomp;
	# print "$_";
	my @in = split/\ /;
	push @x, $in[0];
	push @y, $in[1];
	push @z, $in[2];
}
close IN;

open OUT,">","visual/js/index.js" or die "$!";
print OUT "var data=[\n";
print OUT "    {\n";
print OUT "    opacity: 1,\n";
print OUT "    type: 'scatter3d',\n";
print OUT "    name: '3D',\n";
print OUT "    x: [";
for my $i (0 .. $#x-1)
{
      print OUT "$x[$i],";
}
print OUT "$x[$#x]\]\,\n";

print OUT "    y: [";
for my $i (0 .. $#y-1)
{
      print OUT "$y[$i],";
}
print OUT "$y[$#y]\]\,\n";

print OUT "    z: [";
for my $i (0 .. $#z-1)
{
      print OUT "$z[$i],";
}
print OUT "$z[$#z]\]\,\n";

print OUT "    }\n";
print OUT "];\n";
print OUT "var layout = {\n";
print OUT "  scene:{\n";
print OUT "  aspectmode: \"manual\",\n";
print OUT "    aspectratio: {\n";
print OUT "    x: 1,\n";
print OUT "    y: 1,\n";
print OUT "    z: 1,\n";
print OUT "  },\n";
print OUT "  xaxis: {\n";
print OUT "    nticks: 5,\n";
print OUT "    range: [-150, 150],\n";
print OUT "  },\n";
print OUT "  yaxis: {\n";
print OUT "    nticks: 5,\n";
print OUT "    range: [-150, 150],\n";
print OUT "  },\n";
print OUT "  zaxis: {\n";
print OUT "    nticks: 5,\n";
print OUT "    range: [-150, 150],\n";
print OUT "  }},\n";
print OUT "  autosize: false,\n";
print OUT "  width: 1024,\n";
print OUT "  height: 1024,\n";
print OUT "  margin: {\n";
print OUT "    l: 0,\n";
print OUT "    r: 0,\n";
print OUT "    b: 0,\n";
print OUT "    t: 0,\n";
print OUT "    pad: 4\n";
print OUT "  },\n";
print OUT "};\n";
print OUT "Plotly.newPlot('myDiv', data, layout);\n";

close OUT;
