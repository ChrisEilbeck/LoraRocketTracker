#!/usr/bin/perl

use strict;
use warnings;

package Device::RFM95_96_97_98W;
require Exporter;

our @ISA=qw(Exporter);

our @EXPORT_OK=qw(
                    RegFifo
                    RegOpMode
                    RegFrMsb
                    RegFrMid
                    RegFrLsb
                    RegPaConfig
                    RegPaRamp
                    RegOcp
                    RegLna
                    RegDioMapping1
                    RegDioMapping2
                    RegVersion
                    RegTcxo
                    RegPaDac
                    RegFormerTemp
                    RegAgcRef
                    RegAgcThresh1
                    RegAgcThresh2
                    RegAgcThresh3
                    RegBitRateMsb_FskOok
                    RegBitRateLsb_FskOok
                    RegFdevMsg_FskOok
                    RegFdevLsb_FskOok
                    RegRxConfig_FskOok
                    RegRssiConfig_FskOok
                    RegRssiCollision_FskOok
                    RegRssiThreshold_FskOok
                    RegRssiValue_FskOok
                    RegRxBw_FskOok
                    RegAfcBw_FskOok
                    RegOokPeak_FskOok
                    RegOokFix_FskOok
                    RegOokAvg_FskOok
                    Reserved17_FskOok
                    Reserved18_FskOok
                    Reserved19_FskOok
                    RegAfcFei_FskOok
                    RegAfcMsb_FskOok
                    RegAfcLsb_FskOok
                    RegFeiMsb_FskOok
                    RegFeiLsb_FskOok
                    RegPreambleDetect_FskOok
                    RegRxTimeout1_FskOok
                    RegRxTimeout2_FskOok
                    RegRxTimeout3_FskOok
                    RegRxDelay_FskOok
                    RegOsc_FskOok
                    RegPreambleMsb_FskOok
                    RegPreambleLsb_FskOok
                    RegSyncConfig_FskOok
                    RegSyncValue1_FskOok
                    RegSyncValue2_FskOok
                    RegSyncValue3_FskOok
                    RegSyncValue4_FskOok
                    RegSyncValue5_FskOok
                    RegSyncValue6_FskOok
                    RegSyncValue7_FskOok
                    RegSyncValue8_FskOok
                    RegPacketConfig1_FskOok
                    RegPacketConfig2_FskOok
                    RegPayloadLength_FskOok
                    RegNodeAdrs_FskOok
                    RegBroadcastAdrs_FskOok
                    RegFifoThresh_FskOok
                    RegSeqConfig1_FskOok
                    RegSeqConfig2_FskOok
                    RegTimerResol_FskOok
                    RegTimer1Coef_FskOok
                    RegTimer2Coef_FskOok
                    RegImageCal_FskOok
                    RegTemp_FskOok
                    RegLowBat_FskOok
                    RegIrqFlags1_FskOok
                    RegIrqFlags2_FskOok
                    RegPllHop_FskOok
                    RegBitRateFrac_FskOok
                    RegFifoAddrPtr_Lora
                    RegFifoTxBaseAddr_Lora
                    RegFifoRxBaseAddr_Lora
                    RegIrqFlags_Lora
                    RegIrqFlagsMask_Lora
                    RegFreqIfMsb_Lora
                    RegFreqIfLsb_Lora
                    RegSymbTimeoutMsb_Lora
                    RegSymbTimeoutLsb_Lora
                    RegTxCfg_Lora
                    RegPayloadLength_Lora
                    RegPreambleMsb_Lora
                    RegPreambleLsb_Lora
                    RegModulationCfg_Lora
                    RegRfMode_Lora
                    RegHopPeriod_Lora
                    RegNbRxBytes_Lora
                    RegRxHeaderInfo_Lora
                    RegRxHeaderCntValue_Lora
                    RegRxPacketCntValue_Lora
                    RegModemStat_Lora	
                    RegPktSnrValue_Lora
                    RegRssiValue_Lora
                    RegPktRssiValue_Lora
                    RegHopChannel_Lora
                    RegRxDataAddr_Lora
                );

