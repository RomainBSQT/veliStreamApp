//
//  RBTFriendsService.h
//  veli
//
//  Created by Romain Bousquet on 22/09/2015.
//  Copyright © 2015 Romain Bousquet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RBTFriendsService : NSObject

+ (RACSignal *)fetchFriends;

@end
