//
//  ENDDrawOperation.h
//  Smooth Line View
//
//  Created by Andreas Kompanez on 26.05.15.
//  Copyright (c) 2015 culturezoo. All rights reserved.
//

#import <Foundation/Foundation.h>



@protocol ENDDrawOperation <NSObject>

@end



@interface ENDDrawPathOperation : NSObject <ENDDrawOperation>

@property (nonatomic, copy, readonly) NSArray *subpaths;
@property (nonatomic, copy) UIColor *color;

- (void)addSubpath:(UIBezierPath *)subpath;

@end
