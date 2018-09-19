//
//  SFAirDropNode.h
//  Airdrop Hack
//
//  Created by Derek Selander on 10/29/16.
//  Copyright © 2016 Selander. All rights reserved.
//


@protocol SFAirDropNode <NSObject>

#ifdef __IPHONE_10_0
@property (retain) NSString *contactIdentifier;
#endif

@property (retain) UIImage *displayIcon;
@property (retain) NSString *displayName;
@property (getter=isMe) BOOL me;
@property (getter=isMonogram) BOOL monogram;
@property (retain) id node;
@property (retain) NSString *realName;
@property (retain) NSString *secondaryName;
@property (readonly) BOOL supportsFMF;
@property (readonly) BOOL supportsMixedTypes;
@property (readonly) BOOL supportsPasses;
@property (getter=isUnknown) BOOL unknown;

//+ (id)nodeWithSFNode:(struct __SFNode { }*)arg1;

- (void)cancelSend;
//- (id)contactIdentifier;
- (id)description;
//- (id)displayIcon;
//- (id)displayName;
//- (void)handleOperationCallback:(struct __SFOperation { }*)arg1 event:(long)arg2 withResults:(id)arg3;
- (unsigned int)hash;
- (id)init;
- (BOOL)isEqual:(id)arg1;
- (BOOL)isMe;
- (BOOL)isMonogram;
- (BOOL)isUnknown;
- (id)node;
//- (id)realName;
//- (id)secondaryName;
/*- (void)setContactIdentifier:(id)arg1;
- (void)setDisplayIcon:(id)arg1;
- (void)setDisplayName:(id)arg1;
- (void)setMe:(BOOL)arg1;
- (void)setMonogram:(BOOL)arg1;
- (void)setNode:(id)arg1;
- (void)setRealName:(id)arg1;
- (void)setSecondaryName:(id)arg1;
- (void)setUnknown:(BOOL)arg1; */
- (void)simulateFakeTransferWithSessionID:(id)arg1;
//- (void)startSendWithSessionID:(id)arg1 items:(id)arg2 description:(id)arg3 previewImage:(id)arg4;
-(void)startSendForBundleID:(id)arg1 sessionID:(id)arg2 items:(id)arg3 description:(id)arg4 previewImage:(id)arg5;
- (BOOL)supportsFMF;
- (BOOL)supportsMixedTypes;
- (BOOL)supportsPasses;
//- (void)updateWithSFNode:(struct __SFNode { }*)arg1;

@end


