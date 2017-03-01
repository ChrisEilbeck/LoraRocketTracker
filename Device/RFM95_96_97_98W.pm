#!/usr/bin/perl

use strict;
use warnings;

package Device::RFM95_96_97_98W;
require Exporter;

our @ISA=qw(Exporter);

our @EXPORT_OK=qw(
                    ReadFIFO
                    WriteFIFO
                );
                
use Data::Dumper;
use Log::Log4perl;

sub ReadFIFO($$)
{
    my ($logger,$len)=@_;
    
    $logger->trace("ReadFIFO() entry");
    $logger->debug("ReadFIFO()");
    
    my $retval;
    
    $logger->trace("ReadFIFO() exit");
    
    return($retval);
}

sub WriteFIFO($$)
{
    my ($logger,$bytes)=@_;
    
    $logger->trace("WriteFIFO() entry");
    $logger->debug("WriteFIFO()");
    
    my $retval;
    
    $logger->trace("WriteFIFO() exit");
    
    return($retval);
}

1;
