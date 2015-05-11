#!/usr/bin/env perl
#
use strict ;
use warnings ;
use lib '/home/hayate/Tools/d2j_v2/' ;
use lib::d2j ;
use Getopt::Long 'GetOptions';
use Data::Dumper ;

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

#テスト出力
print "Conf:".$cnf."\n" ;
print "input:".$input_f."\n" ;
print "Out:".$out_f."\n" ;
print "Dump:".$dmp_f."\n" ;

#処理開始
#データ読込
my $d2j = lib::d2j->new() ;
my $cnf_d = $d2j->Load_ConfigFile($cnf) ;
print "-"x20 ;
print "\n"  ;
my @work_files = $d2j->Get_DatList() ;
#print Dumper(@work_files) ;
my @names = $d2j->Get_Name(@work_files) ;
my @names_jp = $d2j->Translate_jp(@names) ;


#データ書込
open(my $file_h,">",$out_f) or die("File can't open") ;

my $i = 0 ; 
while($i < $#names){
    print $names[$i]."\n" ;
    print $names_jp[$i]."\n" ;

    print $file_h $names[$i]."\n" ;
    print $file_h $names_jp[$i]."\n" ;
    $i++ ;
}

#print "Count:".$#names.":".$#names_jp."\n" ;
