//
//  SFAirDropBrowser.h
//  Airdrop Hack
//
//  Created by Derek Selander on 10/29/16.
//  Copyright © 2016 Selander. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SFAirNode;
@class SFAirDropBrowser;

@protocol SFAirDropBrowserDelegate <NSObject>
@required

- (void)browser:(SFAirDropBrowser *)arg1 didDeletePersonAtIndex:(unsigned int)arg2;
- (void)browser:(SFAirDropBrowser *)arg1 didInsertPersonAtIndex:(unsigned int)arg2;
- (void)browserDidChangePeople:(SFAirDropBrowser *)arg1;
- (void)browserWillChangePeople:(SFAirDropBrowser *)arg1;

@end

@protocol SFAirDropBrowser <NSObject>

@property (nonatomic, weak) id<SFAirDropBrowserDelegate> delegate;
// @property (nonatomic, readonly) NSArray *people;
@property (nonatomic, copy) NSString *sessionID;

- (void)dealloc;
- (id)delegate;
- (void)handleBrowserCallBack;
- (id)init;
- (NSArray *)people;
- (id)sessionID;
- (void)start;
- (void)stop;
- (void)updateDiscoveredPeople;
@end
