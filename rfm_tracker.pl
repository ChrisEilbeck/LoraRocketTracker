#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

use threads;
use threads::shared;

use rfm_tracker_gpsthread qw(gps_thread);

my $finished :shared =0;

my @rfmthreads;

push(@rfmthreads,threads->create(\&gps_thread));

foreach my $thr (@rfmthreads)	{	$thr->join();	}

##while(!$finished)	{}

print("endmain\n");

