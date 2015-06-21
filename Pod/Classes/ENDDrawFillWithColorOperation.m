//
//  ENDDrawFillWithColorOperation.m
//  Pods
//
//  Created by Andreas Kompanez on 21.06.15.
//
//

#import "ENDDrawFillWithColorOperation.h"



@implementation ENDDrawFillWithColorOperation

- (void)drawInContext:(CGContextRef)context inRect:(CGRect)rect
{
    if (self.color) {
        [self.color set];
        UIRectFill(rect);
    }
}

@end
