//
//  RBTServerSentEventHelper.h
//  veli
//
//  Created by Romain Bousquet on 31/05/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventSource.h"

@class RBTJoinLeftInformations;

FOUNDATION_EXPORT NSString *const kMainEventName;


@protocol RBTServerSentEventProtocol <NSObject>

@property (nonatomic, strong) NSNumber *audience;
@property (nonatomic, copy) NSArray *eventsArray;

@end


typedef void (^RBTServerSentEvent)(id<RBTServerSentEventProtocol> eventDatas);
typedef void (^RBTServerSentError)(NSError *error);


@interface RBTServerSentEventDatas : NSObject <RBTServerSentEventProtocol>

@property (nonatomic, strong) NSNumber *audience;
@property (nonatomic, copy) NSArray *eventsArray;

+ (instancetype)eventDatasWithEventArray:(NSArray *)eventArray audience:(NSNumber *)audience;

@end


@interface RBTServerSentEventHelper : NSObject

+ (instancetype)SSEWithUrl:(NSURL *)url;
- (RACSignal *)onEvent:(NSString *)eventName;

@end
