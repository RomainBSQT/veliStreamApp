//
//  RBTTheme.h
//  veli
//
//  Created by Romain Bousquet on 26/03/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RBTTheme : NSObject

+ (UIColor *)colorRed;
+ (UIColor *)colorDarkRed;
+ (UIColor *)colorGreenEmerald;
+ (UIColor *)colorLightGray;
+ (UIColor *)colorDarkGray;

+ (UIColor *)colorTurquoise;
+ (UIColor *)colorEmerald;
+ (UIColor *)colorPeterRiver;
+ (UIColor *)colorAmethyst;
+ (UIColor *)colorWetAsphalt;
+ (UIColor *)colorSunFlower;
+ (UIColor *)colorCarrot;
+ (UIColor *)colorAlizarin;
+ (UIColor *)colorCloud;
+ (UIColor *)colorConcrete;
+ (UIColor *)nextColor;

+ (UIFont *)sourceSansProBlackWithSize:(CGFloat)fontSize;
+ (UIFont *)sourceSansProBlackItalicWithSize:(CGFloat)fontSize;
+ (UIFont *)sourceSansProBoldWithSize:(CGFloat)fontSize;
+ (UIFont *)sourceSansProBoldItalicWithSize:(CGFloat)fontSize;
+ (UIFont *)sourceSansProExtraLightWithSize:(CGFloat)fontSize;
+ (UIFont *)sourceSansProExtraLightItalicWithSize:(CGFloat)fontSize;
+ (UIFont *)sourceSansProItalicWithSize:(CGFloat)fontSize;
+ (UIFont *)sourceSansProLightWithSize:(CGFloat)fontSize;
+ (UIFont *)sourceSansProLightItalicWithSize:(CGFloat)fontSize;
+ (UIFont *)sourceSansProRegularWithSize:(CGFloat)fontSize;
+ (UIFont *)sourceSansProSemiboldWithSize:(CGFloat)fontSize;
+ (UIFont *)sourceSansProSemiboldItalicWithSize:(CGFloat)fontSize;

@end
