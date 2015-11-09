//
//  RBTURLBuilder.h
//  veli
//
//  Created by Romain Bousquet on 06/04/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RBTURLType) {
	RBTURLTypeRegister,
	RBTURLTypeUsers,
	RBTURLTYpeUser
};

@interface RBTURLBuilder : NSObject

+ (instancetype)sharedInstance;
- (NSString *)urlWithUrlType:(RBTURLType)urlType;
+ (NSString *)SSEURLSubscribe;

@end
