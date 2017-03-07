#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

use HiPi::Device::SPI qw( :spi );

my $dev=HiPi::Device::SPI->new(
    devicename	=>	'/dev/spidev0.1',
    speed		=>	SPI_SPEED_MHZ_1,
    bitsperword	=>	8,
    delay		=>	0,
);

$dev->set_bus_mode(SPI_MODE_0);

#my $cmd="\x06\x00\x00\x00";

my @buffer=(6,0,0,0);
my @vals=unpack("C4",$dev->transfer(pack("C4",@buffer)));

print(Dumper(\@buffer));
print(Dumper(\@vals));

1;
