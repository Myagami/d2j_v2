package lib::d2j ;
use Getopt::Long 'GetOptions';

sub new{#インスタンス生成
    my $pak = shift ;
    my $hash = {
    };
    bless $hash,$pak;    
}

sub Load_Opts{
    GetOptions(
	'conf=s' => \$conf
	);
    return $conf ;
}

1;
