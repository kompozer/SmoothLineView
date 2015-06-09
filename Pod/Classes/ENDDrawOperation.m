//
//  ENDDrawOperation.m
//  Smooth Line View
//
//  Created by Andreas Kompanez on 26.05.15.
//  Copyright (c) 2015 culturezoo. All rights reserved.
//

#import "ENDDrawOperation.h"



@interface ENDDrawPathOperation ()

@property (nonatomic, strong) UIBezierPath *internalPath;

@end

@implementation ENDDrawPathOperation

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.internalPath = [UIBezierPath bezierPath];
    }
    return self;
}

- (UIBezierPath *)path
{
    return [self.internalPath copy];
}

- (void)addSubpath:(UIBezierPath *)subpath
{
    if (subpath) {
        [self.internalPath appendPath:subpath];
    }
}

@end



@implementation ENDDrawFillWithColorOperation

@end
