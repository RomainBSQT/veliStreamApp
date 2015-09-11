//
//  UINavigationController+RBT.h
//  veli
//
//  Created by Romain Bousquet on 24/03/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (RBT)

+ (UINavigationController *)RBTNavigationControllerWithRootViewController:(UIViewController *)viewController;

- (void)statusBarAnimateIn;
- (void)statusBarAnimateOut;
- (void)popToViewController:(Class)aClass;

@end
