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

- (void)drawInContext:(CGContextRef)context inRect:(CGRect)rect
{
#pragma unused(rect)
    UIBezierPath *path = [self.internalPath copy];
    
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, self.brush.lineWidth);
    
    
    CGMutablePathRef newPath = CGPathCreateMutableCopy(path.CGPath);
    CGContextAddPath(context, newPath);
    CGContextSetStrokeColorWithColor(context, self.brush.color.CGColor);
    if (self.brush.shadow) {
        CGContextSetShadowWithColor(context, self.brush.shadow.offset, self.brush.shadow.blur, self.brush.shadow.color.CGColor);
    }
    
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
