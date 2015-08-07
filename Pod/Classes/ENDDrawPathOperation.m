//
//  ENDDrawPathOperation.m
//  Pods
//
//  Created by Andreas Kompanez on 21.06.15.
//
//

#import "ENDDrawPathOperation.h"

#import "ENDBrush.h"
#import "ENDBrushShadow.h"



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

- (void)drawInContext:(CGContextRef)context inRect:(CGRect)rect
{
#pragma unused(rect)
    UIBezierPath *path = self.path;
    
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, self.brush.lineWidth);
    
    CGContextAddPath(context, path.CGPath);
    CGContextSetStrokeColorWithColor(context, self.brush.color.CGColor);
    if (self.brush.shadow) {
        CGContextSetShadowWithColor(context, self.brush.shadow.offset, self.brush.shadow.blur, self.brush.shadow.color.CGColor);
    }
    
    CGContextStrokePath(context);
}

- (CGRect)pathDrawBox:(CGPathRef)path
{
    if (! path) {
        return CGRectNull;
    }
    
    CGRect bounds = CGPathGetBoundingBox(path);
    CGRect pathDrawBox = CGRectInset(bounds, -2.0 * self.brush.lineWidth, -2.0 * self.brush.lineWidth);
    
    return pathDrawBox;
}

- (CGRect)drawRect
{
    return [self pathDrawBox:[self.path CGPath]];
}

- (void)addSubpath:(UIBezierPath *)subpath
{
    if (subpath) {
        [self.internalPath appendPath:subpath];
    }
}

@end
