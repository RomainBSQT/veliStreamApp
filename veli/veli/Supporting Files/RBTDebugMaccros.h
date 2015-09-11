//
//  RBTDebugMaccros.h
//  veli
//
//  Created by Romain Bousquet on 21/03/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#ifdef DEBUG
	#define NCLog(s, ...) NSLog(@"<%@:%@:%d> %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__])
#else
	#define NCLog(s, ...)
#endif