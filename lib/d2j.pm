package lib::d2j ;
our %conf ;
local @Format_Key ;
sub new{#インスタンス生成
    my $pak = shift ;
    my $hash = {
    };
    bless $hash,$pak;    
}

sub Load_ConfigFile{#設定ファイル読み込み
    my $self = shift ;
    my $cnf_p = shift ;
    print $cnf_p."\n" ;

    %conf = Parse_Data($cnf_p) ;

    sub Parse_Data{
	my $cnf_p = shift ;
	my %cnf_d ;
	my $cnf_k = Null ;
	open(my $file_h,"<","/home/hayate/Tools/d2j_v2/config/".$cnf_p.".conf") or die("File can't open") ;	
	while(my $line =  readline($file_h)){
	    chomp($line) ;	
	    if($line =~ /\-{3}\[([A-z]{1,})\]-{3}/){
		print "Cont:".$1."\n" ;
		$cnf_k = $1 ;
	    }elsif($line =~ /^([A-z0-9]{1,}) = (.*)$/){
		$cnf_d{$cnf_k}{$1} = $2 ;
		print $cnf_k.":" ;
		print $1."\n" ;
		print "Trans:".$2."\n" ;
	    }
	}
	#print Data::Dumper::Dumper(%cnf_d) ;
	return %cnf_d ;
    }
}

sub Get_DatList{
    return glob "*.dat" ;
}

sub Get_Name{#名前を取得する
    my $self = shift ;
    my @dats =  @_ ;
    my @names ;

    foreach my $dat(@dats){
	#print $dat."\n" ;
	open(my $file_h,"<","./".$dat) or die("File can't open") ;
	while(my $line =  readline($file_h)){
	    chomp($line) ;
	    if($line =~ /name=(.*)/){
		push(@names,$1) ;
	    }
	}
	close($file_h) ;
    }
    return @names ;
}

#日本語訳
sub Translate_jp{
    #変数宣言
    local @Format_Key ;
    my $self = shift ;
    my @jp_name ;
    my @names = @_ ;

    #翻訳用フォーマットキー取得
    @Format_Key = split(/,/,$conf{"Format"}{"Key"}) ;
    #print Data::Dumper::Dumper(@Format_Key)."\n" ;


    #データ取得
    foreach my $name_d(@names){
	#print $name_d."\n" ;
	my %name_Ad = GetData($name_d) ;
	#$name_Ad{"Camp"} = Campany($name_Ad{"Camp"}) ;
	&Campany(\$name_Ad{"Camp"}) ;
	&TypeCar(\$name_Ad{"Type"}) ;
	&SeriesCar(\$name_Ad{"Series"}) ;
	&Name_Replace(\$name_Ad{"Replace"}) ;
	my $name_Fm = &Format_Embed(\%name_Ad) ;
	push(@jp_name,$name_Fm);
    }

    #print Data::Dumper::Dumper(@jp_name)."\n" ;

    return @jp_name ;

    #内部関数
    sub GetData{
	#データ受取
	my $name = shift ;
	my $In_Reg =  $conf{"Format"}{"In"} ;
	my %Name_Ad ;
	#データ処理
	#正規表現で取得
	my @match = $name =~ /${In_Reg}/ ;
	#print Data::Dumper::Dumper(@match)."\n" ;
	my $i = 0 ;

	while($i+1 < $#Format_Key+2){#取得したデータをハッシュに格納する
	    print $i.":" ;
	    print $Format_Key[$i].":" ;
	    print $match[$i]."\n" ;
	    
	    $Name_Ad{$Format_Key[$i]} = $match[$i] ;
	    $i++ ;
	}

	return %Name_Ad ;
    }
    sub Campany{#会社名
	my $name = shift ;
	$$name =  $conf{"Campany"}{$$name} ;
    }

    sub TypeCar{
	my $name = shift ;
	if(undef($conf{"Type"})){
	    $$name = $conf{"Type"}{$$name}
	}
    }

    sub SeriesCar{
	my $name = shift ;
	if(undef($conf{"Series"})){
	    $$name = $conf{"Series"}{$$name}
	}
    }

    sub Car_Type{#車両型式
	my $name = shift ;
	$$name =  $conf{"Type"}{$$name} ;
    }

    sub Name_Replace{#置換
	my $name = shift ;
	if(undef($conf{"Replace"})){
	    $$name = $conf{"Replace"}{$$name}
	}
    }

    sub Format_Embed{
	my $data = shift ;
	my $outd = $conf{"Format"}{"Out"} ; 
	foreach my $key(keys($data)){
	    $outd =~ s/\[$key\]/$$data{$key}/ ;
	    #print "Key:".$key."/ Val:".$$data{$key}."\n" ;
	}

	print "---"x10 ;
	print "\n" ;
	return $outd ;
    }
}

1;
