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
        self.lineWidth = 1.0;
    }
    return self;
}

- (void)drawInContext:(CGContextRef)context inRect:(CGRect)rect
{
#pragma unused(rect)
    UIBezierPath *path = [self.internalPath copy];
    
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, self.lineWidth);
    
    CGMutablePathRef newPath = CGPathCreateMutableCopy(path.CGPath);
    CGContextAddPath(context, newPath);
    CGContextSetStrokeColorWithColor(context, self.color.CGColor);
    
    CGContextStrokePath(context);
    
    CFRelease(newPath);
}

- (void)addSubpath:(UIBezierPath *)subpath
{
    if (subpath) {
        [self.internalPath appendPath:subpath];
    }
}

@end



@implementation ENDDrawFillWithColorOperation

- (void)drawInContext:(CGContextRef)context inRect:(CGRect)rect
{
    if (self.color) {
        [self.color set];
        UIRectFill(rect);
    }
}

@end
