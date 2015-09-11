//
//  RBTTheme.m
//  veli
//
//  Created by Romain Bousquet on 26/03/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import "RBTTheme.h"
#import "UIColor+RBT.h"

@implementation RBTTheme

#pragma mark - Colors

+ (UIColor *)colorRed
{
	return [UIColor colorWithIntRed:192 green:57 blue:43 alpha:1.f];
}

+ (UIColor *)colorDarkRed
{
	return [UIColor colorWithIntRed:186 green:50 blue:42 alpha:1.f];
}

+ (UIColor *)colorGreenEmerald
{
	return [UIColor colorWithIntRed:0 green:140 blue:111 alpha:1.f];
}

+ (UIColor *)colorLightGray
{
	return [UIColor grayWithRGB:204];
}

+ (UIColor *)colorDarkGray
{
	return [UIColor grayWithRGB:51];
}

#pragma mark - User's colors

+ (UIColor *)colorTurquoise
{
	return [UIColor colorWithIntRed:26 green:188 blue:156 alpha:1.f];
}

+ (UIColor *)colorEmerald
{
	return [UIColor colorWithIntRed:46 green:204 blue:113 alpha:1.f];
}

+ (UIColor *)colorPeterRiver
{
	return [UIColor colorWithIntRed:52 green:152 blue:219 alpha:1.f];
}

+ (UIColor *)colorAmethyst
{
	return [UIColor colorWithIntRed:155 green:89 blue:182 alpha:1.f];
}

+ (UIColor *)colorWetAsphalt
{
	return [UIColor colorWithIntRed:52 green:73 blue:94 alpha:1.f];
}

+ (UIColor *)colorSunFlower
{
	return [UIColor colorWithIntRed:241 green:196 blue:15 alpha:1.f];
}

+ (UIColor *)colorCarrot
{
	return [UIColor colorWithIntRed:230 green:126 blue:34 alpha:1.f];
}

+ (UIColor *)colorAlizarin
{
	return [UIColor colorWithIntRed:231 green:76 blue:60 alpha:1.f];
}

+ (UIColor *)colorCloud
{
	return [UIColor colorWithIntRed:236 green:240 blue:241 alpha:1.f];
}

+ (UIColor *)colorConcrete
{
	return [UIColor colorWithIntRed:149 green:165 blue:166 alpha:1.f];
}

+ (UIColor *)nextColor
{
	NSArray *colorArray = @[[self colorTurquoise],
							[self colorEmerald],
							[self colorPeterRiver],
							[self colorAmethyst],
							[self colorWetAsphalt],
							[self colorSunFlower],
							[self colorCarrot],
							[self colorAlizarin],
							[self colorCloud],
							[self colorConcrete]];
	static NSInteger idx = -1;
	idx = idx == colorArray.count-1 ? 0 : idx + 1;
	return colorArray[idx];
}

#pragma mark - Fonts

+ (UIFont *)sourceSansProBlackWithSize:(CGFloat)fontSize
{
	return [UIFont fontWithName:@"SourceSansPro-Black" size:fontSize];
}

+ (UIFont *)sourceSansProBlackItalicWithSize:(CGFloat)fontSize
{
	return [UIFont fontWithName:@"SourceSansPro-BlackIt" size:fontSize];
}

+ (UIFont *)sourceSansProBoldWithSize:(CGFloat)fontSize
{
	return [UIFont fontWithName:@"SourceSansPro-Bold" size:fontSize];
}

+ (UIFont *)sourceSansProBoldItalicWithSize:(CGFloat)fontSize
{
	return [UIFont fontWithName:@"SourceSansPro-BoldIt" size:fontSize];
}

+ (UIFont *)sourceSansProExtraLightWithSize:(CGFloat)fontSize
{
	return [UIFont fontWithName:@"SourceSansPro-ExtraLight" size:fontSize];
}

+ (UIFont *)sourceSansProExtraLightItalicWithSize:(CGFloat)fontSize
{
	return [UIFont fontWithName:@"SourceSansPro-ExtraLightIt" size:fontSize];
}

+ (UIFont *)sourceSansProItalicWithSize:(CGFloat)fontSize
{
	return [UIFont fontWithName:@"SourceSansPro-It" size:fontSize];
}

+ (UIFont *)sourceSansProLightWithSize:(CGFloat)fontSize
{
	return [UIFont fontWithName:@"SourceSansPro-Light" size:fontSize];
}

+ (UIFont *)sourceSansProLightItalicWithSize:(CGFloat)fontSize
{
	return [UIFont fontWithName:@"SourceSansPro-LightIt" size:fontSize];
}

+ (UIFont *)sourceSansProRegularWithSize:(CGFloat)fontSize
{
	return [UIFont fontWithName:@"SourceSansPro-Regular" size:fontSize];
}

+ (UIFont *)sourceSansProSemiboldWithSize:(CGFloat)fontSize
{
	return [UIFont fontWithName:@"SourceSansPro-Semibold" size:fontSize];
}

+ (UIFont *)sourceSansProSemiboldItalicWithSize:(CGFloat)fontSize
{
	return [UIFont fontWithName:@"SourceSansPro-SemiboldIt" size:fontSize];
}

@end
