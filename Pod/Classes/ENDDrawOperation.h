//
//  ENDDrawOperation.h
//  Smooth Line View
//
//  Created by Andreas Kompanez on 26.05.15.
//  Copyright (c) 2015 culturezoo. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol ENDDrawOperation <NSObject>

@property (nonatomic, readonly) CGRect drawRect;

/// @param context  The drawing context
/// @param rect     The draw rect
- (void)drawInContext:(CGContextRef)context inRect:(CGRect)rect;

@end
