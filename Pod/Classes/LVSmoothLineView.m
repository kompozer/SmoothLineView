//  The MIT License (MIT)
//
//  Copyright (c) 2013 Levi Nunnink
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

//
//  Created by Levi Nunnink (@a_band) http://culturezoo.com
//  Copyright (C) Droplr Inc. All Rights Reserved
//

#import "LVSmoothLineView.h"

#import <QuartzCore/QuartzCore.h>

#import "ENDDrawOperation.h"
#import "ENDDrawSession.h"
#import "ENDDrawGestureRecognizer.h"
#import "ENDDrawPathOperation.h"
#import "ENDDrawFillWithColorOperation.h"
#import "ENDBrush.h"



static UIColor *LVDefaultBackgroundColor = nil;
static const CGFloat LVPointMinDistance = 4.0f;
static const CGFloat LVPointMinDistanceSquared = LVPointMinDistance * LVPointMinDistance;

#pragma mark private Helper function

static CGPoint LVMiddlePoint(CGPoint p1, CGPoint p2) {
    return CGPointMake((p1.x + p2.x) * 0.5, (p1.y + p2.y) * 0.5);
}


@interface LVSmoothLineView ()

@property (nonatomic, assign) CGPoint currentPoint;
@property (nonatomic, assign) CGPoint previousPoint;
@property (nonatomic, assign) CGPoint previousPreviousPoint;

@property (nonatomic, strong) ENDDrawPathOperation *pathOperation;
@property (nonatomic, strong) ENDDrawSession *session;

@end

@implementation LVSmoothLineView

+ (void)initialize
{
    LVDefaultBackgroundColor = [UIColor whiteColor];
}

#pragma mark UIView lifecycle methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        // NOTE: do not change the backgroundColor here, so it can be set in IB.
        [self setUpSmoothLineView];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = LVDefaultBackgroundColor;
        
        [self setUpSmoothLineView];
    }
    
    return self;
}

- (void)setUpSmoothLineView
{
    self.session = [ENDDrawSession new];
    self.brush = [ENDBrush new];
    
    UIGestureRecognizer *recognizer = [[ENDDrawGestureRecognizer alloc] initWithTarget:self action:@selector(drawGestureRecognized:)];
    [self addGestureRecognizer:recognizer];
    
    UILongPressGestureRecognizer *longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressRecognized:)];
    longPressRecognizer.minimumPressDuration = 0.6;
    [self addGestureRecognizer:longPressRecognizer];
    
    [recognizer requireGestureRecognizerToFail:longPressRecognizer];
}

- (void)drawRect:(CGRect)rect
{
    // clear rect
    [self.backgroundColor set];
    UIRectFill(rect);
    
    // get the graphics context and draw the path
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGContextSetShouldAntialias(context, YES);
    CGContextSetAllowsAntialiasing(context, YES);
    CGContextSetFlatness(context, 0.1f);
    
    // Append the current running operation, so we can draw it
    NSMutableArray *operations = [self.session.operations mutableCopy];
    if (self.session.operation) {
        [operations addObject:self.session.operation];
    }
    
    for (id <ENDDrawOperation> operation in operations) {
        [operation drawInContext:context inRect:rect];
    }
}

#pragma mark Touch handling

- (void)drawGestureRecognized:(ENDDrawGestureRecognizer *)recognizer
{
    NSSet *touches = recognizer.touches;
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        [self drawOperationBegan:touches];
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        [self drawOperationMoved:touches];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded) {
        [self drawOperationEnded:touches];
    }
}

- (void)drawOperationBegan:(NSSet *)touches
{
    UITouch *touch = [touches anyObject];
    
    self.pathOperation = [self.session beginOperation:[ENDDrawPathOperation class]];
    self.pathOperation.brush = [self.brush copy];
    
    // initializes our point records to current location
    self.previousPoint = [touch previousLocationInView:self];
    self.previousPreviousPoint = [touch previousLocationInView:self];
    self.currentPoint = [touch locationInView:self];
    
    [self drawOperationMoved:touches];
}

- (void)drawOperationMoved:(NSSet *)touches
{
    UITouch *touch = [touches anyObject];
    
    CGPoint point = [touch locationInView:self];
    
    // if the finger has moved less than the min dist ...
    CGFloat dx = point.x - self.currentPoint.x;
    CGFloat dy = point.y - self.currentPoint.y;
    CGFloat distance = (dx * dx + dy * dy);
    
    if ((distance > 0) && (distance < LVPointMinDistanceSquared)) {
        // ... then ignore this movement
        return;
    }
    
    // update points: previousPrevious -> mid1 -> previous -> mid2 -> current
    self.previousPreviousPoint = self.previousPoint;
    self.previousPoint = [touch previousLocationInView:self];
    self.currentPoint = [touch locationInView:self];
    
    CGPoint mid1 = LVMiddlePoint(self.previousPoint, self.previousPreviousPoint);
    CGPoint mid2 = LVMiddlePoint(self.currentPoint, self.previousPoint);
    
    // to represent the finger movement, create a new path segment,
    // a quadratic bezier path from mid1 to mid2, using previous as a control point
    CGMutablePathRef subpath = CGPathCreateMutable();
    CGPathMoveToPoint(subpath, NULL, mid1.x, mid1.y);
    CGPathAddQuadCurveToPoint(subpath, NULL,
                              self.previousPoint.x, self.previousPoint.y,
                              mid2.x, mid2.y);
    
    // compute the rect containing the new segment plus padding for drawn line
    CGRect bounds = CGPathGetBoundingBox(subpath);
    CGRect drawBox = CGRectInset(bounds, -2.0 * self.pathOperation.brush.lineWidth, -2.0 * self.pathOperation.brush.lineWidth);
    
    [self.pathOperation addSubpath:[UIBezierPath bezierPathWithCGPath:subpath]];
    
    CGPathRelease(subpath);
    
    [self setNeedsDisplayInRect:drawBox];
}

- (void)drawOperationEnded:(NSSet *)touches
{
    [self.session endOperation];
}

- (void)longPressRecognized:(UILongPressGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateRecognized && [self.delegate respondsToSelector:@selector(smoothLineViewLongPressed:)]) {
        [self.delegate smoothLineViewLongPressed:self];
    }
}

#pragma mark interface

- (BOOL)canUndo
{
    return [self.session canRemoveLastOperation];
}

- (void)undo
{
    if (! [self canUndo]) {
        return;
    }
        
    [self.session removeLastOperation];
    [self setNeedsDisplay];
}

- (BOOL)canRedo
{
    return [self.session canRedoLastOperation];
}

- (void)redo
{
    if (! [self canRedo]) {
        return;
    }
    
    [self.session redoLastOperation];
    [self setNeedsDisplay];
}

- (void)clear
{
    [self.session removeAllOperations];
    [self setNeedsDisplay];
}

- (void)fillWithColor:(UIColor *)color
{
    if (! color) {
        return;
    }
    ENDDrawFillWithColorOperation *fillOperation = [self.session beginOperation:[ENDDrawFillWithColorOperation class]];
    fillOperation.color = color;
    [self.session endOperation];
    
    [self setNeedsDisplay];
}

@end

@implementation LVSmoothLineView (Snapshot)

- (UIImage *)snapshotImage
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return image;
}

@end


