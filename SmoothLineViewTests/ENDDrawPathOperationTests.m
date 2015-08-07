//
//  ENDDrawPathOperationTests.m
//  SmoothLineView
//
//  Created by Andreas Kompanez on 07.08.15.
//  Copyright (c) 2015 Andreas Kompanez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "ENDDrawPathOperation.h"
#import "ENDBrush.h"
#import "ENDDrawOperation.h"



@interface ENDDrawPathOperationTests : XCTestCase

@property (nonatomic) ENDDrawPathOperation *operation;

@end

@implementation ENDDrawPathOperationTests

- (void)setUp
{
    [super setUp];
    
    self.operation = [ENDDrawPathOperation new];
    ENDBrush *brush = [ENDBrush new];
    brush.lineWidth = 1;
    self.operation.brush = brush;
}

- (void)tearDown
{
    [super tearDown];
    
    self.operation = nil;
}

- (void)testThatDrawRectIsNotZero
{
    // Reduce the brush size to get the exact draw box as the path
    self.operation.brush.lineWidth = 0;
    CGRect startRect = CGRectMake(0, 0, 100, 100);

    UIBezierPath *path  = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(startRect.origin.x, startRect.origin.y)];
    [path addLineToPoint:CGPointMake(startRect.origin.x, CGRectGetHeight(startRect))];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(startRect), CGRectGetHeight(startRect))];
    [path addLineToPoint:CGPointMake(startRect.origin.x, startRect.origin.y)];
    [self.operation addSubpath:path];
    
    CGRect drawRect = [self.operation drawRect];
    XCTAssertFalse(CGRectEqualToRect(drawRect, CGRectZero), @"Draw rect is zero");
    XCTAssertTrue(CGRectEqualToRect(drawRect, startRect), @"Start and end draw rects are different");
}

@end
