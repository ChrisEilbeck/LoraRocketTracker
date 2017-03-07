#!/usr/bin/perl

package Device::RFM95_96_97_98W;

##require Exporter;

##our @ISA=qw(Exporter);

##our @EXPORT_OK=qw(
##                    OpenDevice
##                    ReadFIFO
##                    WriteFIFO
##                );

use strict;
use warnings;

use Data::Dumper;
use HiPi::Device::SPI qw( :spi );
#use Log::Log4perl;

use Device::RFM95_96_97_98W::Constants;
#use Device::RFM95_96_97_98W::FSKOOKMode;
#use Device::RFM95_96_97_98W::LoraMode;

use Moose;
             
has 'dev'			=>	(
                            is		=>	'ro',
                            default	=>	sub
                                        {
                                            my $dev=HiPi::Device::SPI->new(
                                                                            devicename	=>	'/dev/spidev0.1',
                                                                            speed		=>	SPI_SPEED_MHZ_1,
                                                                            bitsperword	=>	8,
                                                                            delay		=>	0,
                                                                        );
                                            
                                            if(defined($dev))
                                            {
                                                $dev->set_bus_mode(SPI_MODE_0);
                                            }
                                            
                                            return($dev);
                                        },
                        );
                        
sub QuickHack()
{
    my ($self)=@_;
    
#	my @writecommand=(0x80|RegFrMsb,0x12,0x34,0x56);
    my @writecommand=(0x80|RegFrMsb,0x6c,0xa9,0x99);
    my @writeresponse=unpack("C4",$self->dev->transfer(pack("C4",@writecommand)));
    
    my @readcommand=(RegFrMsb,0,0,0);
    my @readresponse=unpack("C4",$self->dev->transfer(pack("C4",@readcommand)));

    print(Dumper(\@readcommand));
    print(Dumper(\@readresponse));
}

sub SetFrequency($)
{
    my ($self,$frequency)=@_;
    
    my $frequencyvalue=int($frequency*7110656/434);

    my $frmsb=int($frequencyvalue/65536);
    my $frmid=int(($frequencyvalue-65536*$frmsb)/256);
    my $frlsb=int($frequencyvalue-65536*$frmsb-256*$frmid);

    if(0)
    {
        print($frequency."\n");
        print($frequencyvalue."\n");
        print($frmsb."\n");
        print($frmid."\n");
        print($frlsb."\n");
    }

    printf("freq = %3.3f\n",$frequency);

    $self->WriteRegister(RegFrMsb,pack("C*",$frmsb,$frmid,$frlsb));
}

sub GetFrequency()
{
    my ($self)=@_;
 
    my $response=$self->ReadRegister(RegFrMsb,3);

    my @resp=unpack("C*",$response);
    
    if(0)
    {
        print(Dumper(\@resp));
    }
    
    my $frequencyvalue=65536*$resp[1]+256*$resp[2]+$resp[3];
    
    my $frequency=434*$frequencyvalue/7110656;
    
    return($frequency);
}

sub ReadRegister($$)
{
    my ($self,$reg,$len)=@_;
 
#    $logger->trace("ReadRegister() entry");
#    $logger->debug("ReadRegister()");
    
    if(		!defined($reg)
        ||	!defined($len)	)
    {
        return(undef);
    }
    
    $reg&=0x7f;		## unset the write bit in the register number
    
    my @cmd;
    
    push(@cmd,$reg);
    for(my $cnt=0;$cnt<$len;$cnt++)	{	push(@cmd,0);	}

    print("command  = ".unpack("H*",pack("C*",@cmd))."\n");
    
    my @response=unpack("C*",$self->dev->transfer(pack("C*",@cmd)));
    
    print("response = ".unpack("H*",pack("C*",@response))."\n");
    
#    $logger->trace("ReadRegister() exit");
    
    return(pack("C*",@response));
}

sub WriteRegister($$)
{
    my ($self,$reg,$bytes)=@_;
    
#    $logger->trace("WriteRegister() entry");
#    $logger->debug("WriteRegister()");
    
    $reg|=0x80;		## set the write bit in the register number
    
    my @cmd;
    
    push(@cmd,$reg);
    for(my $cnt=0;$cnt<length($bytes);$cnt++)	{	push(@cmd,unpack("C",substr($bytes,$cnt,1)));	}

    print("command  = ".unpack("H*",pack("C*",@cmd))."\n");
    
    my @response=unpack("C*",$self->dev->transfer(pack("C*",@cmd)));
    
    print("response = ".unpack("H*",pack("C*",@response))."\n");
    
#    $logger->trace("WriteRegister() exit");
    
    return(undef);
}

sub ReadFIFO($$)
{
    my ($logger,$len)=@_;
    
    $logger->trace("ReadFIFO() entry");
    $logger->debug("ReadFIFO()");
    
#    my $retval=ReadRegister($logger,RegFifo,$len);
    
    $logger->trace("ReadFIFO() exit");
    
#    return($retval);
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




no Moose;
__PACKAGE__->meta->make_immutable;
