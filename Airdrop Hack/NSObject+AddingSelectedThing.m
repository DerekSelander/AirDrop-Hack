//
//  NSObject+AddingSelectedThing.m
//  Airdrop Hack
//
//  Created by Derek Selander on 3/31/17.
//  Copyright © 2017 Selander. All rights reserved.
//

#import "NSObject+AddingSelectedThing.h"

#import <objc/runtime.h>

@implementation NSObject (AddingSelectedThing)

@dynamic dbs_isSelected;

- (void)setDbs_isSelected:(BOOL)object {
  
  objc_setAssociatedObject(self, @selector(dbs_isSelected), [NSNumber numberWithBool:object], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)dbs_isSelected {
  NSNumber *num = objc_getAssociatedObject(self, @selector(dbs_isSelected));
  return [num boolValue];
}


@end
