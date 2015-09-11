//
//  UIView+RBT.h
//  veli
//
//  Created by Romain Bousquet on 19/03/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (RBT)

+ (UINib *)nib;
+ (instancetype)viewFromNib;
+ (instancetype)viewWithNibName:(NSString *)nibName;

- (void)setConstraintsForYCenteringInView:(UIView *)superView;
- (void)setConstraintsForXCenteringInView:(UIView *)superView;
- (void)setConstraintsForCenteringInView:(UIView *)superView;
- (void)setConstraintsFillSuperView:(UIView *)superView;

@end
