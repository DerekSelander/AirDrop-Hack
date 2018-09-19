//
//  GlobalSettings.m
//  Airdrop Hack
//
//  Created by Derek Selander on 11/5/16.
//  Copyright © 2016 Selander. All rights reserved.
//

#import "GlobalSettings.h"

@implementation GlobalSettings

+ (instancetype)sharedSettings {
  static dispatch_once_t onceToken;
  static GlobalSettings *sharedSettings = nil;
  dispatch_once(&onceToken, ^{
    sharedSettings = [[GlobalSettings alloc] init];
  });
  return sharedSettings;
}


- (instancetype)init {
  if (self = [super init]) {
    self.shouldRepeatTroll = NO; 
  }
  return self;
}
@end
