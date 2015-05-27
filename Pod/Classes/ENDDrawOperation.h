//
//  DrawOperation.h
//  Smooth Line View
//
//  Created by Andreas Kompanez on 26.05.15.
//  Copyright (c) 2015 culturezoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DrawOperation : NSObject

@property (nonatomic, copy, readonly) NSArray *subpaths;
@property (nonatomic, copy) UIColor *color;

- (void)addSubpath:(UIBezierPath *)subpath;

@end
