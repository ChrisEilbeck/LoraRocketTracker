#!/usr/bin/perl

use strict;
use warnings;

package rfm_tracker_gpsthread;
require Exporter;

our @ISA=qw(Exporter);

our @EXPORT_OK=qw(	
                    gps_thread
                );

use Data::Dumper;
use DateTime;
use Log::Log4perl;

use constant GPS_DEVICE	=>	"/dev/ttyAMA0";

sub gps_thread()
{
    `stty cs8 115200 -ixon -crtscts < /dev/ttyAMA0`;
    
    my $gps;
    open($gps,"<".GPS_DEVICE);
    
    if(!defined($gps))
    {
        return(undef);
    }
    
    my $fix={
            'Longitude'		=>	undef,
            'NorthSouth'	=>	undef,
            'Latitude'		=>	undef,
            'EastWest'		=>	undef,
            'Altitude'		=>	undef,
            'ValidStored'	=>	undef,
            'HDOP'			=>	undef,
            'VDOP'			=>	undef,
            'PDOP'			=>	undef,
            'DateTime'		=>	undef,
        };
    
    while(!$main::finished)
    {
        my $line=<$gps>;
		$line=~s/\x0d//g;
		$line=~s/\x0a//g;
        
##		print($line."\n");
        
        my ($data,$checksum)=split(/\*/,$line);
        
        my @fields=split(/,/,$data);
        
        if($fields[0] eq '$GPGLL')
        {
            ## this is the last message for a burst of data for a fix computation
            
##			print(Dumper($fix));            
        
        }
        elsif($fields[0] eq '$GPGGA')
        {
##			print($line."\n");
            
            my (	$msg,
                    $gpstime,
                    $latitude,
                    $ns,
                    $longitude,
                    $ew,
                    $fixvalid,
                    $sats,
                    $hdop,
                    $altitude,
                    $altmeters,
                    $height,
                    $heightmeters,
                    $timesincelast,
                    $dpgs)			=	@fields;
            
         
            if((length($fixvalid)>0)&&($fixvalid!=0))
            {   
##				$gpstime
                
                $latitude=substr($latitude,0,2)+(substr($latitude,2)/60);
                $longitude=substr($longitude,0,3)+(substr($longitude,3)/60);
                
##				print($gpstime."\t".$latitude."\t".$longitude."\t".$alt."\n");
                printf("%6.0f\t% 2.6f\t% 3.6f\t%3.1f\n",$gpstime,$latitude,$longitude,$altitude);
                
                if($ns eq 'N')	{	$fix->{'Latitude'}=$latitude;		}
                else			{	$fix->{'Latitude'}=-$latitude;		}
                
                if($ew eq 'E')	{	$fix->{'Longitude'}=$longitude;		}
                else			{	$fix->{'Longitude'}=-$longitude;	}
                
                $fix->{'Altitude'}=$altitude;
                
                $fix->{'ValidStored'}='Valid';
            }
            else
            {
                print("Fixed is invalid ...\n");

                $fix->{'ValidStored'}='Stored';
            }
        }
        elsif($fields[0] eq '$GPRMC')
        {
            print("\x1b[2J");
            print("\x1b[H");
            
            my ( 	$msg,
                    $gpstime,
                    $activeorvoid,
                    $latitude,
                    $ns,
                    $longitude,
                    $ew,
                    $speedoverground,
                    $trackangle,
                    $gpsdate,
                    $magneticvariation,
                    $magvar_ew)			=	@fields;
            
            if($activeorvoid eq 'A')
            {
                my $hour=substr($gpstime,0,2);
                my $min=substr($gpstime,2,2);
                my $sec=substr($gpstime,4,2);
                
                my $mday=substr($gpsdate,0,2);
                my $mon=substr($gpsdate,2,2);
                my $year=substr($gpsdate,4,2)+2000;
                
                my $dt=DateTime->new(
                                        'year'		=>	$year,
                                        'month'		=>	$mon,
                                        'day'		=>	$mday,
                                        'hour'		=>	$hour,
                                        'minute'	=>	$min,
                                        'second'	=>	$sec,
                                    );
                
                print($dt->iso8601()."\n");
                print($dt->epoch()."\n");
                
                $fix->{'DateTime'}=$dt;

                $fix->{'ValidStored'}='Valid';
            }
            else
            {
                print("Fixed is invalid ...\n");
                
                $fix->{'ValidStored'}='Stored';
            }
        }
        elsif($fields[0] eq '$GPGSA')
        {
            print($line."\n");

            my (	$msg,
                    $mode,
                    $fixmode,
                    $s1,$s2,$s3,$s4,$s5,$s6,$s7,$s8,$s9,$s10,$s11,$s12,
                    $pdop,
                    $hdop,
                    $vdop		)	=	@fields;
            
            if(0)
            {
            print(Dumper(	$msg,
                            $mode,
                            $fixmode,
                            $s1,$s2,$s3,$s4,$s5,$s6,$s7,$s8,$s9,$s10,$s11,$s12,
                            $pdop,
                            $hdop,
                            $vdop		          ));
            }
            
            my @sats;
             
            foreach my $sat ($s1,$s2,$s3,$s4,$s5,$s6,$s7,$s8,$s9,$s10,$s11,$s12)
            {
                if(length($sat)>0)	{	push(@sats,scalar($sat));	}
            }
            
            print(Dumper(\@sats));
            
            print(scalar(@sats)."\n");

            $fix->{'PDOP'}=$pdop;
            $fix->{'HDOP'}=$hdop;
            $fix->{'VDOP'}=$vdop;
            
            print("hdop = ".$fix->{'HDOP'}."\tvdop = ".$fix->{'VDOP'}."\tpdop = ".$fix->{'PDOP'}."\n");
        }
        else
        {
##			print($fields[0]." not decoded ...\n");
        }
    }

	$main::finished=1;
}

1;
