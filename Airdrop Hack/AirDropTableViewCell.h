//
//  AirDropTableViewCell.h
//  Airdrop Hack
//
//  Created by Derek Selander on 10/29/16.
//  Copyright © 2016 Selander. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFAirDropNode.h"
@interface AirDropTableViewCell : UITableViewCell

- (void)setupObject:(id<SFAirDropNode>)node;

@end
