//
//  PersonDetailTableViewController.m
//  Airdrop Hack
//
//  Created by Derek Selander on 11/5/16.
//  Copyright © 2016 Selander. All rights reserved.
//

#import "PersonDetailTableViewController.h"
#import <dlfcn.h>
@interface PersonDetailTableViewController ()

@end

void * sharing_handle;
@implementation PersonDetailTableViewController

/*
 
 _SFNodeCreateWithXPCObject
 
 
 (lldb) po $x0
 <OS_xpc_dictionary: dictionary[0x1c0177b80]: { refcnt = 1, xrefcnt = 1, count = 21, reply = 0, dest port = 0x0, dest msg id = 0x0, transaction = 0, voucher = 0x0 } <dictionary: 0x1c0177b80> { count = 21, transaction: 0, voucher = 0x0, contents =
 "AppleID" => <string: 0x1c0248c70> { length = 23, contents = "someemail@yahoo.com" }
 "LastName" => <string: 0x1c0248c40> { length = 8, contents = "Selander" }
 "Model" => <string: 0x1c0248be0> { length = 11, contents = "MacBook Pro" }
 "Domain" => <string: 0x1c0249150> { length = 5, contents = "local" }
 "NickName" => <string: 0x1c0249180> { length = 0, contents = "" }
 "Flags" => <int64: 0x1c00383a0>: 251
 "Comment" => <string: 0x1c0248cd0> { length = 11, contents = "MacBook Pro" }
 "PortNumber" => <int64: 0x1c0038520>: -1
 "ComputerName" => <string: 0x1c02492a0> { length = 4, contents = "Woot" }
 "PhoneHash" => <string: 0x1c02492d0> { length = 44, contents = "1Ox5mFsai61SzA6z1lmhEuBeDMJhXCgcJAghpLrjzL0=" }
 "Kinds" => <array: 0x1c02490f0> { count = 3, capacity = 3, contents =
 0: <int64: 0x1c0035b40>: 1
 1: <int64: 0x1c0037bc0>: 12
 2: <int64: 0x1c0035ce0>: 11
 }
 "DisplayName" => <string: 0x1c0249270> { length = 14, contents = "Derek Selander" }
 "EmailHash" => <string: 0x1c0248f10> { length = 44, contents = "pFFyy/+mhmmIpd1QYGbv+VgnsyFtDPypFpzHicTmNiw=" }
 "FirstName" => <string: 0x1c0248eb0> { length = 5, contents = "Derek" }
 "IconData" => <data: 0x1c027cbc0>: { length = 17099 bytes, contents = 0x89504e470d0a1a0a0000000d494844520000007800000078... }
 "MediaCapabilities" => <data: 0x1c027cb00>: { length = 376 bytes, contents = 0x7b2256657273696f6e223a312c22436f64656373223a7b22... }
 "SupportedMedia" => <uint64: 0x1c0037780>: 0
 "ConnectionState" => <int64: 0x1c0038c60>: 0
 "ServiceName" => <string: 0x1c0248f40> { length = 12, contents = "f53886ac3308" }
 "BonjourProtocols" => <array: 0x1c0248fd0> { count = 1, capacity = 1, contents =
 0: <string: 0x1c0248e80> { length = 7, contents = "airdrop" }
 }
 "RealName" => <string: 0x1c0248f70> { length = 12, contents = "f53886ac3308" }
 }>
 
 */

- (void)viewDidLoad {
    [super viewDidLoad];
  
    sharing_handle =  dlopen("/System/Library/SpringBoardPlugins/Sharing.servicebundle/Sharing", RTLD_NOW);
//    sharing_handle =  dlopen("/System/Library/PrivateFrameworks/Sharing.framework/Sharing", RTLD_NOW);
  
  self.title = [self.person displayName];
//  extern NSString * SFNodeCopyAppleID(id);
//  extern id SFNodeCopyBonjourProtocols(id); // NSCFType
//  extern void * SFNodeCopyColor(id); // No longer used?
//  extern NSString * SFNodeCopyComputerName(id); // Charlie
//  extern char * SFNodeCopyContactIdentifier(id);
//  extern char * SFNodeCopyDiskType(id);
//  extern NSString * SFNodeCopyDisplayName(id); // Charlie, Derek Selander
//  extern NSString * SFNodeCopyDomain(id); //local
//  extern char * SFNodeCopyDomains(id);
//  extern NSString * SFNodeCopyEmailHash(id);
//  extern NSString * SFNodeCopyFirstName(id);
//  extern NSNumber * SFNodeCopyFlags(id);
//  extern char * SFNodeCopyHostName(id); // Don't use this one?
//  extern NSData * SFNodeCopyIconData(id);
//  extern char * SFNodeCopyIconHash(id);
//  extern NSString * SFNodeCopyKindString(id); //mac, from sender?
//  extern NSSet * SFNodeCopyKinds(id);
//  extern NSString * SFNodeCopyLastName(id);
//  extern NSString * SFNodeCopyModel(id);
//  extern char * SFNodeCopyMountPoint(id);
//  extern char * SFNodeCopyNetbiosName(id);
//  extern char * SFNodeCopyNickName(id);
//  extern char * SFNodeCopyParentIdentifier(id);
//  extern char * SFNodeCopyPassword(id);
//  extern char * SFNodeCopyPath(id);
//  extern char * SFNodeCopyPhoneHash(id);
//  extern NSArray * SFNodeCopyProtocols(id); // array of strings
//  extern NSString * SFNodeCopyRealName(id);
//  extern NSString * SFNodeCopySecondaryName(id);
//  extern NSString * SFNodeCopyServiceName(id);
//  extern char * SFNodeCopySharePointBrowserID(id);
//  extern char * SFNodeCopyTypeIdentifier(id);
//  extern NSURL * SFNodeCopyURL(id);
//  extern char * SFNodeCopyURLForProtocol(id);
//  extern char * SFNodeCopyURLs(id);
//  extern char * SFNodeCopyUserName(id);
//  extern char * SFNodeCopyWorkgroup(id);
//  extern char * SFNodeCopyWorkgroups(id);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}




#pragma mark - Table view data source


//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
  [self setupCell:cell];
  return cell;
}


