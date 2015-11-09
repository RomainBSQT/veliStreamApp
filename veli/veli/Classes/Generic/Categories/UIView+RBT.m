//
//  UIView+RBT.m
//  veli
//
//  Created by Romain Bousquet on 19/03/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import "UIView+RBT.h"

@implementation UIView (RBT)

#pragma mark - Convenience methods
#pragma mark - Nibs

+ (UINib *)nib
{
	return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
}

+ (instancetype)viewFromNib
{
	UINib *nib = [self nib];
	return [nib instantiateWithOwner:self options:nil][0];
}

+ (instancetype)viewWithNibName:(NSString *)nibName
{
	UINib *nib = [UINib nibWithNibName:nibName bundle:nil];
	return [nib instantiateWithOwner:self options:nil][0];
}

#pragma mark - Constraints

- (void)setConstraintsForYCenteringInView:(UIView *)superView
{
	[superView addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual
															 toItem:superView attribute:NSLayoutAttributeCenterY multiplier:1.f constant:0.f]];
}

- (void)setConstraintsForXCenteringInView:(UIView *)superView
{
	[superView addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual
															 toItem:superView attribute:NSLayoutAttributeCenterX multiplier:1.f constant:0.f]];
}

- (void)setConstraintsForCenteringInView:(UIView *)superView
{
	[self setConstraintsForXCenteringInView:superView];
	[self setConstraintsForYCenteringInView:superView];
}

- (void)setConstraintsFillSuperView:(UIView *)superView
{
	NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view]-0-|" options:0 metrics:nil views:@{@"view": self}];
	NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|" options:0 metrics:nil views:@{@"view": self}];
	[superView addConstraints:verticalConstraints];
	[superView addConstraints:horizontalConstraints];
}

@end
