//
//  GlobalSettings.h
//  Airdrop Hack
//
//  Created by Derek Selander on 11/5/16.
//  Copyright © 2016 Selander. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalSettings : NSObject

@property (nonatomic) BOOL shouldRepeatTroll;
+ (instancetype)sharedSettings;

@end
