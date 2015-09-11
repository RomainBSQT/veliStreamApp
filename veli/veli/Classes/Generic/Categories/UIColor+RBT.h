//
//  UIColor+RBT.h
//  veli
//
//  Created by Romain Bousquet on 26/03/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (RBT)

+ (UIColor *)colorWithIntRed:(short)red green:(short)green blue:(short)blue alpha:(CGFloat)alpha;
+ (UIColor *)grayWithRGB:(short)white;

@end
