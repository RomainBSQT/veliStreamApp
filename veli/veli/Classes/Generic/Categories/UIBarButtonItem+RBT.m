//
//  UIBarButtonItem+RBT.m
//  veli
//
//  Created by Romain Bousquet on 04/04/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import "UIBarButtonItem+RBT.h"

@implementation UIBarButtonItem (RBT)

+ (UIBarButtonItem *)RBTBarButtonItemWithPictureName:(NSString *)pictureName target:(id)target action:(SEL)selector
{
	UIImage *picture = [[UIImage imageNamed:pictureName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
	UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithImage:picture style:UIBarButtonItemStylePlain
															   target:target action:selector];
	return barItem;
}

@end