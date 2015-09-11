//
//  RBTFriendListHeaderView.h
//  veli
//
//  Created by Romain Bousquet on 29/03/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RBTSearchBar;

@interface RBTFriendListHeaderView : UITableViewHeaderFooterView

@property (strong, nonatomic) RBTSearchBar *searchBar;

+ (NSString *)reuseIdentifier;
+ (CGFloat)height;

@end
