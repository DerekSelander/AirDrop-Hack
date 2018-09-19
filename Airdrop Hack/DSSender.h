//
//  DSSender.h
//  Airdrop Hack
//
//  Created by Derek Selander on 12/3/16.
//  Copyright © 2016 Selander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PrivateSwizzler.h"
@import UIKit;

/// Hooks into SFNode external events when remote node interacts with airdrop
@protocol DSSenderCallbackDelegate <NSObject>
@required
-(void)eventFromRemoteNode:(id)node withEvent:(SFSharingEvent) event withResults:(NSDictionary*)results;
@end

@interface DSSender : NSObject

+ (instancetype)sharedSender;

@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) UIImage *previewImage;
@property (nonatomic, strong) NSString *itemDescription;
@property (nonatomic, weak) id<DSSenderCallbackDelegate> callbackDelegate;
@end
