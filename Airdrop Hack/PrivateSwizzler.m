//
//  PrivateSwizzler.m
//  Airdrop Hack
//
//  Created by Derek Selander on 11/5/16.
//  Copyright © 2016 Selander. All rights reserved.
//

#import "PrivateSwizzler.h"
#import "DSSender.h"
#import <dlfcn.h>
#import <objc/runtime.h>


NSString* const kSharingAirdropCallBackNotification = @"com.selander.airdrop.update";


@implementation PrivateSwizzler

+ (void)load {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    [self loadPrivateDynamicLibraries];
    [self setupSwizzledMethods];
  });
}


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
+ (void)setupSwizzledMethods {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{

    [self swizzleMethodsForClass:NSClassFromString(@"SFAirDropNode") originalSelector:@selector(handleOperationCallback:event:withResults:) swizzledSelector:@selector(ds_handleOperationCallback:event:withResults:) isClassMethod:NO];
    
    [self swizzleMethodsForClass:NSClassFromString(@"SFAirDropNode") originalSelector:@selector(nodeWithSFNode:) swizzledSelector:@selector(ds_nodeWithSFNode:) isClassMethod:YES];
    
    [self swizzleMethodsForClass:NSClassFromString(@"SFAirDropNode") originalSelector:@selector(isMe) swizzledSelector:@selector(ds_isMe) isClassMethod:NO];
    
    [self swizzleMethodsForClass:NSClassFromString(@"SFAirDropNode") originalSelector:@selector(setMe:) swizzledSelector:@selector(ds_setMe:) isClassMethod:NO];
    
    [self swizzleMethodsForClass:NSClassFromString(@"SFAirDropNode") originalSelector:@selector(setUnknown:) swizzledSelector:@selector(ds_setUnknown:) isClassMethod:NO];
    
        [self swizzleMethodsForClass:NSClassFromString(@"SFAirDropNode") originalSelector:@selector(isUnknown) swizzledSelector:@selector(ds_isUnknown) isClassMethod:NO];
    
    [self swizzleMethodsForClass:NSClassFromString(@"SFBLEClient") originalSelector:@selector(nearby:didDiscoverType:withData:fromPeer:peerInfo:) swizzledSelector:@selector(ds_nearby:didDiscoverType:withData:fromPeer:peerInfo:) isClassMethod:NO];
    
  });
}
#pragma clang diagnostic pop

+ (void)swizzleMethodsForClass:(Class)aClass originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector isClassMethod:(BOOL)isClassMethod {
  
  
  Method originalMethod;
  Method swizzledMethod;
  
  if (isClassMethod) {
    originalMethod = class_getClassMethod(aClass, originalSelector);
    swizzledMethod = class_getClassMethod(aClass, swizzledSelector);
  } else {
    originalMethod = class_getInstanceMethod(aClass, originalSelector);
    swizzledMethod = class_getInstanceMethod(aClass, swizzledSelector);
  }
  // When swizzling a class method, use the following:
  // Class class = object_getClass((id)self);
  // ...
  if (!isClassMethod) {
    
    BOOL didAddMethod =
    class_addMethod(aClass,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
      class_replaceMethod(aClass,
                          swizzledSelector,
                          method_getImplementation(originalMethod),
                          method_getTypeEncoding(originalMethod));
    } else {
      method_exchangeImplementations(originalMethod, swizzledMethod);
    }
  } else {
    method_exchangeImplementations(originalMethod, swizzledMethod);

  }
}

+ (void)loadPrivateDynamicLibraries {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    
#if TARGET_OS_SIMULATOR
    if (!dlopen("/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/System/Library/SpringBoardPlugins/Sharing.servicebundle/Sharing", 0x2)) {
      NSLog(@"error %s", dlerror());
    }
    
#else
    
//    if (!dlopen("/usr/libexec/sharingd", RTLD_GLOBAL)) {
//      NSLog(@"error %s", dlerror());
//    }
    
    
    if (!dlopen("/System/Library/PrivateFrameworks/AssistantUI.framework/AssistantUI", RTLD_NOW)) {
      NSLog(@"error %s", dlerror());
    }
    
    if (!dlopen("/System/Library/PrivateFrameworks/SpringBoardUI.framework/SpringBoardUI", RTLD_NOW)) {
      NSLog(@"error %s", dlerror());
    }
    
    if (!dlopen("/System/Library/PrivateFrameworks/Sharing.framework/Sharing", RTLD_NOW)) {
      NSLog(@"error %s", dlerror());
    }
    
    if (!dlopen("/System/Library/SpringBoardPlugins/WiFiPicker.servicebundle/WiFiPicker", RTLD_NOW)) {
      NSLog(@"error %s", dlerror());
    }
    
    
    if (!dlopen("/System/Library/Frameworks/PhotosUI.framework/PhotosUI", RTLD_NOW)) {
      NSLog(@"error %s", dlerror());
    }
    if (!dlopen("/System/Library/PrivateFrameworks/AirTrafficDevice.framework/AirTrafficDevice", RTLD_NOW)) {
      NSLog(@"error %s", dlerror());
    }
#endif
  });
}

@end


@implementation NSObject (PrivateMethods)

- (void) ds_nearby:(id)arg1 didDiscoverType:(long)arg2 withData:(id)arg3 fromPeer:(id)arg4 peerInfo:(id)arg5 {
  [self ds_nearby:arg1 didDiscoverType:arg2 withData:arg3 fromPeer:arg4 peerInfo:arg5];
}

- (void)ds_handleOperationCallback:(id)callback event:(SFSharingEvent)event withResults:(NSDictionary *)results {
  
  if (event == SFSharingEventDidFinishTransmitting || event == SFSharingEventDeclined) {
    
    id<DSSenderCallbackDelegate> callbackDelegate = [[DSSender sharedSender] callbackDelegate];
    
    if (callbackDelegate) {
      [callbackDelegate eventFromRemoteNode:self withEvent:event withResults:results];
    }
  }
  
  [self ds_handleOperationCallback:callback event:event withResults:results];
}

+ (instancetype)ds_nodeWithSFNode:(id)node {
  NSObject *object = [self ds_nodeWithSFNode:node];
  [object setDbs_acceptedCount:@0];
  [object setDbs_rejectedCount:@0];
  
  return object;
}

- (void)ds_setMe:(BOOL)isMe {
  [self ds_setMe:YES];
}

- (BOOL)ds_isMe {
  return YES;
}

- (BOOL)isUnknown {
  return NO;
}

- (void)ds_setUnknown:(BOOL)isUnknown {
  [self ds_setUnknown:NO];
}

//*****************************************************************************/
#pragma mark - Associated Objects
//*****************************************************************************/

- (void)setDbs_rejectedCount:(NSNumber *)object {
  objc_setAssociatedObject(self, @selector(dbs_rejectedCount), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)dbs_rejectedCount {
  return objc_getAssociatedObject(self, @selector(dbs_rejectedCount));
}

- (void)setDbs_acceptedCount:(NSNumber *)object {
  objc_setAssociatedObject(self, @selector(dbs_acceptedCount), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)dbs_acceptedCount {
  return objc_getAssociatedObject(self, @selector(dbs_acceptedCount));
}

@end

