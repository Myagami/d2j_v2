#!/usr/bin/env perl
#
use strict ;
use warnings ;
use lib '/home/hayate/Tools/d2j_v2/' ;
use lib::d2j ;
use Getopt::Long 'GetOptions';


#引数受取
my $cnf = "monitor" ;
my $input_f = "./" ;
my $out_f = "out.txt" ;
my $dmp_f = "dump.txt" ;
GetOptions(
    'conf=s' => \$cnf ,
    'input=s' => \$input_f,
    'out=s' => \$out_f,
    'dump=s' => \$dmp_f,
 );


print "Conf:".$cnf."\n" ;
print "input:".$input_f."\n" ;
print "Out:".$out_f."\n" ;
print "Dump:".$dmp_f."\n" ;

