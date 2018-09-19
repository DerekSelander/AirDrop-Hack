//
//  DSSender.m
//  Airdrop Hack
//
//  Created by Derek Selander on 12/3/16.
//  Copyright © 2016 Selander. All rights reserved.
//

#import "DSSender.h"

@implementation DSSender

+ (instancetype)sharedSender {
  static DSSender *sharedSender = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedSender = [DSSender new];
  });
  
  return sharedSender;
}

- (instancetype)init {
  if (self = [super init]) {
    self.previewImage = [UIImage imageNamed:@"Troll_Preview"];
    self.url = [[NSBundle mainBundle] URLForResource:@"Troll_Preview" withExtension:@"png"];
    self.itemDescription = @"Safari Woot";
  }
  return self;
}

@end
