//
//  ENDDrawSession.h
//  Smooth Line View
//
//  Created by Andreas Kompanez on 26.05.15.
//  Copyright (c) 2015 culturezoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ENDDrawOperation;



@interface ENDDrawSession : NSObject

/// Current running operation
@property (nonatomic, strong, readonly) id <ENDDrawOperation> operation;
@property (nonatomic, copy, readonly) NSArray *operations;

- (id <ENDDrawOperation>)beginOperation:(Class)operationClass;
- (void)endOperation;

- (BOOL)canRemoveLastOperation;
- (void)removeLastOperation;

- (BOOL)canRedoLastOperation;
- (void)redoLastOperation;

- (void)removeAllOperations;

@end
