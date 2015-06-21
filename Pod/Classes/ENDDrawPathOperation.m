//
//  ENDDrawPathOperation.m
//  Pods
//
//  Created by Andreas Kompanez on 21.06.15.
//
//

#import "ENDDrawPathOperation.h"



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
    CGContextSetShadowWithColor(context, (CGSize){1, 1}, 0.6, [UIColor grayColor].CGColor);
    
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
