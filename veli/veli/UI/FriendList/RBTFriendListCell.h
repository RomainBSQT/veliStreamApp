//
//  RBTFriendListCell.h
//  veli
//
//  Created by Romain Bousquet on 29/03/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import "RBTTableViewCell.h"

@class RBTFriend;

typedef NS_ENUM(NSUInteger, RBTFriendListCellType) {
	RBTFriendListCellTypeFriendList,
	RBTFriendListCellTypeAddFriend
};

@interface RBTFriendListCell : RBTTableViewCell

@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

- (void)configureCellWithFriend:(RBTFriend *)currentFriend withType:(RBTFriendListCellType)cellType;

@end