- (void)setupCell:(UITableViewCell *)cell {
  NSString *reuseIdentifier = [cell reuseIdentifier];
  id node = [self.person node];
  
  
  
  NSString *(*SFNodeCopyAppleID)(id) = dlsym(sharing_handle, "SFNodeCopyAppleID");
  NSString *(*SFNodeCopyComputerName)(id) = dlsym(sharing_handle, "SFNodeCopyComputerName");
  NSString *(*SFNodeCopyFirstName)(id) = dlsym(sharing_handle, "SFNodeCopyFirstName");
    NSString *(*SFNodeCopyLastName)(id) = dlsym(sharing_handle, "SFNodeCopyLastName");
  NSString *(*SFNodeCopyRealName)(id) = dlsym(sharing_handle, "SFNodeCopyRealName");
  NSString *(*SFNodeCopySecondaryName)(id) = dlsym(sharing_handle, "SFNodeCopySecondaryName");
  NSString *(*SFNodeCopyModel)(id) = dlsym(sharing_handle, "SFNodeCopyModel");
  NSString *(*SFNodeCopyDisplayName)(id) = dlsym(sharing_handle, "SFNodeCopyDisplayName");
//  NSString *(*SFNodeCopyAppleID)(id) = dlsym(sharing_handle, "SFNodeCopyAppleID");
  NSString *(*SFNodeCopyEmailHash)(id) = dlsym(sharing_handle, "SFNodeCopyEmailHash");
    NSString *(*SFNodeCopyPhoneHash)(id) = dlsym(sharing_handle, "SFNodeCopyPhoneHash");
  
  
  
  
  
  
  
//  SFNodeCopyDisplayName
//  SFNodeCopyDomain
//  SFNodeCopyEmailHash
//  SFNodeCopyFlags
//  SFNodeCopyKindString
//  SFNodeCopyKinds
//  SFNodeCopyModel
//  SFNodeCopyProtocols
  
  if ([reuseIdentifier isEqualToString:@"name"]) {
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@", SFNodeCopyFirstName(node) ? SFNodeCopyFirstName(node) : @"¯\\_(ツ)_/¯", SFNodeCopyLastName(node) ? SFNodeCopyLastName(node) : @""];
    cell.imageView.image = [self.person displayIcon];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
  } else if ([reuseIdentifier isEqualToString:@"appleID"]) {
    cell.detailTextLabel.text = SFNodeCopyAppleID(node);
  } else if ([reuseIdentifier isEqualToString:@"realName"]) {
    cell.detailTextLabel.text = SFNodeCopyRealName(node);
  } else if ([reuseIdentifier isEqualToString:@"secondaryName"]) {
    cell.detailTextLabel.text = SFNodeCopySecondaryName(node);
  } else if ([reuseIdentifier isEqualToString:@"emailHash"]) {
    cell.detailTextLabel.text = SFNodeCopyEmailHash(node);
  } else if ([reuseIdentifier isEqualToString:@"icon"]) {
    // TODO
  } else if ([reuseIdentifier isEqualToString:@"computerName"]) {
    cell.detailTextLabel.text = SFNodeCopyComputerName(node);
  } else if ([reuseIdentifier isEqualToString:@"displayName"]) {
    cell.detailTextLabel.text = SFNodeCopyDisplayName(node);
  } else if ([reuseIdentifier isEqualToString:@"model"]) {
    cell.detailTextLabel.text = SFNodeCopyModel(node);
  } else if ([reuseIdentifier isEqualToString:@"phonehash"]) {
    cell.detailTextLabel.text = SFNodeCopyPhoneHash(node);
  }
}
@end
