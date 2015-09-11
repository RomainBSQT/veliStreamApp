//
//  RBTLiveInformationsView.m
//  veli
//
//  Created by Romain Bousquet on 16/04/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import "RBTLiveInformationsView.h"
#import "RBTFriend.h"

@interface RBTLiveInformationsView ()

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewersLabel;

@end

@implementation RBTLiveInformationsView

- (void)awakeFromNib
{
	[super awakeFromNib];
}

#pragma mark - Setters

- (void)setCurrentFriend:(RBTFriend *)currentFriend
{
	_currentFriend = currentFriend;
	self.usernameLabel.text = currentFriend.username;
	self.viewersLabel.text = [currentFriend.live_audience stringValue];
}

@end
