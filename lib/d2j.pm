package lib::d2j ;

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

    my $data = Parse_Data($cnf_p) ;
    sub Parse_Data{
	my $cnf_p = shift ;
	my $cnf_d = Null ;
	my $cnf_k = Null ;
	open(my $file_h,"<","./".$cnf_p) or die("File can't open") ;	
	while(my $line =  readline($file_h)){
	    chomp($line) ;
	    if($line =~ /\-{3}\[([A-z]{1,})\]-{3}/){
		print "Cont:".$line."\n" ;
		$cnf_k = $1 ;
	    }else{
		print $cnf_k.":" ;
		print $line."\n" ;
		
	    }
	}
    }
}

1;
