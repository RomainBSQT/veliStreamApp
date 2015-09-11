//
//  RBTFriendViewCell.m
//  veli
//
//  Created by Romain Bousquet on 03/05/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import "RBTFriendViewCell.h"
#import "RBTJoinLeftInformations.h"

@interface RBTFriendViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UIView *placeholderView;
@property (weak, nonatomic) IBOutlet UILabel *letterLabel;

@end

@implementation RBTFriendViewCell

- (void)awakeFromNib
{
	[super awakeFromNib];
	self.contentView.clipsToBounds = YES;
	self.contentView.layer.cornerRadius = 3.f;
	self.contentView.backgroundColor = [UIColor clearColor];
	self.letterLabel.font = [RBTTheme sourceSansProBoldWithSize:35.f];
	self.letterLabel.textColor = [UIColor whiteColor];
}

- (void)setupViewFriendInformations:(RBTJoinLeftInformations *)friendInformations
{
	self.picture.hidden = (friendInformations.currentFriend == nil);
	self.placeholderView.hidden = (friendInformations.currentFriend != nil);
	self.letterLabel.text = [[friendInformations.username substringToIndex:1] uppercaseString];
	self.placeholderView.backgroundColor = friendInformations.color;
}

@end
