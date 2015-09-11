//
//  RBTNavigationBarTitleView.m
//  veli
//
//  Created by Romain Bousquet on 27/03/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import "RBTNavigationBarTitleView.h"

UIViewAutoresizing ReplicateParentFrameResizing();

@interface RBTNavigationBarTitleView ()

@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation RBTNavigationBarTitleView

- (id)initWithFrame:(CGRect)frame title:(NSString *)title
{
	self = [super initWithFrame:frame];
	if (self) {
		self.titleLabel = [[UILabel alloc] init];
		self.titleLabel.text = title;
		self.titleLabel.font = [RBTTheme sourceSansProSemiboldWithSize:20.f];
		self.titleLabel.textColor = [UIColor whiteColor];
		self.titleLabel.frame = self.bounds;
		self.titleLabel.autoresizingMask = ReplicateParentFrameResizing();
		self.titleLabel.textAlignment = NSTextAlignmentCenter;
		[self addSubview:self.titleLabel];
	}
	return self;
}

+ (instancetype)titleViewWithTitle:(NSString *)title
{
	RBTNavigationBarTitleView *titleView = [[self alloc] initWithFrame:CGRectMake(0, 0, 200, 44) title:title];
	return titleView;
}

@end

UIViewAutoresizing ReplicateParentFrameResizing() {
	return UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleWidth|
	UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|
	UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleBottomMargin;
}
