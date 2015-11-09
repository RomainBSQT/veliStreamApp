//
//  RBTFriendListCell.m
//  veli
//
//  Created by Romain Bousquet on 29/03/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "RBTFriendListCell.h"
#import "RBTFriend.h"

@interface RBTFriendListCell ()

@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UIImageView *liveIcon;
@property (weak, nonatomic) IBOutlet UIView *separatorView;
@property (weak, nonatomic) IBOutlet UIImageView *addFriendImage;

@end

@implementation RBTFriendListCell

- (void)awakeFromNib
{
	[super awakeFromNib];
	
	self.selectionStyle = UITableViewCellSelectionStyleNone;
	self.picture.layer.cornerRadius = 3.f;
	
	UIImage *confirmPicture = [UIImage imageNamed:@"icon-check"];
	UIImageView *confirmView = [[UIImageView alloc] initWithImage:confirmPicture];
	confirmView.translatesAutoresizingMaskIntoConstraints = NO;
	confirmView.userInteractionEnabled = NO;
	[self.confirmButton addSubview:confirmView];
	NSArray *horizontalConstraintsConfirm = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[view(==viewWidth)]" options:0
																					metrics:@{@"viewWidth": @(confirmPicture.size.width)}
																					  views:@{@"view": confirmView}];
	[self.confirmButton addConstraints:horizontalConstraintsConfirm];
	[confirmView setConstraintsForYCenteringInView:self.confirmButton];
	
	UIImage *cancelPicture = [UIImage imageNamed:@"icon-cross"];
	UIImageView *cancelView = [[UIImageView alloc] initWithImage:cancelPicture];
	cancelView.translatesAutoresizingMaskIntoConstraints = NO;
	cancelView.userInteractionEnabled = NO;
	[self.cancelButton addSubview:cancelView];
	NSArray *horizontalConstraintsCancel = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[view(==viewWidth)]" options:0
																				   metrics:@{@"viewWidth": @(cancelPicture.size.width)}
																					 views:@{@"view": cancelView}];
	[self.cancelButton addConstraints:horizontalConstraintsCancel];
	[cancelView setConstraintsForYCenteringInView:self.cancelButton];
	
	self.addFriendImage.userInteractionEnabled = NO;
	self.addFriendImage.alpha = 0.15f;
}

- (void)prepareForReuse
{
	[super prepareForReuse];
	[self.confirmButton removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
	[self.cancelButton removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
	if (selected) {
		self.addFriendImage.alpha = 1.f;
	} else {
		self.addFriendImage.alpha = 0.15f;
	}
	[super setSelected:selected animated:animated];
}

- (void)configureCellWithFriend:(RBTFriend *)currentFriend withType:(RBTFriendListCellType)cellType
{
	self.username.text = currentFriend.username;
	switch (cellType) {
		case RBTFriendListCellTypeFriendList:
			self.addFriendImage.hidden = YES;
			self.confirmButton.hidden = NO;
			self.cancelButton.hidden = NO;
			self.confirmButton.enabled = YES;
			self.cancelButton.enabled = YES;
			self.liveIcon.hidden = YES; // ![currentFriend.live_status boolValue];
			break;
		case RBTFriendListCellTypeAddFriend:
			self.liveIcon.hidden = YES;
			self.addFriendImage.hidden = NO;
			self.confirmButton.hidden = YES;
			self.cancelButton.hidden = YES;
			self.confirmButton.enabled = NO;
			self.cancelButton.enabled = NO;
			break;
	}
}

@end
