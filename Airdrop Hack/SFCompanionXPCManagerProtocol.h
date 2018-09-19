//
//  SFCompanionXPCManagerProtocol.h
//  Airdrop Hack
//
//  Created by Derek Selander on 11/5/16.
//  Copyright © 2016 Selander. All rights reserved.
//

@import Foundation; 

@class NSDictionary, NSString, SFCompanionService;

@protocol SFCompanionXPCManagerProtocol <NSObject>
- (void)createUnlockManagerWithReply:(void (^)(id <SFUnlockProtocol>, NSError *))arg1;
- (void)createContinuityScannerForClientProxy:(id <SFContinuityScannerClient>)arg1 reply:(void (^)(id <SFContinuityScannerProtocol>, NSError *))arg2;
- (void)createActivityAdvertiserForClientProxy:(id <SFActivityAdvertiserClient>)arg1 reply:(void (^)(id <SFActivityAdvertiserProtocol>, NSError *))arg2;
- (void)createStreamsForMessage:(NSDictionary *)arg1 reply:(void (^)(NSFileHandle *, NSError *))arg2;
- (void)createCompanionConnectionManagerForService:(SFCompanionService *)arg1 clientProxy:(id <SFCompanionConnectionManagerClient>)arg2 reply:(void (^)(id <SFCompanionConnectionManagerProtocol>))arg3;
- (void)createCompanionServiceManagerWithIdentifier:(NSString *)arg1 clientProxy:(id <SFCompanionServiceManagerClient>)arg2 reply:(void (^)(id <SFCompanionServiceManagerProtocol>, NSString *, NSString *, NSString *, NSError *))arg3;
- (void)createCompanionBrowserWithIdentifier:(NSString *)arg1 serviceType:(NSString *)arg2 clientProxy:(id <SFCompanionBrowserClient>)arg3 reply:(void (^)(id <SFCompanionBrowserProtocol>))arg4;
@end
