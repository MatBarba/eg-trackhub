
# do first:
# export THR_USER=your_user_name_in_your_track_hub_registry_account
# export THR_PWD=your_password_in_your_track_hub_registry_account

use strict ;
use warnings;

use Registry;


my $registry_user_name = $ENV{'THR_USER'}; 
my $registry_pwd = $ENV{'THR_PWD'};


my $registry_obj = Registry->new($registry_user_name, $registry_pwd,"public"); # dosn't matter the visibility setting in this case

my %track_hub_names = %{$registry_obj->give_all_Registered_track_hub_names()};

foreach my $study_name (keys %track_hub_names){
  print $study_name."\n";
}