use constant RegFifo					=> 0x00;
use constant RegOpMode					=> 0x01;
use constant RegFrMsb					=> 0x06;
use constant RegFrMid					=> 0x07;
use constant RegFrLsb					=> 0x08;
use constant RegPaConfig				=> 0x09;
use constant RegPaRamp					=> 0x0a;
use constant RegOcp						=> 0x0b;
use constant RegLna						=> 0x0c;
use constant RegDioMapping1				=> 0x40;
use constant RegDioMapping2				=> 0x41;
use constant RegVersion					=> 0x42;
use constant RegTcxo					=> 0x4b;
use constant RegPaDac					=> 0x4d;
use constant RegFormerTemp				=> 0x5b;
use constant RegAgcRef					=> 0x61;
use constant RegAgcThresh1				=> 0x62;
use constant RegAgcThresh2				=> 0x63;
use constant RegAgcThresh3				=> 0x64;

## for FSK/OOK Mode
use constant RegBitRateMsb_FskOok		=> 0x02;
use constant RegBitRateLsb_FskOok		=> 0x03;
use constant RegFdevMsg_FskOok			=> 0x04;
use constant RegFdevLsb_FskOok			=> 0x05;
use constant RegRxConfig_FskOok			=> 0x0d;
use constant RegRssiConfig_FskOok		=> 0x0e;
use constant RegRssiCollision_FskOok	=> 0x0f;
use constant RegRssiThreshold_FskOok	=> 0x10;
use constant RegRssiValue_FskOok		=> 0x11;
use constant RegRxBw_FskOok				=> 0x12;
use constant RegAfcBw_FskOok			=> 0x13;
use constant RegOokPeak_FskOok			=> 0x14;
use constant RegOokFix_FskOok			=> 0x15;
use constant RegOokAvg_FskOok			=> 0x16;
use constant Reserved17_FskOok			=> 0x17;
use constant Reserved18_FskOok			=> 0x18;
use constant Reserved19_FskOok			=> 0x19;
use constant RegAfcFei_FskOok			=> 0x1a;
use constant RegAfcMsb_FskOok			=> 0x1b;
use constant RegAfcLsb_FskOok			=> 0x1c;
use constant RegFeiMsb_FskOok			=> 0x1d;
use constant RegFeiLsb_FskOok			=> 0x1e;
use constant RegPreambleDetect_FskOok	=> 0x1f;
use constant RegRxTimeout1_FskOok		=> 0x20;
use constant RegRxTimeout2_FskOok		=> 0x21;
use constant RegRxTimeout3_FskOok		=> 0x22;
use constant RegRxDelay_FskOok			=> 0x23;
use constant RegOsc_FskOok				=> 0x24;
use constant RegPreambleMsb_FskOok		=> 0x25;
use constant RegPreambleLsb_FskOok		=> 0x26;
use constant RegSyncConfig_FskOok		=> 0x27;
use constant RegSyncValue1_FskOok		=> 0x28;
use constant RegSyncValue2_FskOok		=> 0x29;
use constant RegSyncValue3_FskOok		=> 0x2a;
use constant RegSyncValue4_FskOok		=> 0x2b;
use constant RegSyncValue5_FskOok		=> 0x2c;
use constant RegSyncValue6_FskOok		=> 0x2d;
use constant RegSyncValue7_FskOok		=> 0x2e;
use constant RegSyncValue8_FskOok		=> 0x2f;
use constant RegPacketConfig1_FskOok	=> 0x30;
use constant RegPacketConfig2_FskOok	=> 0x31;
use constant RegPayloadLength_FskOok	=> 0x32;
use constant RegNodeAdrs_FskOok			=> 0x33;
use constant RegBroadcastAdrs_FskOok	=> 0x34;
use constant RegFifoThresh_FskOok		=> 0x35;
use constant RegSeqConfig1_FskOok		=> 0x36;
use constant RegSeqConfig2_FskOok		=> 0x37;
use constant RegTimerResol_FskOok		=> 0x37;
use constant RegTimer1Coef_FskOok		=> 0x39;
use constant RegTimer2Coef_FskOok		=> 0x3a;
use constant RegImageCal_FskOok			=> 0x3b;
use constant RegTemp_FskOok				=> 0x3c;
use constant RegLowBat_FskOok			=> 0x3d;
use constant RegIrqFlags1_FskOok		=> 0x3e;
use constant RegIrqFlags2_FskOok		=> 0x3f;
use constant RegPllHop_FskOok			=> 0x44;
use constant RegBitRateFrac_FskOok		=> 0x5d;

