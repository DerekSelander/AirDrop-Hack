//
//  SFBLEClient.h
//  Airdrop Hack
//
//  Created by Derek Selander on 10/30/16.
//  Copyright © 2016 Selander. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SFBLEClient <NSObject> 

@property (readonly, copy) NSString *debugDescription;
@property (readonly, copy) NSString *description;
//@property (readonly) unsigned int hash;
@property (readonly) Class superclass;

+ (id)sharedClient;


- (id)addAirDropDelegate:(id)arg1;
- (id)addNearbyDelegate:(id)arg1;
- (id)addPairingDelegate:(id)arg1;
- (void)awdl:(id)arg1 failedToStartAdvertisingWithError:(id)arg2;
- (void)awdl:(id)arg1 failedToStartScanningWithError:(id)arg2;
- (void)awdl:(id)arg1 foundDevice:(id)arg2 rssi:(id)arg3;
- (void)awdlAdvertisingPending:(id)arg1;
- (void)awdlDidUpdateState:(id)arg1;
- (void)awdlStartedAdvertising:(id)arg1;
- (void)awdlStartedScanning:(id)arg1;
- (id)init;
- (void)nearby:(id)arg1 didConnectToPeer:(id)arg2 error:(id)arg3;
- (void)nearby:(id)arg1 didDeferAdvertisingType:(int)arg2;
- (void)nearby:(id)arg1 didDisconnectFromPeer:(id)arg2 error:(id)arg3;
- (void)nearby:(id)arg1 didDiscoverType:(int)arg2 withData:(id)arg3 fromPeer:(id)arg4 peerInfo:(id)arg5;
- (void)nearby:(id)arg1 didFailToStartAdvertisingOfType:(int)arg2 withError:(id)arg3;
- (void)nearby:(id)arg1 didFailToStartScanningForType:(int)arg2 WithError:(id)arg3;
- (void)nearby:(id)arg1 didLosePeer:(id)arg2 type:(int)arg3;
- (void)nearby:(id)arg1 didReceiveData:(id)arg2 fromPeer:(id)arg3;
- (void)nearby:(id)arg1 didSendData:(id)arg2 toPeer:(id)arg3 error:(id)arg4;
- (void)nearby:(id)arg1 didStartAdvertisingType:(int)arg2;
- (void)nearby:(id)arg1 didStartScanningForType:(int)arg2;
- (void)nearbyDidChangeBluetoothBandwidthState:(id)arg1;
- (void)nearbyDidUpdateState:(id)arg1;
- (void)pairing:(id)arg1 failedToStartScanningWithError:(id)arg2;
- (void)pairing:(id)arg1 foundDevice:(id)arg2 payload:(id)arg3 rssi:(id)arg4 peerInfo:(id)arg5;
- (void)pairingDidUpdateState:(id)arg1;
- (void)pairingStartedScanning:(id)arg1;
- (void)pairingStoppedScanning:(id)arg1;
- (void)removeAirDropDelegate:(id)arg1;
- (void)removeNearbyDelegate:(id)arg1;
- (void)removePairingDelegate:(id)arg1;

@end
