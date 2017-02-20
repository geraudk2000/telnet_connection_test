#!/usr/bin/perl
#this script test telent connection for hosts in files
#And print in stdout
#Version 1 By Geraud

use strict;
use warnings;
use autodie; # die if problem reading or writing a file
use Net::Telnet;


my $timeout = 3;
my $file = 'test_telnet.txt';
my $ssh_port = 22;
my $telent_port = 23;


open(my $data, '<', $file)
  or die "Could not open file '$file' $!";

open(my $fh, '>', 'KoTelnet.txt' )
    or die "Could not open file noPing.txt";


my $telnet = Net::Telnet-> new(Timeout=> $timeout, Errmode=> 'return');
my $ssh = Net::Telnet -> new(Timeout=> $timeout, Errmode => 'return');

while (my $line = <$data>){
        chomp $line;
        my @fields = split ";", $line;

        if ($telnet->open (Host => $fields[0], Port => 23)){
            print "$fields[0] is available and  Telnet_OK \n";

        }
        elsif ($ssh->open (Host => $fields[0], Port => 22)){
            print "$fields[0] is avaiblable and SSH_OK\n";
        }
        else{
                print "$fields[0] is not available \n [Telnet and SSH NOK] ";
                print $fh "$fields[0];$fields[1]\n";
        }

        sleep(1);
}

$telnet->close();
$ssh->close();
close $data;
close $fh;
