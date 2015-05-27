//
//  ENDDrawSession.h
//  Smooth Line View
//
//  Created by Andreas Kompanez on 26.05.15.
//  Copyright (c) 2015 culturezoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ENDDrawOperation;



@interface ENDDrawSession : NSObject

@property (nonatomic, strong, readonly) ENDDrawOperation *operation;
@property (nonatomic, copy, readonly) NSArray *operations;

- (void)beginOperation;
- (void)endOperation;

/// Has operaions YES/NO
- (BOOL)isEmpty;

- (void)removeLastOperation;

@end
