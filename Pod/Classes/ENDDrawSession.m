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

@property (nonatomic, strong, readwrite) ENDDrawOperation *operation;

@property (nonatomic, strong) NSMutableArray *internalOperations;


@end

@implementation ENDDrawSession

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.internalOperations = [NSMutableArray new];
    }
    return self;
}

- (NSArray *)operations
{
    return [NSArray arrayWithArray:self.internalOperations];
}

- (void)beginOperation
{
    self.operation = [ENDDrawOperation new];
}

- (void)endOperation
{
    if (self.operation) {
        [self.internalOperations addObject:self.operation];
        self.operation = nil;
    }
}

- (BOOL)isEmpty
{
    return (self.internalOperations.count == 0);
}

- (void)removeLastOperation
{
    if (self.internalOperations.count == 0) {
        return;
    }
    
    [self.internalOperations removeLastObject];
}


@end
