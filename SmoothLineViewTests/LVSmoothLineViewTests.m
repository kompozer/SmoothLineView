//
//  LVSmoothLineViewTests.m
//  SmoothLineView
//
//  Created by Andreas Kompanez on 10.08.15.
//  Copyright (c) 2015 Andreas Kompanez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "LVSmoothLineView.h"
#import "ENDDrawOperation.h"
#import "ENDDrawPathOperation.h"
#import "ENDDrawFillWithColorOperation.h"
#import "ENDBrush.h"
#import "ENDDrawSession.h"



@interface LVSmoothLineView (Internal)

@property (nonatomic, strong) ENDDrawSession *session;

@end

@interface LVSmoothLineViewTests : XCTestCase

@property (nonatomic) LVSmoothLineView *sketchView;

@end

@implementation LVSmoothLineViewTests

- (void)setUp
{
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.sketchView = [[LVSmoothLineView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
    self.sketchView = nil;
}

- (void)testThatDrawingBoxMethodIsCorrectWithJustDrawPathOperation
{
    ENDDrawPathOperation *operation = [self.sketchView.session beginOperation:[ENDDrawPathOperation class]];
    ENDBrush *brush = [ENDBrush new];
    brush.lineWidth = 0.0;
    operation.brush = brush;
    // 100x100 rect at the 50,50 pos
    CGRect startRect = CGRectMake(50, 50, 150, 150);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(startRect.origin.x, startRect.origin.y)];
    [path addLineToPoint:CGPointMake(startRect.origin.x, CGRectGetHeight(startRect))];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(startRect), CGRectGetHeight(startRect))];
    [path addLineToPoint:CGPointMake(startRect.origin.x, startRect.origin.y)];
    [path closePath];
    [operation addSubpath:path];
    
    [self.sketchView.session endOperation];
    
    CGRect drawingBox = [self.sketchView drawingBox];
    XCTAssertFalse(CGRectEqualToRect(drawingBox, CGRectZero));
    XCTAssertTrue(CGRectEqualToRect(drawingBox, CGRectMake(50, 50, 100, 100)));
}

- (void)testThatDrawingBoxMethodIsCorrectWithPathAndFillOperations
{
    // Path
    ENDDrawPathOperation *operation = [self.sketchView.session beginOperation:[ENDDrawPathOperation class]];
    ENDBrush *brush = [ENDBrush new];
    brush.lineWidth = 0.0;
    operation.brush = brush;
    // 100x100 rect at the 50,50 pos
    CGRect startRect = CGRectMake(50, 50, 150, 150);

    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(startRect.origin.x, startRect.origin.y)];
    [path addLineToPoint:CGPointMake(startRect.origin.x, CGRectGetHeight(startRect))];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(startRect), CGRectGetHeight(startRect))];
    [path addLineToPoint:CGPointMake(startRect.origin.x, startRect.origin.y)];
    [path closePath];
    [operation addSubpath:path];
    [self.sketchView.session endOperation];
    
    // Fill
    ENDDrawFillWithColorOperation *fillOperation = [self.sketchView.session beginOperation:[ENDDrawFillWithColorOperation class]];
    fillOperation.fillRect = self.sketchView.bounds;
    [self.sketchView.session endOperation];
    
    
    CGRect drawingBox = [self.sketchView drawingBox];
    XCTAssertFalse(CGRectEqualToRect(drawingBox, CGRectZero));
    XCTAssertTrue(CGRectEqualToRect(drawingBox, self.sketchView.bounds));
}

@end
