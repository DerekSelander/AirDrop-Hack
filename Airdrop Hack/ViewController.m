//
//  ViewController.m
//  Airdrop Hack
//
//  Created by Derek Selander on 10/28/16.
//  Copyright © 2016 Selander. All rights reserved.
//

#import "ViewController.h"
#import "SFAirDropNode.h"
#import "AirDropTableViewCell.h"
#import "SFBLEClient.h"
#import "PrivateSwizzler.h"
#import "PersonDetailTableViewController.h"
#import "GlobalSettings.h"
#import "DSSender.h"
#import "NSObject+AddingSelectedThing.h"
#import <AudioToolbox/AudioServices.h>

#define FAKE_BUNDLE_ID @"com.apple.mobileslideshow"
#define FAKE_SESSION_ID @0

@interface ViewController ()  <UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate, DSSenderCallbackDelegate>
@property (nonatomic, strong) id<SFAirDropBrowser> browser;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) BOOL scanning;
@property (nonatomic) BOOL shouldRepeatTrolling;
@property (nonatomic, strong) NSMutableArray *totalPeople;
@property (nonatomic, strong) IBOutlet UIBarButtonItem* editBarButtonItem;
@end


//static BOOL ___scanning = YES;

@implementation ViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  if (self = [super initWithCoder:aDecoder]) {
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.totalPeople = [NSMutableArray array];
  self.shouldRepeatTrolling = NO;
  self.browser = [[NSClassFromString(@"SFAirDropBrowser") alloc] init];
  [self.browser setDelegate:self];
  [[DSSender sharedSender] setCallbackDelegate:self];
  id obj = [NSClassFromString(@"SFBLEClient") valueForKey:@"sharedClient"];
  if ([obj respondsToSelector:@selector(addNearbyDelegate:)]) {
    [obj performSelector:@selector(addNearbyDelegate:) withObject:self];
  }
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.browser start];
}

- (void)updateContents {
  NSUInteger count = [self.totalPeople count];
  
  for (id person in [self.browser people]) {
    if ([self.totalPeople containsObject:person]) {
      continue;
    }
    
    [self.totalPeople addObject:person];
  }
  self.title = [NSString stringWithFormat:@"%lu Devices", (unsigned long)count];
  NSArray *indexPaths = [self.tableView indexPathsForSelectedRows];
  [self.tableView reloadData];

  for (NSIndexPath *path in indexPaths) {
    [self.tableView selectRowAtIndexPath:path animated:NO scrollPosition:UITableViewScrollPositionNone];
  }
  
}

- (void)setScanning:(BOOL)scanning {
  _scanning = scanning;
  if (scanning) {
    [self.browser start];
  } else {
    [self.browser stop];
  }
  
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if (![sender isKindOfClass:[UITableViewCell class]]) {
    return;
  }
  UITableViewCell *cell = (UITableViewCell *)sender;
  NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
  
  id<SFAirDropNode>person = self.totalPeople[indexPath.row];
  PersonDetailTableViewController *vc = [segue destinationViewController];
  
  vc.person = person;
}


//*****************************************************************************/
#pragma mark - SFAirDropBrowserDelegate
//*****************************************************************************/

- (void)browserDidChangePeople:(id<SFAirDropBrowser>)browser {
  [self updateContents];
}

- (void)browserWillChangePeople:(id<SFAirDropBrowser>)browser {
  // -[SFAirDropActivityViewController browserWillChangePeople:]:
  // Doesn't use this method at all though required
}

- (void)browser:(id<SFAirDropBrowser>)arg1 didDeletePersonAtIndex:(unsigned int)arg2 {
  [self updateContents];
}

- (void)browser:(id<SFAirDropBrowser>)arg1 didInsertPersonAtIndex:(unsigned int)arg2 {
  [self updateContents];
}

//*****************************************************************************/
#pragma mark - UITableViewDataSource
//*****************************************************************************/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.totalPeople count];
}

- (void)updateBarTitle:(UITableView * _Nonnull)tableView {
  if ([[tableView indexPathsForSelectedRows] count]) {
    [self.editBarButtonItem setTitle:@"Deselect All"];
  } else {
    [self.editBarButtonItem setTitle:@"Select All"];
  }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSObject<SFAirDropNode>* node =  self.totalPeople[indexPath.row];
  [node setDbs_isSelected:YES];
  [self updateBarTitle:tableView];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSObject<SFAirDropNode>* node =  self.totalPeople[indexPath.row];
    [node setDbs_isSelected:NO];
  [self updateBarTitle:tableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  AirDropTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
  NSObject<SFAirDropNode>* node =  self.totalPeople[indexPath.row];
  [cell setupObject:node];
  [cell setSelected:[node dbs_isSelected] animated:NO];
  return cell;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
  UIStoryboard *storyboard = self.storyboard;
  PersonDetailTableViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"PersonDetailTableViewController"];
  id person =  self.totalPeople[indexPath.row];
  [vc setPerson:person];
  [self.navigationController pushViewController:vc animated:YES];
}

//*****************************************************************************/
#pragma mark - UITableViewCellDataSource
//*****************************************************************************/

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
  __typeof(self) __weak weakSelf = self;
  
  UITableViewRowAction *rowActionTroll = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Troll Time" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
    
    weakSelf.tableView.editing = NO;
    
    [weakSelf sendToPersonAtIndexPath:indexPath];
  }];
  return @[rowActionTroll];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  return YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
    return 100.0;
  }
  return 90.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  return 0.0;
}

- (void)sendToPersonAtIndexPath:(NSIndexPath *)indexPath {
  id<SFAirDropNode>person = self.totalPeople[indexPath.row];
  DSSender *sender = [DSSender sharedSender];
  [person startSendForBundleID:nil sessionID:nil items:@[sender.url] description:sender.itemDescription previewImage:sender.previewImage];
}

