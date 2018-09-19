//
//  PrivateSwizzler.h
//  Airdrop Hack
//
//  Created by Derek Selander on 11/5/16.
//  Copyright © 2016 Selander. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PrivateSwizzler : NSObject

@end

typedef NS_ENUM(long long, SFSharingEvent) {
  SFSharingEventIsWaitingForResponse = 0x3,
  SFSharingEventDeclined = 0x4,
  SFSharingEventTransmitting = 0x5,
  SFSharingEventApproved = 0x6,
  SFSharingEventItemSent = 0x7,
  SFSharingEventDidFinishTransmitting = 0x9,
  SFSharingEventConnectionRequested = 0xB
};

@interface NSObject (PrivateMethods)

- (void)ds_handleOperationCallback:(id)callback event:(SFSharingEvent)event withResults:(NSDictionary *)results;
@property (nonatomic, strong) NSNumber *dbs_acceptedCount;
@property (nonatomic, strong) NSNumber *dbs_rejectedCount;

@end

/// A notification for a remote device interacting with airdrop
extern NSString* const kSharingAirdropCallBackNotification;


/*
 * thread #1, queue = 'com.apple.main-thread', stop reason = breakpoint 1.1
 * frame #0: 0x00007fff4c5734c7 Foundation` -[NSData(NSData) base64EncodedStringWithOptions:]
 frame #1: 0x000000010dac2f37 sharingd` combinedHashStringFromArray  + 439
 frame #2: 0x000000010dac29ea sharingd` validateRecordAndCacheIdentity  + 1161
 frame #3: 0x000000010dac32ac sharingd` validateRecordAndCacheInfoForPerson  + 218
 frame #4: 0x000000010dacc1ab sharingd` -[SDAirDropConnection handleDiscoverRequest]  + 94
 frame #5: 0x00007fff4a3aee14 CoreFoundation` _signalEventSync  + 228
 frame #6: 0x00007fff4a3aed12 CoreFoundation` ___signalEventQueue_block_invoke  + 18
 frame #7: 0x00007fff72b9964a libdispatch.dylib` _dispatch_call_block_and_release  + 12
 frame #8: 0x00007fff72b91e08 libdispatch.dylib` _dispatch_client_callout  + 8
 frame #9: 0x00007fff72b9d3e5 libdispatch.dylib` _dispatch_main_queue_callback_4CF  + 1148
 frame #10: 0x00007fff4a3adc69 CoreFoundation` __CFRUNLOOP_IS_SERVICING_THE_MAIN_DISPATCH_QUEUE__  + 9
 frame #11: 0x00007fff4a36fe4a CoreFoundation` __CFRunLoopRun  + 2586
 frame #12: 0x00007fff4a36f1a3 CoreFoundation` CFRunLoopRunSpecific  + 483
 frame #13: 0x00007fff4c50cf26 Foundation` -[NSRunLoop(NSRunLoop) runMode:beforeDate:]  + 277
 frame #14: 0x00007fff4c50cdfe Foundation` -[NSRunLoop(NSRunLoop) run]  + 76
 frame #15: 0x000000010daf08e8 sharingd` main  + 814
 frame #16: 0x00007fff72bcb015 libdyld.dylib` start  + 1
 (lldb) po $rdi

 */


