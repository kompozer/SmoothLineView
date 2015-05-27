//
//  ENDDrawOperation.m
//  Smooth Line View
//
//  Created by Andreas Kompanez on 26.05.15.
//  Copyright (c) 2015 culturezoo. All rights reserved.
//

#import "ENDDrawOperation.h"



@interface ENDDrawOperation ()

@property (nonatomic, strong) NSMutableArray *internalSubpaths;

@end

@implementation ENDDrawOperation

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.internalSubpaths = [NSMutableArray array];
    }
    return self;
}

- (NSArray *)subpaths
{
    return [NSArray arrayWithArray:self.internalSubpaths];
}

- (void)addSubpath:(UIBezierPath *)subpath
{
    if (subpath) {
        [self.internalSubpaths addObject:subpath];
    }
}

@end