//*****************************************************************************/
#pragma mark - IBActions
//*****************************************************************************/

-(IBAction)toggleRepeatOrSingleTrollTapped:(UIBarButtonItem *)sender {
  if (!self.shouldRepeatTrolling) {
    sender.title = @"Single";
  } else {
    sender.title = @"Repeat";
  }
  self.shouldRepeatTrolling = !self.shouldRepeatTrolling;
}

- (IBAction)selectAllTapped:(id)sender {
  BOOL shouldDeselect = NO;
  if ([[sender title] isEqualToString:@"Deselect All"]) {
    shouldDeselect = YES;
  }
  
  for (NSInteger s = 0; s < self.tableView.numberOfSections; s++) {
    for (NSInteger r = 0; r < [self.tableView numberOfRowsInSection:s]; r++) {
      if (shouldDeselect) {
        [self.tableView deselectRowAtIndexPath:[NSIndexPath indexPathForRow:r inSection:s] animated:NO];
      } else {
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:r inSection:s]
                                    animated:NO
                              scrollPosition:UITableViewScrollPositionNone];
      }
    }
  }
  [self updateBarTitle:self.tableView];
}

- (IBAction)sendAll:(id)sender {
  NSArray *people = [self.browser people];  
  DSSender *s = [DSSender sharedSender];
  for (id<SFAirDropNode>person in people) {
    [person startSendForBundleID:FAKE_BUNDLE_ID
                       sessionID:FAKE_SESSION_ID
                           items:@[s.url]
                     description:s.itemDescription
                    previewImage:s.previewImage];
  }
}

- (IBAction)refresh:(id)sender {
  [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
  [self.browser updateDiscoveredPeople];
  self.scanning = NO;
  __typeof(self) __weak weakSelf = self;

  dispatch_async(dispatch_get_main_queue(), ^{
    weakSelf.scanning = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    });
  });
  
}
- (IBAction)startStopTapped:(id)sender {
  for (NSIndexPath *indexPath in self.tableView.indexPathsForSelectedRows) {
    [self sendToPersonAtIndexPath:indexPath];
  }
}

- (void)toggleAllNoneTapped:(UIBarButtonItem *)sender {
  if ([sender.title isEqualToString:@"All"]) {
    
    sender.title = @"None";
  } else {
    sender.title = @"All";
  }
}

  //*****************************************************************************/
#pragma mark - UIPickerVIewDataSource
  //*****************************************************************************/


  // returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
  return 1;
}

  // returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
  
  return 2;
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
  NSString *returnString;
  
  switch (row) {
    case 0:
      returnString = @"Troll Pic";
      break;
    case 1:
      returnString = @"Rick Roll";
      break;
    case 2:
      returnString = @"991";
      break;
    default:
      break;
      
  }
  
  NSAttributedString *attString =
  [[NSAttributedString alloc] initWithString:returnString attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
  
  return attString;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
  NSURL *url = nil;
  NSString *itemDescription = nil;
  UIImage *previewImage = nil;
  switch (row) {
    case 0:
      url = [[NSBundle mainBundle] URLForResource:@"Troll_Preview" withExtension:@"png"];
      itemDescription = @"Troll";
      previewImage = [UIImage imageNamed:@"Troll_Preview.png"];
      break;
    case 1:
      url = [NSURL URLWithString:@"https://www.youtube.com/watch?v=dQw4w9WgXcQ"];
      itemDescription = @"Youtube";
      previewImage = [UIImage imageNamed:@"mac_icon.png"];
      break;
    case 2:
      url = [[NSBundle mainBundle] URLForResource:@"test" withExtension:@"txt"];
      break;
      
    default:
      break;
  }
  
  [DSSender sharedSender].url = url;
  [DSSender sharedSender].previewImage = previewImage;
  [DSSender sharedSender].itemDescription = itemDescription;
}

//*****************************************************************************/
#pragma mark - DSSenderCallbackDelegate
//*****************************************************************************/

- (void)eventFromRemoteNode:(id)node withEvent:(SFSharingEvent)event withResults:(NSDictionary *)results {
  
  
  if (self.shouldRepeatTrolling == NO || (event != SFSharingEventDidFinishTransmitting && event != SFSharingEventDeclined)) {
    return;
  }

  NSString *receiverID = results[@"ReceiverID"];
  NSArray *people = self.totalPeople;

  dispatch_async(dispatch_get_global_queue(QOS_CLASS_UTILITY, 0), ^{
    
    for (NSObject <SFAirDropNode>* person in people) {
      NSString *hashName = [person realName];
      
      if ([hashName isEqualToString:receiverID]) {
        dispatch_async(dispatch_get_main_queue(), ^{
        
          AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
          if (event == SFSharingEventDidFinishTransmitting) {
            person.dbs_acceptedCount = @(person.dbs_acceptedCount.integerValue + 1);
          } else if (event == SFSharingEventDeclined) {
            person.dbs_rejectedCount = @(person.dbs_rejectedCount.integerValue + 1);
          }
          
          NSArray *indexPaths = [self.tableView indexPathsForSelectedRows];
          [self.tableView reloadData];
          
          for (NSIndexPath *path in indexPaths) {
            [self.tableView selectRowAtIndexPath:path animated:NO scrollPosition:UITableViewScrollPositionNone];
          }
          
          DSSender *sender = [DSSender sharedSender];
          if (self.shouldRepeatTrolling) {
            [person startSendForBundleID:FAKE_BUNDLE_ID sessionID:FAKE_SESSION_ID items:@[sender.url] description:sender.itemDescription previewImage:sender.previewImage];
            
          }
        });
      }
    }
  });
}
@end
