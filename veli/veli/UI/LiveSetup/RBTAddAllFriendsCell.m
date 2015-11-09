//
//  RBTAddAllFriendsCell.m
//  veli
//
//  Created by Romain Bousquet on 25/04/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import "RBTAddAllFriendsCell.h"

@interface RBTAddAllFriendsCell ()

@property (weak, nonatomic) IBOutlet UIImageView *addFriendsImage;

@end

@implementation RBTAddAllFriendsCell

- (void)awakeFromNib
{
	[super awakeFromNib];
	
	self.selectionStyle = UITableViewCellSelectionStyleNone;
	self.addFriendsImage.userInteractionEnabled = NO;
	self.addFriendsImage.alpha = 0.15f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
	if (selected) {
		self.addFriendsImage.alpha = 1.f;
	} else {
		self.addFriendsImage.alpha = 0.15f;
	}
	[super setSelected:selected animated:animated];
}

@end
