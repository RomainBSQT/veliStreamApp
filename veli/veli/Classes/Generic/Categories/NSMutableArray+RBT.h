//
//  NSMutableArray+RBT.h
//  veli
//
//  Created by Romain Bousquet on 02/05/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (RBT)

- (id)queuePop;
- (void)queuePush:(id)object;

@end
