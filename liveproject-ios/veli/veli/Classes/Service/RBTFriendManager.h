//
//  RBTFriendManager.h
//  veli
//
//  Created by Romain Bousquet on 24/06/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RBTFriendManager : NSObject

+ (RBTFriendManager *)sharedInstance;
- (RACSignal *)friends;

@end
