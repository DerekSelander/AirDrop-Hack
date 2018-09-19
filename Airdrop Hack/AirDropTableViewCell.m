//
//  AirDropTableViewCell.m
//  Airdrop Hack
//
//  Created by Derek Selander on 10/29/16.
//  Copyright © 2016 Selander. All rights reserved.
//

#import "AirDropTableViewCell.h"
#import <dlfcn.h>
#import "PrivateSwizzler.h"
#import "NSObject+AddingSelectedThing.h"
@class SFAirDropNode;

@interface AirDropTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *acceptedLabel;
@property (weak, nonatomic) IBOutlet UILabel *rejectedLabel;
@property (weak, nonatomic) IBOutlet UIImageView *selectedImageView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *secondaryNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *realNameLabel;
@property (weak, nonatomic) NSObject<SFAirDropNode>* node;
@end

@implementation AirDropTableViewCell

- (void)setupObject:(id<SFAirDropNode>)node {
  self.node = node;
  if ([node respondsToSelector:@selector(contactIdentifier)] && [node contactIdentifier]) {
    [self.label setText:[node contactIdentifier]];
  } else if ([node displayName]) {
    [self.label setText:[node displayName]];
  } else {
      [self.label setText:[node secondaryName]];
  }
  self.acceptedLabel.text = self.node.dbs_acceptedCount.stringValue;
  self.realNameLabel.text = self.node.dbs_rejectedCount.stringValue;
  [self.iconImageView setImage:[node displayIcon]];
  
  static NSString *(*SFNodeCopyModel)(id);
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
   SFNodeCopyModel = dlsym(dlopen("/System/Library/PrivateFrameworks/Sharing.framework/Sharing", RTLD_NOW), "SFNodeCopyModel");
  });
  [self.realNameLabel setText:[node realName]];
  [self.secondaryNameLabel setText:SFNodeCopyModel([node node])];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];
  self.selectedImageView.hidden = !selected;
  
  if ([self isSelected]) {
    self.backgroundColor = [UIColor colorWithWhite:0.47 alpha:1.0];
  } else {
    self.backgroundColor = [UIColor whiteColor]; 
  }
  
  

  // Configure the view for the selected state
}

@end
