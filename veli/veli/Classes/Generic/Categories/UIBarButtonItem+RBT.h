//
//  UIBarButtonItem+RBT.h
//  veli
//
//  Created by Romain Bousquet on 04/04/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (RBT)

+ (UIBarButtonItem *)RBTBarButtonItemWithPictureName:(NSString *)pictureName target:(id)target action:(SEL)selector;

@end
