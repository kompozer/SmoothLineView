//
//  ENDDrawFillWithColorOperation.m
//  Pods
//
//  Created by Andreas Kompanez on 21.06.15.
//
//

#import "ENDDrawFillWithColorOperation.h"



@interface ENDDrawFillWithColorOperation ()

@end

@implementation ENDDrawFillWithColorOperation
@synthesize sequenceID;

- (void)drawInContext:(CGContextRef)context inRect:(CGRect)rect
{
    if (self.color) {
        [self.color set];
        UIRectFill(rect);
    }
}

- (CGRect)drawRect
{
    return self.fillRect;
}

@end
