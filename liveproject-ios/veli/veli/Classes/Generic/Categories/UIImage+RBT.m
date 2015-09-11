//
//  UIImage+RBT.m
//  veli
//
//  Created by Romain Bousquet on 24/03/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import "UIImage+RBT.h"

@implementation UIImage (RBT)

+ (UIImage *)RBTNavigationBarBackgroundImage
{
	return [self RBTUIImageWithColor:[RBTTheme colorRed]];
}

+ (UIImage *)RBTUIImageWithColor:(UIColor *)color
{
	CGRect rect = CGRectMake(0, 0, 1, 3);
	
	UIGraphicsBeginImageContext(rect.size);
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(context, [color CGColor]);
	CGContextFillRect(context, rect);
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return image;
}

@end
