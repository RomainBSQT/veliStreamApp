//
//  RBTFriendListHeaderView.m
//  veli
//
//  Created by Romain Bousquet on 29/03/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import "RBTFriendListHeaderView.h"
#import "RBTSearchBar.h"

@implementation RBTFriendListHeaderView

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		self.contentView.backgroundColor = [UIColor whiteColor];
		RBTSearchBar *contentView = [RBTSearchBar viewFromNib];
		self.searchBar = contentView;
		contentView.frame = self.contentView.bounds;
		[self.contentView addSubview:contentView];
	}
	return self;
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithReuseIdentifier:reuseIdentifier];
	if (self) {
	}
	return self;
}

+ (NSString *)reuseIdentifier
{
	return NSStringFromClass(self);
}

+ (CGFloat)height
{
	return 46.f;
}

@end