## for Lora Mode
use constant RegFifoAddrPtr_Lora		=> 0x0d;
use constant RegFifoTxBaseAddr_Lora		=> 0x0e;
use constant RegFifoRxBaseAddr_Lora		=> 0x0f;
use constant RegIrqFlags_Lora			=> 0x10;
use constant RegIrqFlagsMask_Lora		=> 0x11;
use constant RegFreqIfMsb_Lora			=> 0x12;
use constant RegFreqIfLsb_Lora			=> 0x13;
use constant RegSymbTimeoutMsb_Lora		=> 0x14;
use constant RegSymbTimeoutLsb_Lora		=> 0x15;
use constant RegTxCfg_Lora				=> 0x16;
use constant RegPayloadLength_Lora		=> 0x17;
use constant RegPreambleMsb_Lora		=> 0x18;
use constant RegPreambleLsb_Lora		=> 0x19;
use constant RegModulationCfg_Lora		=> 0x1a;
use constant RegRfMode_Lora				=> 0x1b;
use constant RegHopPeriod_Lora			=> 0x1c;
use constant RegNbRxBytes_Lora			=> 0x1d;
use constant RegRxHeaderInfo_Lora		=> 0x1e;
use constant RegRxHeaderCntValue_Lora	=> 0x1f;
use constant RegRxPacketCntValue_Lora	=> 0x20;
use constant RegModemStat_Lora			=> 0x21;
use constant RegPktSnrValue_Lora		=> 0x22;
use constant RegRssiValue_Lora			=> 0x23;
use constant RegPktRssiValue_Lora		=> 0x24;
use constant RegHopChannel_Lora			=> 0x25;
use constant RegRxDataAddr_Lora			=> 0x26;
use constant RegReserved27_Lora			=> 0x27;
use constant RegReserved28_Lora			=> 0x28;
use constant RegReserved29_Lora			=> 0x29;
use constant RegReserved2a_Lora			=> 0x2a;
use constant RegReserved2b_Lora			=> 0x2b;
use constant RegReserved2c_Lora			=> 0x2c;
use constant RegReserved2d_Lora			=> 0x2d;
use constant RegReserved2e_Lora			=> 0x2e;
use constant RegReserved2f_Lora			=> 0x2f;
use constant RegReserved30_Lora			=> 0x30;
use constant RegReserved31_Lora			=> 0x31;
use constant RegReserved32_Lora			=> 0x32;
use constant RegReserved33_Lora			=> 0x33;
use constant RegReserved34_Lora			=> 0x34;
use constant RegReserved35_Lora			=> 0x35;
use constant RegReserved36_Lora			=> 0x36;
use constant RegReserved37_Lora			=> 0x37;
use constant RegReserved38_Lora			=> 0x37;
use constant RegReserved39_Lora			=> 0x39;
use constant RegReserved3a_Lora			=> 0x3a;
use constant RegReserved3b_Lora			=> 0x3b;
use constant RegReserved3c_Lora			=> 0x3c;
use constant RegReserved3d_Lora			=> 0x3d;
use constant RegReserved3e_Lora			=> 0x3e;
use constant RegReserved3f_Lora			=> 0x3f;
use constant RegUnused44_Lora			=> 0x44;

1;
