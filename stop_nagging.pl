#!/usr/bin/env perl

use warnings;
use strict;
use File::HomeDir qw(home); #just a fancy way to get to your home directory, can be commented out if you just explicitly define $DEFAULT_REMMINA

#modify this if your remmina connection profiles are stored elsewhere
my $DEFAULT_REMMINA = home().'/.remmina';


&main;

sub main{


	my $profiles = &show_profiles($DEFAULT_REMMINA);

	print "\nIs $DEFAULT_REMMINA where your connection profiles are stored? ";
	my $response = <>;

	if($response =~/^y/i){
		&modify_profiles($profiles);
		print "done.\n";
	}
}


sub modify_profiles{
	my($profiles)=@_;
	foreach my $profile (@$profiles){
		if($profile =~ /\.remmina$/){
			my $file =  $DEFAULT_REMMINA.'/'.$profile;
			open(INPUT,"$file") or die "can't open $file";
			my @contents=<INPUT>;
			close(INPUT);

			if(grep(/protocol=RDP/,@contents)){
				if(! grep(/security=rdp/,@contents)){

				open(OUTPUT,">>$file") or die "can't open $file";
				print OUTPUT "security=rdp\n";
				close(OUTPUT);

				}
			}
		}
	}
}



sub show_profiles{
	my($dir)=@_;
	my $retval;

	if(-d $dir){
		opendir(my $rd,$dir);
		my @profiles = readdir($rd);
		print "these are the contents of $dir\n\n";
		foreach my $profile (sort @profiles){
			print "$profile ";
		}
		print "\n";
		$retval=\@profiles;
	}else{
		print "Path doesn't exist\n";
		$retval=0;
	}
	return($retval);
}
