//
//  PersonDetailTableViewController.h
//  Airdrop Hack
//
//  Created by Derek Selander on 11/5/16.
//  Copyright © 2016 Selander. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFAirDropNode.h"

@interface PersonDetailTableViewController : UITableViewController

@property (nonatomic, strong) id<SFAirDropNode> person;

@end
