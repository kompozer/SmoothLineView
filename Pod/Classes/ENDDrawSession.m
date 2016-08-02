//
//  ENDDrawSession.m
//  Smooth Line View
//
//  Created by Andreas Kompanez on 26.05.15.
//  Copyright (c) 2015 culturezoo. All rights reserved.
//

#import "ENDDrawSession.h"

#import "ENDDrawOperation.h"



@interface ENDDrawSession ()

@property (nonatomic, strong, readwrite) id <ENDDrawOperation> operation;

@property (nonatomic, strong) NSMutableArray *internalOperations;
@property (nonatomic, strong) NSMutableArray *redoOperations;

@property (nonatomic) NSUInteger lastSequenceID;
@end

@implementation ENDDrawSession

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.internalOperations = [NSMutableArray new];
        self.redoOperations = [NSMutableArray new];
    }
    return self;
}

- (NSArray *)operations
{
    return [NSArray arrayWithArray:self.internalOperations];
}

- (id <ENDDrawOperation>)beginOperation:(Class)operationClass
{
    return [self beginOperation:operationClass inSequence:NO];
}

- (id <ENDDrawOperation>)beginOperation:(Class)operationClass inSequence:(BOOL)inSequence
{
    if (! [operationClass conformsToProtocol:@protocol(ENDDrawOperation)]) {
        return nil;
    }
    self.operation = [operationClass new];
    self.operation.sequenceID = inSequence ? self.lastSequenceID : self.lastSequenceID + 1;
    return self.operation;
}

- (void)endOperation
{
    if (self.operation) {
        [self.internalOperations addObject:self.operation];
        self.operation = nil;
        
        [self.redoOperations removeAllObjects];
    }
}

- (BOOL)canRemoveLastOperation
{
    return (self.internalOperations.count > 0);
}

- (void)removeLastOperation
{
    if (self.internalOperations.count == 0) {
        return;
    }
    
    id <ENDDrawOperation> operation = [self.internalOperations lastObject];
    [self.internalOperations removeObject:operation];
    [self.redoOperations addObject:operation];
    
    NSUInteger lastOperationSequenceID = operation.sequenceID;

    operation = [self.internalOperations lastObject];

    while(operation.sequenceID == lastOperationSequenceID) {
        [self.internalOperations removeObject:operation];
        [self.redoOperations addObject:operation];
        operation = [self.internalOperations lastObject];
    };
}

- (BOOL)canRedoLastOperation
{
    return (self.redoOperations.count > 0);
}

- (void)redoLastOperation
{
    if (self.redoOperations.count == 0) {
        return;
    }
    id <ENDDrawOperation> operation = [self.redoOperations lastObject];
    [self.internalOperations addObject:operation];
    [self.redoOperations removeObject:operation];
    
    NSUInteger lastOperationSequenceID = operation.sequenceID;
    
    operation = [self.redoOperations lastObject];
    
    while(operation.sequenceID == lastOperationSequenceID) {
        [self.internalOperations addObject:operation];
        [self.redoOperations removeObject:operation];
        operation = [self.redoOperations lastObject];
    };
}

- (void)removeAllOperations
{
    [self.internalOperations removeAllObjects];
    [self.redoOperations removeAllObjects];
}

- (NSUInteger)lastSequenceID
{
    id <ENDDrawOperation> operation = self.internalOperations.lastObject;
    return operation.sequenceID;
}

@end
