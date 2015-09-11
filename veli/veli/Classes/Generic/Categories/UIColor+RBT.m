//
//  UIColor+RBT.m
//  veli
//
//  Created by Romain Bousquet on 26/03/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import "UIColor+RBT.h"

@implementation UIColor (RBT)

+ (UIColor *)colorWithIntRed:(short)red green:(short)green blue:(short)blue alpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:((CGFloat)red/255.f) green:((CGFloat)green/255.f) blue:((CGFloat)blue/255.f) alpha:alpha];
}

+ (UIColor *)grayWithRGB:(short)white
{
	return [UIColor colorWithIntRed:white green:white blue:white alpha:1.f];
}

@end
