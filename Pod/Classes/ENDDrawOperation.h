//
//  ENDDrawOperation.h
//  Smooth Line View
//
//  Created by Andreas Kompanez on 26.05.15.
//  Copyright (c) 2015 culturezoo. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol ENDDrawOperation <NSObject>

@end



@interface ENDDrawPathOperation : NSObject <ENDDrawOperation>

/// Combined path
@property (nonatomic, copy, readonly) UIBezierPath *path;
@property (nonatomic, copy) UIColor *color;

- (void)addSubpath:(UIBezierPath *)subpath;

@end



@interface ENDDrawFillWithColorOperation : NSObject <ENDDrawOperation>

/// The fill color
@property (nonatomic, strong) UIColor *color;

@end