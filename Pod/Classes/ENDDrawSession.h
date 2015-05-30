//
//  ENDDrawSession.h
//  Smooth Line View
//
//  Created by Andreas Kompanez on 26.05.15.
//  Copyright (c) 2015 culturezoo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ENDDrawOperation.h"



@interface ENDDrawSession : NSObject

/// Current running operation
@property (nonatomic, strong, readonly) id <ENDDrawOperation> operation;
@property (nonatomic, copy, readonly) NSArray *operations;

- (id <ENDDrawOperation>)beginOperation:(Class)operationClass;
- (void)endOperation;

/// Has operaions YES/NO
- (BOOL)isEmpty;

- (void)removeLastOperation;
- (void)removeAllOperations;

@end
