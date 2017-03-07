#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;
use Proc::Daemon;

use threads;
use threads::shared;

#use rfm_tracker_gpsthread qw(gps_thread);

use Device::RFM95_96_97_98W;

my $finished :shared =0;

if(0)
{
    my @rfmthreads;
    push(@rfmthreads,threads->create(\&gps_thread));

    foreach my $thr (@rfmthreads)	{	$thr->join();	}
}

my $rfm=Device::RFM95_96_97_98W->new();

##$rfm->QuickHack();

$rfm->SetFrequency(433.920);

my $freq=$rfm->GetFrequency();

if(defined($freq))
{
    printf("freq = %3.3f\n",$freq);
}

##while(!$finished)	{}

print("endmain\n");

